Received: from eggs.gnu.org ([2001:4830:134:3::10]:45774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3OnW-0003wc-7O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3OnT-0000oO-2z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:24:06 -0400
Date: Wed, 26 Apr 2017 18:23:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170426182155-mutt-send-email-mst@kernel.org>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328021651.19350-2-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [RFC for-2.10 1/3] pci/pcie: Make a consistent
 helper for switching PCI/PCIe "hybrid" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ehabkost@redhat.com, aik@ozlabs.ru, marcel@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com

On Tue, Mar 28, 2017 at 01:16:49PM +1100, David Gibson wrote:
> virtio-pci and XHCI are "hybrid" devices in the sense that they can present
> themselves as either PCIe or plain PCI devices depending on the machine
> and bus they're connected to.
> 
> For virtio-pci to present as PCIe it requires that it's connected to a PCIe
> bus and that it's not a root bus - this is to ensure that the device is
> connected via a PCIe root port or downstream port rather than being a
> integrated endpoint.  Some guests (Windows in particular AIUI) don't really
> cope with PCIe integrated endpoints.
> 
> For XHCI it only checks that the bus is PCIe, but that probably means it
> would cause problems if attached as an integrated devices directly to a
> PCIe root bus.
> 
> This patch makes the test consistent between XHCI and virtio-pci, and
> clarifies things by having them both use a new 'pci_allow_hybrid_pcie()'
> helper which performs the same check as virtio-pci.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/pci/pci.c           | 7 +++++++
>  hw/usb/hcd-xhci.c      | 2 +-
>  hw/virtio/virtio-pci.c | 3 +--
>  include/hw/pci/pci.h   | 1 +
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bd8043c..779787b 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -390,6 +390,13 @@ bool pci_bus_is_root(PCIBus *bus)
>      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
>  }
>  
> +bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
> +{
> +    PCIBus *bus = pci_dev->bus;
> +
> +    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> +}
> +
>  void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                           const char *name,
>                           MemoryRegion *address_space_mem,

I'd prefer pci_allow_hybrid_pci_pcie.

> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index f0af852..a7ff4fd 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3619,7 +3619,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
>                       PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64,
>                       &xhci->mem);
>  
> -    if (pci_bus_is_express(dev->bus) ||
> +    if (pci_allow_hybrid_pcie(dev) ||
>          xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
>          ret = pcie_endpoint_cap_init(dev, 0xa0);
>          assert(ret >= 0);

This seems to change the behaviour for xhci on a root bus - what
am I missing?

> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..9b34673 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1737,8 +1737,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
>      VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(pci_dev);
> -    bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
> -                     !pci_bus_is_root(pci_dev->bus);
> +    bool pcie_port = pci_allow_hybrid_pcie(pci_dev);
>  
>      if (!kvm_has_many_ioeventfds()) {
>          proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;

I don't actually remember why do we disable pcie on a root port.
Marcel, do you happen to know?

> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a37a2d5..7b9a40f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -453,6 +453,7 @@ void pci_for_each_bus(PCIBus *bus,
>  
>  PCIBus *pci_find_primary_bus(void);
>  PCIBus *pci_device_root_bus(const PCIDevice *d);
> +bool pci_allow_hybrid_pcie(PCIDevice *pci_dev);
>  const char *pci_root_bus_path(PCIDevice *dev);
>  PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
>  int pci_qdev_find_device(const char *id, PCIDevice **pdev);
> -- 
> 2.9.3
