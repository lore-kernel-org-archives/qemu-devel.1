Received: from eggs.gnu.org ([2001:4830:134:3::10]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyj-000772-12
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyg-0005ta-1g
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:17 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyf-0005sj-Nr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:13 -0400
Received: by mail-pg0-x236.google.com with SMTP id m5-v6so3366718pgd.3
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:40 -1000
Message-Id: <20180614193147.29680-12-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 11/18] translate-all: use per-page locking in
 !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting parallel TCG generation.

Instead of using a global lock (tb_lock) to protect changes
to pages, use fine-grained, per-page locks in !user-mode.
User-mode stays with mmap_lock.

Sometimes changes need to happen atomically on more than one
page (e.g. when a TB that spans across two pages is
added/invalidated, or when a range of pages is invalidated).
We therefore introduce struct page_collection, which helps
us keep track of a set of pages that have been locked in
the appropriate locking order (i.e. by ascending page index).

This commit first introduces the structs and the function helpers,
to then convert the calling code to use per-page locking. Note
that tb_lock is not removed yet.

While at it, rename tb_alloc_page to tb_page_add, which pairs with
tb_page_remove.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h |   3 +
 include/exec/exec-all.h   |   3 +-
 accel/tcg/translate-all.c | 444 ++++++++++++++++++++++++++++++++++----
 3 files changed, 409 insertions(+), 41 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index ba8e4d63c4..6d1d2588b5 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -23,6 +23,9 @@
 
 
 /* translate-all.c */
+struct page_collection *page_collection_lock(tb_page_addr_t start,
+                                             tb_page_addr_t end);
+void page_collection_unlock(struct page_collection *set);
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 54a3398374..a647cf8841 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -359,7 +359,8 @@ struct TranslationBlock {
     /* original tb when cflags has CF_NOCACHE */
     struct TranslationBlock *orig_tb;
     /* first and second physical page containing code. The lower bit
-       of the pointer tells the index in page_next[] */
+       of the pointer tells the index in page_next[].
+       The list is protected by the TB's page('s) lock(s) */
     uintptr_t page_next[2];
     tb_page_addr_t page_addr[2];
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83bb40fb20..1cc7aab82c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -112,8 +112,55 @@ typedef struct PageDesc {
 #else
     unsigned long flags;
 #endif
+#ifndef CONFIG_USER_ONLY
+    QemuSpin lock;
+#endif
 } PageDesc;
 
+/**
+ * struct page_entry - page descriptor entry
+ * @pd:     pointer to the &struct PageDesc of the page this entry represents
+ * @index:  page index of the page
+ * @locked: whether the page is locked
+ *
+ * This struct helps us keep track of the locked state of a page, without
+ * bloating &struct PageDesc.
+ *
+ * A page lock protects accesses to all fields of &struct PageDesc.
+ *
+ * See also: &struct page_collection.
+ */
+struct page_entry {
+    PageDesc *pd;
+    tb_page_addr_t index;
+    bool locked;
+};
+
+/**
+ * struct page_collection - tracks a set of pages (i.e. &struct page_entry's)
+ * @tree:   Binary search tree (BST) of the pages, with key == page index
+ * @max:    Pointer to the page in @tree with the highest page index
+ *
+ * To avoid deadlock we lock pages in ascending order of page index.
+ * When operating on a set of pages, we need to keep track of them so that
+ * we can lock them in order and also unlock them later. For this we collect
+ * pages (i.e. &struct page_entry's) in a binary search @tree. Given that the
+ * @tree implementation we use does not provide an O(1) operation to obtain the
+ * highest-ranked element, we use @max to keep track of the inserted page
+ * with the highest index. This is valuable because if a page is not in
+ * the tree and its index is higher than @max's, then we can lock it
+ * without breaking the locking order rule.
+ *
+ * Note on naming: 'struct page_set' would be shorter, but we already have a few
+ * page_set_*() helpers, so page_collection is used instead to avoid confusion.
+ *
+ * See also: page_collection_lock().
+ */
+struct page_collection {
+    GTree *tree;
+    struct page_entry *max;
+};
+
 /* list iterators for lists of tagged pointers in TranslationBlock */
 #define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
     for (n = (head) & 1, tb = (TranslationBlock *)((head) & ~1);        \
@@ -507,6 +554,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
             return NULL;
         }
         pd = g_new0(PageDesc, V_L2_SIZE);
+#ifndef CONFIG_USER_ONLY
+        {
+            int i;
+
+            for (i = 0; i < V_L2_SIZE; i++) {
+                qemu_spin_init(&pd[i].lock);
+            }
+        }
+#endif
         existing = atomic_cmpxchg(lp, NULL, pd);
         if (unlikely(existing)) {
             g_free(pd);
@@ -522,6 +578,253 @@ static inline PageDesc *page_find(tb_page_addr_t index)
     return page_find_alloc(index, 0);
 }
 
+static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
+                           PageDesc **ret_p2, tb_page_addr_t phys2, int alloc);
+
+/* In user-mode page locks aren't used; mmap_lock is enough */
+#ifdef CONFIG_USER_ONLY
+static inline void page_lock(PageDesc *pd)
+{ }
+
+static inline void page_unlock(PageDesc *pd)
+{ }
+
+static inline void page_lock_tb(const TranslationBlock *tb)
+{ }
+
+static inline void page_unlock_tb(const TranslationBlock *tb)
+{ }
+
+struct page_collection *
+page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
+{
+    return NULL;
+}
+
+void page_collection_unlock(struct page_collection *set)
+{ }
+#else /* !CONFIG_USER_ONLY */
+
+static inline void page_lock(PageDesc *pd)
+{
+    qemu_spin_lock(&pd->lock);
+}
+
+static inline void page_unlock(PageDesc *pd)
+{
+    qemu_spin_unlock(&pd->lock);
+}
+
+/* lock the page(s) of a TB in the correct acquisition order */
+static inline void page_lock_tb(const TranslationBlock *tb)
+{
+    page_lock_pair(NULL, tb->page_addr[0], NULL, tb->page_addr[1], 0);
+}
+
+static inline void page_unlock_tb(const TranslationBlock *tb)
+{
+    page_unlock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
+    if (unlikely(tb->page_addr[1] != -1)) {
+        page_unlock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
+    }
+}
+
+static inline struct page_entry *
+page_entry_new(PageDesc *pd, tb_page_addr_t index)
+{
+    struct page_entry *pe = g_malloc(sizeof(*pe));
+
+    pe->index = index;
+    pe->pd = pd;
+    pe->locked = false;
+    return pe;
+}
+
+static void page_entry_destroy(gpointer p)
+{
+    struct page_entry *pe = p;
+
+    g_assert(pe->locked);
+    page_unlock(pe->pd);
+    g_free(pe);
+}
+
+/* returns false on success */
+static bool page_entry_trylock(struct page_entry *pe)
+{
+    bool busy;
+
+    busy = qemu_spin_trylock(&pe->pd->lock);
+    if (!busy) {
+        g_assert(!pe->locked);
+        pe->locked = true;
+    }
+    return busy;
+}
+
+static void do_page_entry_lock(struct page_entry *pe)
+{
+    page_lock(pe->pd);
+    g_assert(!pe->locked);
+    pe->locked = true;
+}
+
+static gboolean page_entry_lock(gpointer key, gpointer value, gpointer data)
+{
+    struct page_entry *pe = value;
+
+    do_page_entry_lock(pe);
+    return FALSE;
+}
+
+static gboolean page_entry_unlock(gpointer key, gpointer value, gpointer data)
+{
+    struct page_entry *pe = value;
+
+    if (pe->locked) {
+        pe->locked = false;
+        page_unlock(pe->pd);
+    }
+    return FALSE;
+}
+
+/*
+ * Trylock a page, and if successful, add the page to a collection.
+ * Returns true ("busy") if the page could not be locked; false otherwise.
+ */
+static bool page_trylock_add(struct page_collection *set, tb_page_addr_t addr)
+{
+    tb_page_addr_t index = addr >> TARGET_PAGE_BITS;
+    struct page_entry *pe;
+    PageDesc *pd;
+
+    pe = g_tree_lookup(set->tree, &index);
+    if (pe) {
+        return false;
+    }
+
+    pd = page_find(index);
+    if (pd == NULL) {
+        return false;
+    }
+
+    pe = page_entry_new(pd, index);
+    g_tree_insert(set->tree, &pe->index, pe);
+
+    /*
+     * If this is either (1) the first insertion or (2) a page whose index
+     * is higher than any other so far, just lock the page and move on.
+     */
+    if (set->max == NULL || pe->index > set->max->index) {
+        set->max = pe;
+        do_page_entry_lock(pe);
+        return false;
+    }
+    /*
+     * Try to acquire out-of-order lock; if busy, return busy so that we acquire
+     * locks in order.
+     */
+    return page_entry_trylock(pe);
+}
+
+static gint tb_page_addr_cmp(gconstpointer ap, gconstpointer bp, gpointer udata)
+{
+    tb_page_addr_t a = *(const tb_page_addr_t *)ap;
+    tb_page_addr_t b = *(const tb_page_addr_t *)bp;
+
+    if (a == b) {
+        return 0;
+    } else if (a < b) {
+        return -1;
+    }
+    return 1;
+}
+
+/*
+ * Lock a range of pages ([@start,@end[) as well as the pages of all
+ * intersecting TBs.
+ * Locking order: acquire locks in ascending order of page index.
+ */
+struct page_collection *
+page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
+{
+    struct page_collection *set = g_malloc(sizeof(*set));
+    tb_page_addr_t index;
+    PageDesc *pd;
+
+    start >>= TARGET_PAGE_BITS;
+    end   >>= TARGET_PAGE_BITS;
+    g_assert(start <= end);
+
+    set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
+                                page_entry_destroy);
+    set->max = NULL;
+
+ retry:
+    g_tree_foreach(set->tree, page_entry_lock, NULL);
+
+    for (index = start; index <= end; index++) {
+        TranslationBlock *tb;
+        int n;
+
+        pd = page_find(index);
+        if (pd == NULL) {
+            continue;
+        }
+        if (page_trylock_add(set, index << TARGET_PAGE_BITS)) {
+            g_tree_foreach(set->tree, page_entry_unlock, NULL);
+            goto retry;
+        }
+        PAGE_FOR_EACH_TB(pd, tb, n) {
+            if (page_trylock_add(set, tb->page_addr[0]) ||
+                (tb->page_addr[1] != -1 &&
+                 page_trylock_add(set, tb->page_addr[1]))) {
+                /* drop all locks, and reacquire in order */
+                g_tree_foreach(set->tree, page_entry_unlock, NULL);
+                goto retry;
+            }
+        }
+    }
+    return set;
+}
+
+void page_collection_unlock(struct page_collection *set)
+{
+    /* entries are unlocked and freed via page_entry_destroy */
+    g_tree_destroy(set->tree);
+    g_free(set);
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
+static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
+                           PageDesc **ret_p2, tb_page_addr_t phys2, int alloc)
+{
+    PageDesc *p1, *p2;
+
+    assert_memory_lock();
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
@@ -807,6 +1110,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
     return tb;
 }
 
+/* call with @p->lock held */
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
 #ifdef CONFIG_SOFTMMU
@@ -828,8 +1132,10 @@ static void page_flush_tb_1(int level, void **lp)
         PageDesc *pd = *lp;
 
         for (i = 0; i < V_L2_SIZE; ++i) {
+            page_lock(&pd[i]);
             pd[i].first_tb = (uintptr_t)NULL;
             invalidate_page_bitmap(pd + i);
+            page_unlock(&pd[i]);
         }
     } else {
         void **pp = *lp;
@@ -956,6 +1262,7 @@ static void tb_page_check(void)
 
 #endif /* CONFIG_USER_ONLY */
 
+/* call with @pd->lock held */
 static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
@@ -1032,11 +1339,8 @@ static inline void tb_jmp_unlink(TranslationBlock *tb)
     }
 }
 
-/* invalidate one TB
- *
- * Called with tb_lock held.
- */
-void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
+/* If @rm_from_page_list is set, call with the TB's pages' locks held */
+static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 {
     CPUState *cpu;
     PageDesc *p;
@@ -1056,15 +1360,15 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
     }
 
     /* remove the TB from the page list */
-    if (tb->page_addr[0] != page_addr) {
+    if (rm_from_page_list) {
         p = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
         tb_page_remove(p, tb);
         invalidate_page_bitmap(p);
-    }
-    if (tb->page_addr[1] != -1 && tb->page_addr[1] != page_addr) {
-        p = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
-        tb_page_remove(p, tb);
-        invalidate_page_bitmap(p);
+        if (tb->page_addr[1] != -1) {
+            p = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
+            tb_page_remove(p, tb);
+            invalidate_page_bitmap(p);
+        }
     }
 
     /* remove the TB from the hash list */
@@ -1086,7 +1390,28 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
                tcg_ctx->tb_phys_invalidate_count + 1);
 }
 
+static void tb_phys_invalidate__locked(TranslationBlock *tb)
+{
+    do_tb_phys_invalidate(tb, true);
+}
+
+/* invalidate one TB
+ *
+ * Called with tb_lock held.
+ */
+void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
+{
+    if (page_addr == -1) {
+        page_lock_tb(tb);
+        do_tb_phys_invalidate(tb, true);
+        page_unlock_tb(tb);
+    } else {
+        do_tb_phys_invalidate(tb, false);
+    }
+}
+
 #ifdef CONFIG_SOFTMMU
+/* call with @p->lock held */
 static void build_page_bitmap(PageDesc *p)
 {
     int n, tb_start, tb_end;
@@ -1116,11 +1441,11 @@ static void build_page_bitmap(PageDesc *p)
 /* add the tb in the target page and protect it if necessary
  *
  * Called with mmap_lock held for user-mode emulation.
+ * Called with @p->lock held.
  */
-static inline void tb_alloc_page(TranslationBlock *tb,
-                                 unsigned int n, tb_page_addr_t page_addr)
+static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
+                               unsigned int n, tb_page_addr_t page_addr)
 {
-    PageDesc *p;
 #ifndef CONFIG_USER_ONLY
     bool page_already_protected;
 #endif
@@ -1128,7 +1453,6 @@ static inline void tb_alloc_page(TranslationBlock *tb,
     assert_memory_lock();
 
     tb->page_addr[n] = page_addr;
-    p = page_find_alloc(page_addr >> TARGET_PAGE_BITS, 1);
     tb->page_next[n] = p->first_tb;
 #ifndef CONFIG_USER_ONLY
     page_already_protected = p->first_tb != (uintptr_t)NULL;
@@ -1180,18 +1504,28 @@ static inline void tb_alloc_page(TranslationBlock *tb,
 static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
                          tb_page_addr_t phys_page2)
 {
+    PageDesc *p;
+    PageDesc *p2 = NULL;
     uint32_t h;
 
     assert_memory_lock();
 
-    /* add in the page list */
-    tb_alloc_page(tb, 0, phys_pc & TARGET_PAGE_MASK);
-    if (phys_page2 != -1) {
-        tb_alloc_page(tb, 1, phys_page2);
+    /*
+     * Add the TB to the page list, acquiring first the pages's locks.
+     */
+    page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
+    tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
+    if (p2) {
+        tb_page_add(p2, tb, 1, phys_page2);
     } else {
         tb->page_addr[1] = -1;
     }
 
+    if (p2) {
+        page_unlock(p2);
+    }
+    page_unlock(p);
+
     /* add in the hash table */
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
                      tb->trace_vcpu_dstate);
@@ -1364,21 +1698,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 }
 
 /*
- * Invalidate all TBs which intersect with the target physical address range
- * [start;end[. NOTE: start and end must refer to the *same* physical page.
- * 'is_cpu_write_access' should be true if called from a real cpu write
- * access: the virtual CPU will exit the current TB if code is modified inside
- * this TB.
- *
- * Called with tb_lock/mmap_lock held for user-mode emulation
- * Called with tb_lock held for system-mode emulation
+ * Call with all @pages locked.
+ * @p must be non-NULL.
  */
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access)
+static void
+tb_invalidate_phys_page_range__locked(struct page_collection *pages,
+                                      PageDesc *p, tb_page_addr_t start,
+                                      tb_page_addr_t end,
+                                      int is_cpu_write_access)
 {
     TranslationBlock *tb;
     tb_page_addr_t tb_start, tb_end;
-    PageDesc *p;
     int n;
 #ifdef TARGET_HAS_PRECISE_SMC
     CPUState *cpu = current_cpu;
@@ -1394,10 +1724,6 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
     assert_memory_lock();
     assert_tb_locked();
 
-    p = page_find(start >> TARGET_PAGE_BITS);
-    if (!p) {
-        return;
-    }
 #if defined(TARGET_HAS_PRECISE_SMC)
     if (cpu != NULL) {
         env = cpu->env_ptr;
@@ -1443,7 +1769,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                      &current_flags);
             }
 #endif /* TARGET_HAS_PRECISE_SMC */
-            tb_phys_invalidate(tb, -1);
+            tb_phys_invalidate__locked(tb);
         }
     }
 #if !defined(CONFIG_USER_ONLY)
@@ -1455,6 +1781,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
+        page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         cpu->cflags_next_tb = 1 | curr_cflags();
         cpu_loop_exit_noexc(cpu);
@@ -1462,6 +1789,35 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 }
 
+/*
+ * Invalidate all TBs which intersect with the target physical address range
+ * [start;end[. NOTE: start and end must refer to the *same* physical page.
+ * 'is_cpu_write_access' should be true if called from a real cpu write
+ * access: the virtual CPU will exit the current TB if code is modified inside
+ * this TB.
+ *
+ * Called with tb_lock/mmap_lock held for user-mode emulation
+ * Called with tb_lock held for system-mode emulation
+ */
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
+                                   int is_cpu_write_access)
+{
+    struct page_collection *pages;
+    PageDesc *p;
+
+    assert_memory_lock();
+    assert_tb_locked();
+
+    p = page_find(start >> TARGET_PAGE_BITS);
+    if (p == NULL) {
+        return;
+    }
+    pages = page_collection_lock(start, end);
+    tb_invalidate_phys_page_range__locked(pages, p, start, end,
+                                          is_cpu_write_access);
+    page_collection_unlock(pages);
+}
+
 /*
  * Invalidate all TBs which intersect with the target physical address range
  * [start;end[. NOTE: start and end may refer to *different* physical pages.
@@ -1474,15 +1830,22 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
  */
 static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
 {
+    struct page_collection *pages;
     tb_page_addr_t next;
 
+    pages = page_collection_lock(start, end);
     for (next = (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
          start < end;
          start = next, next += TARGET_PAGE_SIZE) {
+        PageDesc *pd = page_find(start >> TARGET_PAGE_BITS);
         tb_page_addr_t bound = MIN(next, end);
 
-        tb_invalidate_phys_page_range(start, bound, 0);
+        if (pd == NULL) {
+            continue;
+        }
+        tb_invalidate_phys_page_range__locked(pages, pd, start, bound, 0);
     }
+    page_collection_unlock(pages);
 }
 
 #ifdef CONFIG_SOFTMMU
@@ -1508,6 +1871,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
  */
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
 {
+    struct page_collection *pages;
     PageDesc *p;
 
 #if 0
@@ -1525,11 +1889,10 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
     if (!p) {
         return;
     }
+
+    pages = page_collection_lock(start, start + len);
     if (!p->code_bitmap &&
         ++p->code_write_count >= SMC_BITMAP_USE_THRESHOLD) {
-        /* build code bitmap.  FIXME: writes should be protected by
-         * tb_lock, reads by tb_lock or RCU.
-         */
         build_page_bitmap(p);
     }
     if (p->code_bitmap) {
@@ -1543,8 +1906,9 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
         }
     } else {
     do_invalidate:
-        tb_invalidate_phys_page_range(start, start + len, 1);
+        tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
     }
+    page_collection_unlock(pages);
 }
 #else
 /* Called with mmap_lock held. If pc is not 0 then it indicates the
-- 
2.17.1
