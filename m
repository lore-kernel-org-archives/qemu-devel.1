Received: from eggs.gnu.org ([2001:4830:134:3::10]:46384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7BsZ-0001xy-49
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7BsV-0006DP-4h
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:29:31 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:34036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7BsU-0006Cw-TZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:29:27 -0400
Received: by mail-pl0-x22b.google.com with SMTP id y12-v6so7120398plt.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 20:29:26 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-11-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87be5f7f-e33e-a101-ff01-2a7375ac9934@linaro.org>
Date: Fri, 13 Apr 2018 17:29:20 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-11-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/17] translate-all: use per-page
 locking in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> +/**
> + * struct page_collection - tracks a set of pages (i.e. &struct page_entry's)
> + * @tree:   Binary search tree (BST) of the pages, with key == page index
> + * @max:    Pointer to the page in @tree with the highest page index
> + *
> + * To avoid deadlock we lock pages in ascending order of page index.
> + * When operating on a set of pages, we need to keep track of them so that
> + * we can lock them in order and also unlock them later. For this we collect
> + * pages (i.e. &struct page_entry's) in a binary search @tree. Given that the
> + * @tree implementation we use does not provide an O(1) operation to obtain the
> + * highest-ranked element, we use @max to keep track of the inserted page
> + * with the highest index. This is valuable because if a page is not in
> + * the tree and its index is higher than @max's, then we can lock it
> + * without breaking the locking order rule.
> + *
> + * Note on naming: 'struct page_set' would be shorter, but we already have a few
> + * page_set_*() helpers, so page_collection is used instead to avoid confusion.
> + *
> + * See also: page_collection_lock().
> + */
> +struct page_collection {
> +    GTree *tree;
> +    struct page_entry *max;
> +};

I don't understand the motivation for this data structure.  Substituting one
tree for another does not, on the face of it, seem to be a win.

Given that your locking order is based on the physical address, I can
understand that the sequential virtual addresses that these routines are given
is not appropriate.  But surely you should know how many pages are involved,
and therefore be able to allocate a flat array to hold the PageDesc.

> +/*
> + * Lock a range of pages ([@start,@end[) as well as the pages of all
> + * intersecting TBs.
> + * Locking order: acquire locks in ascending order of page index.
> + */

I don't think I understand this either.  From whence do you wind up with a
range of physical addresses?

> +struct page_collection *
> +page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)

...

> +    /*
> +     * Add the TB to the page list.
> +     * To avoid deadlock, acquire first the lock of the lower-addressed page.
> +     */
> +    p = page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
> +    if (likely(phys_page2 == -1)) {
>          tb->page_addr[1] = -1;
> +        page_lock(p);
> +        tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
> +    } else {
> +        p2 = page_find_alloc(phys_page2 >> TARGET_PAGE_BITS, 1);
> +        if (phys_pc < phys_page2) {
> +            page_lock(p);
> +            page_lock(p2);
> +        } else {
> +            page_lock(p2);
> +            page_lock(p);
> +        }

Extract this as a helper for use here and page_lock_tb?

>  /*
>   * Invalidate all TBs which intersect with the target physical address range
> + * [start;end[. NOTE: start and end must refer to the *same* physical page.
> + * 'is_cpu_write_access' should be true if called from a real cpu write
> + * access: the virtual CPU will exit the current TB if code is modified inside
> + * this TB.
> + *
> + * Called with tb_lock/mmap_lock held for user-mode emulation
> + * Called with tb_lock held for system-mode emulation
> + */
> +void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
> +                                   int is_cpu_write_access)

FWIW, we should probably notice and optimize end = start + 1, which appears to
have the largest number of users for e.g. watchpoints.


r~
