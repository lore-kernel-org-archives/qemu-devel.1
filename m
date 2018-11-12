Received: from eggs.gnu.org ([2001:4830:134:3::10]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK39-0003X2-I9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK38-0004xl-G5
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK38-0004xQ-9h
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:14 -0500
Received: by mail-wm1-x341.google.com with SMTP id 124-v6so10004274wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:52 +0100
Message-Id: <20181112214503.22941-7-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 06/17] tcg: Add
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
Cc: cota@braap.org

This variant of tcg-ldst.inc.c allows the entire thunk to be
moved out-of-line, with caching across TBs within a region.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h              |  4 ++
 tcg/tcg-ldst-ool.inc.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c              | 20 +++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 tcg/tcg-ldst-ool.inc.c

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f4efbaa680..1255d2a2c6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -706,6 +706,10 @@ struct TCGContext {
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdst) ldst_labels;
 #endif
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdstOol) ldst_ool_labels;
+    GHashTable *ldst_ool_thunks;
+#endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
 #endif
diff --git a/tcg/tcg-ldst-ool.inc.c b/tcg/tcg-ldst-ool.inc.c
new file mode 100644
index 0000000000..8fb6550a8d
--- /dev/null
+++ b/tcg/tcg-ldst-ool.inc.c
@@ -0,0 +1,94 @@
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
index 54f1272187..885d842a12 100644
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
@@ -964,6 +971,11 @@ void tcg_context_init(TCGContext *s)
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
@@ -3540,6 +3552,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_INIT(&s->ldst_labels);
 #endif
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    QSIMPLEQ_INIT(&s->ldst_ool_labels);
+#endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
 #endif
@@ -3620,6 +3635,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
