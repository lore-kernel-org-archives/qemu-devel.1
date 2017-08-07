Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpQ-0005yq-E4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpI-0005kQ-Sz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpI-0005k4-Ma
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:33 -0400
Message-Id: <1502149958-23381-18-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 17/22] translate-all: discard TB when
 tb_link_page returns an existing matching TB
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

Use the recently-gained QHT feature of returning the matching TB if it
already exists. This allows us to get rid of the lookup we perform
right after acquiring tb_lock.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      | 14 ++------------
 accel/tcg/translate-all.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2222e8c..d86081a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -237,10 +237,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         if (tb == NULL) {
             mmap_lock();
             tb_lock();
-            tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
-            if (likely(tb == NULL)) {
-                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
-            }
+            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
             tb_unlock();
             mmap_unlock();
         }
@@ -348,14 +345,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
         tb_lock();
         acquired_tb_lock = true;
 
-        /* There's a chance that our desired tb has been translated while
-         * taking the locks so we check again inside the lock.
-         */
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
-        if (likely(tb == NULL)) {
-            /* if no translated code available, then translate it now */
-            tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
-        }
+        tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
 
         mmap_unlock();
         /* We add the TB in the virtual pc hash table for the fast lookup */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8eb7af3..4fc5c76 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1490,12 +1490,16 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
  * (-1) to indicate that only one page contains the TB.
  *
  * Called with mmap_lock held for user-mode emulation.
+ *
+ * Returns @tb or an existing TB that matches @tb.
  */
-static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
-                         tb_page_addr_t phys_page2)
+static TranslationBlock *
+tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
+             tb_page_addr_t phys_page2)
 {
     PageDesc *p;
     PageDesc *p2 = NULL;
+    void *existing_tb;
     uint32_t h;
 
     assert_memory_lock();
@@ -1503,6 +1507,11 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     /*
      * Add the TB to the page list.
      * To avoid deadlock, acquire first the lock of the lower-addressed page.
+     * We keep the locks held until after inserting the TB in the hash table,
+     * so that if the insertion fails we know for sure that the TBs are still
+     * in the page descriptors.
+     * Note that inserting into the hash table first isn't an option, since
+     * we can only insert TBs that are fully initialized.
      */
     p = page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
     if (likely(phys_page2 == -1)) {
@@ -1522,21 +1531,33 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
         tb_page_add(p2, tb, 1, phys_page2);
     }
 
+    /* add in the hash table */
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+                     tb->trace_vcpu_dstate);
+    existing_tb = qht_insert(&tb_ctx.htable, tb, h);
+
+    /* remove TB from the page(s) if we couldn't insert it */
+    if (existing_tb) {
+        tb_page_remove(p, tb);
+        invalidate_page_bitmap(p);
+        if (p2) {
+            tb_page_remove(p2, tb);
+            invalidate_page_bitmap(p2);
+        }
+        tb = existing_tb;
+    }
+
     if (p2) {
         page_unlock(p2);
     }
     page_unlock(p);
 
-    /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
-                     tb->trace_vcpu_dstate);
-    qht_insert(&tb_ctx.htable, tb, h);
-
 #ifdef CONFIG_USER_ONLY
     if (DEBUG_TB_CHECK_GATE) {
         tb_page_check();
     }
 #endif
+    return tb;
 }
 
 /* Called with mmap_lock held for user mode emulation.  */
@@ -1545,7 +1566,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                               uint32_t flags, int cflags)
 {
     CPUArchState *env = cpu->env_ptr;
-    TranslationBlock *tb;
+    TranslationBlock *tb, *existing_tb;
     tb_page_addr_t phys_pc, phys_page2;
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
@@ -1676,7 +1697,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * memory barrier is required before tb_link_page() makes the TB visible
      * through the physical hash table and physical page list.
      */
-    tb_link_page(tb, phys_pc, phys_page2);
+    existing_tb = tb_link_page(tb, phys_pc, phys_page2);
+    /* if the TB already exists, discard what we just translated */
+    if (unlikely(existing_tb != tb)) {
+        uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
+
+        orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
+        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
+        return existing_tb;
+    }
     tcg_tb_insert(tb);
     return tb;
 }
-- 
2.7.4
