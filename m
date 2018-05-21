Received: from eggs.gnu.org ([2001:4830:134:3::10]:57897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOv-0002f7-I1
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005Z2-BT
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005Xa-Fd
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:21 -0400
Message-Id: <1526945967-9687-12-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/17] translate-all: add page_locked
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is only compiled under CONFIG_DEBUG_TCG to avoid
bloating the binary.

In user-mode, assert_page_locked is equivalent to assert_mmap_lock.

Note: There are some tb_lock assertions left that will be
removed by later patches.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 14c2c23..8286203 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -583,6 +583,9 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 
 /* In user-mode page locks aren't used; mmap_lock is enough */
 #ifdef CONFIG_USER_ONLY
+
+#define assert_page_locked(pd) tcg_debug_assert(have_mmap_lock())
+
 static inline void page_lock(PageDesc *pd)
 { }
 
@@ -605,14 +608,80 @@ void page_collection_unlock(struct page_collection *set)
 { }
 #else /* !CONFIG_USER_ONLY */
 
+#ifdef CONFIG_DEBUG_TCG
+
+static __thread GHashTable *ht_pages_locked_debug;
+
+static void ht_pages_locked_debug_init(void)
+{
+    if (ht_pages_locked_debug) {
+        return;
+    }
+    ht_pages_locked_debug = g_hash_table_new(NULL, NULL);
+}
+
+static bool page_is_locked(const PageDesc *pd)
+{
+    PageDesc *found;
+
+    ht_pages_locked_debug_init();
+    found = g_hash_table_lookup(ht_pages_locked_debug, pd);
+    return !!found;
+}
+
+static void page_lock__debug(PageDesc *pd)
+{
+    ht_pages_locked_debug_init();
+    g_assert(!page_is_locked(pd));
+    g_hash_table_insert(ht_pages_locked_debug, pd, pd);
+}
+
+static void page_unlock__debug(const PageDesc *pd)
+{
+    bool removed;
+
+    ht_pages_locked_debug_init();
+    g_assert(page_is_locked(pd));
+    removed = g_hash_table_remove(ht_pages_locked_debug, pd);
+    g_assert(removed);
+}
+
+static void
+do_assert_page_locked(const PageDesc *pd, const char *file, int line)
+{
+    if (unlikely(!page_is_locked(pd))) {
+        error_report("assert_page_lock: PageDesc %p not locked @ %s:%d",
+                     pd, file, line);
+        abort();
+    }
+}
+
+#define assert_page_locked(pd) do_assert_page_locked(pd, __FILE__, __LINE__)
+
+#else /* !CONFIG_DEBUG_TCG */
+
+#define assert_page_locked(pd)
+
+static inline void page_lock__debug(const PageDesc *pd)
+{
+}
+
+static inline void page_unlock__debug(const PageDesc *pd)
+{
+}
+
+#endif /* CONFIG_DEBUG_TCG */
+
 static inline void page_lock(PageDesc *pd)
 {
+    page_lock__debug(pd);
     qemu_spin_lock(&pd->lock);
 }
 
 static inline void page_unlock(PageDesc *pd)
 {
     qemu_spin_unlock(&pd->lock);
+    page_unlock__debug(pd);
 }
 
 /* lock the page(s) of a TB in the correct acquisition order */
@@ -775,6 +844,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
             g_tree_foreach(set->tree, page_entry_unlock, NULL);
             goto retry;
         }
+        assert_page_locked(pd);
         PAGE_FOR_EACH_TB(pd, tb, n) {
             if (page_trylock_add(set, tb->page_addr[0]) ||
                 (tb->page_addr[1] != -1 &&
@@ -1113,6 +1183,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 /* call with @p->lock held */
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
+    assert_page_locked(p);
 #ifdef CONFIG_SOFTMMU
     g_free(p->code_bitmap);
     p->code_bitmap = NULL;
@@ -1269,6 +1340,7 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
     uintptr_t *pprev;
     unsigned int n1;
 
+    assert_page_locked(pd);
     pprev = &pd->first_tb;
     PAGE_FOR_EACH_TB(pd, tb1, n1) {
         if (tb1 == tb) {
@@ -1417,6 +1489,7 @@ static void build_page_bitmap(PageDesc *p)
     int n, tb_start, tb_end;
     TranslationBlock *tb;
 
+    assert_page_locked(p);
     p->code_bitmap = bitmap_new(TARGET_PAGE_SIZE);
 
     PAGE_FOR_EACH_TB(p, tb, n) {
@@ -1450,7 +1523,7 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
     bool page_already_protected;
 #endif
 
-    assert_memory_lock();
+    assert_page_locked(p);
 
     tb->page_addr[n] = page_addr;
     tb->page_next[n] = p->first_tb;
@@ -1721,8 +1794,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     uint32_t current_flags = 0;
 #endif /* TARGET_HAS_PRECISE_SMC */
 
-    assert_memory_lock();
-    assert_tb_locked();
+    assert_page_locked(p);
 
 #if defined(TARGET_HAS_PRECISE_SMC)
     if (cpu != NULL) {
@@ -1734,6 +1806,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     /* XXX: see if in some cases it could be faster to invalidate all
        the code */
     PAGE_FOR_EACH_TB(p, tb, n) {
+        assert_page_locked(p);
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1891,6 +1964,7 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
     }
 
     pages = page_collection_lock(start, start + len);
+    assert_page_locked(p);
     if (!p->code_bitmap &&
         ++p->code_write_count >= SMC_BITMAP_USE_THRESHOLD) {
         build_page_bitmap(p);
@@ -1949,6 +2023,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         env = cpu->env_ptr;
     }
 #endif
+    assert_page_locked(p);
     PAGE_FOR_EACH_TB(p, tb, n) {
 #ifdef TARGET_HAS_PRECISE_SMC
         if (current_tb == tb &&
-- 
2.7.4
