Received: from eggs.gnu.org ([2001:4830:134:3::10]:60059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0B-0005Ix-Cg
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT09-00062c-Vx
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:31 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT09-00062H-Nx
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:29 -0500
Received: by mail-pf0-x243.google.com with SMTP id k19so6079995pfj.5
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:40 -0800
Message-Id: <20180122034217.19593-7-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/43] target/hppa: Implement mmu_idx from IA
 privilege level
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

Most aspects of privilege are not yet handled.  But this
gives us the start from which to begin checking.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       | 19 +++++++++++++----
 target/hppa/cpu.c       |  2 +-
 target/hppa/translate.c | 55 ++++++++++++++++++++++++++++++-------------------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 1524ef91b6..805c93db9c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -36,8 +36,10 @@
 #define TARGET_PAGE_BITS 12
 
 #define ALIGNED_ONLY
-#define NB_MMU_MODES     1
-#define MMU_USER_IDX     0
+#define NB_MMU_MODES     5
+#define MMU_KERNEL_IDX   0
+#define MMU_USER_IDX     3
+#define MMU_PHYS_IDX     4
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 /* Hardware exceptions, interupts, faults, and traps.  */
@@ -195,7 +197,14 @@ static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
 
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
-    return 0;
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
+        return env->iaoq_f & 3;
+    }
+    return MMU_PHYS_IDX;  /* mmu disabled */
+#endif
 }
 
 void hppa_translate_init(void);
@@ -210,7 +219,9 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
 {
     *pc = env->iaoq_f;
     *cs_base = env->iaoq_b;
-    *pflags = env->psw_n;
+    /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
+    *pflags = (env->psw & (PSW_W | PSW_C | PSW_D))
+            | env->psw_n * PSW_N;
 }
 
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index f6d92de972..9962ab71ee 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -39,7 +39,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
     cpu->env.iaoq_f = tb->pc;
     cpu->env.iaoq_b = tb->cs_base;
-    cpu->env.psw_n = tb->flags & 1;
+    cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b3996cfcdc..8a40c3f46b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,6 +278,8 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    int mmu_idx;
+    int privilege;
     bool psw_n_nonzero;
 } DisasContext;
 
@@ -1288,10 +1290,10 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     }
 
     if (modify == 0) {
-        tcg_gen_qemu_ld_i32(dest, addr, MMU_USER_IDX, mop);
+        tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop);
     } else {
         tcg_gen_qemu_ld_i32(dest, (modify < 0 ? addr : base),
-                            MMU_USER_IDX, mop);
+                            ctx->mmu_idx, mop);
         save_gpr(ctx, rb, addr);
     }
     tcg_temp_free(addr);
@@ -1318,10 +1320,10 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     }
 
     if (modify == 0) {
-        tcg_gen_qemu_ld_i64(dest, addr, MMU_USER_IDX, mop);
+        tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop);
     } else {
         tcg_gen_qemu_ld_i64(dest, (modify < 0 ? addr : base),
-                            MMU_USER_IDX, mop);
+                            ctx->mmu_idx, mop);
         save_gpr(ctx, rb, addr);
     }
     tcg_temp_free(addr);
@@ -1347,7 +1349,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
         tcg_gen_addi_reg(addr, base, disp);
     }
 
-    tcg_gen_qemu_st_i32(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
+    tcg_gen_qemu_st_i32(src, (modify <= 0 ? addr : base), ctx->mmu_idx, mop);
 
     if (modify != 0) {
         save_gpr(ctx, rb, addr);
@@ -1375,7 +1377,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
         tcg_gen_addi_reg(addr, base, disp);
     }
 
-    tcg_gen_qemu_st_i64(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
+    tcg_gen_qemu_st_i64(src, (modify <= 0 ? addr : base), ctx->mmu_idx, mop);
 
     if (modify != 0) {
         save_gpr(ctx, rb, addr);
@@ -2486,7 +2488,7 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
 
     zero = tcg_const_reg(0);
     tcg_gen_atomic_xchg_reg(dest, (modify <= 0 ? addr : base),
-                            zero, MMU_USER_IDX, mop);
+                            zero, ctx->mmu_idx, mop);
     if (modify) {
         save_gpr(ctx, rb, addr);
     }
@@ -3960,30 +3962,43 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
                                       CPUState *cs, int max_insns)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    TranslationBlock *tb = ctx->base.tb;
     int bound;
 
     ctx->cs = cs;
-    ctx->iaoq_f = tb->pc;
-    ctx->iaoq_b = tb->cs_base;
+
+#ifdef CONFIG_USER_ONLY
+    ctx->privilege = MMU_USER_IDX;
+    ctx->mmu_idx = MMU_USER_IDX;
+#else
+    ctx->privilege = ctx->base.pc_first & 3;
+    ctx->mmu_idx = (ctx->base.tb->flags & PSW_D
+                    ? ctx->privilege : MMU_PHYS_IDX);
+#endif
+    ctx->iaoq_f = ctx->base.pc_first;
+    ctx->iaoq_b = ctx->base.tb->cs_base;
+    ctx->base.pc_first &= -4;
+
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
 
+    /* Bound the number of instructions by those left on the page.  */
+    bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
+    bound = MIN(max_insns, bound);
+
     ctx->ntemps = 0;
     memset(ctx->temps, 0, sizeof(ctx->temps));
 
-    bound = -(tb->pc | TARGET_PAGE_MASK) / 4;
-    return MIN(max_insns, bound);
+    return bound;
 }
 
 static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    /* Seed the nullification status from PSW[N], as shown in TB->FLAGS.  */
+    /* Seed the nullification status from PSW[N], as saved in TB->FLAGS.  */
     ctx->null_cond = cond_make_f();
     ctx->psw_n_nonzero = false;
-    if (ctx->base.tb->flags & 1) {
+    if (ctx->base.tb->flags & PSW_N) {
         ctx->null_cond.c = TCG_COND_ALWAYS;
         ctx->psw_n_nonzero = true;
     }
@@ -4003,7 +4018,7 @@ static bool hppa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     ctx->base.is_jmp = gen_excp(ctx, EXCP_DEBUG);
-    ctx->base.pc_next = ctx->iaoq_f + 4;
+    ctx->base.pc_next = (ctx->iaoq_f & -4) + 4;
     return true;
 }
 
@@ -4024,7 +4039,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->iaoq_f);
+        uint32_t insn = cpu_ldl_code(env, ctx->iaoq_f & -4);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
@@ -4053,10 +4068,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
     ctx->ntemps = 0;
 
-    /* Advance the insn queue.  */
-    /* ??? The non-linear instruction restriction is purely due to
-       the debugging dump.  Otherwise we *could* follow unconditional
-       branches within the same page.  */
+    /* Advance the insn queue.  Note that this check also detects
+       a priority change within the instruction queue.  */
     if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
         if (ctx->null_cond.c == TCG_COND_NEVER
             || ctx->null_cond.c == TCG_COND_ALWAYS) {
@@ -4110,7 +4123,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     /* We don't actually use this during normal translation,
        but we should interact with the generic main loop.  */
-    ctx->base.pc_next = ctx->base.tb->pc + 4 * ctx->base.num_insns;
+    ctx->base.pc_next = ctx->base.pc_first + 4 * ctx->base.num_insns;
 }
 
 static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
-- 
2.14.3
