Received: from eggs.gnu.org ([2001:4830:134:3::10]:48624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy5-0003kb-AV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy2-0000Sg-T9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4Vy2-0000ST-Ox
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  6 Apr 2018 14:19:52 -0400
Message-Id: <1523038800-2494-10-git-send-email-cota@braap.org>
In-Reply-To: <1523038800-2494-1-git-send-email-cota@braap.org>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 09/17] target/mips: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Notes:

- DISAS_TOO_MANY replaces the former "break" in the translation loop.
  However, care must be taken not to overwrite a previous condition
  in is_jmp; that's why in translate_insn we first check is_jmp and
  return if it's != DISAS_NEXT.

- Added an assert in translate_insn, before exiting due to an exception,
  to make sure that is_jmp is set to DISAS_EXCP (the exception generation
  function always sets it.)

- Added an assert for the default case in is_jmp's switch.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/translate.c | 227 ++++++++++++++++++++++++------------------------
 1 file changed, 113 insertions(+), 114 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 08bd140..f01139c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1432,6 +1432,7 @@ static TCGv_i64 msa_wr_d[64];
 typedef struct DisasContext {
     DisasContextBase base;
     target_ulong saved_pc;
+    target_ulong next_page_start;
     uint32_t opcode;
     int insn_flags;
     int32_t CP0_Config1;
@@ -20194,24 +20195,12 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUMIPSState *env = cs->env_ptr;
-    DisasContext ctx1;
-    DisasContext *ctx = &ctx1;
-    target_ulong next_page_start;
-    int max_insns;
-    int insn_bytes;
-    int is_slot;
-
-    ctx->base.tb = tb;
-    ctx->base.pc_first = tb->pc;
-    ctx->base.pc_next = tb->pc;
-    ctx->base.is_jmp = DISAS_NEXT;
-    ctx->base.singlestep_enabled = cs->singlestep_enabled;
-    ctx->base.num_insns = 0;
 
-    next_page_start = (ctx->base.pc_first & TARGET_PAGE_MASK) +
+    ctx->next_page_start = (ctx->base.pc_first & TARGET_PAGE_MASK) +
         TARGET_PAGE_SIZE;
     ctx->saved_pc = -1;
     ctx->insn_flags = env->insn_flags;
@@ -20245,99 +20234,102 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 #endif
     ctx->default_tcg_memop_mask = (ctx->insn_flags & ISA_MIPS32R6) ?
                                   MO_UNALN : MO_ALIGN;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
-    LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx->mem_idx, ctx->hflags);
-    gen_tb_start(tb);
-    while (ctx->base.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx->base.pc_next, ctx->hflags & MIPS_HFLAG_BMASK,
-                           ctx->btarget);
-        ctx->base.num_insns++;
+    LOG_DISAS("\ntb %p idx %d hflags %04x\n", ctx->base.tb, ctx->mem_idx,
+              ctx->hflags);
+}
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx->base.pc_next, BP_ANY))) {
-            save_cpu_state(ctx, 1);
-            ctx->base.is_jmp = DISAS_NORETURN;
-            gen_helper_raise_exception_debug(cpu_env);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            ctx->base.pc_next += 4;
-            goto done_generating;
-        }
+static void mips_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+{
+}
 
-        if (ctx->base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void mips_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
-        if (!(ctx->hflags & MIPS_HFLAG_M16)) {
-            ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-            insn_bytes = 4;
-            decode_opc(env, ctx);
-        } else if (ctx->insn_flags & ASE_MICROMIPS) {
-            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
-            insn_bytes = decode_micromips_opc(env, ctx);
-        } else if (ctx->insn_flags & ASE_MIPS16) {
-            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
-            insn_bytes = decode_mips16_opc(env, ctx);
-        } else {
-            generate_exception_end(ctx, EXCP_RI);
-            break;
-        }
+    tcg_gen_insn_start(ctx->base.pc_next, ctx->hflags & MIPS_HFLAG_BMASK,
+                       ctx->btarget);
+}
 
-        if (ctx->hflags & MIPS_HFLAG_BMASK) {
-            if (!(ctx->hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
-                                MIPS_HFLAG_FBNSLOT))) {
-                /* force to generate branch as there is neither delay nor
-                   forbidden slot */
-                is_slot = 1;
-            }
-            if ((ctx->hflags & MIPS_HFLAG_M16) &&
-                (ctx->hflags & MIPS_HFLAG_FBNSLOT)) {
-                /* Force to generate branch as microMIPS R6 doesn't restrict
-                   branches in the forbidden slot. */
-                is_slot = 1;
-            }
-        }
-        if (is_slot) {
-            gen_branch(ctx, insn_bytes);
-        }
-        ctx->base.pc_next += insn_bytes;
+static bool mips_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                     const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        /* Execute a branch and its delay slot as a single instruction.
-           This is what GDB expects and is consistent with what the
-           hardware does (e.g. if a delay slot instruction faults, the
-           reported PC is the PC of the branch).  */
-        if (ctx->base.singlestep_enabled &&
-            (ctx->hflags & MIPS_HFLAG_BMASK) == 0) {
-            break;
-        }
+    save_cpu_state(ctx, 1);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_helper_raise_exception_debug(cpu_env);
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 4;
+    return true;
+}
 
-        if (ctx->base.pc_next >= next_page_start) {
-            break;
-        }
+static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPUMIPSState *env = cs->env_ptr;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    int insn_bytes;
+    int is_slot;
 
-        if (tcg_op_buf_full()) {
-            break;
-        }
+    is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
+    if (!(ctx->hflags & MIPS_HFLAG_M16)) {
+        ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+        insn_bytes = 4;
+        decode_opc(env, ctx);
+    } else if (ctx->insn_flags & ASE_MICROMIPS) {
+        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+        insn_bytes = decode_micromips_opc(env, ctx);
+    } else if (ctx->insn_flags & ASE_MIPS16) {
+        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+        insn_bytes = decode_mips16_opc(env, ctx);
+    } else {
+        generate_exception_end(ctx, EXCP_RI);
+        g_assert(ctx->base.is_jmp == DISAS_EXCP);
+        return;
+    }
 
-        if (ctx->base.num_insns >= max_insns) {
-            break;
+    if (ctx->hflags & MIPS_HFLAG_BMASK) {
+        if (!(ctx->hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
+                             MIPS_HFLAG_FBNSLOT))) {
+            /* force to generate branch as there is neither delay nor
+               forbidden slot */
+            is_slot = 1;
+        }
+        if ((ctx->hflags & MIPS_HFLAG_M16) &&
+            (ctx->hflags & MIPS_HFLAG_FBNSLOT)) {
+            /* Force to generate branch as microMIPS R6 doesn't restrict
+               branches in the forbidden slot. */
+            is_slot = 1;
         }
+    }
+    if (is_slot) {
+        gen_branch(ctx, insn_bytes);
+    }
+    ctx->base.pc_next += insn_bytes;
 
-        if (singlestep)
-            break;
+    if (ctx->base.is_jmp != DISAS_NEXT) {
+        return;
     }
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
+    /* Execute a branch and its delay slot as a single instruction.
+       This is what GDB expects and is consistent with what the
+       hardware does (e.g. if a delay slot instruction faults, the
+       reported PC is the PC of the branch).  */
+    if (ctx->base.singlestep_enabled &&
+        (ctx->hflags & MIPS_HFLAG_BMASK) == 0) {
+        ctx->base.is_jmp = DISAS_TOO_MANY;
+    }
+    if (ctx->base.pc_next >= ctx->next_page_start) {
+        ctx->base.is_jmp = DISAS_TOO_MANY;
     }
+}
+
+static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
     if (ctx->base.singlestep_enabled && ctx->base.is_jmp != DISAS_NORETURN) {
         save_cpu_state(ctx, ctx->base.is_jmp != DISAS_EXCP);
         gen_helper_raise_exception_debug(cpu_env);
@@ -20347,6 +20339,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_goto_tb(ctx, 0, ctx->base.pc_next);
             break;
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             save_cpu_state(ctx, 0);
             gen_goto_tb(ctx, 0, ctx->base.pc_next);
             break;
@@ -20354,28 +20347,34 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             tcg_gen_exit_tb(0);
             break;
         case DISAS_NORETURN:
-        default:
             break;
+        default:
+            g_assert_not_reached();
         }
     }
-done_generating:
-    gen_tb_end(tb, ctx->base.num_insns);
-
-    tb->size = ctx->base.pc_next - ctx->base.pc_first;
-    tb->icount = ctx->base.num_insns;
-
-#ifdef DEBUG_DISAS
-    LOG_DISAS("\n");
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(ctx->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(ctx->base.pc_first));
-        log_target_disas(cs, ctx->base.pc_first,
-                         ctx->base.pc_next - ctx->base.pc_first);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+}
+
+static void mips_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cs, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps mips_tr_ops = {
+    .init_disas_context = mips_tr_init_disas_context,
+    .tb_start           = mips_tr_tb_start,
+    .insn_start         = mips_tr_insn_start,
+    .breakpoint_check   = mips_tr_breakpoint_check,
+    .translate_insn     = mips_tr_translate_insn,
+    .tb_stop            = mips_tr_tb_stop,
+    .disas_log          = mips_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+{
+    DisasContext ctx;
+
+    translator_loop(&mips_tr_ops, &ctx.base, cs, tb);
 }
 
 static void fpu_dump_state(CPUMIPSState *env, FILE *f, fprintf_function fpu_fprintf,
-- 
2.7.4
