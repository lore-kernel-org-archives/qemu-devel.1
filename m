Received: from eggs.gnu.org ([2001:4830:134:3::10]:43277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA0E-00049U-LV
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA0A-0000dk-A5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 14 Feb 2018 22:14:22 -0500
Message-Id: <1518664462-2960-4-git-send-email-cota@braap.org>
In-Reply-To: <1518664462-2960-1-git-send-email-cota@braap.org>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/3] target/ppc: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

A few changes worth noting:

- Didn't migrate ctx->exception to DISAS_* since the exception field is
  in many cases architecturally relevant.

- Moved the cross-page check from the end of translate_insn to tb_start.

- Removed the exit(1) after a TCG temp leak; changed the fprintf there to
  qemu_log.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/translate.c | 329 +++++++++++++++++++++++++------------------------
 1 file changed, 167 insertions(+), 162 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6e35daa..d0d965a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7207,217 +7207,222 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
 #endif
 }
 
-/*****************************************************************************/
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static int ppc_tr_init_disas_context(DisasContextBase *dcbase,
+                                     CPUState *cs, int max_insns)
 {
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUPPCState *env = cs->env_ptr;
-    DisasContext ctx, *ctxp = &ctx;
-    opc_handler_t **table, *handler;
-    int max_insns;
-
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.base.tb = tb;
-    ctx.base.pc_first = tb->pc;
-    ctx.base.pc_next = tb->pc; /* nip */
-    ctx.base.num_insns = 0;
-
-    ctx.exception = POWERPC_EXCP_NONE;
-    ctx.spr_cb = env->spr_cb;
-    ctx.pr = msr_pr;
-    ctx.mem_idx = env->dmmu_idx;
-    ctx.dr = msr_dr;
+    int bound;
+
+    ctx->exception = POWERPC_EXCP_NONE;
+    ctx->spr_cb = env->spr_cb;
+    ctx->pr = msr_pr;
+    ctx->mem_idx = env->dmmu_idx;
+    ctx->dr = msr_dr;
 #if !defined(CONFIG_USER_ONLY)
-    ctx.hv = msr_hv || !env->has_hv_mode;
+    ctx->hv = msr_hv || !env->has_hv_mode;
 #endif
-    ctx.insns_flags = env->insns_flags;
-    ctx.insns_flags2 = env->insns_flags2;
-    ctx.access_type = -1;
-    ctx.need_access_type = !(env->mmu_model & POWERPC_MMU_64B);
-    ctx.le_mode = !!(env->hflags & (1 << MSR_LE));
-    ctx.default_tcg_memop_mask = ctx.le_mode ? MO_LE : MO_BE;
+    ctx->insns_flags = env->insns_flags;
+    ctx->insns_flags2 = env->insns_flags2;
+    ctx->access_type = -1;
+    ctx->need_access_type = !(env->mmu_model & POWERPC_MMU_64B);
+    ctx->le_mode = !!(env->hflags & (1 << MSR_LE));
+    ctx->default_tcg_memop_mask = ctx->le_mode ? MO_LE : MO_BE;
 #if defined(TARGET_PPC64)
-    ctx.sf_mode = msr_is_64bit(env, env->msr);
-    ctx.has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
+    ctx->sf_mode = msr_is_64bit(env, env->msr);
+    ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
 #endif
     if (env->mmu_model == POWERPC_MMU_32B ||
         env->mmu_model == POWERPC_MMU_601 ||
         (env->mmu_model & POWERPC_MMU_64B))
-            ctx.lazy_tlb_flush = true;
+            ctx->lazy_tlb_flush = true;
 
-    ctx.fpu_enabled = !!msr_fp;
+    ctx->fpu_enabled = !!msr_fp;
     if ((env->flags & POWERPC_FLAG_SPE) && msr_spe)
-        ctx.spe_enabled = !!msr_spe;
+        ctx->spe_enabled = !!msr_spe;
     else
-        ctx.spe_enabled = false;
+        ctx->spe_enabled = false;
     if ((env->flags & POWERPC_FLAG_VRE) && msr_vr)
-        ctx.altivec_enabled = !!msr_vr;
+        ctx->altivec_enabled = !!msr_vr;
     else
-        ctx.altivec_enabled = false;
+        ctx->altivec_enabled = false;
     if ((env->flags & POWERPC_FLAG_VSX) && msr_vsx) {
-        ctx.vsx_enabled = !!msr_vsx;
+        ctx->vsx_enabled = !!msr_vsx;
     } else {
-        ctx.vsx_enabled = false;
+        ctx->vsx_enabled = false;
     }
 #if defined(TARGET_PPC64)
     if ((env->flags & POWERPC_FLAG_TM) && msr_tm) {
-        ctx.tm_enabled = !!msr_tm;
+        ctx->tm_enabled = !!msr_tm;
     } else {
-        ctx.tm_enabled = false;
+        ctx->tm_enabled = false;
     }
 #endif
-    ctx.gtse = !!(env->spr[SPR_LPCR] & LPCR_GTSE);
+    ctx->gtse = !!(env->spr[SPR_LPCR] & LPCR_GTSE);
     if ((env->flags & POWERPC_FLAG_SE) && msr_se)
-        ctx.singlestep_enabled = CPU_SINGLE_STEP;
+        ctx->singlestep_enabled = CPU_SINGLE_STEP;
     else
-        ctx.singlestep_enabled = 0;
+        ctx->singlestep_enabled = 0;
     if ((env->flags & POWERPC_FLAG_BE) && msr_be)
-        ctx.singlestep_enabled |= CPU_BRANCH_STEP;
-    if (unlikely(ctx.base.singlestep_enabled)) {
-        ctx.singlestep_enabled |= GDBSTUB_SINGLE_STEP;
+        ctx->singlestep_enabled |= CPU_BRANCH_STEP;
+    if (unlikely(ctx->base.singlestep_enabled)) {
+        ctx->singlestep_enabled |= GDBSTUB_SINGLE_STEP;
     }
 #if defined (DO_SINGLE_STEP) && 0
     /* Single step trace mode */
     msr_se = 1;
 #endif
-    ctx.base.num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb);
-    tcg_clear_temp_count();
-    /* Set env in case of segfault during code fetch */
-    while (ctx.exception == POWERPC_EXCP_NONE && !tcg_op_buf_full()) {
-        tcg_gen_insn_start(ctx.base.pc_next);
-        ctx.base.num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
-            gen_debug_exception(ctxp);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            ctx.base.pc_next += 4;
-            break;
-        }
 
-        LOG_DISAS("----------------\n");
-        LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
-                  ctx.base.pc_next, ctx.mem_idx, (int)msr_ir);
-        if (ctx.base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
-        if (unlikely(need_byteswap(&ctx))) {
-            ctx.opcode = bswap32(cpu_ldl_code(env, ctx.base.pc_next));
-        } else {
-            ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
-        }
-        LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
-                  ctx.opcode, opc1(ctx.opcode), opc2(ctx.opcode),
-                  opc3(ctx.opcode), opc4(ctx.opcode),
-                  ctx.le_mode ? "little" : "big");
-        ctx.base.pc_next += 4;
-        table = env->opcodes;
-        handler = table[opc1(ctx.opcode)];
+    bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
+    return MIN(max_insns, bound);
+}
+
+static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
+{
+}
+
+static void ppc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    tcg_gen_insn_start(dcbase->pc_next);
+}
+
+static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    gen_debug_exception(ctx);
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 4;
+    return true;
+}
+
+static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUPPCState *env = cs->env_ptr;
+    opc_handler_t **table, *handler;
+
+    LOG_DISAS("----------------\n");
+    LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
+              ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
+
+    if (unlikely(need_byteswap(ctx))) {
+        ctx->opcode = bswap32(cpu_ldl_code(env, ctx->base.pc_next));
+    } else {
+        ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+    }
+    LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
+              ctx->opcode, opc1(ctx->opcode), opc2(ctx->opcode),
+              opc3(ctx->opcode), opc4(ctx->opcode),
+              ctx->le_mode ? "little" : "big");
+    ctx->base.pc_next += 4;
+    table = env->opcodes;
+    handler = table[opc1(ctx->opcode)];
+    if (is_indirect_opcode(handler)) {
+        table = ind_table(handler);
+        handler = table[opc2(ctx->opcode)];
         if (is_indirect_opcode(handler)) {
             table = ind_table(handler);
-            handler = table[opc2(ctx.opcode)];
+            handler = table[opc3(ctx->opcode)];
             if (is_indirect_opcode(handler)) {
                 table = ind_table(handler);
-                handler = table[opc3(ctx.opcode)];
-                if (is_indirect_opcode(handler)) {
-                    table = ind_table(handler);
-                    handler = table[opc4(ctx.opcode)];
-                }
+                handler = table[opc4(ctx->opcode)];
             }
         }
-        /* Is opcode *REALLY* valid ? */
-        if (unlikely(handler->handler == &gen_invalid)) {
-            qemu_log_mask(LOG_GUEST_ERROR, "invalid/unsupported opcode: "
-                          "%02x - %02x - %02x - %02x (%08x) "
-                          TARGET_FMT_lx " %d\n",
-                          opc1(ctx.opcode), opc2(ctx.opcode),
-                          opc3(ctx.opcode), opc4(ctx.opcode),
-                          ctx.opcode, ctx.base.pc_next - 4, (int)msr_ir);
-        } else {
-            uint32_t inval;
+    }
+    /* Is opcode *REALLY* valid ? */
+    if (unlikely(handler->handler == &gen_invalid)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "invalid/unsupported opcode: "
+                      "%02x - %02x - %02x - %02x (%08x) "
+                      TARGET_FMT_lx " %d\n",
+                      opc1(ctx->opcode), opc2(ctx->opcode),
+                      opc3(ctx->opcode), opc4(ctx->opcode),
+                      ctx->opcode, ctx->base.pc_next - 4, (int)msr_ir);
+    } else {
+        uint32_t inval;
 
-            if (unlikely(handler->type & (PPC_SPE | PPC_SPE_SINGLE | PPC_SPE_DOUBLE) && Rc(ctx.opcode))) {
-                inval = handler->inval2;
-            } else {
-                inval = handler->inval1;
-            }
+        if (unlikely(handler->type & (PPC_SPE | PPC_SPE_SINGLE | PPC_SPE_DOUBLE)
+                     && Rc(ctx->opcode))) {
+            inval = handler->inval2;
+        } else {
+            inval = handler->inval1;
+        }
 
-            if (unlikely((ctx.opcode & inval) != 0)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "invalid bits: %08x for opcode: "
-                              "%02x - %02x - %02x - %02x (%08x) "
-                              TARGET_FMT_lx "\n", ctx.opcode & inval,
-                              opc1(ctx.opcode), opc2(ctx.opcode),
-                              opc3(ctx.opcode), opc4(ctx.opcode),
-                              ctx.opcode, ctx.base.pc_next - 4);
-                gen_inval_exception(ctxp, POWERPC_EXCP_INVAL_INVAL);
-                break;
-            }
+        if (unlikely((ctx->opcode & inval) != 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "invalid bits: %08x for opcode: "
+                          "%02x - %02x - %02x - %02x (%08x) "
+                          TARGET_FMT_lx "\n", ctx->opcode & inval,
+                          opc1(ctx->opcode), opc2(ctx->opcode),
+                          opc3(ctx->opcode), opc4(ctx->opcode),
+                          ctx->opcode, ctx->base.pc_next - 4);
+            gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+            ctx->base.is_jmp = DISAS_NORETURN;
+            return;
         }
-        (*(handler->handler))(&ctx);
+    }
+    (*(handler->handler))(ctx);
 #if defined(DO_PPC_STATISTICS)
-        handler->count++;
+    handler->count++;
 #endif
-        /* Check trace mode exceptions */
-        if (unlikely(ctx.singlestep_enabled & CPU_SINGLE_STEP &&
-                     (ctx.base.pc_next <= 0x100 || ctx.base.pc_next > 0xF00) &&
-                     ctx.exception != POWERPC_SYSCALL &&
-                     ctx.exception != POWERPC_EXCP_TRAP &&
-                     ctx.exception != POWERPC_EXCP_BRANCH)) {
-            gen_exception_nip(ctxp, POWERPC_EXCP_TRACE, ctx.base.pc_next);
-        } else if (unlikely(((ctx.base.pc_next & (TARGET_PAGE_SIZE - 1))
-                             == 0) ||
-                            (ctx.base.singlestep_enabled) ||
-                            singlestep ||
-                            ctx.base.num_insns >= max_insns)) {
-            /* if we reach a page boundary or are single stepping, stop
-             * generation
-             */
-            break;
-        }
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "Opcode %02x %02x %02x %02x (%08x) leaked "
-                    "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode),
-                    opc3(ctx.opcode), opc4(ctx.opcode), ctx.opcode);
-            exit(1);
-        }
+    /* Check trace mode exceptions */
+    if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP &&
+                 (ctx->base.pc_next <= 0x100 || ctx->base.pc_next > 0xF00) &&
+                 ctx->exception != POWERPC_SYSCALL &&
+                 ctx->exception != POWERPC_EXCP_TRAP &&
+                 ctx->exception != POWERPC_EXCP_BRANCH)) {
+        gen_exception_nip(ctx, POWERPC_EXCP_TRACE, ctx->base.pc_next);
+    }
+
+    if (translator_loop_temp_check(&ctx->base)) {
+        qemu_log("Opcode %02x %02x %02x %02x (%08x) leaked "
+                 "temporaries\n", opc1(ctx->opcode), opc2(ctx->opcode),
+                 opc3(ctx->opcode), opc4(ctx->opcode), ctx->opcode);
     }
-    if (tb_cflags(tb) & CF_LAST_IO)
-        gen_io_end();
-    if (ctx.exception == POWERPC_EXCP_NONE) {
-        gen_goto_tb(&ctx, 0, ctx.base.pc_next);
-    } else if (ctx.exception != POWERPC_EXCP_BRANCH) {
-        if (unlikely(ctx.base.singlestep_enabled)) {
-            gen_debug_exception(ctxp);
+
+    ctx->base.is_jmp = ctx->exception == POWERPC_EXCP_NONE ?
+        DISAS_NEXT : DISAS_NORETURN;
+}
+
+static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    if (ctx->exception == POWERPC_EXCP_NONE) {
+        gen_goto_tb(ctx, 0, ctx->base.pc_next);
+    } else if (ctx->exception != POWERPC_EXCP_BRANCH) {
+        if (unlikely(ctx->base.singlestep_enabled)) {
+            gen_debug_exception(ctx);
         }
         /* Generate the return instruction */
         tcg_gen_exit_tb(0);
     }
-    gen_tb_end(tb, ctx.base.num_insns);
+}
+
+static void ppc_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cs, dcbase->pc_first, dcbase->tb->size);
+}
 
-    tb->size = ctx.base.pc_next - ctx.base.pc_first;
-    tb->icount = ctx.base.num_insns;
+static const TranslatorOps ppc_tr_ops = {
+    .init_disas_context = ppc_tr_init_disas_context,
+    .tb_start           = ppc_tr_tb_start,
+    .insn_start         = ppc_tr_insn_start,
+    .breakpoint_check   = ppc_tr_breakpoint_check,
+    .translate_insn     = ppc_tr_translate_insn,
+    .tb_stop            = ppc_tr_tb_stop,
+    .disas_log          = ppc_tr_disas_log,
+};
 
-#if defined(DEBUG_DISAS)
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(ctx.base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
-        log_target_disas(cs, ctx.base.pc_first,
-                         ctx.base.pc_next - ctx.base.pc_first);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+{
+    DisasContext ctx;
+
+    translator_loop(&ppc_tr_ops, &ctx.base, cs, tb);
 }
 
 void restore_state_to_opc(CPUPPCState *env, TranslationBlock *tb,
-- 
2.7.4
