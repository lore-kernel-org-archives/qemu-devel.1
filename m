Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dmKAZ-0006VK-0C
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dmKAV-0007vt-0r
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:33:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41053 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dmKAU-0007vQ-NI
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:33:30 -0400
Date: Mon, 28 Aug 2017 15:33:26 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170828133326.GN17097@dhcp22.suse.cz>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503914913-28893-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v15 4/5] mm: support reporting free page
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

On Mon 28-08-17 18:08:32, Wei Wang wrote:
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

OK, looks much better. I still have few nits.

> +extern void walk_free_mem_block(void *opaque,
> +				int min_order,
> +				bool (*report_page_block)(void *, unsigned long,
> +							  unsigned long));
> +

please add names to arguments of the prototype

>  /*
>   * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
>   * into the buddy system. The freed pages will be poisoned with pattern
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d00f74..81eedc7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4762,6 +4762,71 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  	show_swap_cache_info();
>  }
>  
> +/**
> + * walk_free_mem_block - Walk through the free page blocks in the system
> + * @opaque: the context passed from the caller
> + * @min_order: the minimum order of free lists to check
> + * @report_page_block: the callback function to report free page blocks

page_block has meaning in the core MM which doesn't strictly match its
usage here. Moreover we are reporting pfn ranges rather than struct page
range. So report_pfn_range would suit better.

[...]
> +	for_each_populated_zone(zone) {
> +		for (order = MAX_ORDER - 1; order >= min_order; order--) {
> +			for (mt = 0; !stop && mt < MIGRATE_TYPES; mt++) {
> +				spin_lock_irqsave(&zone->lock, flags);
> +				list = &zone->free_area[order].free_list[mt];
> +				list_for_each_entry(page, list, lru) {
> +					pfn = page_to_pfn(page);
> +					stop = report_page_block(opaque, pfn,
> +								 1 << order);
> +					if (stop)
> +						break;

					if (stop) {
						spin_unlock_irqrestore(&zone->lock, flags);
						return;
					}

would be both easier and less error prone. E.g. You wouldn't pointlessly
iterate over remaining orders just to realize there is nothing to be
done for those...

> +				}
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +			}
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(walk_free_mem_block);

-- 
Michal Hocko
SUSE Labs
