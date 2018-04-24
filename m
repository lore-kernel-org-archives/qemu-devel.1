Received: from eggs.gnu.org ([2001:4830:134:3::10]:57713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlfK-0004Gu-K7
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAlfF-0007PQ-JC
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:18:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAlfF-0007P8-CL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:18:33 -0400
Date: Mon, 23 Apr 2018 20:18:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180424001831.GA8651@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-11-git-send-email-cota@braap.org>
	<87be5f7f-e33e-a101-ff01-2a7375ac9934@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87be5f7f-e33e-a101-ff01-2a7375ac9934@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 13, 2018 at 17:29:20 -1000, Richard Henderson wrote:
> On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
(snip)
> > +struct page_collection {
> > +    GTree *tree;
> > +    struct page_entry *max;
> > +};
> 
> I don't understand the motivation for this data structure.  Substituting one
> tree for another does not, on the face of it, seem to be a win.
> 
> Given that your locking order is based on the physical address, I can
> understand that the sequential virtual addresses that these routines are given
> is not appropriate.  But surely you should know how many pages are involved,
> and therefore be able to allocate a flat array to hold the PageDesc.
> 
> > +/*
> > + * Lock a range of pages ([@start,@end[) as well as the pages of all
> > + * intersecting TBs.
> > + * Locking order: acquire locks in ascending order of page index.
> > + */
> 
> I don't think I understand this either.  From whence do you wind up with a
> range of physical addresses?

For instance in tb_invalidate_phys_page_range. We need to invalidate
all TBs associated with a range of phys addresses.

I am not sure how an array would make things easier, since we need
to lock the pages in the given range, as well as the pages that
overlap with the TBs in said range (since we'll invalidate the TBs).
For example, if we have to invalidate all TBs in the range A-E, it
is possible that a TB in page C will overlap with page K (not in
the original range), so we'll have to lock page K as well. All of
this needs to be done in order, that is, A-E,K.

If we had an array, we'd have to resize the array anytime we had
an out-of-range page, and then do a binary search in the array
to check whether we already locked that page. At this point
we'd be reinventing a binary tree, so it seems simpler to just
use a tree.

> > +struct page_collection *
> > +page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
> 
> ...
> 
> > +    /*
> > +     * Add the TB to the page list.
> > +     * To avoid deadlock, acquire first the lock of the lower-addressed page.
> > +     */
> > +    p = page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
> > +    if (likely(phys_page2 == -1)) {
> >          tb->page_addr[1] = -1;
> > +        page_lock(p);
> > +        tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
> > +    } else {
> > +        p2 = page_find_alloc(phys_page2 >> TARGET_PAGE_BITS, 1);
> > +        if (phys_pc < phys_page2) {
> > +            page_lock(p);
> > +            page_lock(p2);
> > +        } else {
> > +            page_lock(p2);
> > +            page_lock(p);
> > +        }
> 
> Extract this as a helper for use here and page_lock_tb?

Done. Alex already suggested this when reviewing v1; I should
have done it then instead of resisting. Fixup appended.

> >  /*
> >   * Invalidate all TBs which intersect with the target physical address range
> > + * [start;end[. NOTE: start and end must refer to the *same* physical page.
> > + * 'is_cpu_write_access' should be true if called from a real cpu write
> > + * access: the virtual CPU will exit the current TB if code is modified inside
> > + * this TB.
> > + *
> > + * Called with tb_lock/mmap_lock held for user-mode emulation
> > + * Called with tb_lock held for system-mode emulation
> > + */
> > +void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
> > +                                   int is_cpu_write_access)
> 
> FWIW, we should probably notice and optimize end = start + 1, which appears to
> have the largest number of users for e.g. watchpoints.

This is also the case when booting linux (~99% of cases). Once we
agree on the correctness of the whole thing we can look into
making the common case faster, if necessary.

Thanks,

		Emilio
---
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ff087..9b21c1a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -549,6 +549,9 @@ static inline PageDesc *page_find(tb_page_addr_t index)
     return page_find_alloc(index, 0);
 }
 
+static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
+                           PageDesc **ret_p2, tb_page_addr_t phys2, int alloc);
+
 /* In user-mode page locks aren't used; mmap_lock is enough */
 #ifdef CONFIG_USER_ONLY
 
@@ -682,17 +685,7 @@ static inline void page_unlock(PageDesc *pd)
 /* lock the page(s) of a TB in the correct acquisition order */
 static inline void page_lock_tb(const TranslationBlock *tb)
 {
-    if (likely(tb->page_addr[1] == -1)) {
-        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
-        return;
-    }
-    if (tb->page_addr[0] < tb->page_addr[1]) {
-        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
-        page_lock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
-    } else {
-        page_lock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
-        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
-    }
+    page_lock_pair(NULL, tb->page_addr[0], NULL, tb->page_addr[1], 0);
 }
 
 static inline void page_unlock_tb(const TranslationBlock *tb)
@@ -871,6 +864,33 @@ void page_collection_unlock(struct page_collection *set)
 
 #endif /* !CONFIG_USER_ONLY */
 
+static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
+                           PageDesc **ret_p2, tb_page_addr_t phys2, int alloc)
+{
+    PageDesc *p1, *p2;
+
+    g_assert(phys1 != -1 && phys1 != phys2);
+    p1 = page_find_alloc(phys1 >> TARGET_PAGE_BITS, alloc);
+    if (ret_p1) {
+        *ret_p1 = p1;
+    }
+    if (likely(phys2 == -1)) {
+        page_lock(p1);
+        return;
+    }
+    p2 = page_find_alloc(phys2 >> TARGET_PAGE_BITS, alloc);
+    if (ret_p2) {
+        *ret_p2 = p2;
+    }
+    if (phys1 < phys2) {
+        page_lock(p1);
+        page_lock(p2);
+    } else {
+        page_lock(p2);
+        page_lock(p1);
+    }
+}
+
 #if defined(CONFIG_USER_ONLY)
 /* Currently it is not recommended to allocate big chunks of data in
    user mode. It will change when a dedicated libc will be used.  */
@@ -1600,22 +1620,12 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
      * Note that inserting into the hash table first isn't an option, since
      * we can only insert TBs that are fully initialized.
      */
-    p = page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
-    if (likely(phys_page2 == -1)) {
-        tb->page_addr[1] = -1;
-        page_lock(p);
-        tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
-    } else {
-        p2 = page_find_alloc(phys_page2 >> TARGET_PAGE_BITS, 1);
-        if (phys_pc < phys_page2) {
-            page_lock(p);
-            page_lock(p2);
-        } else {
-            page_lock(p2);
-            page_lock(p);
-        }
-        tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
+    page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
+    tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
+    if (p2) {
         tb_page_add(p2, tb, 1, phys_page2);
+    } else {
+        tb->page_addr[1] = -1;
     }
 
     /* add in the hash table */
