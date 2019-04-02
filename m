Received: from eggs.gnu.org ([209.51.188.92]:35184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBJ59-00087Q-UB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBJ54-00040V-JB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:04:03 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:50059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hBJ51-0003yr-Od
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:03:56 -0400
Received: from player728.ha.ovh.net (unknown [10.109.160.239])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3D5CC206922
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 15:03:53 +0200 (CEST)
Date: Tue, 2 Apr 2019 15:03:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190402130804.2d400068@bahia.lan>
In-Reply-To: <20190402054028.20926-5-david@gibson.dropbear.id.au>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
	<20190402054028.20926-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-4.1 4/5] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue,  2 Apr 2019 16:40:27 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> pci_bus_is_root() currently relies on a method in the PCIBusClass.
> But it's always known if a PCI bus is a root bus when we create it, so
> using a dynamic method is overkill.
> 
> This replaces it with an IS_ROOT bit in a new flags field, which is set on
> root buses and otherwise clear.  As a bonus this removes the special
> is_root logic from pci_expander_bridge, since it already creates its bus
> as a root bus.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/pci-bridge/pci_expander_bridge.c |  6 ------
>  hw/pci/pci.c                        | 14 ++------------
>  hw/virtio/virtio-pci.c              |  1 +
>  include/hw/pci/pci.h                |  1 -
>  include/hw/pci/pci_bus.h            | 12 +++++++++++-
>  5 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index e62de4218f..ca66bc721a 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -66,11 +66,6 @@ static int pxb_bus_num(PCIBus *bus)
>      return pxb->bus_nr;
>  }
>  
> -static bool pxb_is_root(PCIBus *bus)
> -{
> -    return true; /* by definition */
> -}
> -
>  static uint16_t pxb_bus_numa_node(PCIBus *bus)
>  {
>      PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> @@ -83,7 +78,6 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
>      PCIBusClass *pbc = PCI_BUS_CLASS(class);
>  
>      pbc->bus_num = pxb_bus_num;
> -    pbc->is_root = pxb_is_root;
>      pbc->numa_node = pxb_bus_numa_node;
>  }
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 6d13ef877b..ea5941fb22 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -129,14 +129,9 @@ static void pci_bus_unrealize(BusState *qbus, Error **errp)
>      vmstate_unregister(NULL, &vmstate_pcibus, bus);
>  }
>  
> -static bool pcibus_is_root(PCIBus *bus)
> -{
> -    return !bus->parent_dev;
> -}
> -
>  static int pcibus_num(PCIBus *bus)
>  {
> -    if (pcibus_is_root(bus)) {
> +    if (pci_bus_is_root(bus)) {
>          return 0; /* pci host bridge */
>      }
>      return bus->parent_dev->config[PCI_SECONDARY_BUS];
> @@ -164,7 +159,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>      k->unrealize = pci_bus_unrealize;
>      k->reset = pcibus_reset;
>  
> -    pbc->is_root = pcibus_is_root;
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
>      pbc->allows_extended_config_space = pcibus_allows_extended_config_space;
> @@ -398,6 +392,7 @@ static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
>      bus->slot_reserved_mask = 0x0;
>      bus->address_space_mem = address_space_mem;
>      bus->address_space_io = address_space_io;
> +    bus->flags |= PCI_BUS_IS_ROOT;
>  
>      /* host bridge */
>      QLIST_INIT(&bus->child);
> @@ -415,11 +410,6 @@ bool pci_bus_is_express(PCIBus *bus)
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
>  }
>  
> -bool pci_bus_is_root(PCIBus *bus)
> -{
> -    return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> -}
> -
>  bool pci_bus_allows_extended_config_space(PCIBus *bus)
>  {
>      return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb44e19b67..942173d830 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -20,6 +20,7 @@
>  #include "standard-headers/linux/virtio_pci.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bus.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/msi.h"
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 0abb06b357..33ccce320c 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -395,7 +395,6 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
>  #define TYPE_PCIE_BUS "PCIE"
>  
>  bool pci_bus_is_express(PCIBus *bus);
> -bool pci_bus_is_root(PCIBus *bus);
>  bool pci_bus_allows_extended_config_space(PCIBus *bus);
>  
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index f6df834170..aea98d5040 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -15,14 +15,19 @@ typedef struct PCIBusClass {
>      BusClass parent_class;
>      /*< public >*/
>  
> -    bool (*is_root)(PCIBus *bus);
>      int (*bus_num)(PCIBus *bus);
>      uint16_t (*numa_node)(PCIBus *bus);
>      bool (*allows_extended_config_space)(PCIBus *bus);
>  } PCIBusClass;
>  
> +enum PCIBusFlags {
> +    /* This bus is the root of a PCI domain */
> +    PCI_BUS_IS_ROOT                                         = 0x0001,
> +};
> +
>  struct PCIBus {
>      BusState qbus;
> +    enum PCIBusFlags flags;
>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
>      uint8_t devfn_min;
> @@ -47,4 +52,9 @@ struct PCIBus {
>      Notifier machine_done;
>  };
>  
> +static inline bool pci_bus_is_root(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_IS_ROOT);
> +}
> +
>  #endif /* QEMU_PCI_BUS_H */
