Received: from eggs.gnu.org ([2001:4830:134:3::10]:39863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpng-00064U-QA
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpnd-0001DE-HV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpnd-0001Ch-8G
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F49A232046
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 16:51:44 +0000 (UTC)
Date: Fri, 2 Jun 2017 19:51:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170602195026-mutt-send-email-mst@kernel.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496404254-17429-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] vhost: iommu: cache static mapping if
 there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Jun 02, 2017 at 07:50:54PM +0800, Peter Xu wrote:
> This patch pre-heat vhost iotlb cache when passthrough mode enabled.
> 
> Sometimes, even if user specified iommu_platform for vhost devices,
> IOMMU might still be disabled. One case is passthrough mode in VT-d
> implementation. We can detect this by observing iommu_list. If it's
> empty, it means IOMMU translation is disabled, then we can actually
> pre-heat the translation (it'll be static mapping then) by first
> invalidating all IOTLB, then cache existing memory ranges into vhost
> backend iotlb using 1:1 mapping.
> 
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Can't say I like this, this does not help the more important
use-case of dpdk which has a small static mapping but can't
be detected by QEMU. vhost should just heat up whatever's
actually used. Why isn't this enough?

> ---
>  hw/virtio/trace-events |  4 +++
>  hw/virtio/vhost.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 1f7a7c1..54dcbb3 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -24,3 +24,7 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
>  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
>  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
>  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: %"PRIx64" num_pages: %d"
> +
> +# hw/virtio/vhost.c
> +vhost_iommu_commit(void) ""
> +vhost_iommu_static_preheat(void) ""
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 03a46a7..d03d720 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/blocker.h"
>  #include "sysemu/dma.h"
> +#include "trace.h"
>  
>  /* enabled until disconnected backend stabilizes */
>  #define _VHOST_DEBUG 1
> @@ -730,6 +731,11 @@ static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  }
>  
> +static bool vhost_iommu_mr_enabled(struct vhost_dev *dev)
> +{
> +    return !QLIST_EMPTY(&dev->iommu_list);
> +}
> +
>  static void vhost_iommu_region_add(MemoryListener *listener,
>                                     MemoryRegionSection *section)
>  {
> @@ -782,6 +788,65 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static void vhost_iommu_commit(MemoryListener *listener)
> +{
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         iommu_listener);
> +    struct vhost_memory_region *r;
> +    int i;
> +
> +    trace_vhost_iommu_commit();
> +
> +    if (!vhost_iommu_mr_enabled(dev)) {
> +        /*
> +        * This means iommu_platform is enabled, however iommu memory
> +        * region is disabled, e.g., when device passthrough is setup.
> +        * Then, no translation is needed any more.
> +        *
> +        * Let's first invalidate the whole IOTLB, then pre-heat the
> +        * static mapping by looping over vhost memory ranges.
> +        */
> +
> +        if (dev->vhost_ops->vhost_invalidate_device_iotlb(dev, 0,
> +                                                          UINT64_MAX)) {
> +            error_report("%s: flush existing IOTLB failed", __func__);
> +            return;
> +        }
> +
> +        /*
> +         * Current VHOST_IOTLB_INVALIDATE API has a small defect that
> +         * the invalidation for (start=0, size=UINT64_MAX) cannot
> +         * really invalidate an cached range of (start=UINT64_MAX-1,
> +         * size=1). We send this 2nd invalidation to workaround this.
> +         * But, frankly speaking for QEMU we don't have a problem with
> +         * this since we will never have a vhost cache with range
> +         * (start=UINT64_MAX-1, size=1) - if you see
> +         * address_space_get_iotlb_entry() all IOTLBs are page
> +         * aligned.
> +         */
> +        if (dev->vhost_ops->vhost_invalidate_device_iotlb(dev, UINT64_MAX,
> +                                                          1)) {
> +            error_report("%s: flush existing IOTLB failed", __func__);
> +            return;
> +        }
> +
> +        for (i = 0; i < dev->mem->nregions; i++) {
> +            r = &dev->mem->regions[i];
> +            /* Vhost regions are writable RAM, so IOMMU_RW suites. */
> +            if (dev->vhost_ops->vhost_update_device_iotlb(dev,
> +                                                          r->guest_phys_addr,
> +                                                          r->userspace_addr,
> +                                                          r->memory_size,
> +                                                          IOMMU_RW)) {
> +                error_report("%s: pre-heat static mapping failed", __func__);
> +                return;
> +            }
> +        }
> +
> +        trace_vhost_iommu_static_preheat();
> +    }
> +}
> +
>  static void vhost_region_nop(MemoryListener *listener,
>                               MemoryRegionSection *section)
>  {
> @@ -1298,6 +1363,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      hdev->iommu_listener = (MemoryListener) {
>          .region_add = vhost_iommu_region_add,
>          .region_del = vhost_iommu_region_del,
> +        .commit = vhost_iommu_commit,
>      };
>  
>      if (hdev->migration_blocker == NULL) {
> -- 
> 2.7.4
