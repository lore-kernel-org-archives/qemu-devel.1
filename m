Received: from eggs.gnu.org ([2001:4830:134:3::10]:50613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD3-0002rn-7s
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD1-0004YQ-BK
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:01 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoD1-0004Y8-36
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:59 -0500
Received: by mail-pg0-x244.google.com with SMTP id o13so9956209pgp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:14 -0800
Message-Id: <20171229063145.29167-8-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/38] target/hppa: Implement the system mask
 instructions
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |   4 ++
 target/hppa/op_helper.c |  14 +++++++
 target/hppa/translate.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index c720de523b..254a4da133 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -76,3 +76,7 @@ DEF_HELPER_FLAGS_4(fmpyfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
 DEF_HELPER_FLAGS_4(fmpynfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
 DEF_HELPER_FLAGS_4(fmpyfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
+#endif
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 479bfc0fdf..1c3e043cc0 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -601,3 +601,17 @@ float64 HELPER(fmpynfadd_d)(CPUHPPAState *env, float64 a, float64 b, float64 c)
     update_fr0_op(env, GETPC());
     return ret;
 }
+
+#ifndef CONFIG_USER_ONLY
+target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
+{
+    target_ulong psw = env->psw;
+    /* ??? On second reading this condition simply seems
+       to be undefined rather than a diagnosed trap.  */
+    if (nsm & ~psw & PSW_Q) {
+        dynexcp(env, EXCP_ILL, GETPC());
+    }
+    env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
+    return psw & PSW_SM;
+}
+#endif
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7afd91b69d..6f165fdd3d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -295,6 +295,11 @@ typedef struct DisasContext {
    updated the iaq for the next instruction to be executed.  */
 #define DISAS_IAQ_N_STALE    DISAS_TARGET_1
 
+/* Similarly, but we want to return to the main loop immediately
+   to recognize unmasked interrupts.  */
+#define DISAS_IAQ_N_UPDATED_EXIT    DISAS_TARGET_2
+#define DISAS_IAQ_N_STALE_EXIT      DISAS_TARGET_3
+
 typedef struct DisasInsn {
     uint32_t insn, mask;
     DisasJumpType (*trans)(DisasContext *ctx, uint32_t insn,
@@ -693,6 +698,14 @@ static DisasJumpType gen_illegal(DisasContext *ctx)
     return nullify_end(ctx, gen_excp(ctx, EXCP_ILL));
 }
 
+#define CHECK_MOST_PRIVILEGED(EXCP)                               \
+    do {                                                          \
+        if (ctx->privilege != 0) {                                \
+            nullify_over(ctx);                                    \
+            return nullify_end(ctx, gen_excp(ctx, EXCP));         \
+        }                                                         \
+    } while (0)
+
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
@@ -1971,6 +1984,79 @@ static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
     return DISAS_NEXT;
 }
 
+#ifndef CONFIG_USER_ONLY
+/* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
+static target_ureg extract_sm_imm(uint32_t insn)
+{
+    target_ureg val = extract32(insn, 16, 10);
+
+    if (val & PSW_SM_E) {
+        val = (val & ~PSW_SM_E) | PSW_E;
+    }
+    if (val & PSW_SM_W) {
+        val = (val & ~PSW_SM_W) | PSW_W;
+    }
+    return val;
+}
+
+static DisasJumpType trans_rsm(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    target_ureg sm = extract_sm_imm(insn);
+    TCGv_reg tmp;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    tmp = get_temp(ctx);
+    tcg_gen_ld_reg(tmp, cpu_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_andi_reg(tmp, tmp, ~sm);
+    gen_helper_swap_system_mask(tmp, cpu_env, tmp);
+    save_gpr(ctx, rt, tmp);
+
+    /* Exit the TB to recognize new interrupts, e.g. PSW_M.  */
+    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+}
+
+static DisasJumpType trans_ssm(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    target_ureg sm = extract_sm_imm(insn);
+    TCGv_reg tmp;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    tmp = get_temp(ctx);
+    tcg_gen_ld_reg(tmp, cpu_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ori_reg(tmp, tmp, sm);
+    gen_helper_swap_system_mask(tmp, cpu_env, tmp);
+    save_gpr(ctx, rt, tmp);
+
+    /* Exit the TB to recognize new interrupts, e.g. PSW_I.  */
+    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+}
+
+static DisasJumpType trans_mtsm(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned rr = extract32(insn, 16, 5);
+    TCGv_reg tmp, reg;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    reg = load_gpr(ctx, rr);
+    tmp = get_temp(ctx);
+    gen_helper_swap_system_mask(tmp, cpu_env, reg);
+
+    /* Exit the TB to recognize new interrupts.  */
+    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+}
+#endif /* !CONFIG_USER_ONLY */
+
 static const DisasInsn table_system[] = {
     { 0x00000000u, 0xfc001fe0u, trans_break },
     /* We don't implement space register, so MTSP is a nop.  */
@@ -1982,6 +2068,11 @@ static const DisasInsn table_system[] = {
     { 0x000008a0u, 0xfc1fffe0u, trans_mfctl },
     { 0x00000400u, 0xffffffffu, trans_sync },
     { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
+#ifndef CONFIG_USER_ONLY
+    { 0x00000e60u, 0xfc00ffe0u, trans_rsm },
+    { 0x00000d60u, 0xfc00ffe0u, trans_ssm },
+    { 0x00001860u, 0xffe0ffffu, trans_mtsm },
+#endif
 };
 
 static DisasJumpType trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
@@ -4107,21 +4198,27 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    DisasJumpType is_jmp = ctx->base.is_jmp;
 
-    switch (ctx->base.is_jmp) {
+    switch (is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
+    case DISAS_IAQ_N_STALE_EXIT:
         copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
         copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
+    case DISAS_IAQ_N_UPDATED_EXIT:
         if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
-        } else {
+        } else if (is_jmp != DISAS_IAQ_N_UPDATED_EXIT
+                   && is_jmp != DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_lookup_and_goto_ptr();
+        } else {
+            tcg_gen_exit_tb(0);
         }
         break;
     default:
-- 
2.14.3
