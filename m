Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcue-0001nv-4J
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuX-0005MA-9Z
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:14 +1100
Message-Id: <20180216100617.25265-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/14] target/ppc: convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, surajjs@au1.ibm.com, "Emilio G. Cota" <cota@braap.org>, David Gibson <david@gibson.dropbear.id.au>

From: "Emilio G. Cota" <cota@braap.org>

A couple of notes:

- removed ctx->nip in favour of base->pc_next. Yes, it is annoying,
  but didn't want to waste its 4 bytes.

- ctx->singlestep_enabled does a lot more than
  base.singlestep_enabled; this confused me at first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c              | 129 +++++++++++++++++++-----------------
 target/ppc/translate/dfp-impl.inc.c |  16 ++---
 target/ppc/translate_init.c         |  32 ++++-----
 3 files changed, 91 insertions(+), 86 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4132f67bb1..6e35daa0db 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -31,6 +31,7 @@
 #include "exec/helper-gen.h"
 
 #include "trace-tcg.h"
+#include "exec/translator.h"
 #include "exec/log.h"
 
 
@@ -187,8 +188,7 @@ void ppc_translate_init(void)
 
 /* internal defines */
 struct DisasContext {
-    struct TranslationBlock *tb;
-    target_ulong nip;
+    DisasContextBase base;
     uint32_t opcode;
     uint32_t exception;
     /* Routine used to access memory */
@@ -275,7 +275,7 @@ static void gen_exception_err(DisasContext *ctx, uint32_t excp, uint32_t error)
      * the faulting instruction
      */
     if (ctx->exception == POWERPC_EXCP_NONE) {
-        gen_update_nip(ctx, ctx->nip - 4);
+        gen_update_nip(ctx, ctx->base.pc_next - 4);
     }
     t0 = tcg_const_i32(excp);
     t1 = tcg_const_i32(error);
@@ -293,7 +293,7 @@ static void gen_exception(DisasContext *ctx, uint32_t excp)
      * the faulting instruction
      */
     if (ctx->exception == POWERPC_EXCP_NONE) {
-        gen_update_nip(ctx, ctx->nip - 4);
+        gen_update_nip(ctx, ctx->base.pc_next - 4);
     }
     t0 = tcg_const_i32(excp);
     gen_helper_raise_exception(cpu_env, t0);
@@ -322,7 +322,7 @@ static void gen_debug_exception(DisasContext *ctx)
      */
     if ((ctx->exception != POWERPC_EXCP_BRANCH) &&
         (ctx->exception != POWERPC_EXCP_SYNC)) {
-        gen_update_nip(ctx, ctx->nip);
+        gen_update_nip(ctx, ctx->base.pc_next);
     }
     t0 = tcg_const_i32(EXCP_DEBUG);
     gen_helper_raise_exception(cpu_env, t0);
@@ -349,7 +349,7 @@ static inline void gen_hvpriv_exception(DisasContext *ctx, uint32_t error)
 /* Stop translation */
 static inline void gen_stop_exception(DisasContext *ctx)
 {
-    gen_update_nip(ctx, ctx->nip);
+    gen_update_nip(ctx, ctx->base.pc_next);
     ctx->exception = POWERPC_EXCP_STOP;
 }
 
@@ -978,7 +978,7 @@ static void gen_addpcis(DisasContext *ctx)
 {
     target_long d = DX(ctx->opcode);
 
-    tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], ctx->nip + (d << 16));
+    tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], ctx->base.pc_next + (d << 16));
 }
 
 static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
@@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->nip);
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 }
 #endif /* defined(TARGET_PPC64) */
 
@@ -2397,7 +2397,7 @@ static inline void gen_check_align(DisasContext *ctx, TCGv EA, int mask)
     tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);
     t1 = tcg_const_i32(POWERPC_EXCP_ALIGN);
     t2 = tcg_const_i32(ctx->opcode & 0x03FF0000);
-    gen_update_nip(ctx, ctx->nip - 4);
+    gen_update_nip(ctx, ctx->base.pc_next - 4);
     gen_helper_raise_exception_err(cpu_env, t1, t2);
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t2);
@@ -3322,7 +3322,7 @@ static void gen_wait(DisasContext *ctx)
                    -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
     tcg_temp_free_i32(t0);
     /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->nip);
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 }
 
 #if defined(TARGET_PPC64)
@@ -3407,7 +3407,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     }
 
 #ifndef CONFIG_USER_ONLY
-    return (ctx->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -3422,7 +3422,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
     } else {
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
         if (unlikely(ctx->singlestep_enabled)) {
@@ -3458,14 +3458,14 @@ static void gen_b(DisasContext *ctx)
     li = LI(ctx->opcode);
     li = (li ^ 0x02000000) - 0x02000000;
     if (likely(AA(ctx->opcode) == 0)) {
-        target = ctx->nip + li - 4;
+        target = ctx->base.pc_next + li - 4;
     } else {
         target = li;
     }
     if (LK(ctx->opcode)) {
-        gen_setlr(ctx, ctx->nip);
+        gen_setlr(ctx, ctx->base.pc_next);
     }
-    gen_update_cfar(ctx, ctx->nip - 4);
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_goto_tb(ctx, 0, target);
 }
 
@@ -3493,7 +3493,7 @@ static void gen_bcond(DisasContext *ctx, int type)
         target = NULL;
     }
     if (LK(ctx->opcode))
-        gen_setlr(ctx, ctx->nip);
+        gen_setlr(ctx, ctx->base.pc_next);
     l1 = gen_new_label();
     if ((bo & 0x4) == 0) {
         /* Decrement and test CTR */
@@ -3530,11 +3530,11 @@ static void gen_bcond(DisasContext *ctx, int type)
         }
         tcg_temp_free_i32(temp);
     }
-    gen_update_cfar(ctx, ctx->nip - 4);
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
     if (type == BCOND_IM) {
         target_ulong li = (target_long)((int16_t)(BD(ctx->opcode)));
         if (likely(AA(ctx->opcode) == 0)) {
-            gen_goto_tb(ctx, 0, ctx->nip + li - 4);
+            gen_goto_tb(ctx, 0, ctx->base.pc_next + li - 4);
         } else {
             gen_goto_tb(ctx, 0, li);
         }
@@ -3549,7 +3549,7 @@ static void gen_bcond(DisasContext *ctx, int type)
     }
     if ((bo & 0x14) != 0x14) {
         gen_set_label(l1);
-        gen_goto_tb(ctx, 1, ctx->nip);
+        gen_goto_tb(ctx, 1, ctx->base.pc_next);
     }
 }
 
@@ -3645,7 +3645,7 @@ static void gen_rfi(DisasContext *ctx)
     }
     /* Restore CPU state */
     CHK_SV;
-    gen_update_cfar(ctx, ctx->nip - 4);
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfi(cpu_env);
     gen_sync_exception(ctx);
 #endif
@@ -3659,7 +3659,7 @@ static void gen_rfid(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_SV;
-    gen_update_cfar(ctx, ctx->nip - 4);
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfid(cpu_env);
     gen_sync_exception(ctx);
 #endif
@@ -3934,10 +3934,11 @@ static inline void gen_op_mfspr(DisasContext *ctx)
              */
             if (sprn != SPR_PVR) {
                 fprintf(stderr, "Trying to read privileged spr %d (0x%03x) at "
-                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                        TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
                 if (qemu_log_separate()) {
                     qemu_log("Trying to read privileged spr %d (0x%03x) at "
-                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                             TARGET_FMT_lx "\n", sprn, sprn,
+                             ctx->base.pc_next - 4);
                 }
             }
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
@@ -3951,10 +3952,10 @@ static inline void gen_op_mfspr(DisasContext *ctx)
         }
         /* Not defined */
         fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
         if (qemu_log_separate()) {
             qemu_log("Trying to read invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
         }
 
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
@@ -4030,7 +4031,7 @@ static void gen_mtmsrd(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
-        gen_update_nip(ctx, ctx->nip);
+        gen_update_nip(ctx, ctx->base.pc_next);
         gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
@@ -4059,7 +4060,7 @@ static void gen_mtmsr(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
-        gen_update_nip(ctx, ctx->nip);
+        gen_update_nip(ctx, ctx->base.pc_next);
 #if defined(TARGET_PPC64)
         tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32);
 #else
@@ -4097,10 +4098,10 @@ static void gen_mtspr(DisasContext *ctx)
         } else {
             /* Privilege exception */
             fprintf(stderr, "Trying to write privileged spr %d (0x%03x) at "
-                    TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                    TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
             if (qemu_log_separate()) {
                 qemu_log("Trying to write privileged spr %d (0x%03x) at "
-                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                         TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
             }
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
         }
@@ -4115,10 +4116,10 @@ static void gen_mtspr(DisasContext *ctx)
         /* Not defined */
         if (qemu_log_separate()) {
             qemu_log("Trying to write invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
         }
         fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
 
 
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
@@ -7212,13 +7213,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     CPUPPCState *env = cs->env_ptr;
     DisasContext ctx, *ctxp = &ctx;
     opc_handler_t **table, *handler;
-    target_ulong pc_start;
-    int num_insns;
     int max_insns;
 
-    pc_start = tb->pc;
-    ctx.nip = pc_start;
-    ctx.tb = tb;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.tb = tb;
+    ctx.base.pc_first = tb->pc;
+    ctx.base.pc_next = tb->pc; /* nip */
+    ctx.base.num_insns = 0;
+
     ctx.exception = POWERPC_EXCP_NONE;
     ctx.spr_cb = env->spr_cb;
     ctx.pr = msr_pr;
@@ -7270,14 +7272,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         ctx.singlestep_enabled = 0;
     if ((env->flags & POWERPC_FLAG_BE) && msr_be)
         ctx.singlestep_enabled |= CPU_BRANCH_STEP;
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(ctx.base.singlestep_enabled)) {
         ctx.singlestep_enabled |= GDBSTUB_SINGLE_STEP;
     }
 #if defined (DO_SINGLE_STEP) && 0
     /* Single step trace mode */
     msr_se = 1;
 #endif
-    num_insns = 0;
+    ctx.base.num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -7290,34 +7292,35 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     tcg_clear_temp_count();
     /* Set env in case of segfault during code fetch */
     while (ctx.exception == POWERPC_EXCP_NONE && !tcg_op_buf_full()) {
-        tcg_gen_insn_start(ctx.nip);
-        num_insns++;
+        tcg_gen_insn_start(ctx.base.pc_next);
+        ctx.base.num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.nip, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
             gen_debug_exception(ctxp);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.nip += 4;
+            ctx.base.pc_next += 4;
             break;
         }
 
         LOG_DISAS("----------------\n");
         LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
-                  ctx.nip, ctx.mem_idx, (int)msr_ir);
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO))
+                  ctx.base.pc_next, ctx.mem_idx, (int)msr_ir);
+        if (ctx.base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
+        }
         if (unlikely(need_byteswap(&ctx))) {
-            ctx.opcode = bswap32(cpu_ldl_code(env, ctx.nip));
+            ctx.opcode = bswap32(cpu_ldl_code(env, ctx.base.pc_next));
         } else {
-            ctx.opcode = cpu_ldl_code(env, ctx.nip);
+            ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
         }
         LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
                   ctx.opcode, opc1(ctx.opcode), opc2(ctx.opcode),
                   opc3(ctx.opcode), opc4(ctx.opcode),
                   ctx.le_mode ? "little" : "big");
-        ctx.nip += 4;
+        ctx.base.pc_next += 4;
         table = env->opcodes;
         handler = table[opc1(ctx.opcode)];
         if (is_indirect_opcode(handler)) {
@@ -7339,7 +7342,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                           TARGET_FMT_lx " %d\n",
                           opc1(ctx.opcode), opc2(ctx.opcode),
                           opc3(ctx.opcode), opc4(ctx.opcode),
-                          ctx.opcode, ctx.nip - 4, (int)msr_ir);
+                          ctx.opcode, ctx.base.pc_next - 4, (int)msr_ir);
         } else {
             uint32_t inval;
 
@@ -7355,7 +7358,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                               TARGET_FMT_lx "\n", ctx.opcode & inval,
                               opc1(ctx.opcode), opc2(ctx.opcode),
                               opc3(ctx.opcode), opc4(ctx.opcode),
-                              ctx.opcode, ctx.nip - 4);
+                              ctx.opcode, ctx.base.pc_next - 4);
                 gen_inval_exception(ctxp, POWERPC_EXCP_INVAL_INVAL);
                 break;
             }
@@ -7366,15 +7369,16 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #endif
         /* Check trace mode exceptions */
         if (unlikely(ctx.singlestep_enabled & CPU_SINGLE_STEP &&
-                     (ctx.nip <= 0x100 || ctx.nip > 0xF00) &&
+                     (ctx.base.pc_next <= 0x100 || ctx.base.pc_next > 0xF00) &&
                      ctx.exception != POWERPC_SYSCALL &&
                      ctx.exception != POWERPC_EXCP_TRAP &&
                      ctx.exception != POWERPC_EXCP_BRANCH)) {
-            gen_exception_nip(ctxp, POWERPC_EXCP_TRACE, ctx.nip);
-        } else if (unlikely(((ctx.nip & (TARGET_PAGE_SIZE - 1)) == 0) ||
-                            (cs->singlestep_enabled) ||
+            gen_exception_nip(ctxp, POWERPC_EXCP_TRACE, ctx.base.pc_next);
+        } else if (unlikely(((ctx.base.pc_next & (TARGET_PAGE_SIZE - 1))
+                             == 0) ||
+                            (ctx.base.singlestep_enabled) ||
                             singlestep ||
-                            num_insns >= max_insns)) {
+                            ctx.base.num_insns >= max_insns)) {
             /* if we reach a page boundary or are single stepping, stop
              * generation
              */
@@ -7390,25 +7394,26 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     if (ctx.exception == POWERPC_EXCP_NONE) {
-        gen_goto_tb(&ctx, 0, ctx.nip);
+        gen_goto_tb(&ctx, 0, ctx.base.pc_next);
     } else if (ctx.exception != POWERPC_EXCP_BRANCH) {
-        if (unlikely(cs->singlestep_enabled)) {
+        if (unlikely(ctx.base.singlestep_enabled)) {
             gen_debug_exception(ctxp);
         }
         /* Generate the return instruction */
         tcg_gen_exit_tb(0);
     }
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, ctx.base.num_insns);
 
-    tb->size = ctx.nip - pc_start;
-    tb->icount = num_insns;
+    tb->size = ctx.base.pc_next - ctx.base.pc_first;
+    tb->icount = ctx.base.num_insns;
 
 #if defined(DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(ctx.base.pc_first)) {
         qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.nip - pc_start);
+        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
+        log_target_disas(cs, ctx.base.pc_first,
+                         ctx.base.pc_next - ctx.base.pc_first);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/ppc/translate/dfp-impl.inc.c b/target/ppc/translate/dfp-impl.inc.c
index 178d3044a7..634ef73b8a 100644
--- a/target/ppc/translate/dfp-impl.inc.c
+++ b/target/ppc/translate/dfp-impl.inc.c
@@ -15,7 +15,7 @@ static void gen_##name(DisasContext *ctx)        \
         gen_exception(ctx, POWERPC_EXCP_FPU);    \
         return;                                  \
     }                                            \
-    gen_update_nip(ctx, ctx->nip - 4);           \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);  \
     rd = gen_fprp_ptr(rD(ctx->opcode));          \
     ra = gen_fprp_ptr(rA(ctx->opcode));          \
     rb = gen_fprp_ptr(rB(ctx->opcode));          \
@@ -36,7 +36,7 @@ static void gen_##name(DisasContext *ctx)         \
         gen_exception(ctx, POWERPC_EXCP_FPU);     \
         return;                                   \
     }                                             \
-    gen_update_nip(ctx, ctx->nip - 4);            \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);            \
     ra = gen_fprp_ptr(rA(ctx->opcode));           \
     rb = gen_fprp_ptr(rB(ctx->opcode));           \
     gen_helper_##name(cpu_crf[crfD(ctx->opcode)], \
@@ -54,7 +54,7 @@ static void gen_##name(DisasContext *ctx)         \
         gen_exception(ctx, POWERPC_EXCP_FPU);     \
         return;                                   \
     }                                             \
-    gen_update_nip(ctx, ctx->nip - 4);            \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);            \
     uim = tcg_const_i32(UIMM5(ctx->opcode));      \
     rb = gen_fprp_ptr(rB(ctx->opcode));           \
     gen_helper_##name(cpu_crf[crfD(ctx->opcode)], \
@@ -72,7 +72,7 @@ static void gen_##name(DisasContext *ctx)         \
         gen_exception(ctx, POWERPC_EXCP_FPU);     \
         return;                                   \
     }                                             \
-    gen_update_nip(ctx, ctx->nip - 4);            \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);   \
     ra = gen_fprp_ptr(rA(ctx->opcode));           \
     dcm = tcg_const_i32(DCM(ctx->opcode));        \
     gen_helper_##name(cpu_crf[crfD(ctx->opcode)], \
@@ -90,7 +90,7 @@ static void gen_##name(DisasContext *ctx)             \
         gen_exception(ctx, POWERPC_EXCP_FPU);         \
         return;                                       \
     }                                                 \
-    gen_update_nip(ctx, ctx->nip - 4);                \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);       \
     rt = gen_fprp_ptr(rD(ctx->opcode));               \
     rb = gen_fprp_ptr(rB(ctx->opcode));               \
     u32_1 = tcg_const_i32(u32f1(ctx->opcode));        \
@@ -114,7 +114,7 @@ static void gen_##name(DisasContext *ctx)        \
         gen_exception(ctx, POWERPC_EXCP_FPU);    \
         return;                                  \
     }                                            \
-    gen_update_nip(ctx, ctx->nip - 4);           \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);  \
     rt = gen_fprp_ptr(rD(ctx->opcode));          \
     ra = gen_fprp_ptr(rA(ctx->opcode));          \
     rb = gen_fprp_ptr(rB(ctx->opcode));          \
@@ -137,7 +137,7 @@ static void gen_##name(DisasContext *ctx)        \
         gen_exception(ctx, POWERPC_EXCP_FPU);    \
         return;                                  \
     }                                            \
-    gen_update_nip(ctx, ctx->nip - 4);           \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);  \
     rt = gen_fprp_ptr(rD(ctx->opcode));          \
     rb = gen_fprp_ptr(rB(ctx->opcode));          \
     gen_helper_##name(cpu_env, rt, rb);          \
@@ -157,7 +157,7 @@ static void gen_##name(DisasContext *ctx)          \
         gen_exception(ctx, POWERPC_EXCP_FPU);      \
         return;                                    \
     }                                              \
-    gen_update_nip(ctx, ctx->nip - 4);             \
+    gen_update_nip(ctx, ctx->base.pc_next - 4);    \
     rt = gen_fprp_ptr(rD(ctx->opcode));            \
     rs = gen_fprp_ptr(fprfld(ctx->opcode));        \
     i32 = tcg_const_i32(i32fld(ctx->opcode));      \
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 48f2c10156..cbaa343e04 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -179,11 +179,11 @@ static void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -191,11 +191,11 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -206,11 +206,11 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 /* Time base */
 static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_tbl(cpu_gpr[gprn], cpu_env);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -218,11 +218,11 @@ static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_tbu(cpu_gpr[gprn], cpu_env);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -243,11 +243,11 @@ static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_tbl(cpu_env, cpu_gpr[gprn]);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -255,11 +255,11 @@ static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 
 static void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_tbu(cpu_env, cpu_gpr[gprn]);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -287,11 +287,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 /* HDECR */
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_hdecr(cpu_gpr[gprn], cpu_env);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -299,11 +299,11 @@ static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_hdecr(cpu_env, cpu_gpr[gprn]);
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
-- 
2.14.3
