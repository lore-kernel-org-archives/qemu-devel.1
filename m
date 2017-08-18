Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dikzR-0000vq-0T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dikzN-00030E-RK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dikzN-0002zw-H7
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:23:17 -0400
Date: Fri, 18 Aug 2017 20:23:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170818201946-mutt-send-email-mst@kernel.org>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v14 4/5] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Thu, Aug 17, 2017 at 11:26:55AM +0800, Wei Wang wrote:
> This patch adds support to walk through the free page blocks in the
> system and report them via a callback function. Some page blocks may
> leave the free list after zone->lock is released, so it is the caller's
> responsibility to either detect or prevent the use of such pages.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/mm.h |  6 ++++++
>  mm/page_alloc.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 46b9ac5..cd29b9f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1835,6 +1835,12 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
>  		unsigned long zone_start_pfn, unsigned long *zholes_size);
>  extern void free_initmem(void);
>  
> +extern void walk_free_mem_block(void *opaque1,
> +				unsigned int min_order,
> +				void (*visit)(void *opaque2,
> +					      unsigned long pfn,
> +					      unsigned long nr_pages));
> +
>  /*
>   * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
>   * into the buddy system. The freed pages will be poisoned with pattern
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d00f74..a721a35 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4762,6 +4762,50 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  	show_swap_cache_info();
>  }
>  
> +/**
> + * walk_free_mem_block - Walk through the free page blocks in the system
> + * @opaque1: the context passed from the caller
> + * @min_order: the minimum order of free lists to check
> + * @visit: the callback function given by the caller
> + *
> + * The function is used to walk through the free page blocks in the system,
> + * and each free page block is reported to the caller via the @visit callback.
> + * Please note:
> + * 1) The function is used to report hints of free pages, so the caller should
> + * not use those reported pages after the callback returns.
> + * 2) The callback is invoked with the zone->lock being held, so it should not
> + * block and should finish as soon as possible.
> + */
> +void walk_free_mem_block(void *opaque1,
> +			 unsigned int min_order,
> +			 void (*visit)(void *opaque2,

You can just avoid opaque2 completely I think, then opaque1 can
be renamed opaque.

> +				       unsigned long pfn,
> +				       unsigned long nr_pages))
> +{
> +	struct zone *zone;
> +	struct page *page;
> +	struct list_head *list;
> +	unsigned int order;
> +	enum migratetype mt;
> +	unsigned long pfn, flags;
> +
> +	for_each_populated_zone(zone) {
> +		for (order = MAX_ORDER - 1;
> +		     order < MAX_ORDER && order >= min_order; order--) {
> +			for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> +				spin_lock_irqsave(&zone->lock, flags);
> +				list = &zone->free_area[order].free_list[mt];
> +				list_for_each_entry(page, list, lru) {
> +					pfn = page_to_pfn(page);
> +					visit(opaque1, pfn, 1 << order);

My only concern here is inability of callback to
1. break out of list
2. remove page from the list

So I would make the callback bool, and I would use
list_for_each_entry_safe.


> +				}
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +			}
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(walk_free_mem_block);
> +
>  static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
>  {
>  	zoneref->zone = zone;
> -- 
> 2.7.4
