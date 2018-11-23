Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-0007yT-Qu
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCid-00038B-MO
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCic-00036n-KQ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id 125so12199204wmh.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:25 +0100
Message-Id: <20181123144558.5048-5-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 04/37] tcg: Add
 TCG_TARGET_NEED_LDST_OOL_LABELS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This variant of tcg-ldst.inc.c allows the entire thunk to be
moved out-of-line, with caching across TBs within a region.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h                 |  5 +++
 accel/tcg/translate-all.c | 15 +++++--
 tcg/tcg-ldst-ool.inc.c    | 95 +++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c                 | 28 ++++++++++++
 4 files changed, 140 insertions(+), 3 deletions(-)
 create mode 100644 tcg/tcg-ldst-ool.inc.c

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f4efbaa680..73737dc671 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -706,6 +706,11 @@ struct TCGContext {
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdst) ldst_labels;
 #endif
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdstOol) ldst_ool_labels;
+    GHashTable *ldst_ool_thunks;
+    size_t ldst_ool_generation;
+#endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 639f0b2728..dd9332b24c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1678,6 +1678,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size;
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    size_t ldst_ool_generation = tcg_ctx->ldst_ool_generation;
+#endif
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
@@ -1831,10 +1834,16 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     existing_tb = tb_link_page(tb, phys_pc, phys_page2);
     /* if the TB already exists, discard what we just translated */
     if (unlikely(existing_tb != tb)) {
-        uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
+        bool discard = true;
 
-        orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
-        atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+        discard = ldst_ool_generation == tcg_ctx->ldst_ool_generation;
+#endif
+        if (discard) {
+            uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
+            orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
+            atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
+        }
         return existing_tb;
     }
     tcg_tb_insert(tb);
diff --git a/tcg/tcg-ldst-ool.inc.c b/tcg/tcg-ldst-ool.inc.c
new file mode 100644
index 0000000000..70b8789797
--- /dev/null
+++ b/tcg/tcg-ldst-ool.inc.c
@@ -0,0 +1,95 @@
+/*
+ * TCG Backend Data: load-store optimization only.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+typedef struct TCGLabelQemuLdstOol {
+    QSIMPLEQ_ENTRY(TCGLabelQemuLdstOol) next;
+    tcg_insn_unit *label;   /* label pointer to be updated */
+    int reloc;              /* relocation type from label_ptr */
+    intptr_t addend;        /* relocation addend from label_ptr */
+    uint32_t key;           /* oi : is_64 : is_ld */
+} TCGLabelQemuLdstOol;
+
+
+/*
+ * Generate TB finalization at the end of block
+ */
+
+static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
+                                            bool is64, TCGMemOpIdx oi);
+
+static bool tcg_out_ldst_ool_finalize(TCGContext *s)
+{
+    TCGLabelQemuLdstOol *lb;
+
+    /* qemu_ld/st slow paths */
+    QSIMPLEQ_FOREACH(lb, &s->ldst_ool_labels, next) {
+        gpointer dest, key = (gpointer)(uintptr_t)lb->key;
+        TCGMemOpIdx oi;
+        bool is_ld, is_64, ok;
+
+        /* If we have generated the thunk, and it's still in range, all ok.  */
+        dest = g_hash_table_lookup(s->ldst_ool_thunks, key);
+        if (dest &&
+            patch_reloc(lb->label, lb->reloc, (intptr_t)dest, lb->addend)) {
+            continue;
+        }
+
+        /* Generate a new thunk.  */
+        is_ld = extract32(lb->key, 0, 1);
+        is_64 = extract32(lb->key, 1, 1);
+        oi = extract32(lb->key, 2, 30);
+        dest = tcg_out_qemu_ldst_ool(s, is_ld, is_64, oi);
+
+        /* Test for (pending) buffer overflow.  The assumption is that any
+           one thunk beginning below the high water mark cannot overrun
+           the buffer completely.  Thus we can test for overflow after
+           generating code without having to check during generation.  */
+        if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
+            return false;
+        }
+
+        /* Remember the thunk for next time.  */
+        g_hash_table_replace(s->ldst_ool_thunks, key, dest);
+        s->ldst_ool_generation++;
+
+        /* The new thunk must be in range.  */
+        ok = patch_reloc(lb->label, lb->reloc, (intptr_t)dest, lb->addend);
+        tcg_debug_assert(ok);
+    }
+    return true;
+}
+
+/*
+ * Allocate a new TCGLabelQemuLdstOol entry.
+ */
+
+static void add_ldst_ool_label(TCGContext *s, bool is_ld, bool is_64,
+                               TCGMemOpIdx oi, int reloc, intptr_t addend)
+{
+    TCGLabelQemuLdstOol *lb = tcg_malloc(sizeof(*lb));
+
+    QSIMPLEQ_INSERT_TAIL(&s->ldst_ool_labels, lb, next);
+    lb->label = s->code_ptr;
+    lb->reloc = reloc;
+    lb->addend = addend;
+    lb->key = is_ld | (is_64 << 1) | (oi << 2);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 54f1272187..17c193791f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -521,6 +521,13 @@ static void tcg_region_assign(TCGContext *s, size_t curr_region)
     s->code_gen_ptr = start;
     s->code_gen_buffer_size = end - start;
     s->code_gen_highwater = end - TCG_HIGHWATER;
+
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    /* No thunks yet generated this region.  Even if they were in range,
+       this is also the most convenient place to clear the table after a
+       full tb_flush.  */
+    g_hash_table_remove_all(s->ldst_ool_thunks);
+#endif
 }
 
 static bool tcg_region_alloc__locked(TCGContext *s)
@@ -756,6 +763,14 @@ void tcg_register_thread(void)
     err = tcg_region_initial_alloc__locked(tcg_ctx);
     g_assert(!err);
     qemu_mutex_unlock(&region.lock);
+
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    /* If n == 0, keep the hash table we allocated in tcg_context_init.  */
+    if (n) {
+        /* Both key and value are raw pointers.  */
+        s->ldst_ool_thunks = g_hash_table_new(NULL, NULL);
+    }
+#endif
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -964,6 +979,11 @@ void tcg_context_init(TCGContext *s)
     tcg_debug_assert(!tcg_regset_test_reg(s->reserved_regs, TCG_AREG0));
     ts = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, TCG_AREG0, "env");
     cpu_env = temp_tcgv_ptr(ts);
+
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    /* Both key and value are raw pointers.  */
+    s->ldst_ool_thunks = g_hash_table_new(NULL, NULL);
+#endif
 }
 
 /*
@@ -3540,6 +3560,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_INIT(&s->ldst_labels);
 #endif
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    QSIMPLEQ_INIT(&s->ldst_ool_labels);
+#endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
 #endif
@@ -3620,6 +3643,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         return -1;
     }
 #endif
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    if (!tcg_out_ldst_ool_finalize(s)) {
+        return -1;
+    }
+#endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     if (!tcg_out_pool_finalize(s)) {
         return -1;
-- 
2.17.2
