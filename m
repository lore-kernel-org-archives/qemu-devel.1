Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P4-0003Je-Nu
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1Oz-0007aT-Bp
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:50 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1Oz-0007a2-3J
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:45 -0400
Received: by mail-pf0-x230.google.com with SMTP id g13so718476pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:19:36 -0700
Message-Id: <20170907181938.3948-3-richard.henderson@linaro.org>
In-Reply-To: <20170907181938.3948-1-richard.henderson@linaro.org>
References: <20170907181938.3948-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/4] target/alpha: Convert to DisasContextBase
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
 target/alpha/translate.c | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a75bf5dd90..ba38717e0f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -43,8 +43,8 @@
 
 typedef struct DisasContext DisasContext;
 struct DisasContext {
-    struct TranslationBlock *tb;
-    uint64_t pc;
+    DisasContextBase base;
+
 #ifndef CONFIG_USER_ONLY
     uint64_t palbr;
 #endif
@@ -68,8 +68,6 @@ struct DisasContext {
     TCGv sink;
     /* Temporary for immediate constants.  */
     TCGv lit;
-
-    bool singlestep_enabled;
 };
 
 /* Target-specific return values from translate_one, indicating the
@@ -282,7 +280,7 @@ static void gen_excp_1(int exception, int error_code)
 
 static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
 {
-    tcg_gen_movi_i64(cpu_pc, ctx->pc);
+    tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
     gen_excp_1(exception, error_code);
     return DISAS_NORETURN;
 }
@@ -463,8 +461,8 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
 
 static bool use_exit_tb(DisasContext *ctx)
 {
-    return ((ctx->tb->cflags & CF_LAST_IO)
-            || ctx->singlestep_enabled
+    return ((ctx->base.tb->cflags & CF_LAST_IO)
+            || ctx->base.singlestep_enabled
             || singlestep);
 }
 
@@ -480,7 +478,7 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
         return true;
     }
     /* Check for the dest on the same page as the start of the TB.  */
-    return ((ctx->tb->pc ^ dest) & TARGET_PAGE_MASK) == 0;
+    return ((ctx->base.tb->pc ^ dest) & TARGET_PAGE_MASK) == 0;
 #else
     return true;
 #endif
@@ -488,10 +486,10 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->pc + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + (disp << 2);
 
     if (ra != 31) {
-        tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
+        tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
     }
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
@@ -500,7 +498,7 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
     } else if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
         return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
@@ -511,26 +509,26 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, int32_t disp)
 {
-    uint64_t dest = ctx->pc + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
 
         tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, ctx->pc);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb);
+        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
 
         gen_set_label(lab_true);
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + 1);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + 1);
 
         return DISAS_NORETURN;
     } else {
         TCGv_i64 z = tcg_const_i64(0);
         TCGv_i64 d = tcg_const_i64(dest);
-        TCGv_i64 p = tcg_const_i64(ctx->pc);
+        TCGv_i64 p = tcg_const_i64(ctx->base.pc_next);
 
         tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
 
@@ -1210,7 +1208,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             }
 
             /* Allow interrupts to be recognized right away.  */
-            tcg_gen_movi_i64(cpu_pc, ctx->pc);
+            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
             return DISAS_PC_UPDATED_NOCHAIN;
 
         case 0x36:
@@ -1260,7 +1258,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #else
     {
         TCGv tmp = tcg_temp_new();
-        uint64_t exc_addr = ctx->pc;
+        uint64_t exc_addr = ctx->base.pc_next;
         uint64_t entry = ctx->palbr;
 
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
@@ -1285,7 +1283,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
         if (!use_exit_tb(ctx)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, entry);
-            tcg_gen_exit_tb((uintptr_t)ctx->tb);
+            tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
             return DISAS_NORETURN;
         } else {
             tcg_gen_movi_i64(cpu_pc, entry);
@@ -2407,7 +2405,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0xC000:
             /* RPCC */
             va = dest_gpr(ctx, ra);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
                 gen_io_end();
@@ -2457,7 +2455,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         vb = load_gpr(ctx, rb);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
         if (ra != 31) {
-            tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
+            tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
         }
         ret = DISAS_PC_UPDATED;
         break;
@@ -2944,13 +2942,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     pc_start = tb->pc;
 
-    ctx.tb = tb;
-    ctx.pc = pc_start;
+    ctx.base.tb = tb;
+    ctx.base.pc_next = pc_start;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+
     ctx.tbflags = tb->flags;
     ctx.mem_idx = cpu_mmu_index(env, false);
     ctx.implver = env->implver;
     ctx.amask = env->amask;
-    ctx.singlestep_enabled = cs->singlestep_enabled;
 
 #ifdef CONFIG_USER_ONLY
     ctx.ir = cpu_std_ir;
@@ -2992,39 +2991,40 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     tcg_clear_temp_count();
 
     do {
-        tcg_gen_insn_start(ctx.pc);
+        tcg_gen_insn_start(ctx.base.pc_next);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
             ret = gen_excp(&ctx, EXCP_DEBUG, 0);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.pc += 4;
+            ctx.base.pc_next += 4;
             break;
         }
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
-        insn = cpu_ldl_code(env, ctx.pc);
+        insn = cpu_ldl_code(env, ctx.base.pc_next);
 
-        ctx.pc += 4;
+        ctx.base.pc_next += 4;
         ret = translate_one(ctxp, insn);
         free_context_temps(ctxp);
 
         if (tcg_check_temp_count()) {
-            qemu_log("TCG temporary leak before "TARGET_FMT_lx"\n", ctx.pc);
+            qemu_log("TCG temporary leak before "TARGET_FMT_lx"\n",
+                     ctx.base.pc_next);
         }
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
         if (ret == DISAS_NEXT
-            && ((ctx.pc & pc_mask) == 0
+            && ((ctx.base.pc_next & pc_mask) == 0
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
-                || ctx.singlestep_enabled)) {
+                || ctx.base.singlestep_enabled)) {
             ret = DISAS_TOO_MANY;
         }
     } while (ret == DISAS_NEXT);
@@ -3037,14 +3037,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        if (use_goto_tb(&ctx, ctx.pc)) {
+        if (use_goto_tb(&ctx, ctx.base.pc_next)) {
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(cpu_pc, ctx.pc);
-            tcg_gen_exit_tb((uintptr_t)ctx.tb);
+            tcg_gen_movi_i64(cpu_pc, ctx.base.pc_next);
+            tcg_gen_exit_tb((uintptr_t)ctx.base.tb);
         }
         /* FALLTHRU */
     case DISAS_PC_STALE:
-        tcg_gen_movi_i64(cpu_pc, ctx.pc);
+        tcg_gen_movi_i64(cpu_pc, ctx.base.pc_next);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         if (!use_exit_tb(&ctx)) {
@@ -3053,7 +3053,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
         /* FALLTHRU */
     case DISAS_PC_UPDATED_NOCHAIN:
-        if (ctx.singlestep_enabled) {
+        if (ctx.base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG, 0);
         } else {
             tcg_gen_exit_tb(0);
@@ -3065,7 +3065,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     gen_tb_end(tb, num_insns);
 
-    tb->size = ctx.pc - pc_start;
+    tb->size = ctx.base.pc_next - pc_start;
     tb->icount = num_insns;
 
 #ifdef DEBUG_DISAS
@@ -3073,7 +3073,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 1);
+        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start, 1);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.13.5
