Received: from eggs.gnu.org ([2001:4830:134:3::10]:48101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwURZ-0005k6-EK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwURT-0007Nv-NQ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:33:09 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:39399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwURT-0007Ml-GJ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:33:03 -0400
Date: Mon, 25 Sep 2017 15:32:59 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925143259.GA25986@perard.uk.xensource.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170823221445.15243-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] pci: Add INTERFACE_LEGACY_PCI_DEVICE
 to legacy PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Aug 23, 2017 at 07:14:44PM -0300, Eduardo Habkost wrote:
> Add INTERFACE_LEGACY_PCI_DEVICE to all direct subtypes of
> TYPE_PCI_DEVICE, except:
> 
> 1) The ones that already have INTERFACE_PCIE_DEVICE set:
> 
> * base-xhci
> * e1000e
> * nvme
> * pvscsi
> * vfio-pci
> * virtio-pci
> * vmxnet3
> 
> 2) base-pci-bridge
> 
> Not all PCI bridges are legacy PCI devices, so
> INTERFACE_LEGACY_PCI_DEVICE is added only to the subtypes that
> are actually legacy PCI devices:
> 
> * dec-21154-p2p-bridge
> * i82801b11-bridge
> * pbm-bridge
> * pci-bridge
> 
> The direct subtypes of base-pci-bridge not touched by this patch
> are:
> 
> * xilinx-pcie-root: Already marked as PCIe-only device.
> * pcie-port: all non-abstract subtypes of pcie-port are already
>   marked as PCIe-only devices.
> 
> 3) megasas-base
> 
> Not all megasas devices are legacy PCI devices, so the interface
> names are added to the subclasses registered by
> megasas_register_types(), according to information in the
> megasas_devices[] array.
> 
> "megasas-gen2" already implements INTERFACE_PCIE_DEVICE, so add
> INTERFACE_LEGACY_PCI_DEVICE only to "megasas".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/xen/xen_platform.c          |  4 ++++
>  hw/i386/xen/xen_pvdevice.c          |  4 ++++
>  hw/xen/xen_pt.c                     |  4 ++++
>  62 files changed, 288 insertions(+)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 9ba7474..2113bd0 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -517,6 +517,10 @@ static const TypeInfo xen_platform_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIXenPlatformState),
>      .class_init    = xen_platform_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_platform_register_types(void)
> diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
> index c093b34..e2ae81b 100644
> --- a/hw/i386/xen/xen_pvdevice.c
> +++ b/hw/i386/xen/xen_pvdevice.c
> @@ -127,6 +127,10 @@ static const TypeInfo xen_pv_type_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(XenPVDevice),
>      .class_init    = xen_pv_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_pv_register_types(void)
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 375efa6..66664fc 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -964,6 +964,10 @@ static const TypeInfo xen_pci_passthrough_info = {
>      .instance_size = sizeof(XenPCIPassthroughState),
>      .instance_finalize = xen_pci_passthrough_finalize,
>      .class_init = xen_pci_passthrough_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_pci_passthrough_register_types(void)

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
