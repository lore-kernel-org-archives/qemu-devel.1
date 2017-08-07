Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpN-0005yb-HW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpH-0005iw-9k
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpH-0005iJ-3f
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:26 -0400
Message-Id: <1502149958-23381-11-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 10/22] translate-all: iterate over TBs in a
 page with page_for_each_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This commit does several things, but to avoid churn I merged them all
into the same commit. To wit:

- Use uintptr_t instead of TranslationBlock * for the list of TBs in a page.
  Just like we did in (c37e6d7e "tcg: Use uintptr_t type for
  jmp_list_{next|first} fields of TB"), the rationale is the same: these
  are tagged pointers, not pointers. So use a more appropriate type.

- Only check the least significant bit of the tagged pointers. Masking
  with 3/~3 is unnecessary and confusing.

- Use the new tb_for_each_tagged macros to define page_for_each_tb(_safe),
  which improves readability.

- Update tb_page_remove to use page_for_each_tb_safe(). In case there
  is a bug and we attempt to remove a TB that is not in the list, instead
  of segfaulting (since the list is NULL-terminated) we will reach
  g_assert_not_reached().

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  2 +-
 accel/tcg/translate-all.c | 57 ++++++++++++++++++++---------------------------
 2 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 32e97e1..26084c3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -381,7 +381,7 @@ struct TranslationBlock {
     struct TranslationBlock *orig_tb;
     /* first and second physical page containing code. The lower bit
        of the pointer tells the index in page_next[] */
-    struct TranslationBlock *page_next[2];
+    uintptr_t page_next[2];
     tb_page_addr_t page_addr[2];
 
     /* The following data are used to directly call another TB from
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 396c10c..8e5e5b2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -104,7 +104,7 @@
 
 typedef struct PageDesc {
     /* list of TBs intersecting this ram page */
-    TranslationBlock *first_tb;
+    uintptr_t first_tb;
 #ifdef CONFIG_SOFTMMU
     /* in order to optimize self modifying code, we count the number
        of lookups we do to a given page to use a bitmap */
@@ -134,6 +134,12 @@ typedef struct PageDesc {
              n = (uintptr_t)*prev & 1,                          \
              tb = (TranslationBlock *)(*prev & ~1))
 
+#define page_for_each_tb(pagedesc, tb, n)                       \
+    tb_for_each_tagged((pagedesc)->first_tb, tb, n, page_next)
+
+#define page_for_each_tb_safe(pagedesc, tb, n, prev)                    \
+    tb_for_each_tagged_safe((pagedesc)->first_tb, tb, n, page_next, prev)
+
 /* In system mode we want L1_MAP to be based on ram offsets,
    while in user mode we want it to be based on virtual addresses.  */
 #if !defined(CONFIG_USER_ONLY)
@@ -834,7 +840,7 @@ static void page_flush_tb_1(int level, void **lp)
         PageDesc *pd = *lp;
 
         for (i = 0; i < V_L2_SIZE; ++i) {
-            pd[i].first_tb = NULL;
+            pd[i].first_tb = (uintptr_t)NULL;
             invalidate_page_bitmap(pd + i);
         }
     } else {
@@ -962,21 +968,19 @@ static void tb_page_check(void)
 
 #endif /* CONFIG_USER_ONLY */
 
-static inline void tb_page_remove(TranslationBlock **ptb, TranslationBlock *tb)
+static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
+    uintptr_t *prev;
     unsigned int n1;
 
-    for (;;) {
-        tb1 = *ptb;
-        n1 = (uintptr_t)tb1 & 3;
-        tb1 = (TranslationBlock *)((uintptr_t)tb1 & ~3);
+    page_for_each_tb_safe(pd, tb1, n1, prev) {
         if (tb1 == tb) {
-            *ptb = tb1->page_next[n1];
-            break;
+            *prev = tb1->page_next[n1];
+            return;
         }
-        ptb = &tb1->page_next[n1];
     }
+    g_assert_not_reached();
 }
 
 /* remove the TB from a list of TBs jumping to the n-th jump target of the TB */
@@ -1062,12 +1066,12 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
     /* remove the TB from the page list */
     if (tb->page_addr[0] != page_addr) {
         p = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
-        tb_page_remove(&p->first_tb, tb);
+        tb_page_remove(p, tb);
         invalidate_page_bitmap(p);
     }
     if (tb->page_addr[1] != -1 && tb->page_addr[1] != page_addr) {
         p = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
-        tb_page_remove(&p->first_tb, tb);
+        tb_page_remove(p, tb);
         invalidate_page_bitmap(p);
     }
 
@@ -1098,10 +1102,7 @@ static void build_page_bitmap(PageDesc *p)
 
     p->code_bitmap = bitmap_new(TARGET_PAGE_SIZE);
 
-    tb = p->first_tb;
-    while (tb != NULL) {
-        n = (uintptr_t)tb & 3;
-        tb = (TranslationBlock *)((uintptr_t)tb & ~3);
+    page_for_each_tb(p, tb, n) {
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1116,7 +1117,6 @@ static void build_page_bitmap(PageDesc *p)
             tb_end = ((tb->pc + tb->size) & ~TARGET_PAGE_MASK);
         }
         bitmap_set(p->code_bitmap, tb_start, tb_end - tb_start);
-        tb = tb->page_next[n];
     }
 }
 #endif
@@ -1139,9 +1139,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
     p = page_find_alloc(page_addr >> TARGET_PAGE_BITS, 1);
     tb->page_next[n] = p->first_tb;
 #ifndef CONFIG_USER_ONLY
-    page_already_protected = p->first_tb != NULL;
+    page_already_protected = p->first_tb != (uintptr_t)NULL;
 #endif
-    p->first_tb = (TranslationBlock *)((uintptr_t)tb | n);
+    p->first_tb = (uintptr_t)tb | n;
     invalidate_page_bitmap(p);
 
 #if defined(CONFIG_USER_ONLY)
@@ -1401,7 +1401,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access)
 {
-    TranslationBlock *tb, *tb_next;
+    TranslationBlock *tb;
 #if defined(TARGET_HAS_PRECISE_SMC)
     CPUState *cpu = current_cpu;
     CPUArchState *env = NULL;
@@ -1434,11 +1434,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
     /* we remove all the TBs in the range [start, end[ */
     /* XXX: see if in some cases it could be faster to invalidate all
        the code */
-    tb = p->first_tb;
-    while (tb != NULL) {
-        n = (uintptr_t)tb & 3;
-        tb = (TranslationBlock *)((uintptr_t)tb & ~3);
-        tb_next = tb->page_next[n];
+    page_for_each_tb(p, tb, n) {
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1475,7 +1471,6 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate(tb, -1);
         }
-        tb = tb_next;
     }
 #if !defined(CONFIG_USER_ONLY)
     /* if no code remaining, no need to continue to use slow writes */
@@ -1572,18 +1567,15 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     }
 
     tb_lock();
-    tb = p->first_tb;
 #ifdef TARGET_HAS_PRECISE_SMC
-    if (tb && pc != 0) {
+    if (p->first_tb && pc != 0) {
         current_tb = tcg_tb_lookup(pc);
     }
     if (cpu != NULL) {
         env = cpu->env_ptr;
     }
 #endif
-    while (tb != NULL) {
-        n = (uintptr_t)tb & 3;
-        tb = (TranslationBlock *)((uintptr_t)tb & ~3);
+    page_for_each_tb(p, tb, n) {
 #ifdef TARGET_HAS_PRECISE_SMC
         if (current_tb == tb &&
             (current_tb->cflags & CF_COUNT_MASK) != 1) {
@@ -1600,9 +1592,8 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         }
 #endif /* TARGET_HAS_PRECISE_SMC */
         tb_phys_invalidate(tb, addr);
-        tb = tb->page_next[n];
     }
-    p->first_tb = NULL;
+    p->first_tb = (uintptr_t)NULL;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
         /* we generate a block containing just the instruction
-- 
2.7.4
