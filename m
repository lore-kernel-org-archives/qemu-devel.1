Received: from eggs.gnu.org ([2001:4830:134:3::10]:51955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tt-0002xX-Da
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5To-00082x-89
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:05 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tn-00081G-VM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:00 -0400
Received: by mail-pf0-x234.google.com with SMTP id e199so1621728pfh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:31 -0700
Message-Id: <20170907224051.21518-4-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/23] tcg: Infrastructure for managing constant
 pools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

A new shared header tcg-pool.inc.c adds new_pool_label,
for registering a tcg_target_ulong to be emitted after
the generated code, plus relocation data to install a
pointer to the data.

A new pointer is added to the TCGContext, so that we
dump the constant pool as data, not code.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h                 |  4 +++
 accel/tcg/translate-all.c | 22 +++++++++++-
 tcg/tcg-pool.inc.c        | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c                 |  9 +++++
 4 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tcg/tcg-pool.inc.c

diff --git a/tcg/tcg.h b/tcg/tcg.h
index b0e00e744e..ac94133870 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -702,6 +702,7 @@ struct TCGContext {
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
+    void *data_gen_ptr;
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
@@ -716,6 +717,9 @@ struct TCGContext {
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     struct TCGLabelQemuLdst *ldst_labels;
 #endif
+#ifdef TCG_TARGET_NEED_POOL_LABELS
+    struct TCGLabelPoolData *pool_labels;
+#endif
 
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 93a1cf2ba8..2d1ed06065 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1329,7 +1329,27 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         qemu_log_in_addr_range(tb->pc)) {
         qemu_log_lock();
         qemu_log("OUT: [size=%d]\n", gen_code_size);
-        log_disas(tb->tc_ptr, gen_code_size);
+        if (tcg_ctx.data_gen_ptr) {
+            size_t code_size = tcg_ctx.data_gen_ptr - tb->tc_ptr;
+            size_t data_size = gen_code_size - code_size;
+            size_t i;
+
+            log_disas(tb->tc_ptr, code_size);
+
+            for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
+                if (sizeof(tcg_target_ulong) == 8) {
+                    qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
+                             (uintptr_t)tcg_ctx.data_gen_ptr + i,
+                             *(uint64_t *)(tcg_ctx.data_gen_ptr + i));
+                } else {
+                    qemu_log("0x%08" PRIxPTR ":  .long  0x%08x\n",
+                             (uintptr_t)tcg_ctx.data_gen_ptr + i,
+                             *(uint32_t *)(tcg_ctx.data_gen_ptr + i));
+                }
+            }
+        } else {
+            log_disas(tb->tc_ptr, gen_code_size);
+        }
         qemu_log("\n");
         qemu_log_flush();
         qemu_log_unlock();
diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
new file mode 100644
index 0000000000..8a85131405
--- /dev/null
+++ b/tcg/tcg-pool.inc.c
@@ -0,0 +1,85 @@
+/*
+ * TCG Backend Data: constant pool.
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
+typedef struct TCGLabelPoolData {
+    struct TCGLabelPoolData *next;
+    tcg_target_ulong data;
+    tcg_insn_unit *label;
+    intptr_t addend;
+    int type;
+} TCGLabelPoolData;
+
+
+static void new_pool_label(TCGContext *s, tcg_target_ulong data, int type,
+                           tcg_insn_unit *label, intptr_t addend)
+{
+    TCGLabelPoolData *n = tcg_malloc(sizeof(*n));
+    TCGLabelPoolData *i, **pp;
+
+    n->data = data;
+    n->label = label;
+    n->type = type;
+    n->addend = addend;
+
+    /* Insertion sort on the pool.  */
+    for (pp = &s->pool_labels; (i = *pp) && i->data < data; pp = &i->next) {
+        continue;
+    }
+    n->next = *pp;
+    *pp = n;
+}
+
+/* To be provided by cpu/tcg-target.inc.c.  */
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
+
+static bool tcg_out_pool_finalize(TCGContext *s)
+{
+    TCGLabelPoolData *p = s->pool_labels;
+    tcg_target_ulong d, *a;
+
+    if (p == NULL) {
+        return true;
+    }
+
+    /* ??? Round up to qemu_icache_linesize, but then do not round
+       again when allocating the next TranslationBlock structure.  */
+    a = (void *)ROUND_UP((uintptr_t)s->code_ptr, sizeof(tcg_target_ulong));
+    tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
+    s->data_gen_ptr = a;
+
+    /* Ensure the first comparison fails.  */
+    d = p->data + 1;
+
+    for (; p != NULL; p = p->next) {
+        if (p->data != d) {
+            d = p->data;
+            if (unlikely((void *)a > s->code_gen_highwater)) {
+                return false;
+            }
+            *a++ = d;
+        }
+        patch_reloc(p->label, p->type, (intptr_t)(a - 1), p->addend);
+    }
+
+    s->code_ptr = (void *)a;
+    return true;
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dd74eabb0a..fd8a3dfe93 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -399,6 +399,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
         return NULL;
     }
     s->code_gen_ptr = next;
+    s->data_gen_ptr = NULL;
     return tb;
 }
 
@@ -2619,6 +2620,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     s->ldst_labels = NULL;
 #endif
+#ifdef TCG_TARGET_NEED_POOL_LABELS
+    s->pool_labels = NULL;
+#endif
 
     num_insns = -1;
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
@@ -2698,6 +2702,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         return -1;
     }
 #endif
+#ifdef TCG_TARGET_NEED_POOL_LABELS
+    if (!tcg_out_pool_finalize(s)) {
+        return -1;
+    }
+#endif
 
     /* flush instruction cache */
     flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
-- 
2.13.5
