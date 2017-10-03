Received: from eggs.gnu.org ([2001:4830:134:3::10]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzOPl-0005dK-GN
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzOPg-0006wz-V9
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzOPg-0006w0-Op
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:43:12 -0400
Date: Tue, 3 Oct 2017 11:42:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003144259.GK17385@localhost.localdomain>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
	<20171003091423.28704-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003091423.28704-5-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [RFC 4/5] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Tue, Oct 03, 2017 at 08:14:22PM +1100, David Gibson wrote:
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
> 
> # Conflicts:
> #	include/hw/pci/pci_bus.h

Should this be part of the commit message?

> ---
[...]
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 77d92a3dc4..cbb3386207 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -404,6 +404,11 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>  #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
>  #define TYPE_PCIE_BUS "PCIE"
>  
> +enum PCIBusFlags {
> +    /* This bus is the root of a PCI domain */
> +    PCI_BUS_IS_ROOT                                         = 0x0001,
> +};
> +
>  typedef struct PCIBusClass {
>      /*< private >*/
>      BusClass parent_class;
> @@ -416,6 +421,7 @@ typedef struct PCIBusClass {
>  
>  struct PCIBus {
>      BusState qbus;
> +    enum PCIBusFlags flags;

Why not a simple boolean field?  If we want to keep the struct
size smaller when adding more flags, we can use bit-fields.

>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
>      uint8_t devfn_min;
> @@ -440,8 +446,12 @@ struct PCIBus {
>      Notifier machine_done;
>  };
>  
> +static inline bool pci_bus_is_root(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_IS_ROOT);
> +}
> +
>  bool pci_bus_is_express(PCIBus *bus);
> -bool pci_bus_is_root(PCIBus *bus);
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
>                                MemoryRegion *address_space_mem,
> -- 
> 2.13.6
> 

-- 
Eduardo
