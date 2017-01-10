Received: from eggs.gnu.org ([2001:4830:134:3::10]:59070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQznS-0007CU-Lz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQznP-00058h-LJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:01:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQznP-00058O-Cx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:01:15 -0500
References: <1479991949-11311-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14810c5b-1cac-b6d0-c5e0-f8be848e8db3@redhat.com>
Date: Tue, 10 Jan 2017 18:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <1479991949-11311-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] memory: add section range info for
 IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, david@gibson.dropbear.id.au



On 24/11/2016 13:52, Peter Xu wrote:
> In this patch, IOMMUNotifier.{start|end} are introduced to store section
> information for a specific notifier. When notification occurs, we not
> only check the notification type (MAP|UNMAP), but also check whether the
> notified iova is in the range of specific IOMMU notifier, and skip those
> notifiers if not in the listened range.
> 
> When removing an region, we need to make sure we removed the correct
> VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> 
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Seems to be a VFIO bugfix, so

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> ---
> v2:
> - replace offset_within_address_space with offset_within_region since
>   IOTLB iova is relative to region [David]
> ---
>  hw/vfio/common.c      | 7 ++++++-
>  include/exec/memory.h | 3 +++
>  memory.c              | 4 +++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 801578b..6f648da 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -455,6 +455,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          giommu->container = container;
>          giommu->n.notify = vfio_iommu_map_notify;
>          giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
> +        giommu->n.start = section->offset_within_region;
> +        llend = int128_add(int128_make64(giommu->n.start), section->size);
> +        llend = int128_sub(llend, int128_one());
> +        giommu->n.end = int128_get64(llend);
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>  
>          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> @@ -525,7 +529,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>          VFIOGuestIOMMU *giommu;
>  
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> -            if (giommu->iommu == section->mr) {
> +            if (giommu->iommu == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
>                  memory_region_unregister_iommu_notifier(giommu->iommu,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9728a2f..87357ea 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -84,6 +84,9 @@ typedef enum {
>  struct IOMMUNotifier {
>      void (*notify)(struct IOMMUNotifier *notifier, IOMMUTLBEntry *data);
>      IOMMUNotifierFlag notifier_flags;
> +    /* Notify for address space range start <= addr <= end */
> +    hwaddr start;
> +    hwaddr end;
>      QLIST_ENTRY(IOMMUNotifier) node;
>  };
>  typedef struct IOMMUNotifier IOMMUNotifier;
> diff --git a/memory.c b/memory.c
> index 33110e9..f89d047 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1662,7 +1662,9 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>      }
>  
>      QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> -        if (iommu_notifier->notifier_flags & request_flags) {
> +        if (iommu_notifier->notifier_flags & request_flags &&
> +            iommu_notifier->start <= entry.iova &&
> +            iommu_notifier->end >= entry.iova) {
>              iommu_notifier->notify(iommu_notifier, &entry);
>          }
>      }
> 
