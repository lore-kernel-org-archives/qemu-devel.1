Received: from eggs.gnu.org ([209.51.188.92]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzTsi-0008RW-NA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzTsh-0006T3-Dj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:20 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:44742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gzTsY-0006OL-4F
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:14 -0500
Received: by mail-lf1-x136.google.com with SMTP id v185so5080244lfa.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:10:06 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Feb 2019 14:09:48 -0800
Message-Id: <20190228220948.14436-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 09/40] target/xtensa: sort FLIX instruction
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Opcodes in different slots may read and write same resources (registers,
states). In the absence of resource dependency loops it must be possible
to sort opcodes to avoid interference.

Record resources used by each opcode in the bundle. Build opcode
dependency graph and use topological sort to order its nodes. In case of
success translate opcodes in sort order. In case of failure report and
raise invalid opcode exception.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- fix build with clang

 target/xtensa/cpu.h       |   2 +
 target/xtensa/translate.c | 227 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 221 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index db8ee70a0386..c59f79e56326 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -373,6 +373,8 @@ enum {
     XTENSA_OP_EXIT_TB_0 = 0x800,
 
     XTENSA_OP_NAME_ARRAY = 0x8000,
+
+    XTENSA_OP_CONTROL_FLOW = 0x10000,
 };
 
 typedef struct XtensaOpcodeOps {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index e8dddd32b3af..bda4e9469b86 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -846,6 +846,157 @@ static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
     return xtensa_isa_length_from_chars(dc->config->isa, &op0);
 }
 
+struct opcode_arg_info {
+    uint32_t resource;
+    int index;
+};
+
+struct slot_prop {
+    XtensaOpcodeOps *ops;
+    uint32_t arg[MAX_OPCODE_ARGS];
+    uint32_t raw_arg[MAX_OPCODE_ARGS];
+    struct opcode_arg_info in[MAX_OPCODE_ARGS];
+    struct opcode_arg_info out[MAX_OPCODE_ARGS];
+    unsigned n_in;
+    unsigned n_out;
+    uint32_t op_flags;
+};
+
+enum resource_type {
+    RES_REGFILE,
+    RES_STATE,
+    RES_MAX,
+};
+
+static uint32_t encode_resource(enum resource_type r, unsigned g, unsigned n)
+{
+    assert(r < RES_MAX && g < 256 && n < 65536);
+    return (r << 24) | (g << 16) | n;
+}
+
+/*
+ * a depends on b if b must be executed before a,
+ * because a's side effects will destroy b's inputs.
+ */
+static bool op_depends_on(const struct slot_prop *a,
+                          const struct slot_prop *b)
+{
+    unsigned i = 0;
+    unsigned j = 0;
+
+    if (a->op_flags & XTENSA_OP_CONTROL_FLOW) {
+        return true;
+    }
+    while (i < a->n_out && j < b->n_in) {
+        if (a->out[i].resource < b->in[j].resource) {
+            ++i;
+        } else if (a->out[i].resource > b->in[j].resource) {
+            ++j;
+        } else {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * Calculate evaluation order for slot opcodes.
+ * Build opcode order graph and output its nodes in topological sort order.
+ * An edge a -> b in the graph means that opcode a must be followed by
+ * opcode b.
+ */
+static bool tsort(struct slot_prop *slot,
+                  struct slot_prop *sorted[],
+                  unsigned n)
+{
+    struct tsnode {
+        unsigned n_in_edge;
+        unsigned n_out_edge;
+        unsigned out_edge[MAX_INSN_SLOTS];
+    } node[MAX_INSN_SLOTS];
+
+    unsigned in[MAX_INSN_SLOTS];
+    unsigned i, j;
+    unsigned n_in = 0;
+    unsigned n_out = 0;
+    unsigned n_edge = 0;
+    unsigned in_idx;
+
+    for (i = 0; i < n; ++i) {
+        node[i].n_in_edge = 0;
+        node[i].n_out_edge = 0;
+    }
+
+    for (i = 0; i < n; ++i) {
+        unsigned n_out_edge = 0;
+
+        for (j = 0; j < n; ++j) {
+            if (i != j && op_depends_on(slot + j, slot + i)) {
+                node[i].out_edge[n_out_edge] = j;
+                ++node[j].n_in_edge;
+                ++n_out_edge;
+                ++n_edge;
+            }
+        }
+        node[i].n_out_edge = n_out_edge;
+    }
+
+    for (i = 0; i < n; ++i) {
+        if (!node[i].n_in_edge) {
+            in[n_in] = i;
+            ++n_in;
+        }
+    }
+
+    for (in_idx = 0; in_idx < n_in; ++in_idx) {
+        i = in[in_idx];
+        sorted[n_out] = slot + i;
+        ++n_out;
+        for (j = 0; j < node[i].n_out_edge; ++j) {
+            --n_edge;
+            if (--node[node[i].out_edge[j]].n_in_edge == 0) {
+                in[n_in] = node[i].out_edge[j];
+                ++n_in;
+            }
+        }
+    }
+    return n_edge == 0;
+}
+
+static void opcode_add_resource(struct slot_prop *op,
+                                uint32_t resource, char direction,
+                                int index)
+{
+    switch (direction) {
+    case 'm':
+    case 'i':
+        assert(op->n_in < ARRAY_SIZE(op->in));
+        op->in[op->n_in].resource = resource;
+        op->in[op->n_in].index = index;
+        ++op->n_in;
+        /* fall through */
+    case 'o':
+        if (direction == 'm' || direction == 'o') {
+            assert(op->n_out < ARRAY_SIZE(op->out));
+            op->out[op->n_out].resource = resource;
+            op->out[op->n_out].index = index;
+            ++op->n_out;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static int resource_compare(const void *a, const void *b)
+{
+    const struct opcode_arg_info *pa = a;
+    const struct opcode_arg_info *pb = b;
+
+    return pa->resource < pb->resource ?
+        -1 : (pa->resource > pb->resource ? 1 : 0);
+}
+
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
@@ -855,11 +1006,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     int slot, slots;
     unsigned i;
     uint32_t op_flags = 0;
-    struct {
-        XtensaOpcodeOps *ops;
-        uint32_t arg[MAX_OPCODE_ARGS];
-        uint32_t raw_arg[MAX_OPCODE_ARGS];
-    } slot_prop[MAX_INSN_SLOTS];
+    struct slot_prop slot_prop[MAX_INSN_SLOTS];
+    struct slot_prop *ordered[MAX_INSN_SLOTS];
     uint32_t debug_cause = 0;
     uint32_t windowed_register = 0;
     uint32_t coprocessor = 0;
@@ -954,6 +1102,68 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
             windowed_register |= ops->test_overflow(dc, arg, ops->par);
         }
         coprocessor |= ops->coprocessor;
+
+        if (slots > 1) {
+            slot_prop[slot].n_in = 0;
+            slot_prop[slot].n_out = 0;
+            slot_prop[slot].op_flags = 0;
+
+            opnds = xtensa_opcode_num_operands(isa, opc);
+
+            for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
+                bool visible = xtensa_operand_is_visible(isa, opc, opnd);
+
+                if (xtensa_operand_is_register(isa, opc, opnd)) {
+                    xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);
+                    uint32_t v = 0;
+
+                    xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                             dc->slotbuf, &v);
+                    xtensa_operand_decode(isa, opc, opnd, &v);
+                    opcode_add_resource(slot_prop + slot,
+                                        encode_resource(RES_REGFILE, rf, v),
+                                        xtensa_operand_inout(isa, opc, opnd),
+                                        visible ? vopnd : -1);
+                }
+                if (visible) {
+                    ++vopnd;
+                }
+            }
+
+            opnds = xtensa_opcode_num_stateOperands(isa, opc);
+
+            for (opnd = 0; opnd < opnds; ++opnd) {
+                xtensa_state state = xtensa_stateOperand_state(isa, opc, opnd);
+
+                opcode_add_resource(slot_prop + slot,
+                                    encode_resource(RES_STATE, 0, state),
+                                    xtensa_stateOperand_inout(isa, opc, opnd),
+                                    -1);
+            }
+            if (xtensa_opcode_is_branch(isa, opc) ||
+                xtensa_opcode_is_jump(isa, opc) ||
+                xtensa_opcode_is_loop(isa, opc) ||
+                xtensa_opcode_is_call(isa, opc)) {
+                slot_prop[slot].op_flags |= XTENSA_OP_CONTROL_FLOW;
+            }
+
+            qsort(slot_prop[slot].in, slot_prop[slot].n_in,
+                  sizeof(slot_prop[slot].in[0]), resource_compare);
+            qsort(slot_prop[slot].out, slot_prop[slot].n_out,
+                  sizeof(slot_prop[slot].out[0]), resource_compare);
+        }
+    }
+
+    if (slots > 1) {
+        if (!tsort(slot_prop, ordered, slots)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Circular resource dependencies (pc = %08x)\n",
+                          dc->pc);
+            gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+            return;
+        }
+    } else {
+        ordered[0] = slot_prop + 0;
     }
 
     if ((op_flags & XTENSA_OP_PRIVILEGED) &&
@@ -1002,10 +1212,11 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     for (slot = 0; slot < slots; ++slot) {
-        XtensaOpcodeOps *ops = slot_prop[slot].ops;
+        struct slot_prop *pslot = ordered[slot];
+        XtensaOpcodeOps *ops = pslot->ops;
 
-        dc->raw_arg = slot_prop[slot].raw_arg;
-        ops->translate(dc, slot_prop[slot].arg, ops->par);
+        dc->raw_arg = pslot->raw_arg;
+        ops->translate(dc, pslot->arg, ops->par);
     }
 
     if (dc->base.is_jmp == DISAS_NEXT) {
-- 
2.11.0
