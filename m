Received: from eggs.gnu.org ([2001:4830:134:3::10]:50933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDX-0003Hx-1K
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDV-0004qx-1e
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:30 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:47011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDU-0004qX-PY
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:28 -0500
Received: by mail-pf0-x243.google.com with SMTP id c204so21819872pfc.13
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:37 -0800
Message-Id: <20171229063145.29167-31-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 30/38] target/hppa: Optimize for flat
 addressing space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Linux sets sr4-sr7 all to the same value, which means that we
need not do any runtime computation to find out what space to
use in forming the GVA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  8 +++++++-
 target/hppa/translate.c | 32 +++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c072f55d31..8c8ce66094 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -282,11 +282,12 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_psw(env->psw, spc, off);
 }
 
-/* Since PSW_V and PSW_CB will never need to be in tb->flags, reuse them.
+/* Since PSW_{V,I,CB} will never need to be in tb->flags, reuse them.
  * TB_FLAG_NONSEQ indicates that the two instructions in the insn queue
  * are non-sequential.
  */
 #define TB_FLAG_NONSEQ      PSW_V
+#define TB_FLAG_SR_SAME     PSW_I
 #define TB_FLAG_PRIV_SHIFT  8
 
 static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
@@ -294,6 +295,7 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
                                         uint32_t *pflags)
 {
     bool nonseq = env->iaoq_b != env->iaoq_f + 4;
+    bool sr_same = false;
     int priv;
 
     /* TB lookup assumes that PC contains the complete virtual address.
@@ -316,12 +318,16 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
         *pc = env->iaoq_f & -4;
         *cs_base = 0;
     }
+    sr_same = (env->sr[4] == env->sr[5])
+            & (env->sr[4] == env->sr[6])
+            & (env->sr[4] == env->sr[7]);
 #endif
 
     /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
     *pflags = (env->psw & (PSW_W | PSW_C | PSW_D))
             | env->psw_n * PSW_N
             | nonseq * TB_FLAG_NONSEQ
+            | sr_same * TB_FLAG_SR_SAME
             | (priv << TB_FLAG_PRIV_SHIFT);
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 68f0b86c72..23ec43eff8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -280,6 +280,7 @@ typedef struct DisasContext {
     TCGLabel *null_lab;
 
     uint32_t insn;
+    uint32_t tb_flags;
     int mmu_idx;
     int privilege;
     bool psw_n_nonzero;
@@ -320,6 +321,7 @@ typedef struct DisasInsn {
 /* global register indexes */
 static TCGv_reg cpu_gr[32];
 static TCGv_i64 cpu_sr[4];
+static TCGv_i64 cpu_srH;
 static TCGv_reg cpu_iaoq_f;
 static TCGv_reg cpu_iaoq_b;
 static TCGv_i64 cpu_iasq_f;
@@ -357,8 +359,8 @@ void hppa_translate_init(void)
         "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
     };
     /* SR[4-7] are not global registers so that we can index them.  */
-    static const char sr_names[4][4] = {
-        "sr0", "sr1", "sr2", "sr3"
+    static const char sr_names[5][4] = {
+        "sr0", "sr1", "sr2", "sr3", "srH"
     };
 
     int i;
@@ -374,6 +376,9 @@ void hppa_translate_init(void)
                                            offsetof(CPUHPPAState, sr[i]),
                                            sr_names[i]);
     }
+    cpu_srH = tcg_global_mem_new_i64(cpu_env,
+                                     offsetof(CPUHPPAState, sr[4]),
+                                     sr_names[4]);
 
     for (i = 0; i < ARRAY_SIZE(vars); ++i) {
         const GlobalVar *v = &vars[i];
@@ -601,6 +606,8 @@ static void load_spr(DisasContext *ctx, TCGv_i64 dest, unsigned reg)
 #else
     if (reg < 4) {
         tcg_gen_mov_i64(dest, cpu_sr[reg]);
+    } else if (ctx->tb_flags & TB_FLAG_SR_SAME) {
+        tcg_gen_mov_i64(dest, cpu_srH);
     } else {
         tcg_gen_ld_i64(dest, cpu_env, offsetof(CPUHPPAState, sr[reg]));
     }
@@ -1353,6 +1360,9 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
         load_spr(ctx, spc, sp);
         return spc;
     }
+    if (ctx->tb_flags & TB_FLAG_SR_SAME) {
+        return cpu_srH;
+    }
 
     ptr = tcg_temp_new_ptr();
     tmp = tcg_temp_new();
@@ -1396,7 +1406,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
 #else
     TCGv_tl addr = get_temp_tl(ctx);
     tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
-    if (ctx->base.tb->flags & PSW_W) {
+    if (ctx->tb_flags & PSW_W) {
         tcg_gen_andi_tl(addr, addr, 0x3fffffffffffffffull);
     }
     if (!is_phys) {
@@ -2103,6 +2113,7 @@ static DisasJumpType trans_mtsp(DisasContext *ctx, uint32_t insn,
 
     if (rs >= 4) {
         tcg_gen_st_i64(t64, cpu_env, offsetof(CPUHPPAState, sr[rs]));
+        ctx->tb_flags &= ~TB_FLAG_SR_SAME;
     } else {
         tcg_gen_mov_i64(cpu_sr[rs], t64);
     }
@@ -2394,7 +2405,7 @@ static DisasJumpType trans_ixtlbx(DisasContext *ctx, uint32_t insn,
 
     /* Exit TB for ITLB change if mmu is enabled.  This *should* not be
        the case, since the OS TLB fill handler runs with mmu disabled.  */
-    return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
+    return nullify_end(ctx, !is_data && (ctx->tb_flags & PSW_C)
                        ? DISAS_IAQ_N_STALE : DISAS_NEXT);
 }
 
@@ -2430,7 +2441,7 @@ static DisasJumpType trans_pxtlbx(DisasContext *ctx, uint32_t insn,
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
+    return nullify_end(ctx, !is_data && (ctx->tb_flags & PSW_C)
                        ? DISAS_IAQ_N_STALE : DISAS_NEXT);
 }
 
@@ -4546,15 +4557,14 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->mmu_idx = MMU_USER_IDX;
     ctx->iaoq_f = ctx->base.pc_first;
 #else
-    ctx->privilege = (ctx->base.tb->flags >> TB_FLAG_PRIV_SHIFT) & 3;
-    ctx->mmu_idx = (ctx->base.tb->flags & PSW_D
-                    ? ctx->privilege : MMU_PHYS_IDX);
+    ctx->tb_flags = ctx->base.tb->flags;
+    ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
+    ctx->mmu_idx = (ctx->tb_flags & PSW_D ? ctx->privilege : MMU_PHYS_IDX);
     /* Recover the IAOQ value from the GVA + PRIV.  */
     ctx->iaoq_f = (ctx->base.pc_first & ~ctx->base.tb->cs_base)
                 + ctx->privilege;
 #endif
-    ctx->iaoq_b = (ctx->base.tb->flags & TB_FLAG_NONSEQ
-                   ? -1 : ctx->iaoq_f + 4);
+    ctx->iaoq_b = (ctx->tb_flags & TB_FLAG_NONSEQ ? -1 : ctx->iaoq_f + 4);
 
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
@@ -4578,7 +4588,7 @@ static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
     /* Seed the nullification status from PSW[N], as saved in TB->FLAGS.  */
     ctx->null_cond = cond_make_f();
     ctx->psw_n_nonzero = false;
-    if (ctx->base.tb->flags & PSW_N) {
+    if (ctx->tb_flags & PSW_N) {
         ctx->null_cond.c = TCG_COND_ALWAYS;
         ctx->psw_n_nonzero = true;
     }
-- 
2.14.3
