Received: from eggs.gnu.org ([2001:4830:134:3::10]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX5-0007YQ-6s
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0004Fj-85
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:03 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX2-0004BQ-VZ
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:39 +0200
Message-Id: <20170501221046.9369-8-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 07/14] target/sh4: only save flags state at the
 end of the TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

There is no need to save flags when entering and exiting the delay slot.
They can be saved only when reaching the end of the TB. If the TB is
interrupted before by an exception, they will be restored using
restore_state_to_opc.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 69 ++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 213eb2a0bb..8c99e4fb21 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -212,6 +212,20 @@ static void gen_write_sr(TCGv src)
     tcg_gen_andi_i32(cpu_sr_t, cpu_sr_t, 1);
 }
 
+static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
+{
+    if (save_pc) {
+        tcg_gen_movi_i32(cpu_pc, ctx->pc);
+    }
+    if (ctx->delayed_pc != (uint32_t) -1) {
+        tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
+    }
+    if ((ctx->tbflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL))
+        != ctx->envflags) {
+        tcg_gen_movi_i32(cpu_flags, ctx->envflags);
+    }
+}
+
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     if (unlikely(ctx->singlestep_enabled)) {
@@ -246,6 +260,7 @@ static void gen_jump(DisasContext * ctx)
 	/* Target is not statically known, it comes necessarily from a
 	   delayed jump as immediate jump are conditinal jumps */
 	tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
+        tcg_gen_discard_i32(cpu_delayed_pc);
 	if (ctx->singlestep_enabled)
             gen_helper_debug(cpu_env);
 	tcg_gen_exit_tb(0);
@@ -254,21 +269,12 @@ static void gen_jump(DisasContext * ctx)
     }
 }
 
-static inline void gen_branch_slot(uint32_t delayed_pc, int t)
-{
-    tcg_gen_movi_i32(cpu_delayed_pc, delayed_pc);
-    if (t) {
-        tcg_gen_mov_i32(cpu_delayed_cond, cpu_sr_t);
-    } else {
-        tcg_gen_xori_i32(cpu_delayed_cond, cpu_sr_t, 1);
-    }
-}
-
 /* Immediate conditional jump (bt or bf) */
 static void gen_conditional_jump(DisasContext * ctx,
 				 target_ulong ift, target_ulong ifnott)
 {
     TCGLabel *l1 = gen_new_label();
+    gen_save_cpu_state(ctx, false);
     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_sr_t, 0, l1);
     gen_goto_tb(ctx, 0, ifnott);
     gen_set_label(l1);
@@ -291,11 +297,6 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
     gen_jump(ctx);
 }
 
-static inline void gen_store_flags(uint32_t flags)
-{
-    tcg_gen_movi_i32(cpu_flags, flags);
-}
-
 static inline void gen_load_fpr64(TCGv_i64 t, int reg)
 {
     tcg_gen_concat_i32_i64(t, cpu_fregs[reg + 1], cpu_fregs[reg]);
@@ -337,7 +338,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {     \
-        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
+        gen_save_cpu_state(ctx, true);                               \
         gen_helper_raise_slot_illegal_instruction(cpu_env);          \
         ctx->bstate = BS_EXCP;                                       \
         return;                                                      \
@@ -345,7 +346,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 
 #define CHECK_PRIVILEGED                                             \
     if (IS_USER(ctx)) {                                              \
-        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
+        gen_save_cpu_state(ctx, true);                               \
         if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
             gen_helper_raise_slot_illegal_instruction(cpu_env);      \
         } else {                                                     \
@@ -357,7 +358,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 
 #define CHECK_FPU_ENABLED                                            \
     if (ctx->tbflags & (1u << SR_FD)) {                              \
-        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
+        gen_save_cpu_state(ctx, true);                               \
         if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
             gen_helper_raise_slot_fpu_disable(cpu_env);              \
         } else {                                                     \
@@ -501,14 +502,12 @@ static void _decode_opc(DisasContext * ctx)
     case 0xa000:		/* bra disp */
 	CHECK_NOT_DELAY_SLOT
 	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
-	tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
         ctx->envflags |= DELAY_SLOT;
 	return;
     case 0xb000:		/* bsr disp */
 	CHECK_NOT_DELAY_SLOT
 	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
 	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
-	tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
         ctx->envflags |= DELAY_SLOT;
 	return;
     }
@@ -1165,7 +1164,8 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x8f00:		/* bf/s label */
 	CHECK_NOT_DELAY_SLOT
-	gen_branch_slot(ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2, 0);
+        tcg_gen_xori_i32(cpu_delayed_cond, cpu_sr_t, 1);
+        ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2;
         ctx->envflags |= DELAY_SLOT_CONDITIONAL;
 	return;
     case 0x8900:		/* bt label */
@@ -1176,7 +1176,8 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x8d00:		/* bt/s label */
 	CHECK_NOT_DELAY_SLOT
-	gen_branch_slot(ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2, 1);
+        tcg_gen_mov_i32(cpu_delayed_cond, cpu_sr_t);
+        ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2;
         ctx->envflags |= DELAY_SLOT_CONDITIONAL;
 	return;
     case 0x8800:		/* cmp/eq #imm,R0 */
@@ -1285,7 +1286,7 @@ static void _decode_opc(DisasContext * ctx)
 	{
 	    TCGv imm;
 	    CHECK_NOT_DELAY_SLOT
-            tcg_gen_movi_i32(cpu_pc, ctx->pc);
+            gen_save_cpu_state(ctx, true);
 	    imm = tcg_const_i32(B7_0);
             gen_helper_trapa(cpu_env, imm);
 	    tcg_temp_free(imm);
@@ -1792,7 +1793,7 @@ static void _decode_opc(DisasContext * ctx)
 	    ctx->opcode, ctx->pc);
     fflush(stderr);
 #endif
-    tcg_gen_movi_i32(cpu_pc, ctx->pc);
+    gen_save_cpu_state(ctx, true);
     if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
         gen_helper_raise_slot_illegal_instruction(cpu_env);
     } else {
@@ -1810,7 +1811,7 @@ static void decode_opc(DisasContext * ctx)
     if (old_flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
         /* go out of the delay slot */
         ctx->envflags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
-        gen_store_flags(ctx->envflags);
+        tcg_gen_movi_i32(cpu_flags, ctx->envflags);
         ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
@@ -1819,11 +1820,6 @@ static void decode_opc(DisasContext * ctx)
 	}
 
     }
-
-    /* go into a delay slot */
-    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
-        gen_store_flags(ctx->envflags);
-    }
 }
 
 void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
@@ -1865,7 +1861,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
 
         if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
             /* We have hit a breakpoint - make sure PC is up-to-date */
-            tcg_gen_movi_i32(cpu_pc, ctx.pc);
+            gen_save_cpu_state(&ctx, true);
             gen_helper_debug(cpu_env);
             ctx.bstate = BS_EXCP;
             /* The address covered by the breakpoint must be included in
@@ -1896,18 +1892,16 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
     if (cs->singlestep_enabled) {
-        tcg_gen_movi_i32(cpu_pc, ctx.pc);
+        gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
     } else {
 	switch (ctx.bstate) {
         case BS_STOP:
-            tcg_gen_movi_i32(cpu_pc, ctx.pc);
+            gen_save_cpu_state(&ctx, true);
             tcg_gen_exit_tb(0);
             break;
         case BS_NONE:
-            if (ctx.envflags) {
-                gen_store_flags(ctx.envflags);
-	    }
+            gen_save_cpu_state(&ctx, false);
             gen_goto_tb(&ctx, 0, ctx.pc);
             break;
         case BS_EXCP:
@@ -1940,4 +1934,7 @@ void restore_state_to_opc(CPUSH4State *env, TranslationBlock *tb,
 {
     env->pc = data[0];
     env->flags = data[1];
+    /* Theoretically delayed_pc should also be restored. In practice the
+       branch instruction is re-executed after exception, so the delayed
+       branch target will be recomputed. */
 }
-- 
2.11.0
