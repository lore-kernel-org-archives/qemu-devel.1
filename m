Received: from eggs.gnu.org ([2001:4830:134:3::10]:44771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cfvEo-0001tp-Vg
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cfvCH-0007Gm-5S
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:11:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cfvCG-0007Gc-PF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:08:37 -0500
Date: Mon, 20 Feb 2017 14:08:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170220140833.7221fcd5@t450s.home>
In-Reply-To: <1487554087-15347-2-git-send-email-tianyu.lan@intel.com>
References: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
	<1487554087-15347-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Resend RFC PATCH 1/4] VFIO: Set eventfd for IOMMU
 fault event via new vfio cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, david@gibson.dropbear.id.au, yi.l.liu@intel.com

On Mon, 20 Feb 2017 09:28:04 +0800
Lan Tianyu <tianyu.lan@intel.com> wrote:

> This patch is to assign an event fd to VFIO IOMMU type1 driver
> in order to get notification when IOMMU driver reports fault event.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/vfio/common.c              | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  3 +++
>  linux-headers/linux/vfio.h    | 13 +++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6b33b9f..628b424 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -33,6 +33,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/sysemu.h"
>  #include "trace.h"
>  #include "qapi/error.h"
>  
> @@ -294,6 +295,34 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>             section->offset_within_address_space & (1ULL << 63);
>  }
>  
> +static void vfio_iommu_fault(void *opaque)
> +{
> +}
> +
> +static int vfio_set_iommu_fault_notifier(struct VFIOContainer *container)
> +{
> +    struct vfio_iommu_type1_set_fault_eventfd eventfd;
> +    int ret;
> +
> +    ret = event_notifier_init(&container->fault_notifier, 0);
> +    if (ret < 0) {
> +        error_report("vfio: Failed to init notifier for IOMMU fault event");
> +        return ret;
> +    }
> +
> +    eventfd.fd = event_notifier_get_fd(&container->fault_notifier);
> +    eventfd.argsz = sizeof(eventfd);
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_SET_FAULT_EVENTFD, &eventfd);
> +    if (ret < 0) {
> +        error_report("vfio: Failed to set notifier for IOMMU fault event");
> +        return ret;
> +    }
> +
> +    qemu_set_fd_handler(eventfd.fd, vfio_iommu_fault, NULL, container);
> +    return 0;
> +}
> +
>  /* Called with rcu_read_lock held.  */
>  static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             bool *read_only)
> @@ -1103,6 +1132,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          goto listener_release_exit;
>      }
>  
> +    if (memory_region_is_iommu(container->space->as->root)) {
> +        if (vfio_set_iommu_fault_notifier(container)) {
> +            error_setg_errno(errp, -ret,
> +                "Fail to set IOMMU fault notifier");
> +            goto listener_release_exit;
> +        }
> +    }


Backwards compatibility needs to be supported, we can't invent a
feature and impose it on all users.  We can either opportunistically
enable it and be silent about it when it's not there, or we can add a
feature flag and complain and fail if the user requests the feature and
it's not available or errors.

> +
>      container->initialized = true;
>  
>      QLIST_INIT(&container->group_list);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c582de1..1b594c6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -26,6 +26,7 @@
>  #include "exec/memory.h"
>  #include "qemu/queue.h"
>  #include "qemu/notify.h"
> +#include "qemu/event_notifier.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> @@ -81,6 +82,8 @@ typedef struct VFIOContainer {
>      unsigned iommu_type;
>      int error;
>      bool initialized;
> +    EventNotifier fault_notifier;
> +
>      /*
>       * This assumes the host IOMMU can support only a single
>       * contiguous IOVA window.  We may need to generalize that in
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 759b850..ca890ee 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -537,6 +537,19 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/*
> + * VFIO_IOMMU_SET_FAULT_EVENT_FD	_IO(VFIO_TYPE, VFIO_BASE + 17)
> + * 
> + * Receive eventfd from userspace to notify fault event from IOMMU.
> + */
> +struct vfio_iommu_type1_set_fault_eventfd {
> +	__u32	argsz;
> +	__u32   flags;
> +	__u32	fd;
> +};
> +
> +#define VFIO_IOMMU_SET_FAULT_EVENTFD	_IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
