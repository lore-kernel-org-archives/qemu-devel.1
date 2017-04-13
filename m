Received: from eggs.gnu.org ([2001:4830:134:3::10]:49843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akpm@linux-foundation.org>) id 1cykwg-0005Xp-V6
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akpm@linux-foundation.org>) id 1cykwe-0005bL-BZ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:02:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akpm@linux-foundation.org>)
	id 1cykwe-0005aD-5Z
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:02:20 -0400
Date: Thu, 13 Apr 2017 13:02:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20170413130217.2316b0394192d8677f5ddbdf@linux-foundation.org>
In-Reply-To: <1492076108-117229-4-git-send-email-wei.w.wang@intel.com>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 3/5] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Thu, 13 Apr 2017 17:35:06 +0800 Wei Wang <wei.w.wang@intel.com> wrote:

> Add a function to find a page block on the free list specified by the
> caller. Pages from the page block may be used immediately after the
> function returns. The caller is responsible for detecting or preventing
> the use of such pages.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4498,6 +4498,93 @@ void show_free_areas(unsigned int filter)
>  	show_swap_cache_info();
>  }
>  
> +/**
> + * Heuristically get a page block in the system that is unused.
> + * It is possible that pages from the page block are used immediately after
> + * inquire_unused_page_block() returns. It is the caller's responsibility
> + * to either detect or prevent the use of such pages.
> + *
> + * The free list to check: zone->free_area[order].free_list[migratetype].
> + *
> + * If the caller supplied page block (i.e. **page) is on the free list, offer
> + * the next page block on the list to the caller. Otherwise, offer the first
> + * page block on the list.
> + *
> + * Return 0 when a page block is found on the caller specified free list.
> + */
> +int inquire_unused_page_block(struct zone *zone, unsigned int order,
> +			      unsigned int migratetype, struct page **page)
> +{

Perhaps we can wrap this in the appropriate ifdef so the kernels which
won't be using virtio-balloon don't carry the added overhead.
