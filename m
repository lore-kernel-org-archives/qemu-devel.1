Received: from eggs.gnu.org ([2001:4830:134:3::10]:57893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOv-0002ep-CR
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005Yc-9J
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005XZ-Eq
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:23 -0400
Message-Id: <1526945967-9687-14-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 13/17] translate-all: discard TB when
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Use the recently-gained QHT feature of returning the matching TB if it
already exists. This allows us to get rid of the lookup we perform
right after acquiring tb_lock.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/multi-thread-tcg.txt |  3 +++
 accel/tcg/cpu-exec.c            | 14 ++----------
 accel/tcg/translate-all.c       | 50 +++++++++++++++++++++++++++++++++--------
 3 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index faf8918..faf09c6 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.txt
@@ -140,6 +140,9 @@ to atomically insert new elements.
 The lookup caches are updated atomically and the lookup hash uses QHT
 which is designed for concurrent safe lookup.
 
+Parallel code generation is supported. QHT is used at insertion time
+as the synchronization point across threads, thereby ensuring that we only
+keep track of a single TranslationBlock for each guest code block.
 
 Memory maps and TLBs
 --------------------
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad1f0c4..b45d10f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -246,10 +246,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
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
@@ -399,14 +396,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
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
index f3a0ecb..f24dcb8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1580,18 +1580,30 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
  * (-1) to indicate that only one page contains the TB.
  *
  * Called with mmap_lock held for user-mode emulation.
+ *
+ * Returns a pointer @tb, or a pointer to an existing TB that matches @tb.
+ * Note that in !user-mode, another thread might have already added a TB
+ * for the same block of guest code that @tb corresponds to. In that case,
+ * the caller should discard the original @tb, and use instead the returned TB.
  */
-static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
-                         tb_page_addr_t phys_page2)
+static TranslationBlock *
+tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
+             tb_page_addr_t phys_page2)
 {
     PageDesc *p;
     PageDesc *p2 = NULL;
+    void *existing_tb = NULL;
     uint32_t h;
 
     assert_memory_lock();
 
     /*
      * Add the TB to the page list, acquiring first the pages's locks.
+     * We keep the locks held until after inserting the TB in the hash table,
+     * so that if the insertion fails we know for sure that the TBs are still
+     * in the page descriptors.
+     * Note that inserting into the hash table first isn't an option, since
+     * we can only insert TBs that are fully initialized.
      */
     page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
     tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
@@ -1601,21 +1613,33 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
         tb->page_addr[1] = -1;
     }
 
+    /* add in the hash table */
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+                     tb->trace_vcpu_dstate);
+    qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
+
+    /* remove TB from the page(s) if we couldn't insert it */
+    if (unlikely(existing_tb)) {
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
-    qht_insert(&tb_ctx.htable, tb, h, NULL);
-
 #ifdef CONFIG_USER_ONLY
     if (DEBUG_TB_CHECK_GATE) {
         tb_page_check();
     }
 #endif
+    return tb;
 }
 
 /* Called with mmap_lock held for user mode emulation.  */
@@ -1624,7 +1648,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                               uint32_t flags, int cflags)
 {
     CPUArchState *env = cpu->env_ptr;
-    TranslationBlock *tb;
+    TranslationBlock *tb, *existing_tb;
     tb_page_addr_t phys_pc, phys_page2;
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
@@ -1772,7 +1796,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
