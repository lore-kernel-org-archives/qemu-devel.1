Received: from eggs.gnu.org ([2001:4830:134:3::10]:52735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dPaTd-0005Er-I3
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dPaTc-0007Uk-AC
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dPaTc-0007UY-15
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:16 -0400
Date: Mon, 26 Jun 2017 14:19:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170626141914.355091f0@w520.home>
In-Reply-To: <1491301617-24179-1-git-send-email-yulei.zhang@intel.com>
References: <1491301617-24179-1-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] vfio: introduce a new VFIO region for
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com

On Tue,  4 Apr 2017 18:26:57 +0800
Yulei Zhang <yulei.zhang@intel.com> wrote:

> New VFIO region VFIO_PCI_DEVICE_STATE_REGION_INDEX is added to fetch
> and restore the pci device status during the live migration.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c              | 17 +++++++++++++++++
>  hw/vfio/pci.h              |  1 +
>  linux-headers/linux/vfio.h |  5 ++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 03a3d01..bf2e0ff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2360,6 +2360,23 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>          QLIST_INIT(&vdev->bars[i].quirks);
>      }
>  
> +    /* device state region setup */
> +    if (vbasedev->flags & VFIO_DEVICE_FLAGS_MIGRATABLE) {
> +        char *name = g_strdup_printf("%s BAR %d", vbasedev->name, VFIO_PCI_DEVICE_STATE_REGION_INDEX);
> +
> +        ret = vfio_region_setup(OBJECT(vdev), vbasedev,
> +                                &vdev->device_state.region, VFIO_PCI_DEVICE_STATE_REGION_INDEX, name);
> +        g_free(name);
> +
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "failed to get region %d info",
> +                             VFIO_PCI_DEVICE_STATE_REGION_INDEX);
> +            return;
> +        }
> +
> +        QLIST_INIT(&vdev->device_state.quirks);
> +    }
> +
>      ret = vfio_get_region_info(vbasedev,
>                                 VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
>      if (ret) {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a8366bb..bd98618 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -115,6 +115,7 @@ typedef struct VFIOPCIDevice {
>      int interrupt; /* Current interrupt type */
>      VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
>      VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
> +    VFIOBAR device_state;

But it's not a BAR...

>      void *igd_opregion;
>      PCIHostDeviceAddress host;
>      EventNotifier err_notifier;
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 531cb2e..c87d05c 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -198,6 +198,8 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> +#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)        /* vfio-ccw device */
> +#define VFIO_DEVICE_FLAGS_MIGRATABLE (1 << 5)	/* Device supports migrate */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -433,7 +435,8 @@ enum {
>  	 * between described ranges are unimplemented.
>  	 */
>  	VFIO_PCI_VGA_REGION_INDEX,
> -	VFIO_PCI_NUM_REGIONS = 9 /* Fixed user ABI, region indexes >=9 use */
> +	VFIO_PCI_DEVICE_STATE_REGION_INDEX,
> +	VFIO_PCI_NUM_REGIONS = 10 /* Fixed user ABI, region indexes >=9 use */
>  				 /* device specific cap to define content. */
>  };
>  

Nak, please read the comment on the line you changed.  We're not adding
any more static region indexes, anything new should be added with
device specific capabilities.  Look at how we do opregions and various
other IGD related regions.  There's also no reason to add a flag, the
existence of the device specific region should indicate that it
supports migration.  Also, we call these device specific, but I would
still encourage a shared format, userspace doesn't want to support a
different mechanism for each device.  Thanks,

Alex
