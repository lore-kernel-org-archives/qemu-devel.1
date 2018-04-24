Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlin-00059m-Gl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlih-0000H0-V8
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:22:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAlih-0000Gs-Pz
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:22:07 -0400
Date: Mon, 23 Apr 2018 20:22:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180424002206.GB8651@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-11-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522980788-1252-11-git-send-email-cota@braap.org>
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
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 05, 2018 at 22:13:01 -0400, Emilio G. Cota wrote:
> +/*
> + * Lock a range of pages ([@start,@end[) as well as the pages of all
> + * intersecting TBs.
> + * Locking order: acquire locks in ascending order of page index.
> + */
> +struct page_collection *
> +page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
> +{
> +    struct page_collection *set = g_malloc(sizeof(*set));
> +    tb_page_addr_t index;
> +    PageDesc *pd;
> +
> +    start >>= TARGET_PAGE_BITS;
> +    end   >>= TARGET_PAGE_BITS;
> +    g_assert(start <= end);
> +
> +    set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
> +                                page_entry_destroy);
> +    set->max = NULL;
> +
> + retry:
> +    g_tree_foreach(set->tree, page_entry_lock, NULL);
> +
> +    for (index = start; index <= end; index++) {
> +        TranslationBlock *tb;
> +        int n;
> +
> +        pd = page_find(index);
> +        if (pd == NULL) {
> +            continue;
> +        }

Just noticed there's a bug here: we need to acquire pd's page lock,
since it protects the traversal of the list of pd's TBs.

Fixed in v3 as shown below.

> +        PAGE_FOR_EACH_TB(pd, tb, n) {
> +            if (page_trylock_add(set, tb->page_addr[0]) ||
> +                (tb->page_addr[1] != -1 &&
> +                 page_trylock_add(set, tb->page_addr[1]))) {
> +                /* drop all locks, and reacquire in order */
> +                g_tree_foreach(set->tree, page_entry_unlock, NULL);
> +                goto retry;
> +            }
> +        }
> +    }
> +    return set;
> +}

Thanks,

		Emilio
---
@@ -840,6 +840,12 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
         if (pd == NULL) {
             continue;
         }
+        if (page_trylock_add(set, index << TARGET_PAGE_BITS)) {
+            g_tree_foreach(set->tree, page_entry_unlock, NULL);
+            set_page_collection_locked(false);
+            goto retry;
+        }
+        assert_page_locked(pd);
         PAGE_FOR_EACH_TB(pd, tb, n) {
             if (page_trylock_add(set, tb->page_addr[0]) ||
                 (tb->page_addr[1] != -1 &&
