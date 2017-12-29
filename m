Received: from eggs.gnu.org ([2001:4830:134:3::10]:42870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NN-0000n9-PL
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NH-0000FB-DW
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:29 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NH-0000E0-4m
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:23 -0500
Received: by mail-pl0-x242.google.com with SMTP id n13so23462466plp.11
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:09 -0800
Message-Id: <20171229193113.11753-5-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 4/8] tcg: Dynamically allocate TCGOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

With no fixed array allocation, we can't overflow a buffer.
This will be important as optimizations related to host vectors
may expand the number of ops used.

Use QTAILQ to link the ops together.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h     |   9 ++--
 include/qemu/queue.h          |   5 ++
 target/arm/translate.h        |  10 ++--
 tcg/tcg.h                     |  35 +++++-------
 target/arm/translate-a64.c    |   2 +-
 target/arm/translate.c        |   2 +-
 target/cris/translate.c       |   2 -
 target/lm32/translate.c       |   2 -
 target/microblaze/translate.c |   4 --
 tcg/optimize.c                |  16 ++----
 tcg/tcg-op.c                  |  24 ---------
 tcg/tcg.c                     | 123 ++++++++++++++++--------------------------
 12 files changed, 77 insertions(+), 157 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 049bba86e9..54aaa61d65 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -5,7 +5,7 @@
 
 /* Helpers for instruction counting code generation.  */
 
-static int icount_start_insn_idx;
+static TCGOp *icount_start_insn;
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
@@ -26,8 +26,8 @@ static inline void gen_tb_start(TranslationBlock *tb)
         /* We emit a movi with a dummy immediate argument. Keep the insn index
          * of the movi so that we later (when we know the actual insn count)
          * can update the immediate argument with the actual insn count.  */
-        icount_start_insn_idx = tcg_op_buf_count();
         tcg_gen_movi_i32(imm, 0xdeadbeef);
+        icount_start_insn = tcg_last_op();
 
         tcg_gen_sub_i32(count, count, imm);
         tcg_temp_free_i32(imm);
@@ -48,14 +48,11 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
          * the actual insn count.  */
-        tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
+        tcg_set_insn_param(icount_start_insn, 1, num_insns);
     }
 
     gen_set_label(tcg_ctx->exitreq_label);
     tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
-
-    /* Terminate the linked list.  */
-    tcg_ctx->gen_op_buf[tcg_ctx->gen_op_buf[0].prev].next = 0;
 }
 
 static inline void gen_io_start(void)
diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 35292c3155..aa270d2b38 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -425,6 +425,11 @@ struct {                                                                \
                 (var);                                                  \
                 (var) = (*(((struct headname *)((var)->field.tqe_prev))->tqh_last)))
 
+#define QTAILQ_FOREACH_REVERSE_SAFE(var, head, headname, field, prev_var) \
+        for ((var) = (*(((struct headname *)((head)->tqh_last))->tqh_last)); \
+             (var) && ((prev_var) = (*(((struct headname *)((var)->field.tqe_prev))->tqh_last)), 1); \
+             (var) = (prev_var))
+
 /*
  * Tail queue access methods.
  */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 410ba79c0d..cd7313ace7 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -66,8 +66,8 @@ typedef struct DisasContext {
     bool ss_same_el;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
-    /* TCG op index of the current insn_start.  */
-    int insn_start_idx;
+    /* TCG op of the current insn_start.  */
+    TCGOp *insn_start;
 #define TMP_A64_MAX 16
     int tmp_a64_count;
     TCGv_i64 tmp_a64[TMP_A64_MAX];
@@ -117,9 +117,9 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
     syn >>= ARM_INSN_START_WORD2_SHIFT;
 
     /* We check and clear insn_start_idx to catch multiple updates.  */
-    assert(s->insn_start_idx != 0);
-    tcg_set_insn_param(s->insn_start_idx, 2, syn);
-    s->insn_start_idx = 0;
+    assert(s->insn_start != NULL);
+    tcg_set_insn_param(s->insn_start, 2, syn);
+    s->insn_start = NULL;
 }
 
 /* is_jmp field values */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index c21194c858..a577447846 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
 
@@ -48,8 +49,6 @@
  * and up to 4 + N parameters on 64-bit archs
  * (N = number of input arguments + output arguments).  */
 #define MAX_OPC_PARAM (4 + (MAX_OPC_PARAM_PER_ARG * MAX_OPC_PARAM_ARGS))
-#define OPC_BUF_SIZE 640
-#define OPC_MAX_SIZE (OPC_BUF_SIZE - MAX_OP_PER_INSTR)
 
 #define CPU_TEMP_BUF_NLONGS 128
 
@@ -572,23 +571,18 @@ typedef struct TCGOp {
     unsigned callo  : 2;        /* 14 */
     unsigned        : 2;        /* 16 */
 
-    /* Index of the prev/next op, or 0 for the end of the list.  */
-    unsigned prev   : 16;       /* 32 */
-    unsigned next   : 16;       /* 48 */
-
     /* Lifetime data of the operands.  */
-    unsigned life   : 16;       /* 64 */
+    unsigned life   : 16;       /* 32 */
+
+    /* Next and previous opcodes.  */
+    QTAILQ_ENTRY(TCGOp) link;
 
     /* Arguments for the opcode.  */
     TCGArg args[MAX_OPC_PARAM];
 } TCGOp;
 
-/* Make sure that we don't expand the structure without noticing.  */
-QEMU_BUILD_BUG_ON(sizeof(TCGOp) != 8 + sizeof(TCGArg) * MAX_OPC_PARAM);
-
 /* Make sure operands fit in the bitfields above.  */
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
-QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 16));
 
 typedef struct TCGProfile {
     int64_t tb_count1;
@@ -642,8 +636,6 @@ struct TCGContext {
     int goto_tb_issue_mask;
 #endif
 
-    int gen_next_op_idx;
-
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
@@ -674,12 +666,12 @@ struct TCGContext {
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
+    QTAILQ_HEAD(TCGOpHead, TCGOp) ops, free_ops;
+
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
 
-    TCGOp gen_op_buf[OPC_BUF_SIZE];
-
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
@@ -769,21 +761,21 @@ static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
 }
 #endif
 
-static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
+static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
 {
-    tcg_ctx->gen_op_buf[op_idx].args[arg] = v;
+    op->args[arg] = v;
 }
 
-/* The number of opcodes emitted so far.  */
-static inline int tcg_op_buf_count(void)
+/* The last op that was emitted.  */
+static inline TCGOp *tcg_last_op(void)
 {
-    return tcg_ctx->gen_next_op_idx;
+    return QTAILQ_LAST(&tcg_ctx->ops, TCGOpHead);
 }
 
 /* Test for whether to terminate the TB for using too many opcodes.  */
 static inline bool tcg_op_buf_full(void)
 {
-    return tcg_op_buf_count() >= OPC_MAX_SIZE;
+    return false;
 }
 
 /* pool based memory allocation */
@@ -967,6 +959,7 @@ bool tcg_op_supported(TCGOpcode op);
 
 void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
 
+TCGOp *tcg_emit_op(TCGOpcode opc);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 460bab5987..ba94f7d045 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11290,8 +11290,8 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    dc->insn_start_idx = tcg_op_buf_count();
     tcg_gen_insn_start(dc->pc, 0, 0);
+    dc->insn_start = tcg_last_op();
 }
 
 static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46c25ae2c1..c690658493 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12096,10 +12096,10 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    dc->insn_start_idx = tcg_op_buf_count();
     tcg_gen_insn_start(dc->pc,
                        (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                        0);
+    dc->insn_start = tcg_last_op();
 }
 
 static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 74822ed31f..f51a731db9 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3297,8 +3297,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log("\nisize=%d osize=%d\n",
-                 dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
     }
 #endif
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index b8b2b13e36..2e1c5e6d01 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1156,8 +1156,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("\n");
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log("\nisize=%d osize=%d\n",
-                 dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
     }
 #endif
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e7b5597c46..7628b0e25b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1808,11 +1808,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("--------------\n");
-#if DISAS_GNU
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-#endif
-        qemu_log("\nisize=%d osize=%d\n",
-                 dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
     }
 #endif
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 438321c6cc..e495680e95 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -602,8 +602,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-    int oi, oi_next, nb_temps, nb_globals;
-    TCGOp *prev_mb = NULL;
+    int nb_temps, nb_globals;
+    TCGOp *op, *op_next, *prev_mb = NULL;
     struct tcg_temp_info *infos;
     TCGTempSet temps_used;
 
@@ -617,17 +617,13 @@ void tcg_optimize(TCGContext *s)
     bitmap_zero(temps_used.l, nb_temps);
     infos = tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
 
-    for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
+    QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         tcg_target_ulong mask, partmask, affected;
         int nb_oargs, nb_iargs, i;
         TCGArg tmp;
-
-        TCGOp * const op = &s->gen_op_buf[oi];
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
-        oi_next = op->next;
-
         /* Count the arguments, and initialize the temps that are
            going to be used */
         if (opc == INDEX_op_call) {
@@ -1261,9 +1257,6 @@ void tcg_optimize(TCGContext *s)
                 rh = op->args[1];
                 tcg_opt_gen_movi(s, op, rl, (int32_t)a);
                 tcg_opt_gen_movi(s, op2, rh, (int32_t)(a >> 32));
-
-                /* We've done all we need to do with the movi.  Skip it.  */
-                oi_next = op2->next;
                 break;
             }
             goto do_default;
@@ -1280,9 +1273,6 @@ void tcg_optimize(TCGContext *s)
                 rh = op->args[1];
                 tcg_opt_gen_movi(s, op, rl, (int32_t)r);
                 tcg_opt_gen_movi(s, op2, rh, (int32_t)(r >> 32));
-
-                /* We've done all we need to do with the movi.  Skip it.  */
-                oi_next = op2->next;
                 break;
             }
             goto do_default;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3cad30b1f2..0c509bfe46 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -42,30 +42,6 @@ extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
 #define TCGV_HIGH TCGV_HIGH_link_error
 #endif
 
-/* Note that this is optimized for sequential allocation during translate.
-   Up to and including filling in the forward link immediately.  We'll do
-   proper termination of the end of the list after we finish translation.  */
-
-static inline TCGOp *tcg_emit_op(TCGOpcode opc)
-{
-    TCGContext *ctx = tcg_ctx;
-    int oi = ctx->gen_next_op_idx;
-    int ni = oi + 1;
-    int pi = oi - 1;
-    TCGOp *op = &ctx->gen_op_buf[oi];
-
-    tcg_debug_assert(oi < OPC_BUF_SIZE);
-    ctx->gen_op_buf[0].prev = oi;
-    ctx->gen_next_op_idx = ni;
-
-    memset(op, 0, offsetof(TCGOp, args));
-    op->opc = opc;
-    op->prev = pi;
-    op->next = ni;
-
-    return op;
-}
-
 void tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
     TCGOp *op = tcg_emit_op(opc);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 68bcd2267b..f26949a900 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -862,9 +862,8 @@ void tcg_func_start(TCGContext *s)
     s->goto_tb_issue_mask = 0;
 #endif
 
-    s->gen_op_buf[0].next = 1;
-    s->gen_op_buf[0].prev = 0;
-    s->gen_next_op_idx = 1;
+    QTAILQ_INIT(&s->ops);
+    QTAILQ_INIT(&s->free_ops);
 }
 
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -1339,7 +1338,6 @@ bool tcg_op_supported(TCGOpcode op)
    and endian swap in tcg_reg_alloc_call(). */
 void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
 {
-    TCGContext *s = tcg_ctx;
     int i, real_args, nb_rets, pi;
     unsigned sizemask, flags;
     TCGHelperInfo *info;
@@ -1395,17 +1393,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     }
 #endif /* TCG_TARGET_EXTEND_ARGS */
 
-    i = s->gen_next_op_idx;
-    tcg_debug_assert(i < OPC_BUF_SIZE);
-    s->gen_op_buf[0].prev = i;
-    s->gen_next_op_idx = i + 1;
-    op = &s->gen_op_buf[i];
-
-    /* Set links for sequential allocation during translation.  */
-    memset(op, 0, offsetof(TCGOp, args));
-    op->opc = INDEX_op_call;
-    op->prev = i - 1;
-    op->next = i + 1;
+    op = tcg_emit_op(INDEX_op_call);
 
     pi = 0;
     if (ret != NULL) {
@@ -1622,20 +1610,18 @@ void tcg_dump_ops(TCGContext *s)
 {
     char buf[128];
     TCGOp *op;
-    int oi;
 
-    for (oi = s->gen_op_buf[0].next; oi != 0; oi = op->next) {
+    QTAILQ_FOREACH(op, &s->ops, link) {
         int i, k, nb_oargs, nb_iargs, nb_cargs;
         const TCGOpDef *def;
         TCGOpcode c;
         int col = 0;
 
-        op = &s->gen_op_buf[oi];
         c = op->opc;
         def = &tcg_op_defs[c];
 
         if (c == INDEX_op_insn_start) {
-            col += qemu_log("%s ----", oi != s->gen_op_buf[0].next ? "\n" : "");
+            col += qemu_log("\n ----");
 
             for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
                 target_ulong a;
@@ -1898,65 +1884,51 @@ static void process_op_defs(TCGContext *s)
 
 void tcg_op_remove(TCGContext *s, TCGOp *op)
 {
-    int next = op->next;
-    int prev = op->prev;
-
-    /* We should never attempt to remove the list terminator.  */
-    tcg_debug_assert(op != &s->gen_op_buf[0]);
-
-    s->gen_op_buf[next].prev = prev;
-    s->gen_op_buf[prev].next = next;
-
-    memset(op, 0, sizeof(*op));
+    QTAILQ_REMOVE(&s->ops, op, link);
+    QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
 
 #ifdef CONFIG_PROFILER
     atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
 #endif
 }
 
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
-                            TCGOpcode opc, int nargs)
+static TCGOp *tcg_op_alloc(TCGOpcode opc)
 {
-    int oi = s->gen_next_op_idx;
-    int prev = old_op->prev;
-    int next = old_op - s->gen_op_buf;
-    TCGOp *new_op;
+    TCGContext *s = tcg_ctx;
+    TCGOp *op;
 
-    tcg_debug_assert(oi < OPC_BUF_SIZE);
-    s->gen_next_op_idx = oi + 1;
+    if (likely(QTAILQ_EMPTY(&s->free_ops))) {
+        op = tcg_malloc(sizeof(TCGOp));
+    } else {
+        op = QTAILQ_FIRST(&s->free_ops);
+        QTAILQ_REMOVE(&s->free_ops, op, link);
+    }
+    memset(op, 0, offsetof(TCGOp, link));
+    op->opc = opc;
 
-    new_op = &s->gen_op_buf[oi];
-    *new_op = (TCGOp){
-        .opc = opc,
-        .prev = prev,
-        .next = next
-    };
-    s->gen_op_buf[prev].next = oi;
-    old_op->prev = oi;
+    return op;
+}
+
+TCGOp *tcg_emit_op(TCGOpcode opc)
+{
+    TCGOp *op = tcg_op_alloc(opc);
+    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    return op;
+}
 
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
+                            TCGOpcode opc, int nargs)
+{
+    TCGOp *new_op = tcg_op_alloc(opc);
+    QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
 
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
                            TCGOpcode opc, int nargs)
 {
-    int oi = s->gen_next_op_idx;
-    int prev = old_op - s->gen_op_buf;
-    int next = old_op->next;
-    TCGOp *new_op;
-
-    tcg_debug_assert(oi < OPC_BUF_SIZE);
-    s->gen_next_op_idx = oi + 1;
-
-    new_op = &s->gen_op_buf[oi];
-    *new_op = (TCGOp){
-        .opc = opc,
-        .prev = prev,
-        .next = next
-    };
-    s->gen_op_buf[next].prev = oi;
-    old_op->next = oi;
-
+    TCGOp *new_op = tcg_op_alloc(opc);
+    QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
     return new_op;
 }
 
@@ -2006,23 +1978,19 @@ static void tcg_la_bb_end(TCGContext *s)
 static void liveness_pass_1(TCGContext *s)
 {
     int nb_globals = s->nb_globals;
-    int oi, oi_prev;
+    TCGOp *op, *op_prev;
 
     tcg_la_func_end(s);
 
-    for (oi = s->gen_op_buf[0].prev; oi != 0; oi = oi_prev) {
+    QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, TCGOpHead, link, op_prev) {
         int i, nb_iargs, nb_oargs;
         TCGOpcode opc_new, opc_new2;
         bool have_opc_new2;
         TCGLifeData arg_life = 0;
         TCGTemp *arg_ts;
-
-        TCGOp * const op = &s->gen_op_buf[oi];
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
-        oi_prev = op->prev;
-
         switch (opc) {
         case INDEX_op_call:
             {
@@ -2233,8 +2201,9 @@ static void liveness_pass_1(TCGContext *s)
 static bool liveness_pass_2(TCGContext *s)
 {
     int nb_globals = s->nb_globals;
-    int nb_temps, i, oi, oi_next;
+    int nb_temps, i;
     bool changes = false;
+    TCGOp *op, *op_next;
 
     /* Create a temporary for each indirect global.  */
     for (i = 0; i < nb_globals; ++i) {
@@ -2256,16 +2225,13 @@ static bool liveness_pass_2(TCGContext *s)
         its->state = TS_DEAD;
     }
 
-    for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
-        TCGOp *op = &s->gen_op_buf[oi];
+    QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
         TCGLifeData arg_life = op->life;
         int nb_iargs, nb_oargs, call_flags;
         TCGTemp *arg_ts, *dir_ts;
 
-        oi_next = op->next;
-
         if (opc == INDEX_op_call) {
             nb_oargs = op->callo;
             nb_iargs = op->calli;
@@ -3168,13 +3134,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &s->prof;
 #endif
-    int i, oi, oi_next, num_insns;
+    int i, num_insns;
+    TCGOp *op;
 
 #ifdef CONFIG_PROFILER
     {
         int n;
 
-        n = s->gen_op_buf[0].prev + 1;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
         atomic_set(&prof->op_count, prof->op_count + n);
         if (n > prof->op_count_max) {
             atomic_set(&prof->op_count_max, n);
@@ -3260,11 +3229,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
     num_insns = -1;
-    for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
-        TCGOp * const op = &s->gen_op_buf[oi];
+    QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
-        oi_next = op->next;
 #ifdef CONFIG_PROFILER
         atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
 #endif
-- 
2.14.3
