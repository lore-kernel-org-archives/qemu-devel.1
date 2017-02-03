Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhWx-00076p-Cv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhWu-0000k0-6h
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cZhWt-0000ig-UO
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:12 -0500
Date: Fri, 3 Feb 2017 10:20:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170203102008.6589f92d@t450s.home>
In-Reply-To: <1486110164-13797-3-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 02/18] vfio: introduce vfio_get_vaddr()
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

On Fri,  3 Feb 2017 16:22:28 +0800
Peter Xu <peterx@redhat.com> wrote:

> A cleanup for vfio_iommu_map_notify(). Now we will fetch vaddr even if
> the operation is unmap, but it won't hurt much.
> 
> One thing to mention is that we need the RCU read lock to protect the
> whole translation and map/unmap procedure.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/common.c | 65 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 20 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 174f351..42c4790 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -294,54 +294,79 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>             section->offset_within_address_space & (1ULL << 63);
>  }
>  
> -static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +/* Called with rcu_read_lock held.  */
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
> +    bool writable = iotlb->perm & IOMMU_WO;
>  
>      /*
>       * The IOMMU TLB entry we have just covers translation through
>       * this IOMMU to its immediate target.  We need to translate
>       * it the rest of the way through to memory.
>       */
> -    rcu_read_lock();
>      mr = address_space_translate(&address_space_memory,
>                                   iotlb->translated_addr,
> -                                 &xlat, &len, iotlb->perm & IOMMU_WO);
> +                                 &xlat, &len, writable);
>      if (!memory_region_is_ram(mr)) {
>          error_report("iommu map to non memory area %"HWADDR_PRIx"",
>                       xlat);
> -        goto out;
> +        return false;
>      }
> +
>      /*
>       * Translation truncates length to the IOMMU page size,
>       * check that it did not truncate too much.
>       */
>      if (len & iotlb->addr_mask) {
>          error_report("iommu has granularity incompatible with target AS");
> +        return false;
> +    }
> +
> +    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +    *read_only = !writable || mr->readonly;
> +
> +    return true;
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
> +    rcu_read_lock();
> +
> +    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
>          goto out;
>      }
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        /*
> +         * vaddr is only valid until rcu_read_unlock(). But after
> +         * vfio_dma_map has set up the mapping the pages will be
> +         * pinned by the kernel. This makes sure that the RAM backend
> +         * of vaddr will always be there, even if the memory object is
> +         * destroyed and its backing memory munmap-ed.
> +         */
>          ret = vfio_dma_map(container, iova,
>                             iotlb->addr_mask + 1, vaddr,
> -                           !(iotlb->perm & IOMMU_WO) || mr->readonly);
> +                           read_only);
>          if (ret) {
>              error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx", %p) = %d (%m)",
