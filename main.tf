# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "0814dbd2-88f4-48e9-b76d-e68f7c6bcb35"
}

resource azurerm_resource_group sg {
  name = "sg"
  location = "eastus"
}

resource azurerm_resource_group sg-onprem {
  name = "sg-onprem"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet-onprem" {
  name = "vnet-onprem"
  resource_group_name = azurerm_resource_group.sg-onprem.name
  address_space = [ "192.168.0.0/16" ]
  location = "eastus"
}

resource "azurerm_subnet" "vnet-onprem-default" {
  name = "vnet-onprem-default"
  resource_group_name = azurerm_resource_group.sg-onprem.name
  address_prefixes = [ "192.168.0.0/24" ]
  virtual_network_name = azurerm_virtual_network.vnet-onprem.name
}

resource "azurerm_subnet" "vnet-onprem-gateway" {
  name = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.sg-onprem.name
  address_prefixes = [ "192.168.1.0/27" ]
  virtual_network_name = azurerm_virtual_network.vnet-onprem.name
}