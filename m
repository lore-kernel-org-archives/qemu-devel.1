Received: from eggs.gnu.org ([2001:4830:134:3::10]:35584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhYv-0000QE-W8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhYs-0001YX-Ph
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:22:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cZhYs-0001YG-HY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:22:14 -0500
Date: Fri, 3 Feb 2017 10:22:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170203102213.104d75ef@t450s.home>
In-Reply-To: <1486110164-13797-11-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-11-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 10/18] memory: add section range info
 for IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, bd.aviv@gmail.com

On Fri,  3 Feb 2017 16:22:36 +0800
Peter Xu <peterx@redhat.com> wrote:

> In this patch, IOMMUNotifier.{start|end} are introduced to store section
> information for a specific notifier. When notification occurs, we not
> only check the notification type (MAP|UNMAP), but also check whether the
> notified iova range overlaps with the range of specific IOMMU notifier,
> and skip those notifiers if not in the listened range.
> 
> When removing an region, we need to make sure we removed the correct
> VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> 
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/common.c      | 12 +++++++++---
>  hw/virtio/vhost.c     |  4 ++--
>  include/exec/memory.h | 19 ++++++++++++++++++-
>  memory.c              |  9 +++++++++
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f3ba9b9..6b33b9f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          giommu->iommu_offset = section->offset_within_address_space -
>                                 section->offset_within_region;
>          giommu->container = container;
> -        giommu->n.notify = vfio_iommu_map_notify;
> -        giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
> +        llend = int128_add(int128_make64(section->offset_within_region),
> +                           section->size);
> +        llend = int128_sub(llend, int128_one());
> +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> +                            IOMMU_NOTIFIER_ALL,
> +                            section->offset_within_region,
> +                            int128_get64(llend));
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>  
>          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> @@ -550,7 +555,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>          VFIOGuestIOMMU *giommu;
>  
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> -            if (giommu->iommu == section->mr) {
> +            if (giommu->iommu == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
>                  memory_region_unregister_iommu_notifier(giommu->iommu,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);


Acked-by: Alex Williamson <alex.williamson@redhat.com>
