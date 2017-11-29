Received: from eggs.gnu.org ([2001:4830:134:3::10]:52017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eJzs3-0000JJ-Tc
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eJzs0-0006Js-PT
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:45:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eJzs0-0006JT-9V
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:45:36 -0500
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-5-david@gibson.dropbear.id.au>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <58542052-e433-9105-20ac-734ad4b718e2@redhat.com>
Date: Wed, 29 Nov 2017 12:45:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171129084628.12336-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.12 4/7] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On 29/11/2017 10:46, David Gibson wrote:
> pci_bus_is_root() currently relies on a method in the PCIBusClass.
> But it's always known if a PCI bus is a root bus when we create it, so
> using a dynamic method is overkill.
> 
> This replaces it with an IS_ROOT bit in a new flags field, which is set on
> root buses and otherwise clear.  As a bonus this removes the special
> is_root logic from pci_expander_bridge, since it already creates its bus
> as a root bus.
> 

I agree it makes the code simpler, I am not sure about
the enum. Why not make it a boolean field and when will need
more flags just convert it to an enum (or not)?

Thanks,
Marcel

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/pci-bridge/pci_expander_bridge.c |  6 ------
>   hw/pci/pci.c                        | 14 ++------------
>   include/hw/pci/pci.h                | 12 +++++++++++-
>   3 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 5652cf06e9..11dfa9258e 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -65,11 +65,6 @@ static int pxb_bus_num(PCIBus *bus)
>       return pxb->bus_nr;
>   }
>   
> -static bool pxb_is_root(PCIBus *bus)
> -{
> -    return true; /* by definition */
> -}
> -
>   static uint16_t pxb_bus_numa_node(PCIBus *bus)
>   {
>       PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> @@ -82,7 +77,6 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
>       PCIBusClass *pbc = PCI_BUS_CLASS(class);
>   
>       pbc->bus_num = pxb_bus_num;
> -    pbc->is_root = pxb_is_root;
>       pbc->numa_node = pxb_bus_numa_node;
>   }
>   
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 6e11dc2fec..5fab7f23b3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -126,14 +126,9 @@ static void pci_bus_unrealize(BusState *qbus, Error **errp)
>       vmstate_unregister(NULL, &vmstate_pcibus, bus);
>   }
>   
> -static bool pcibus_is_root(PCIBus *bus)
> -{
> -    return !bus->parent_dev;
> -}
> -
>   static int pcibus_num(PCIBus *bus)
>   {
> -    if (pcibus_is_root(bus)) {
> +    if (pci_bus_is_root(bus)) {
>           return 0; /* pci host bridge */
>       }
>       return bus->parent_dev->config[PCI_SECONDARY_BUS];
> @@ -156,7 +151,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>       k->unrealize = pci_bus_unrealize;
>       k->reset = pcibus_reset;
>   
> -    pbc->is_root = pcibus_is_root;
>       pbc->bus_num = pcibus_num;
>       pbc->numa_node = pcibus_numa_node;
>   }
> @@ -385,6 +379,7 @@ static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
>       bus->slot_reserved_mask = 0x0;
>       bus->address_space_mem = address_space_mem;
>       bus->address_space_io = address_space_io;
> +    bus->flags |= PCI_BUS_IS_ROOT;
>   
>       /* host bridge */
>       QLIST_INIT(&bus->child);
> @@ -397,11 +392,6 @@ bool pci_bus_is_express(PCIBus *bus)
>       return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
>   }
>   
> -bool pci_bus_is_root(PCIBus *bus)
> -{
> -    return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> -}
> -
>   void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                 const char *name,
>                                 MemoryRegion *address_space_mem,
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 77d92a3dc4..cbb3386207 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -404,6 +404,11 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>   #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
>   #define TYPE_PCIE_BUS "PCIE"
>   
> +enum PCIBusFlags {
> +    /* This bus is the root of a PCI domain */
> +    PCI_BUS_IS_ROOT                                         = 0x0001,
> +};
> +
>   typedef struct PCIBusClass {
>       /*< private >*/
>       BusClass parent_class;
> @@ -416,6 +421,7 @@ typedef struct PCIBusClass {
>   
>   struct PCIBus {
>       BusState qbus;
> +    enum PCIBusFlags flags;
>       PCIIOMMUFunc iommu_fn;
>       void *iommu_opaque;
>       uint8_t devfn_min;
> @@ -440,8 +446,12 @@ struct PCIBus {
>       Notifier machine_done;
>   };
>   
> +static inline bool pci_bus_is_root(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_IS_ROOT);
> +}
> +
>   bool pci_bus_is_express(PCIBus *bus);
> -bool pci_bus_is_root(PCIBus *bus);
>   void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                 const char *name,
>                                 MemoryRegion *address_space_mem,
> 
