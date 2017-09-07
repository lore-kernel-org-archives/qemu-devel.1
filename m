Received: from eggs.gnu.org ([2001:4830:134:3::10]:51205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nP-0004Wo-OS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nK-0005Yp-Al
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:59 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1nK-0005Yd-1s
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:54 -0400
Received: by mail-pg0-x232.google.com with SMTP id m9so966084pgd.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:44:47 -0700
Message-Id: <20170907184447.22752-4-richard.henderson@linaro.org>
In-Reply-To: <20170907184447.22752-1-richard.henderson@linaro.org>
References: <20170907184447.22752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/3] target/hppa: Convert to TranslatorOps
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 302 +++++++++++++++++++++++++-----------------------
 1 file changed, 159 insertions(+), 143 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 993438a60b..b6e2652341 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3729,185 +3729,201 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     return gen_illegal(ctx);
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
+                                      CPUState *cs, int max_insns)
 {
-    CPUHPPAState *env = cs->env_ptr;
-    DisasContext ctx;
-    DisasJumpType ret;
-    int num_insns, max_insns, i;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    TranslationBlock *tb = ctx->base.tb;
+    int i, bound;
 
-    ctx.base.tb = tb;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.cs = cs;
-    ctx.iaoq_f = tb->pc;
-    ctx.iaoq_b = tb->cs_base;
+    ctx->cs = cs;
+    ctx->iaoq_f = tb->pc;
+    ctx->iaoq_b = tb->cs_base;
+    ctx->iaoq_n = -1;
+    TCGV_UNUSED(ctx->iaoq_n_var);
 
-    ctx.ntemps = 0;
-    for (i = 0; i < ARRAY_SIZE(ctx.temps); ++i) {
-        TCGV_UNUSED(ctx.temps[i]);
+    ctx->ntemps = 0;
+    for (i = 0; i < ARRAY_SIZE(ctx->temps); ++i) {
+        TCGV_UNUSED(ctx->temps[i]);
     }
 
-    /* Compute the maximum number of insns to execute, as bounded by
-       (1) icount, (2) single-stepping, (3) branch delay slots, or
-       (4) the number of insns remaining on the current page.  */
-    max_insns = tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (ctx.base.singlestep_enabled || singlestep) {
-        max_insns = 1;
-    } else if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+    bound = -(tb->pc | TARGET_PAGE_MASK) / 4;
+    return MIN(max_insns, bound);
+}
 
-    num_insns = 0;
-    gen_tb_start(tb);
+static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     /* Seed the nullification status from PSW[N], as shown in TB->FLAGS.  */
-    ctx.null_cond = cond_make_f();
-    ctx.psw_n_nonzero = false;
-    if (tb->flags & 1) {
-        ctx.null_cond.c = TCG_COND_ALWAYS;
-        ctx.psw_n_nonzero = true;
+    ctx->null_cond = cond_make_f();
+    ctx->psw_n_nonzero = false;
+    if (ctx->base.tb->flags & 1) {
+        ctx->null_cond.c = TCG_COND_ALWAYS;
+        ctx->psw_n_nonzero = true;
     }
-    ctx.null_lab = NULL;
+    ctx->null_lab = NULL;
+}
 
-    do {
-        tcg_gen_insn_start(ctx.iaoq_f, ctx.iaoq_b);
-        num_insns++;
+static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.iaoq_f, BP_ANY))) {
-            ret = gen_excp(&ctx, EXCP_DEBUG);
-            break;
-        }
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
+    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b);
+}
+
+static bool hppa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        if (ctx.iaoq_f < TARGET_PAGE_SIZE) {
-            ret = do_page_zero(&ctx);
-            assert(ret != DISAS_NEXT);
+    ctx->base.is_jmp = gen_excp(ctx, EXCP_DEBUG);
+    ctx->base.pc_next = ctx->iaoq_f + 4;
+    return true;
+}
+
+static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUHPPAState *env = cs->env_ptr;
+    DisasJumpType ret;
+    int i, n;
+
+    /* Execute one insn.  */
+    if (ctx->iaoq_f < TARGET_PAGE_SIZE) {
+        ret = do_page_zero(ctx);
+        assert(ret != DISAS_NEXT);
+    } else {
+        /* Always fetch the insn, even if nullified, so that we check
+           the page permissions for execute.  */
+        uint32_t insn = cpu_ldl_code(env, ctx->iaoq_f);
+
+        /* Set up the IA queue for the next insn.
+           This will be overwritten by a branch.  */
+        if (ctx->iaoq_b == -1) {
+            ctx->iaoq_n = -1;
+            ctx->iaoq_n_var = get_temp(ctx);
+            tcg_gen_addi_tl(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
-            /* Always fetch the insn, even if nullified, so that we check
-               the page permissions for execute.  */
-            uint32_t insn = cpu_ldl_code(env, ctx.iaoq_f);
-
-            /* Set up the IA queue for the next insn.
-               This will be overwritten by a branch.  */
-            if (ctx.iaoq_b == -1) {
-                ctx.iaoq_n = -1;
-                ctx.iaoq_n_var = get_temp(&ctx);
-                tcg_gen_addi_tl(ctx.iaoq_n_var, cpu_iaoq_b, 4);
-            } else {
-                ctx.iaoq_n = ctx.iaoq_b + 4;
-                TCGV_UNUSED(ctx.iaoq_n_var);
-            }
-
-            if (unlikely(ctx.null_cond.c == TCG_COND_ALWAYS)) {
-                ctx.null_cond.c = TCG_COND_NEVER;
-                ret = DISAS_NEXT;
-            } else {
-                ret = translate_one(&ctx, insn);
-                assert(ctx.null_lab == NULL);
-            }
+            ctx->iaoq_n = ctx->iaoq_b + 4;
+            TCGV_UNUSED(ctx->iaoq_n_var);
         }
 
-        for (i = 0; i < ctx.ntemps; ++i) {
-            tcg_temp_free(ctx.temps[i]);
-            TCGV_UNUSED(ctx.temps[i]);
-        }
-        ctx.ntemps = 0;
-
-        /* If we see non-linear instructions, exhaust instruction count,
-           or run out of buffer space, stop generation.  */
-        /* ??? The non-linear instruction restriction is purely due to
-           the debugging dump.  Otherwise we *could* follow unconditional
-           branches within the same page.  */
-        if (ret == DISAS_NEXT
-            && (ctx.iaoq_b != ctx.iaoq_f + 4
-                || num_insns >= max_insns
-                || tcg_op_buf_full())) {
-            if (ctx.null_cond.c == TCG_COND_NEVER
-                || ctx.null_cond.c == TCG_COND_ALWAYS) {
-                nullify_set(&ctx, ctx.null_cond.c == TCG_COND_ALWAYS);
-                gen_goto_tb(&ctx, 0, ctx.iaoq_b, ctx.iaoq_n);
-                ret = DISAS_NORETURN;
-            } else {
-                ret = DISAS_IAQ_N_STALE;
-            }
+        if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
+            ctx->null_cond.c = TCG_COND_NEVER;
+            ret = DISAS_NEXT;
+        } else {
+            ret = translate_one(ctx, insn);
+            assert(ctx->null_lab == NULL);
         }
+    }
 
-        ctx.iaoq_f = ctx.iaoq_b;
-        ctx.iaoq_b = ctx.iaoq_n;
-        if (ret == DISAS_NORETURN || ret == DISAS_IAQ_N_UPDATED) {
-            break;
-        }
-        if (ctx.iaoq_f == -1) {
-            tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
-            copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_n, ctx.iaoq_n_var);
-            nullify_save(&ctx);
-            ret = DISAS_IAQ_N_UPDATED;
-            break;
-        }
-        if (ctx.iaoq_b == -1) {
-            tcg_gen_mov_tl(cpu_iaoq_b, ctx.iaoq_n_var);
-        }
-    } while (ret == DISAS_NEXT);
+    /* Free any temporaries allocated.  */
+    for (i = 0, n = ctx->ntemps; i < n; ++i) {
+        tcg_temp_free(ctx->temps[i]);
+        TCGV_UNUSED(ctx->temps[i]);
+    }
+    ctx->ntemps = 0;
 
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+    /* Advance the insn queue.  */
+    /* ??? The non-linear instruction restriction is purely due to
+       the debugging dump.  Otherwise we *could* follow unconditional
+       branches within the same page.  */
+    if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
+        if (ctx->null_cond.c == TCG_COND_NEVER
+            || ctx->null_cond.c == TCG_COND_ALWAYS) {
+            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
+            gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
+            ret = DISAS_NORETURN;
+        } else {
+            ret = DISAS_IAQ_N_STALE;
+       }
     }
+    ctx->iaoq_f = ctx->iaoq_b;
+    ctx->iaoq_b = ctx->iaoq_n;
+    ctx->base.is_jmp = ret;
+
+    if (ret == DISAS_NORETURN || ret == DISAS_IAQ_N_UPDATED) {
+        return;
+    }
+    if (ctx->iaoq_f == -1) {
+        tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
+        copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+        nullify_save(ctx);
+        ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
+    } else if (ctx->iaoq_b == -1) {
+        tcg_gen_mov_tl(cpu_iaoq_b, ctx->iaoq_n_var);
+    }
+}
+
+static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    switch (ret) {
+    switch (ctx->base.is_jmp) {
     case DISAS_NORETURN:
         break;
+    case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
-        copy_iaoq_entry(cpu_iaoq_f, ctx.iaoq_f, cpu_iaoq_f);
-        copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_b, cpu_iaoq_b);
-        nullify_save(&ctx);
+        copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
+        copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+        nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-        if (ctx.base.singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
         }
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
-    gen_tb_end(tb, num_insns);
+    /* We don't actually use this during normal translation,
+       but we should interact with the generic main loop.  */
+    ctx->base.pc_next = ctx->base.tb->pc + 4 * ctx->base.num_insns;
+}
 
-    tb->size = num_insns * 4;
-    tb->icount = num_insns;
+static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    TranslationBlock *tb = dcbase->tb;
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(tb->pc)) {
-        qemu_log_lock();
-        switch (tb->pc) {
-        case 0x00:
-            qemu_log("IN:\n0x00000000:  (null)\n\n");
-            break;
-        case 0xb0:
-            qemu_log("IN:\n0x000000b0:  light-weight-syscall\n\n");
-            break;
-        case 0xe0:
-            qemu_log("IN:\n0x000000e0:  set-thread-pointer-syscall\n\n");
-            break;
-        case 0x100:
-            qemu_log("IN:\n0x00000100:  syscall\n\n");
-            break;
-        default:
-            qemu_log("IN: %s\n", lookup_symbol(tb->pc));
-            log_target_disas(cs, tb->pc, tb->size, 1);
-            qemu_log("\n");
-            break;
-        }
-        qemu_log_unlock();
+    switch (tb->pc) {
+    case 0x00:
+        qemu_log("IN:\n0x00000000:  (null)\n");
+        break;
+    case 0xb0:
+        qemu_log("IN:\n0x000000b0:  light-weight-syscall\n");
+        break;
+    case 0xe0:
+        qemu_log("IN:\n0x000000e0:  set-thread-pointer-syscall\n");
+        break;
+    case 0x100:
+        qemu_log("IN:\n0x00000100:  syscall\n");
+        break;
+    default:
+        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+        log_target_disas(cs, tb->pc, tb->size, 1);
+        break;
     }
-#endif
+}
+
+static const TranslatorOps hppa_tr_ops = {
+    .init_disas_context = hppa_tr_init_disas_context,
+    .tb_start           = hppa_tr_tb_start,
+    .insn_start         = hppa_tr_insn_start,
+    .breakpoint_check   = hppa_tr_breakpoint_check,
+    .translate_insn     = hppa_tr_translate_insn,
+    .tb_stop            = hppa_tr_tb_stop,
+    .disas_log          = hppa_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+
+{
+    DisasContext ctx;
+    translator_loop(&hppa_tr_ops, &ctx.base, cs, tb);
 }
 
 void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
-- 
2.13.5
