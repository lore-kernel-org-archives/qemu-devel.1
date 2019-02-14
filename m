Received: from eggs.gnu.org ([209.51.188.92]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8m-00034j-R2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ0E-0005F3-2L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:13 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ0D-0005DB-DU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:09 -0500
Received: by mail-lf1-x142.google.com with SMTP id t14so5805704lfk.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:01:09 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:59 -0800
Message-Id: <20190214230000.24894-13-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 12/13] target/xtensa: break circular register
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Currently topologic opcode sorting stops at the first detected
dependency loop. Introduce struct opcode_arg_copy that describes
temporary register copy. Scan remaining opcodes searching for
dependencies that can be broken, break them by introducing temporary
register copies and record them in an array. In case of success
create local temporaries and initialize them with current register
values. Share single temporary copy between all register users. Delete
temporaries after translation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 127 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 276b435ce81e..8bc272d05b4b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -935,6 +935,12 @@ static int gen_postprocess(DisasContext *dc, int slot)
     return slot;
 }
 
+struct opcode_arg_copy {
+    uint32_t resource;
+    void *temp;
+    OpcodeArg *arg;
+};
+
 struct opcode_arg_info {
     uint32_t resource;
     int index;
@@ -961,6 +967,11 @@ static uint32_t encode_resource(enum resource_type r, unsigned g, unsigned n)
     return (r << 24) | (g << 16) | n;
 }
 
+static enum resource_type get_resource_type(uint32_t resource)
+{
+    return resource >> 24;
+}
+
 /*
  * a depends on b if b must be executed before a,
  * because a's side effects will destroy b's inputs.
@@ -987,6 +998,49 @@ static bool op_depends_on(const struct slot_prop *a,
 }
 
 /*
+ * Try to break a dependency on b, append temporary register copy records
+ * to the end of copy and update n_copy in case of success.
+ * This is not always possible: e.g. control flow must always be the last,
+ * load/store must be first and state dependencies are not supported yet.
+ */
+static bool break_dependency(struct slot_prop *a,
+                             struct slot_prop *b,
+                             struct opcode_arg_copy *copy,
+                             unsigned *n_copy)
+{
+    unsigned i = 0;
+    unsigned j = 0;
+    unsigned n = *n_copy;
+    bool rv = false;
+
+    if (a->op_flags & XTENSA_OP_CONTROL_FLOW) {
+        return false;
+    }
+    while (i < a->n_out && j < b->n_in) {
+        if (a->out[i].resource < b->in[j].resource) {
+            ++i;
+        } else if (a->out[i].resource > b->in[j].resource) {
+            ++j;
+        } else {
+            int index = b->in[j].index;
+
+            if (get_resource_type(a->out[i].resource) != RES_REGFILE ||
+                index < 0) {
+                return false;
+            }
+            copy[n].resource = b->in[j].resource;
+            copy[n].arg = b->arg + index;
+            ++n;
+            ++i;
+            ++j;
+            rv = true;
+        }
+    }
+    *n_copy = n;
+    return rv;
+}
+
+/*
  * Calculate evaluation order for slot opcodes.
  * Build opcode order graph and output its nodes in topological sort order.
  * An edge a -> b in the graph means that opcode a must be followed by
@@ -994,7 +1048,9 @@ static bool op_depends_on(const struct slot_prop *a,
  */
 static bool tsort(struct slot_prop *slot,
                   struct slot_prop *sorted[],
-                  unsigned n)
+                  unsigned n,
+                  struct opcode_arg_copy *copy,
+                  unsigned *n_copy)
 {
     struct tsnode {
         unsigned n_in_edge;
@@ -1007,7 +1063,8 @@ static bool tsort(struct slot_prop *slot,
     unsigned n_in = 0;
     unsigned n_out = 0;
     unsigned n_edge = 0;
-    unsigned in_idx;
+    unsigned in_idx = 0;
+    unsigned node_idx = 0;
 
     for (i = 0; i < n; ++i) {
         node[i].n_in_edge = 0;
@@ -1035,7 +1092,8 @@ static bool tsort(struct slot_prop *slot,
         }
     }
 
-    for (in_idx = 0; in_idx < n_in; ++in_idx) {
+again:
+    for (; in_idx < n_in; ++in_idx) {
         i = in[in_idx];
         sorted[n_out] = slot + i;
         ++n_out;
@@ -1047,6 +1105,29 @@ static bool tsort(struct slot_prop *slot,
             }
         }
     }
+    if (n_edge) {
+        for (; node_idx < n; ++node_idx) {
+            struct tsnode *cnode = node + node_idx;
+
+            if (cnode->n_in_edge) {
+                for (j = 0; j < cnode->n_out_edge; ++j) {
+                    unsigned k = cnode->out_edge[j];
+
+                    if (break_dependency(slot + k, slot + node_idx,
+                                         copy, n_copy) &&
+                        --node[k].n_in_edge == 0) {
+                        in[n_in] = k;
+                        ++n_in;
+                        --n_edge;
+                        cnode->out_edge[j] =
+                            cnode->out_edge[cnode->n_out_edge - 1];
+                        --cnode->n_out_edge;
+                        goto again;
+                    }
+                }
+            }
+        }
+    }
     return n_edge == 0;
 }
 
@@ -1084,6 +1165,15 @@ static int resource_compare(const void *a, const void *b)
         -1 : (pa->resource > pb->resource ? 1 : 0);
 }
 
+static int arg_copy_compare(const void *a, const void *b)
+{
+    const struct opcode_arg_copy *pa = a;
+    const struct opcode_arg_copy *pb = b;
+
+    return pa->resource < pb->resource ?
+        -1 : (pa->resource > pb->resource ? 1 : 0);
+}
+
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
@@ -1095,6 +1185,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     uint32_t op_flags = 0;
     struct slot_prop slot_prop[MAX_INSN_SLOTS];
     struct slot_prop *ordered[MAX_INSN_SLOTS];
+    struct opcode_arg_copy arg_copy[MAX_INSN_SLOTS * MAX_OPCODE_ARGS];
+    unsigned n_arg_copy = 0;
     uint32_t debug_cause = 0;
     uint32_t windowed_register = 0;
     uint32_t coprocessor = 0;
@@ -1249,7 +1341,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     if (slots > 1) {
-        if (!tsort(slot_prop, ordered, slots)) {
+        if (!tsort(slot_prop, ordered, slots, arg_copy, &n_arg_copy)) {
             qemu_log_mask(LOG_UNIMP,
                           "Circular resource dependencies (pc = %08x)\n",
                           dc->pc);
@@ -1297,6 +1389,29 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if (n_arg_copy) {
+        uint32_t resource;
+        void *temp;
+        unsigned j;
+
+        qsort(arg_copy, n_arg_copy, sizeof(*arg_copy), arg_copy_compare);
+        for (i = j = 0; i < n_arg_copy; ++i) {
+            if (i == 0 || arg_copy[i].resource != resource) {
+                resource = arg_copy[i].resource;
+                temp = tcg_temp_local_new();
+                tcg_gen_mov_i32(temp, arg_copy[i].arg->in);
+                arg_copy[i].temp = temp;
+
+                if (i != j) {
+                    arg_copy[j] = arg_copy[i];
+                }
+                ++j;
+            }
+            arg_copy[i].arg->in = temp;
+        }
+        n_arg_copy = j;
+    }
+
     if (op_flags & XTENSA_OP_DIVIDE_BY_ZERO) {
         for (slot = 0; slot < slots; ++slot) {
             if (slot_prop[slot].ops->op_flags & XTENSA_OP_DIVIDE_BY_ZERO) {
@@ -1314,6 +1429,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         ops->translate(dc, pslot->arg, ops->par);
     }
 
+    for (i = 0; i < n_arg_copy; ++i) {
+        tcg_temp_free(arg_copy[i].temp);
+    }
+
     if (dc->base.is_jmp == DISAS_NEXT) {
         gen_postprocess(dc, 0);
         dc->op_flags = 0;
-- 
2.11.0
