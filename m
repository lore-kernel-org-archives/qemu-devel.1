Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dzOX4-0007pN-K0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dzOWz-0000ck-Np
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44456 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dzOWz-0000Vt-Dn
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:45 -0400
Date: Tue, 3 Oct 2017 16:50:40 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20171003145040.7d2v3hwypnmmm72e@dhcp22.suse.cz>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506744354-20979-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v16 4/5] mm: support reporting free page
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
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Sat 30-09-17 12:05:53, Wei Wang wrote:
> This patch adds support to walk through the free page blocks in the
> system and report them via a callback function. Some page blocks may
> leave the free list after zone->lock is released, so it is the caller's
> responsibility to either detect or prevent the use of such pages.
> 
> One use example of this patch is to accelerate live migration by skipping
> the transfer of free pages reported from the guest. A popular method used
> by the hypervisor to track which part of memory is written during live
> migration is to write-protect all the guest memory. So, those pages that
> are reported as free pages but are written after the report function
> returns will be captured by the hypervisor, and they will be added to the
> next round of memory transfer.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h |  6 ++++
>  mm/page_alloc.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 46b9ac5..d9652c2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1835,6 +1835,12 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
>  		unsigned long zone_start_pfn, unsigned long *zholes_size);
>  extern void free_initmem(void);
>  
> +extern void walk_free_mem_block(void *opaque,
> +				int min_order,
> +				bool (*report_pfn_range)(void *opaque,
> +							 unsigned long pfn,
> +							 unsigned long num));
> +
>  /*
>   * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
>   * into the buddy system. The freed pages will be poisoned with pattern
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d00f74..c6bb874 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4762,6 +4762,97 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  	show_swap_cache_info();
>  }
>  
> +/*
> + * Walk through a free page list and report the found pfn range via the
> + * callback.
> + *
> + * Return false if the callback requests to stop reporting. Otherwise,
> + * return true.
> + */
> +static bool walk_free_page_list(void *opaque,
> +				struct zone *zone,
> +				int order,
> +				enum migratetype mt,
> +				bool (*report_pfn_range)(void *,
> +							 unsigned long,
> +							 unsigned long))
> +{
> +	struct page *page;
> +	struct list_head *list;
> +	unsigned long pfn, flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
> +	list = &zone->free_area[order].free_list[mt];
> +	list_for_each_entry(page, list, lru) {
> +		pfn = page_to_pfn(page);
> +		ret = report_pfn_range(opaque, pfn, 1 << order);
> +		if (!ret)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	return ret;
> +}
> +
> +/**
> + * walk_free_mem_block - Walk through the free page blocks in the system
> + * @opaque: the context passed from the caller
> + * @min_order: the minimum order of free lists to check
> + * @report_pfn_range: the callback to report the pfn range of the free pages
> + *
> + * If the callback returns false, stop iterating the list of free page blocks.
> + * Otherwise, continue to report.
> + *
> + * Please note that there are no locking guarantees for the callback and
> + * that the reported pfn range might be freed or disappear after the
> + * callback returns so the caller has to be very careful how it is used.
> + *
> + * The callback itself must not sleep or perform any operations which would
> + * require any memory allocations directly (not even GFP_NOWAIT/GFP_ATOMIC)
> + * or via any lock dependency. It is generally advisable to implement
> + * the callback as simple as possible and defer any heavy lifting to a
> + * different context.
> + *
> + * There is no guarantee that each free range will be reported only once
> + * during one walk_free_mem_block invocation.
> + *
> + * pfn_to_page on the given range is strongly discouraged and if there is
> + * an absolute need for that make sure to contact MM people to discuss
> + * potential problems.
> + *
> + * The function itself might sleep so it cannot be called from atomic
> + * contexts.
> + *
> + * In general low orders tend to be very volatile and so it makes more
> + * sense to query larger ones first for various optimizations which like
> + * ballooning etc... This will reduce the overhead as well.
> + */
> +void walk_free_mem_block(void *opaque,
> +			 int min_order,
> +			 bool (*report_pfn_range)(void *opaque,
> +						  unsigned long pfn,
> +						  unsigned long num))
> +{
> +	struct zone *zone;
> +	int order;
> +	enum migratetype mt;
> +	bool ret;
> +
> +	for_each_populated_zone(zone) {
> +		for (order = MAX_ORDER - 1; order >= min_order; order--) {
> +			for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> +				ret = walk_free_page_list(opaque, zone,
> +							  order, mt,
> +							  report_pfn_range);
> +				if (!ret)
> +					return;
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

-- 
Michal Hocko
SUSE Labs
