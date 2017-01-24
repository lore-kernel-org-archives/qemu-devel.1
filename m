Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cW3y5-0004Jr-PI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cW3xz-0004Ur-MY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:29:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cW3xz-0004Ug-Es
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:29:07 -0500
Date: Tue, 24 Jan 2017 09:29:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170124092905.41832531@t450s.home>
In-Reply-To: <1485253571-19058-3-git-send-email-peterx@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 24 Jan 2017 18:25:55 +0800
Peter Xu <peterx@redhat.com> wrote:

> A cleanup for vfio_iommu_map_notify(). Should have no functional change,
> just to make the function shorter and easier to understand.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/common.c | 58 +++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 174f351..ce55dff 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -294,25 +294,14 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>             section->offset_within_address_space & (1ULL << 63);
>  }
>  
> -static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> +                           bool *read_only)
>  {
> -    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> -    VFIOContainer *container = giommu->container;
> -    hwaddr iova = iotlb->iova + giommu->iommu_offset;
>      MemoryRegion *mr;
>      hwaddr xlat;
>      hwaddr len = iotlb->addr_mask + 1;
> -    void *vaddr;
> -    int ret;
> -
> -    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
> -                                iova, iova + iotlb->addr_mask);
> -
> -    if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> -        return;
> -    }
> +    bool ret = false;
> +    bool writable = iotlb->perm & IOMMU_WO;
>  
>      /*
>       * The IOMMU TLB entry we have just covers translation through
> @@ -322,12 +311,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>      mr = address_space_translate(&address_space_memory,
>                                   iotlb->translated_addr,
> -                                 &xlat, &len, iotlb->perm & IOMMU_WO);
> +                                 &xlat, &len, writable);
>      if (!memory_region_is_ram(mr)) {
>          error_report("iommu map to non memory area %"HWADDR_PRIx"",
>                       xlat);
>          goto out;
>      }
> +
>      /*
>       * Translation truncates length to the IOMMU page size,
>       * check that it did not truncate too much.
> @@ -337,11 +327,41 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>          goto out;
>      }
>  
> +    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +    *read_only = !writable || mr->readonly;
> +    ret = true;
> +
> +out:
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
> +static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +{
> +    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> +    VFIOContainer *container = giommu->container;
> +    hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    bool read_only;
> +    void *vaddr;
> +    int ret;
> +
> +    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
> +                                iova, iova + iotlb->addr_mask);
> +
> +    if (iotlb->target_as != &address_space_memory) {
> +        error_report("Wrong target AS \"%s\", only system memory is allowed",
> +                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        return;
> +    }
> +
> +    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +        return;
> +    }
> +
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>          ret = vfio_dma_map(container, iova,
>                             iotlb->addr_mask + 1, vaddr,
> -                           !(iotlb->perm & IOMMU_WO) || mr->readonly);
> +                           read_only);
>          if (ret) {
>              error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx", %p) = %d (%m)",
> @@ -357,8 +377,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                           iotlb->addr_mask + 1, ret);
>          }
>      }
> -out:
> -    rcu_read_unlock();

The comment from v4 still needs input from Paolo, is it valid to make
use of vaddr (based on address_space_translate ->
memory_region_get_ram_ptr) outside of the rcu read lock or could future
BQL reduction efforts allow this to race?

>  }
>  
>  static void vfio_listener_region_add(MemoryListener *listener,
