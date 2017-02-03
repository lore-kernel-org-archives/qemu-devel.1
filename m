Received: from eggs.gnu.org ([2001:4830:134:3::10]:35274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhXN-0007Q5-U0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZhXK-0000px-3U
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cZhXJ-0000pm-TP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:20:38 -0500
Date: Fri, 3 Feb 2017 10:20:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170203102036.21faba1e@t450s.home>
In-Reply-To: <1486110164-13797-4-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 03/18] vfio: allow to notify unmap for
 very large region
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

On Fri,  3 Feb 2017 16:22:29 +0800
Peter Xu <peterx@redhat.com> wrote:

> Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
> region. This can be leveraged by QEMU IOMMU implementation to cleanup
> existing page mappings for an entire iova address space (by notifying
> with an IOTLB with extremely huge addr_mask). However current
> vfio_iommu_map_notify() does not allow that. It make sure that all the
> translated address in IOTLB is falling into RAM range.
> 
> The check makes sense, but it should only be a sensible checker for
> mapping operations, and mean little for unmap operations.
> 
> This patch moves this check into map logic only, so that we'll get
> faster unmap handling (no need to translate again), and also we can then
> better support unmapping a very big region when it covers non-ram ranges
> or even not-existing ranges.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/common.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 42c4790..f3ba9b9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -352,11 +352,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>  
>      rcu_read_lock();
>  
> -    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> -        goto out;
> -    }
> -
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> +        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +            goto out;
> +        }
>          /*
>           * vaddr is only valid until rcu_read_unlock(). But after
>           * vfio_dma_map has set up the mapping the pages will be
