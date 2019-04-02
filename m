Received: from eggs.gnu.org ([209.51.188.92]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBJqo-0008HC-2M
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBJqm-0006LM-Ib
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:53:18 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:36045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hBJqm-0006Jt-8h
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:53:16 -0400
Received: from player793.ha.ovh.net (unknown [10.109.159.139])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D45B411F221
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 15:53:13 +0200 (CEST)
Date: Tue, 2 Apr 2019 15:53:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190402155305.4bf8e300@bahia.lan>
In-Reply-To: <20190402054028.20926-6-david@gibson.dropbear.id.au>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
	<20190402054028.20926-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-4.1 5/5] pcie: Simplify
 pci_adjust_config_limit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org

On Tue,  2 Apr 2019 16:40:28 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> pci_adjust_config_limit() has been used in the config space read and write
> paths to only permit access to extended config space on buses which permit
> it.  Specifically it prevents access on devices below a vanilla-PCI bus via
> some combination of bridges, even if both the host bridge and the device
> itself are PCI-E.
> 
> It accomplishes this with a somewhat complex call up the chain of bridges
> to see if any of them prohibit extended config space access.  This is
> overly complex, since we can always know if the bus will support such
> access at the point it is constructed.
> 
> This patch simplifies the test by using a flag in the PCIBus instance
> indicating wither extended configuration space is accessible.  It is always
> false for vanilla PCI buses.  For PCI-E buses, it is true for root buses
> and equal to the parent bus's's capability otherwise.
> 
> This should cause no behavioural change.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

LGTM. Some remarks below.

>  hw/pci/pci.c             | 36 ++++++++++++++++++++++--------------
>  hw/pci/pci_host.c        | 13 +++----------
>  hw/ppc/spapr_pci.c       | 24 +++++++++---------------
>  include/hw/pci/pci_bus.h |  3 ++-
>  4 files changed, 36 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index ea5941fb22..420496571e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -120,6 +120,25 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
>  }
>  
> +static void pcie_bus_realize(BusState *qbus, Error **errp)
> +{
> +    PCIBus *bus = PCI_BUS(qbus);
> +
> +    pci_bus_realize(qbus, errp);
> +
> +    /* a PCI-E bus can supported extended config space if it's the

s/supported/support

> +     * root bus, or if the bus/bridge above it does as well */
> +    if (pci_bus_is_root(bus)) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    } else {
> +        PCIBus *parent_bus = pci_get_bus(bus->parent_dev);
> +
> +        if (pci_bus_allows_extended_config_space(parent_bus)) {
> +            bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +        }
> +    }
> +}
> +
>  static void pci_bus_unrealize(BusState *qbus, Error **errp)
>  {
>      PCIBus *bus = PCI_BUS(qbus);
> @@ -142,11 +161,6 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>      return NUMA_NODE_UNASSIGNED;
>  }
>  
> -static bool pcibus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return false;
> -}
> -
>  static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
> @@ -161,7 +175,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>  
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
> -    pbc->allows_extended_config_space = pcibus_allows_extended_config_space;
>  }
>  
>  static const TypeInfo pci_bus_info = {
> @@ -182,16 +195,11 @@ static const TypeInfo conventional_pci_interface_info = {
>      .parent        = TYPE_INTERFACE,
>  };
>  
> -static bool pciebus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return true;
> -}
> -
>  static void pcie_bus_class_init(ObjectClass *klass, void *data)
>  {
> -    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
> +    BusClass *k = BUS_CLASS(klass);
>  
> -    pbc->allows_extended_config_space = pciebus_allows_extended_config_space;
> +    k->realize = pcie_bus_realize;
>  }
>  
>  static const TypeInfo pcie_bus_info = {
> @@ -412,7 +420,7 @@ bool pci_bus_is_express(PCIBus *bus)
>  
>  bool pci_bus_allows_extended_config_space(PCIBus *bus)
>  {
> -    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
> +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
>  }
>  

Maybe make this a static inline in pci_bus.h like you already did with
pci_bus_is_root() in the previous patch ?

>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index 9d64b2e12f..5f3497256c 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -53,16 +53,9 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *bus, uint32_t addr)
>  
>  static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
>  {
> -    if (*limit > PCI_CONFIG_SPACE_SIZE) {
> -        if (!pci_bus_allows_extended_config_space(bus)) {
> -            *limit = PCI_CONFIG_SPACE_SIZE;
> -            return;
> -        }
> -
> -        if (!pci_bus_is_root(bus)) {
> -            PCIDevice *bridge = pci_bridge_get_device(bus);
> -            pci_adjust_config_limit(pci_get_bus(bridge), limit);
> -        }
> +    if ((*limit > PCI_CONFIG_SPACE_SIZE) &&

parenthesitis ? ;-)

> +        !pci_bus_allows_extended_config_space(bus)) {
> +        *limit = PCI_CONFIG_SPACE_SIZE;
>      }
>  }
>  
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2e76d8cbd8..23d70ca6fe 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1638,26 +1638,11 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
>      memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
>  }
>  
> -static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
> -{
> -    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
> -
> -    return sphb->pcie_ecs;
> -}
> -
> -static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data)
> -{
> -    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
> -
> -    pbc->allows_extended_config_space = spapr_phb_allows_extended_config_space;
> -}
> -
>  #define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
>  
>  static const TypeInfo spapr_phb_root_bus_info = {
>      .name = TYPE_SPAPR_PHB_ROOT_BUS,
>      .parent = TYPE_PCI_BUS,
> -    .class_init = spapr_phb_root_bus_class_init,

The type is quite useless now, it should be dropped I guess, ie.
git revert of "spapr_pci: Fix extended config space accesses".

>  };
>  
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> @@ -1766,6 +1751,15 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>                                  &sphb->memspace, &sphb->iospace,
>                                  PCI_DEVFN(0, 0), PCI_NUM_PINS,
>                                  TYPE_SPAPR_PHB_ROOT_BUS);
> +
> +    /*
> +     * Despite resembling a vanilla PCI bus in most ways, the PAPR
> +     * para-virtualized PCI bus *does* permit PCI-E extended config
> +     * space access
> +     */
> +    if (sphb->pcie_ecs) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    }
>      phb->bus = bus;
>      qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
>  
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index aea98d5040..3c0be4c420 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -17,12 +17,13 @@ typedef struct PCIBusClass {
>  
>      int (*bus_num)(PCIBus *bus);
>      uint16_t (*numa_node)(PCIBus *bus);
> -    bool (*allows_extended_config_space)(PCIBus *bus);
>  } PCIBusClass;
>  
>  enum PCIBusFlags {
>      /* This bus is the root of a PCI domain */
>      PCI_BUS_IS_ROOT                                         = 0x0001,
> +    /* PCIe extended configuration space is accessible on this bus */
> +    PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
>  };
>  
>  struct PCIBus {
