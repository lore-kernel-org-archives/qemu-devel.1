Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuZ-0001Kd-Mc
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuW-00087A-Cc
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIuW-00086t-6W
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so2721967qte.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:22:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:50 -1000
Message-Id: <20170707022111.21836-7-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

For uniprocessors, SH4 uses optimistic restartable atomic sequences.
Upon an interrupt, a real kernel would simply notice magic values in
the registers and reset the PC to the start of the sequence.

For QEMU, we cannot do this in quite the same way.  Instead, we notice
the normal start of such a sequence (mov #-x,r15), and start a new TB
that can be executed under cpu_exec_step_atomic.

Reported-by: Bruno Haible  <bruno@clisp.org>
LP: https://bugs.launchpad.net/bugs/1701971
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/cpu.h       |  18 +++++--
 target/sh4/helper.h    |   1 +
 target/sh4/op_helper.c |   6 +++
 target/sh4/translate.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 148 insertions(+), 8 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index da31805..e3abb6a 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -98,7 +98,18 @@
 
 #define TB_FLAG_PENDING_MOVCA  (1 << 3)
 
-#define TB_FLAG_ENVFLAGS_MASK  DELAY_SLOT_MASK
+#define GUSA_SHIFT             4
+#ifdef CONFIG_USER_ONLY
+#define GUSA_EXCLUSIVE         (1 << 12)
+#define GUSA_MASK              ((0xff << GUSA_SHIFT) | GUSA_EXCLUSIVE)
+#else
+/* Provide dummy versions of the above to allow tests against tbflags
+   to be elided while avoiding ifdefs.  */
+#define GUSA_EXCLUSIVE         0
+#define GUSA_MASK              0
+#endif
+
+#define TB_FLAG_ENVFLAGS_MASK  (DELAY_SLOT_MASK | GUSA_MASK)
 
 typedef struct tlb_t {
     uint32_t vpn;		/* virtual page number */
@@ -390,8 +401,9 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->flags                                        /* Bits  0-2 */
+    /* For a gUSA region, notice the end of the region.  */
+    *cs_base = env->flags & GUSA_MASK ? env->gregs[0] : 0;
+    *flags = env->flags /* TB_FLAG_ENVFLAGS_MASK: bits 0-2, 4-12 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 767a6d5..6c6fa04 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -6,6 +6,7 @@ DEF_HELPER_1(raise_slot_fpu_disable, noreturn, env)
 DEF_HELPER_1(debug, noreturn, env)
 DEF_HELPER_1(sleep, noreturn, env)
 DEF_HELPER_2(trapa, noreturn, env, i32)
+DEF_HELPER_1(exclusive, noreturn, env)
 
 DEF_HELPER_3(movcal, void, env, i32, i32)
 DEF_HELPER_1(discard_movcal_backup, void, env)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index c3d19b1..8513f38 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -115,6 +115,12 @@ void helper_trapa(CPUSH4State *env, uint32_t tra)
     raise_exception(env, 0x160, 0);
 }
 
+void helper_exclusive(CPUSH4State *env)
+{
+    /* We do not want cpu_restore_state to run.  */
+    cpu_loop_exit_atomic(ENV_GET_CPU(env), 0);
+}
+
 void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
 {
     if (cpu_sh4_is_cached (env, address))
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index cf53cd6..653c06c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -235,7 +235,9 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     if (unlikely(ctx->singlestep_enabled)) {
         return false;
     }
-
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+        return false;
+    }
 #ifndef CONFIG_USER_ONLY
     return (ctx->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
@@ -278,6 +280,28 @@ static void gen_conditional_jump(DisasContext * ctx,
 				 target_ulong ift, target_ulong ifnott)
 {
     TCGLabel *l1 = gen_new_label();
+
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+        /* When in an exclusive region, we must continue to the end.
+           Therefore, exit the region on a taken branch, but otherwise
+           fall through to the next instruction.  */
+        uint32_t taken;
+        TCGCond cond;
+
+        if (ift == ctx->pc + 2) {
+            taken = ifnott;
+            cond = TCG_COND_NE;
+        } else {
+            taken = ift;
+            cond = TCG_COND_EQ;
+        }
+        tcg_gen_brcondi_i32(cond, cpu_sr_t, 0, l1);
+        tcg_gen_movi_i32(cpu_flags, ctx->envflags & ~GUSA_MASK);
+        gen_goto_tb(ctx, 0, taken);
+        gen_set_label(l1);
+        return;
+    }
+
     gen_save_cpu_state(ctx, false);
     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_sr_t, 0, l1);
     gen_goto_tb(ctx, 0, ifnott);
@@ -289,13 +313,26 @@ static void gen_conditional_jump(DisasContext * ctx,
 /* Delayed conditional jump (bt or bf) */
 static void gen_delayed_conditional_jump(DisasContext * ctx)
 {
-    TCGLabel *l1;
-    TCGv ds;
+    TCGLabel *l1 = gen_new_label();
+    TCGv ds = tcg_temp_new();
 
-    l1 = gen_new_label();
-    ds = tcg_temp_new();
     tcg_gen_mov_i32(ds, cpu_delayed_cond);
     tcg_gen_discard_i32(cpu_delayed_cond);
+
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+        /* When in an exclusive region, we must continue to the end.
+           Therefore, exit the region on a taken branch, but otherwise
+           fall through to the next instruction.  */
+        tcg_gen_brcondi_i32(TCG_COND_EQ, ds, 0, l1);
+
+        /* Leave the gUSA region.  */
+        tcg_gen_movi_i32(cpu_flags, ctx->envflags & ~GUSA_MASK);
+        gen_jump(ctx);
+
+        gen_set_label(l1);
+        return;
+    }
+
     tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
     gen_goto_tb(ctx, 1, ctx->pc + 2);
     gen_set_label(l1);
@@ -480,6 +517,15 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0xe000:		/* mov #imm,Rn */
+#ifdef CONFIG_USER_ONLY
+        /* Detect the start of a gUSA region.  If so, update envflags
+           and end the TB.  This will allow us to see the end of the
+           region (stored in R0) in the next TB.  */
+        if (B11_8 == 15 && B7_0s < 0) {
+            ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
+            ctx->bstate = BS_STOP;
+        }
+#endif
 	tcg_gen_movi_i32(REG(B11_8), B7_0s);
 	return;
     case 0x9000:		/* mov.w @(disp,PC),Rn */
@@ -1814,6 +1860,18 @@ static void decode_opc(DisasContext * ctx)
     if (old_flags & DELAY_SLOT_MASK) {
         /* go out of the delay slot */
         ctx->envflags &= ~DELAY_SLOT_MASK;
+
+        /* When in an exclusive region, we must continue to the end
+           for conditional branches.  */
+        if (ctx->tbflags & GUSA_EXCLUSIVE
+            && old_flags & DELAY_SLOT_CONDITIONAL) {
+            gen_delayed_conditional_jump(ctx);
+            return;
+        }
+        /* Otherwise this is probably an invalid gUSA region.
+           Drop the GUSA bits so the next TB doesn't see them.  */
+        ctx->envflags &= ~GUSA_MASK;
+
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
         ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
@@ -1821,9 +1879,60 @@ static void decode_opc(DisasContext * ctx)
         } else {
             gen_jump(ctx);
 	}
+    }
+}
 
+#ifdef CONFIG_USER_ONLY
+/* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
+   Upon an interrupt, a real kernel would simply notice magic values in
+   the registers and reset the PC to the start of the sequence.
+
+   For QEMU, we cannot do this in quite the same way.  Instead, we notice
+   the normal start of such a sequence (mov #-x,r15).  While we can handle
+   any sequence via cpu_exec_step_atomic, we can recognize the "normal"
+   sequences and transform them into atomic operations as seen by the host.
+*/
+static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
+{
+    uint32_t pc = ctx->pc;
+    uint32_t pc_end = ctx->tb->cs_base;
+    int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
+    int max_insns = (pc_end - pc) / 2;
+
+    if (pc != pc_end + backup || max_insns < 2) {
+        /* This is a malformed gUSA region.  Don't do anything special,
+           since the interpreter is likely to get confused.  */
+        ctx->envflags &= ~GUSA_MASK;
+        return 0;
+    }
+
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+        /* Regardless of single-stepping or the end of the page,
+           we must complete execution of the gUSA region while
+           holding the exclusive lock.  */
+        *pmax_insns = max_insns;
+        return 0;
     }
+
+    qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
+                  pc, pc_end);
+
+    /* Restart with the EXCLUSIVE bit set, within a TB run via
+       cpu_exec_step_atomic holding the exclusive lock.  */
+    tcg_gen_insn_start(pc, ctx->envflags);
+    ctx->envflags |= GUSA_EXCLUSIVE;
+    gen_save_cpu_state(ctx, false);
+    gen_helper_exclusive(cpu_env);
+    ctx->bstate = BS_EXCP;
+
+    /* We're not executing an instruction, but we must report one for the
+       purposes of accounting within the TB.  We might as well report the
+       entire region consumed via ctx->pc so that it's immediately available
+       in the disassembly dump.  */
+    ctx->pc = pc_end;
+    return 1;
 }
+#endif
 
 void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
 {
@@ -1869,6 +1978,12 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     gen_tb_start(tb);
     num_insns = 0;
 
+#ifdef CONFIG_USER_ONLY
+    if (ctx.tbflags & GUSA_MASK) {
+        num_insns = decode_gusa(&ctx, env, &max_insns);
+    }
+#endif
+
     while (ctx.bstate == BS_NONE
            && num_insns < max_insns
            && !tcg_op_buf_full()) {
@@ -1899,6 +2014,12 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
+
+    if (ctx.tbflags & GUSA_EXCLUSIVE) {
+        /* Ending the region of exclusivity.  Clear the bits.  */
+        ctx.envflags &= ~GUSA_MASK;
+    }
+
     if (cs->singlestep_enabled) {
         gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
-- 
2.9.4
