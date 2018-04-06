Received: from eggs.gnu.org ([2001:4830:134:3::10]:58438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsL-0002GW-UJ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsJ-0003Vn-UJ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GsJ-0003VI-QN
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Apr 2018 22:13:02 -0400
Message-Id: <1522980788-1252-12-git-send-email-cota@braap.org>
In-Reply-To: <1522980788-1252-1-git-send-email-cota@braap.org>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/17] translate-all: add page_locked
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is only compiled under CONFIG_DEBUG_TCG to avoid
bloating the binary.

In user-mode, assert_page_locked is equivalent to assert_mmap_lock.

Note: There are some tb_lock assertions left that will be
removed by later patches.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 90 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 042378a..29bc1da 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -580,6 +580,9 @@ static inline PageDesc *page_find(tb_page_addr_t index)
 
 /* In user-mode page locks aren't used; mmap_lock is enough */
 #ifdef CONFIG_USER_ONLY
+
+#define assert_page_locked(pd) tcg_debug_assert(have_mmap_lock())
+
 static inline void page_lock(PageDesc *pd)
 { }
 
@@ -602,14 +605,91 @@ void page_collection_unlock(struct page_collection *set)
 { }
 #else /* !CONFIG_USER_ONLY */
 
+#ifdef CONFIG_DEBUG_TCG
+
+struct page_lock_debug {
+    const PageDesc *pd;
+    QLIST_ENTRY(page_lock_debug) entry;
+};
+
+static __thread QLIST_HEAD(, page_lock_debug) page_lock_debug_head;
+
+static struct page_lock_debug *get_page_lock_debug(const PageDesc *pd)
+{
+    struct page_lock_debug *pld;
+
+    QLIST_FOREACH(pld, &page_lock_debug_head, entry) {
+        if (pld->pd == pd) {
+            return pld;
+        }
+    }
+    return NULL;
+}
+
+static bool page_is_locked(const PageDesc *pd)
+{
+    struct page_lock_debug *pld;
+
+    pld = get_page_lock_debug(pd);
+    return pld != NULL;
+}
+
+static void page_lock__debug(const PageDesc *pd)
+{
+    struct page_lock_debug *pld;
+
+    g_assert(!page_is_locked(pd));
+    pld = g_new(struct page_lock_debug, 1);
+    pld->pd = pd;
+    QLIST_INSERT_HEAD(&page_lock_debug_head, pld, entry);
+}
+
+static void page_unlock__debug(const PageDesc *pd)
+{
+    struct page_lock_debug *pld;
+
+    pld = get_page_lock_debug(pd);
+    g_assert(pld);
+    QLIST_REMOVE(pld, entry);
+    g_free(pld);
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
@@ -1091,6 +1171,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 /* call with @p->lock held */
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
+    assert_page_locked(p);
 #ifdef CONFIG_SOFTMMU
     g_free(p->code_bitmap);
     p->code_bitmap = NULL;
@@ -1247,6 +1328,7 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
     uintptr_t *pprev;
     unsigned int n1;
 
+    assert_page_locked(pd);
     pprev = &pd->first_tb;
     PAGE_FOR_EACH_TB(pd, tb1, n1) {
         if (tb1 == tb) {
@@ -1395,6 +1477,7 @@ static void build_page_bitmap(PageDesc *p)
     int n, tb_start, tb_end;
     TranslationBlock *tb;
 
+    assert_page_locked(p);
     p->code_bitmap = bitmap_new(TARGET_PAGE_SIZE);
 
     PAGE_FOR_EACH_TB(p, tb, n) {
@@ -1428,7 +1511,7 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
     bool page_already_protected;
 #endif
 
-    assert_memory_lock();
+    assert_page_locked(p);
 
     tb->page_addr[n] = page_addr;
     tb->page_next[n] = p->first_tb;
@@ -1710,8 +1793,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     uint32_t current_flags = 0;
 #endif /* TARGET_HAS_PRECISE_SMC */
 
-    assert_memory_lock();
-    assert_tb_locked();
+    assert_page_locked(p);
 
 #if defined(TARGET_HAS_PRECISE_SMC)
     if (cpu != NULL) {
@@ -1723,6 +1805,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     /* XXX: see if in some cases it could be faster to invalidate all
        the code */
     PAGE_FOR_EACH_TB(p, tb, n) {
+        assert_page_locked(p);
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1879,6 +1962,7 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
     }
 
     pages = page_collection_lock(start, start + len);
+    assert_page_locked(p);
     if (!p->code_bitmap &&
         ++p->code_write_count >= SMC_BITMAP_USE_THRESHOLD) {
         build_page_bitmap(p);
-- 
2.7.4
