Received: from eggs.gnu.org ([209.51.188.92]:41752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJuXH-0004kH-Nj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJuXF-0002Mc-P3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hJuXD-0002CT-St
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id f36so1050493plb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 23:40:24 -0700 (PDT)
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-4-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
Date: Fri, 26 Apr 2019 16:40:17 +1000
MIME-Version: 1.0
In-Reply-To: <20190424041959.4087-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] pcie: Simplify
 pci_adjust_config_limit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, clg@kaod.org



On 24/04/2019 14:19, David Gibson wrote:
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
> indicating whether extended configuration space is accessible.  It is
> false for vanilla PCI buses.  For PCI-E buses, it is true for root
> buses and equal to the parent bus's's capability otherwise.
> 
> For the special case of sPAPR's paravirtualized PCI root bus, which
> acts mostly like vanilla PCI, but does allow extended config space
> access, we override the default value of the flag from the host bridge
> code.
> 
> This should cause no behavioural change.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
> ---
>  hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
>  hw/pci/pci_host.c        | 13 +++----------
>  hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
>  include/hw/pci/pci.h     |  1 -
>  include/hw/pci/pci_bus.h |  9 ++++++++-
>  5 files changed, 44 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index ea5941fb22..59ee034331 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
>  }
>  
> +static void pcie_bus_realize(BusState *qbus, Error **errp)
> +{
> +    PCIBus *bus = PCI_BUS(qbus);
> +
> +    pci_bus_realize(qbus, errp);
> +
> +    /*
> +     * A PCI-E bus can support extended config space if it's the root
> +     * bus, or if the bus/bridge above it does as well
> +     */
> +    if (pci_bus_is_root(bus)) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    } else {
> +        PCIBus *parent_bus = pci_get_bus(bus->parent_dev);


g_assert(bus->parent_dev) ?

Slightly confusingly bus->parent_dev is not the same as bus->qbus.parent
and can be NULL, I'd even look into ditching parent_dev and using
bus->qbus.parent instead (if possible).


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
> @@ -142,11 +163,6 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
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
> @@ -161,7 +177,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>  
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
> -    pbc->allows_extended_config_space = pcibus_allows_extended_config_space;
>  }
>  
>  static const TypeInfo pci_bus_info = {
> @@ -182,16 +197,11 @@ static const TypeInfo conventional_pci_interface_info = {
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
> @@ -410,11 +420,6 @@ bool pci_bus_is_express(PCIBus *bus)
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
>  }
>  
> -bool pci_bus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
> -}
> -
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
>                                MemoryRegion *address_space_mem,
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
> +        !pci_bus_allows_extended_config_space(bus)) {
> +        *limit = PCI_CONFIG_SPACE_SIZE;
>      }
>  }
>  
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f62e6833b8..65a86be29c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1638,28 +1638,6 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
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
> -#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
> -
> -static const TypeInfo spapr_phb_root_bus_info = {
> -    .name = TYPE_SPAPR_PHB_ROOT_BUS,
> -    .parent = TYPE_PCI_BUS,
> -    .class_init = spapr_phb_root_bus_class_init,
> -};
> -
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
> @@ -1765,7 +1743,16 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>                                  pci_spapr_set_irq, pci_spapr_map_irq, sphb,
>                                  &sphb->memspace, &sphb->iospace,
>                                  PCI_DEVFN(0, 0), PCI_NUM_PINS,
> -                                TYPE_SPAPR_PHB_ROOT_BUS);
> +                                TYPE_PCI_BUS);
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
> @@ -2348,7 +2335,6 @@ void spapr_pci_rtas_init(void)
>  static void spapr_pci_register_types(void)
>  {
>      type_register_static(&spapr_phb_info);
> -    type_register_static(&spapr_phb_root_bus_info);
>  }
>  
>  type_init(spapr_pci_register_types)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 33ccce320c..0edfaabbb0 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -395,7 +395,6 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
>  #define TYPE_PCIE_BUS "PCIE"
>  
>  bool pci_bus_is_express(PCIBus *bus);
> -bool pci_bus_allows_extended_config_space(PCIBus *bus);
>  
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index aea98d5040..2d5f74b7c1 100644
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
> @@ -57,4 +58,10 @@ static inline bool pci_bus_is_root(PCIBus *bus)
>      return !!(bus->flags & PCI_BUS_IS_ROOT);
>  }
>  
> +static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> +}
> +
> +

An extra empty line.

Anyway, these are minor comments, so

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




>  #endif /* QEMU_PCI_BUS_H */
> 

-- 
Alexey
