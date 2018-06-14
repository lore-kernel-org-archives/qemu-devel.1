Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyZ-0006wm-Og
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyW-0005kT-FD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:07 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyW-0005jz-73
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:04 -0400
Received: by mail-pg0-x243.google.com with SMTP id w8-v6so330794pgp.7
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:35 -1000
Message-Id: <20180614193147.29680-7-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/18] translate-all: iterate over TBs in a page
 with PAGE_FOR_EACH_TB
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

This commit does several things, but to avoid churn I merged them all
into the same commit. To wit:

- Use uintptr_t instead of TranslationBlock * for the list of TBs in a page.
  Just like we did in (c37e6d7e "tcg: Use uintptr_t type for
  jmp_list_{next|first} fields of TB"), the rationale is the same: these
  are tagged pointers, not pointers. So use a more appropriate type.

- Only check the least significant bit of the tagged pointers. Masking
  with 3/~3 is unnecessary and confusing.

- Introduce the TB_FOR_EACH_TAGGED macro, and use it to define
  PAGE_FOR_EACH_TB, which improves readability. Note that
  TB_FOR_EACH_TAGGED will gain another user in a subsequent patch.

- Update tb_page_remove to use PAGE_FOR_EACH_TB. In case there
  is a bug and we attempt to remove a TB that is not in the list, instead
  of segfaulting (since the list is NULL-terminated) we will reach
  g_assert_not_reached().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   |  2 +-
 accel/tcg/translate-all.c | 62 ++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 7684f4cb69..54a3398374 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -360,7 +360,7 @@ struct TranslationBlock {
     struct TranslationBlock *orig_tb;
     /* first and second physical page containing code. The lower bit
        of the pointer tells the index in page_next[] */
-    struct TranslationBlock *page_next[2];
+    uintptr_t page_next[2];
     tb_page_addr_t page_addr[2];
 
     /* The following data are used to directly call another TB from
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a9f2bfb468..52e62125ed 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -103,7 +103,7 @@
 
 typedef struct PageDesc {
     /* list of TBs intersecting this ram page */
-    TranslationBlock *first_tb;
+    uintptr_t first_tb;
 #ifdef CONFIG_SOFTMMU
     /* in order to optimize self modifying code, we count the number
        of lookups we do to a given page to use a bitmap */
@@ -114,6 +114,15 @@ typedef struct PageDesc {
 #endif
 } PageDesc;
 
+/* list iterators for lists of tagged pointers in TranslationBlock */
+#define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
+    for (n = (head) & 1, tb = (TranslationBlock *)((head) & ~1);        \
+         tb; tb = (TranslationBlock *)tb->field[n], n = (uintptr_t)tb & 1, \
+             tb = (TranslationBlock *)((uintptr_t)tb & ~1))
+
+#define PAGE_FOR_EACH_TB(pagedesc, tb, n)                       \
+    TB_FOR_EACH_TAGGED((pagedesc)->first_tb, tb, n, page_next)
+
 /* In system mode we want L1_MAP to be based on ram offsets,
    while in user mode we want it to be based on virtual addresses.  */
 #if !defined(CONFIG_USER_ONLY)
@@ -815,7 +824,7 @@ static void page_flush_tb_1(int level, void **lp)
         PageDesc *pd = *lp;
 
         for (i = 0; i < V_L2_SIZE; ++i) {
-            pd[i].first_tb = NULL;
+            pd[i].first_tb = (uintptr_t)NULL;
             invalidate_page_bitmap(pd + i);
         }
     } else {
@@ -943,21 +952,21 @@ static void tb_page_check(void)
 
 #endif /* CONFIG_USER_ONLY */
 
-static inline void tb_page_remove(TranslationBlock **ptb, TranslationBlock *tb)
+static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
+    uintptr_t *pprev;
     unsigned int n1;
 
-    for (;;) {
-        tb1 = *ptb;
-        n1 = (uintptr_t)tb1 & 3;
-        tb1 = (TranslationBlock *)((uintptr_t)tb1 & ~3);
+    pprev = &pd->first_tb;
+    PAGE_FOR_EACH_TB(pd, tb1, n1) {
         if (tb1 == tb) {
-            *ptb = tb1->page_next[n1];
-            break;
+            *pprev = tb1->page_next[n1];
+            return;
         }
-        ptb = &tb1->page_next[n1];
+        pprev = &tb1->page_next[n1];
     }
+    g_assert_not_reached();
 }
 
 /* remove the TB from a list of TBs jumping to the n-th jump target of the TB */
@@ -1045,12 +1054,12 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
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
 
@@ -1081,10 +1090,7 @@ static void build_page_bitmap(PageDesc *p)
 
     p->code_bitmap = bitmap_new(TARGET_PAGE_SIZE);
 
-    tb = p->first_tb;
-    while (tb != NULL) {
-        n = (uintptr_t)tb & 3;
-        tb = (TranslationBlock *)((uintptr_t)tb & ~3);
+    PAGE_FOR_EACH_TB(p, tb, n) {
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1099,7 +1105,6 @@ static void build_page_bitmap(PageDesc *p)
             tb_end = ((tb->pc + tb->size) & ~TARGET_PAGE_MASK);
         }
         bitmap_set(p->code_bitmap, tb_start, tb_end - tb_start);
-        tb = tb->page_next[n];
     }
 }
 #endif
@@ -1122,9 +1127,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
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
@@ -1401,7 +1406,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access)
 {
-    TranslationBlock *tb, *tb_next;
+    TranslationBlock *tb;
     tb_page_addr_t tb_start, tb_end;
     PageDesc *p;
     int n;
@@ -1432,11 +1437,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
     /* we remove all the TBs in the range [start, end[ */
     /* XXX: see if in some cases it could be faster to invalidate all
        the code */
-    tb = p->first_tb;
-    while (tb != NULL) {
-        n = (uintptr_t)tb & 3;
-        tb = (TranslationBlock *)((uintptr_t)tb & ~3);
-        tb_next = tb->page_next[n];
+    PAGE_FOR_EACH_TB(p, tb, n) {
         /* NOTE: this is subtle as a TB may span two physical pages */
         if (n == 0) {
             /* NOTE: tb_end may be after the end of the page, but
@@ -1474,7 +1475,6 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate(tb, -1);
         }
-        tb = tb_next;
     }
 #if !defined(CONFIG_USER_ONLY)
     /* if no code remaining, no need to continue to use slow writes */
@@ -1568,18 +1568,15 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
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
+    PAGE_FOR_EACH_TB(p, tb, n) {
 #ifdef TARGET_HAS_PRECISE_SMC
         if (current_tb == tb &&
             (current_tb->cflags & CF_COUNT_MASK) != 1) {
@@ -1596,9 +1593,8 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         }
 #endif /* TARGET_HAS_PRECISE_SMC */
         tb_phys_invalidate(tb, addr);
-        tb = tb->page_next[n];
     }
-    p->first_tb = NULL;
+    p->first_tb = (uintptr_t)NULL;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
-- 
2.17.1
