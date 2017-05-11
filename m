Received: from eggs.gnu.org ([2001:4830:134:3::10]:50465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8jZS-0005DO-Vi
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8jZO-00072K-3S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d8jZN-00071x-Rm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:35:34 -0400
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-13-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a328f26-bf49-a0e8-1582-2179720b0cb1@redhat.com>
Date: Thu, 11 May 2017 16:35:21 +0800
MIME-Version: 1.0
In-Reply-To: <1494403315-12760-13-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/12] vhost: iommu: cache static
 mapping if there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>



On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
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
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/virtio/trace-events |  4 ++++
>   hw/virtio/vhost.c      | 49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>   2 files changed, 53 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 1f7a7c1..54dcbb3 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -24,3 +24,7 @@ virtio_balloon_handle_output(const char *name, uint64=
_t gpa) "section name: %s g
>   virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_p=
ages: %d actual: %d"
>   virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actua=
l: %d oldactual: %d"
>   virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloo=
n target: %"PRIx64" num_pages: %d"
> +
> +# hw/virtio/vhost.c
> +vhost_iommu_commit(void) ""
> +vhost_iommu_static_preheat(void) ""
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 0001e60..1c92e62 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>   #include "hw/virtio/virtio-access.h"
>   #include "migration/migration.h"
>   #include "sysemu/dma.h"
> +#include "trace.h"
>  =20
>   /* enabled until disconnected backend stabilizes */
>   #define _VHOST_DEBUG 1
> @@ -730,6 +731,11 @@ static void vhost_iommu_unmap_notify(IOMMUNotifier=
 *n, IOMMUTLBEntry *iotlb)
>       }
>   }
>  =20
> +static bool vhost_iommu_mr_enabled(struct vhost_dev *dev)
> +{
> +    return !QLIST_EMPTY(&dev->iommu_list);
> +}
> +
>   static void vhost_iommu_region_add(MemoryListener *listener,
>                                      MemoryRegionSection *section)
>   {
> @@ -782,6 +788,48 @@ static void vhost_iommu_region_del(MemoryListener =
*listener,
>       }
>   }
>  =20
> +static void vhost_iommu_commit(MemoryListener *listener)
> +{
> +    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
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
> +                                                          UINT64_MAX-1=
)) {
> +            error_report("%s: flush existing IOTLB failed", __func__);
> +            return;
> +        }
> +
> +        for (i =3D 0; i < dev->mem->nregions; i++) {
> +            r =3D &dev->mem->regions[i];
> +            /* Vhost regions are writable RAM, so IOMMU_RW suites. */
> +            if (dev->vhost_ops->vhost_update_device_iotlb(dev,
> +                                                          r->guest_phy=
s_addr,
> +                                                          r->userspace=
_addr,
> +                                                          r->memory_si=
ze,
> +                                                          IOMMU_RW)) {
> +                error_report("%s: pre-heat static mapping failed", __f=
unc__);
> +                return;
> +            }
> +        }
> +
> +        trace_vhost_iommu_static_preheat();
> +    }
> +}

Looks like vfio does the map in region_add(), if we can have different=20
types of memory regions (e.g some were under an IOMMU but others were=20
not), do we need to switch to do this in vhost_iommu_region_add() ?

Thanks

> +
>   static void vhost_region_nop(MemoryListener *listener,
>                                MemoryRegionSection *section)
>   {
> @@ -1298,6 +1346,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *=
opaque,
>       hdev->iommu_listener =3D (MemoryListener) {
>           .region_add =3D vhost_iommu_region_add,
>           .region_del =3D vhost_iommu_region_del,
> +        .commit =3D vhost_iommu_commit,
>       };
>  =20
>       if (hdev->migration_blocker =3D=3D NULL) {
