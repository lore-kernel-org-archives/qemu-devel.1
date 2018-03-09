Received: from eggs.gnu.org ([2001:4830:134:3::10]:54194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euGQm-0002QP-8z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euGQh-0001sK-FU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:43:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euGQh-0001sC-9j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:43:19 -0500
Date: Fri, 9 Mar 2018 11:43:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180309114311.GA3214@work-vm>
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
	<1520229653-10658-2-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520229653-10658-2-git-send-email-yulei.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 1/4] vfio: introduce a new VFIO
 subregion for mdev device migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, alex.williamson@redhat.com, kwankhede@nvidia.com, zhenyuw@linux.intel.com

* Yulei Zhang (yulei.zhang@intel.com) wrote:
> New VFIO sub region VFIO_REGION_SUBTYPE_DEVICE_STATE is added
> to fetch and restore the status of mdev device vGPU during the
> live migration.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c              | 14 +++++++++++++-
>  hw/vfio/pci.h              |  1 +
>  linux-headers/linux/vfio.h |  9 ++++++---
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31e1edf..2fe20e4 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -37,6 +37,7 @@
>  
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> +static VMStateDescription vfio_pci_vmstate;
>  
>  /*
>   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> @@ -2813,6 +2814,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          vfio_vga_quirk_setup(vdev);
>      }
>  
> +    struct vfio_region_info *device_state;
> +    /* device state region setup */
> +    if (!vfio_get_dev_region_info(&vdev->vbasedev,
> +                VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> +                VFIO_REGION_SUBTYPE_DEVICE_STATE, &device_state)) {
> +        memcpy(&vdev->device_state, device_state,
> +               sizeof(struct vfio_region_info));
> +        g_free(device_state);
> +        vfio_pci_vmstate.unmigratable = 0;
> +    }

I don't think we've got any other code that changes the 'unmigratable'
flag on a vmstate.  If you've got a device that you don't know whether
it's migratable until runtime, then you should add a 'migration blocker'
if the device isn't migratable.
See for example the calls to migrate_add_blocker in hw/virtio/vhost.c

Dave

>      for (i = 0; i < PCI_ROM_SLOT; i++) {
>          vfio_bar_quirk_setup(vdev, i);
>      }
> @@ -2994,7 +3006,7 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static const VMStateDescription vfio_pci_vmstate = {
> +static VMStateDescription vfio_pci_vmstate = {
>      .name = "vfio-pci",
>      .unmigratable = 1,
>  };
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a8366bb..6a1d26e 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -116,6 +116,7 @@ typedef struct VFIOPCIDevice {
>      VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
>      VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
>      void *igd_opregion;
> +    struct vfio_region_info device_state;
>      PCIHostDeviceAddress host;
>      EventNotifier err_notifier;
>      EventNotifier req_notifier;
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4e7ab4c..c3b8e4a 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -296,9 +296,12 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
>  
>  /* 8086 Vendor sub-types */
> -#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
> -#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> -#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> +#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION		(1)
> +#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG		(2)
> +#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG		(3)
> +
> +/* Mdev sub-type for device state save and restore */
> +#define VFIO_REGION_SUBTYPE_DEVICE_STATE	(4)
>  
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
