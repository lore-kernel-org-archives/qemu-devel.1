Received: from eggs.gnu.org ([209.51.188.92]:56171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhN-0002Cl-BJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhL-0006vA-UL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:17 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gozhL-0006uh-KB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:15 -0500
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so1092810lja.5
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:55:15 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 30 Jan 2019 15:54:40 -0800
Message-Id: <20190130235442.2876-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190130235442.2876-1-jcmvbkbc@gmail.com>
References: <20190130235442.2876-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] target/xtensa: sort FLIX instruction
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Opcodes in different slots may read and write same resources (registers,
states). In the absence of resource dependency loops it must be possible
to sort opcodes to avoid interference.

Record resources used by each opcode in the bundle. Build opcode
dependency graph and use topological sort to order its nodes. In case of
success translate opcodes in sort order. In case of failure report and
raise invalid opcode exception for now.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 202 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a068b6e8335d..b3718d33eec8 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -855,6 +855,138 @@ static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
     return xtensa_isa_length_from_chars(dc->config->isa, &op0);
 }
 
+struct slot_prop {
+    XtensaOpcodeOps *ops;
+    uint32_t arg[MAX_OPCODE_ARGS];
+    uint32_t raw_arg[MAX_OPCODE_ARGS];
+    uint32_t in[MAX_OPCODE_ARGS];
+    uint32_t out[MAX_OPCODE_ARGS];
+    unsigned n_in;
+    unsigned n_out;
+};
+
+enum resource_type {
+    XTENSA_CONTROL_FLOW, /* must be first, see op_depends_on */
+    XTENSA_REGFILE,
+    XTENSA_STATE,
+};
+
+static uint32_t encode_resource(enum resource_type r, unsigned g, unsigned n)
+{
+    assert(r < 256 && g < 256 && n < 65536);
+    return (r << 24) | (g << 16) | n;
+}
+
+static bool op_depends_on(const struct slot_prop *a,
+                          const struct slot_prop *b)
+{
+    unsigned i = 0;
+    unsigned j = 0;
+
+    if (a->n_out && a->out[0] == encode_resource(XTENSA_CONTROL_FLOW, 0, 0)) {
+        return true;
+    }
+    while (i < a->n_out && j < b->n_in) {
+        if (a->out[i] < b->in[j]) {
+            ++i;
+        } else if (a->out[i] > b->in[j]) {
+            ++j;
+        } else {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool tsort(struct slot_prop *slot,
+                  struct slot_prop *sorted[],
+                  unsigned n)
+{
+    struct {
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
+    for (i = 0; i < n_in; ++i) {
+        unsigned k = in[i];
+
+        sorted[n_out] = slot + k;
+        ++n_out;
+        for (j = 0; j < node[k].n_out_edge; ++j) {
+            --n_edge;
+            if (--node[node[k].out_edge[j]].n_in_edge == 0) {
+                in[n_in] = node[k].out_edge[j];
+                ++n_in;
+            }
+        }
+    }
+    return n_edge == 0;
+}
+
+static void opcode_add_resource(struct slot_prop *op,
+                                uint32_t resource, char direction)
+{
+    switch (direction) {
+    case 'i':
+        assert(op->n_in < ARRAY_SIZE(op->in));
+        op->in[op->n_in++] = resource;
+        break;
+    case 'o':
+        assert(op->n_out < ARRAY_SIZE(op->out));
+        op->out[op->n_out++] = resource;
+        break;
+    case 'm':
+        assert(op->n_in < ARRAY_SIZE(op->in));
+        assert(op->n_out < ARRAY_SIZE(op->out));
+        op->in[op->n_in++] = resource;
+        op->out[op->n_out++] = resource;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static int resource_compare(const void *a, const void *b)
+{
+    const uint32_t *pa = a;
+    const uint32_t *pb = b;
+
+    return *pa < *pb ? -1 : (*pa > *pb ? 1 : 0);
+}
+
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
@@ -864,11 +996,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
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
@@ -963,6 +1092,62 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
             }
         }
         coprocessor |= ops->coprocessor;
+
+        if (slots > 1) {
+            slot_prop[slot].n_in = 0;
+            slot_prop[slot].n_out = 0;
+
+            opnds = xtensa_opcode_num_operands(isa, opc);
+
+            for (opnd = 0; opnd < opnds; ++opnd) {
+                if (xtensa_operand_is_register(isa, opc, opnd)) {
+                    xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);
+                    uint32_t v = 0;
+
+                    xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                             dc->slotbuf, &v);
+                    xtensa_operand_decode(isa, opc, opnd, &v);
+                    opcode_add_resource(slot_prop + slot,
+                                        encode_resource(XTENSA_REGFILE, rf, v),
+                                        xtensa_operand_inout(isa, opc, opnd));
+                }
+            }
+
+            opnds = xtensa_opcode_num_stateOperands(isa, opc);
+
+            for (opnd = 0; opnd < opnds; ++opnd) {
+                xtensa_state state = xtensa_stateOperand_state(isa, opc, opnd);
+
+                opcode_add_resource(slot_prop + slot,
+                                    encode_resource(XTENSA_STATE, 0, state),
+                                    xtensa_stateOperand_inout(isa, opc, opnd));
+            }
+            if (xtensa_opcode_is_branch(isa, opc) ||
+                xtensa_opcode_is_jump(isa, opc) ||
+                xtensa_opcode_is_loop(isa, opc) ||
+                xtensa_opcode_is_call(isa, opc)) {
+                opcode_add_resource(slot_prop + slot,
+                                    encode_resource(XTENSA_CONTROL_FLOW, 0, 0),
+                                    'o');
+            }
+
+            qsort(slot_prop[slot].in, slot_prop[slot].n_in, sizeof(uint32_t),
+                  resource_compare);
+            qsort(slot_prop[slot].out, slot_prop[slot].n_out, sizeof(uint32_t),
+                  resource_compare);
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
@@ -1011,10 +1196,11 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
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
