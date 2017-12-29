Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD7-0002wP-Md
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD6-0004aP-Iu
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:05 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoD6-0004Zn-8X
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:04 -0500
Received: by mail-pf0-x244.google.com with SMTP id u19so21809156pfa.12
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:18 -0800
Message-Id: <20171229063145.29167-12-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/38] target/hppa: Implement rfi
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
 target/hppa/cpu.h       |  1 +
 target/hppa/helper.h    |  2 ++
 target/hppa/op_helper.c | 24 ++++++++++++++++++++++++
 target/hppa/translate.c | 31 +++++++++++++++++++++++++++++--
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c92c564a7f..6ec3430ae3 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -178,6 +178,7 @@ struct CPUHPPAState {
 
     target_ureg cr[32];      /* control registers */
     target_ureg cr_back[2];  /* back of cr17/cr18 */
+    target_ureg shadow[7];   /* shadow registers */
 
     /* Those resources are used only in QEMU core */
     CPU_COMMON
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 254a4da133..79d22ae486 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -78,5 +78,7 @@ DEF_HELPER_FLAGS_4(fmpyfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(rfi, void, env)
+DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
 #endif
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 1c3e043cc0..3f5dcbbca0 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -614,4 +614,28 @@ target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
     return psw & PSW_SM;
 }
+
+void HELPER(rfi)(CPUHPPAState *env)
+{
+    /* ??? On second reading this condition simply seems
+       to be undefined rather than a diagnosed trap.  */
+    if (env->psw & (PSW_I | PSW_R | PSW_Q)) {
+        helper_excp(env, EXCP_ILL);
+    }
+    env->iaoq_f = env->cr[CR_IIAOQ];
+    env->iaoq_b = env->cr_back[1];
+    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
+}
+
+void HELPER(rfi_r)(CPUHPPAState *env)
+{
+    env->gr[1] = env->shadow[0];
+    env->gr[8] = env->shadow[1];
+    env->gr[9] = env->shadow[2];
+    env->gr[16] = env->shadow[3];
+    env->gr[17] = env->shadow[4];
+    env->gr[24] = env->shadow[5];
+    env->gr[25] = env->shadow[6];
+    helper_rfi(env);
+}
 #endif
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2a61b6bc8d..8078d3cd46 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -652,6 +652,11 @@ static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
 {
     TCGLabel *null_lab = ctx->null_lab;
 
+    /* For NEXT, NORETURN, STALE, we can easily continue (or exit).
+       For UPDATED, we cannot update on the nullified path.  */
+    assert(status != DISAS_IAQ_N_UPDATED &&
+           status != DISAS_IAQ_N_UPDATED_EXIT);
+
     if (likely(null_lab == NULL)) {
         /* The current insn wasn't conditional or handled the condition
            applied to it without a branch, so the (new) setting of
@@ -673,8 +678,6 @@ static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
         gen_set_label(null_lab);
         ctx->null_cond = cond_make_n();
     }
-
-    assert(status != DISAS_NORETURN && status != DISAS_IAQ_N_UPDATED);
     if (status == DISAS_NORETURN) {
         status = DISAS_NEXT;
     }
@@ -2143,6 +2146,29 @@ static DisasJumpType trans_mtsm(DisasContext *ctx, uint32_t insn,
     /* Exit the TB to recognize new interrupts.  */
     return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
 }
+
+static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned comp = extract32(insn, 5, 4);
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    if (comp == 5) {
+        gen_helper_rfi_r(cpu_env);
+    } else {
+        gen_helper_rfi(cpu_env);
+    }
+    if (ctx->base.singlestep_enabled) {
+        gen_excp_1(EXCP_DEBUG);
+    } else {
+        tcg_gen_exit_tb(0);
+    }
+
+    /* Exit the TB to recognize new interrupts.  */
+    return nullify_end(ctx, DISAS_NORETURN);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
@@ -2159,6 +2185,7 @@ static const DisasInsn table_system[] = {
     { 0x00000e60u, 0xfc00ffe0u, trans_rsm },
     { 0x00000d60u, 0xfc00ffe0u, trans_ssm },
     { 0x00001860u, 0xffe0ffffu, trans_mtsm },
+    { 0x00000c00u, 0xfffffe1fu, trans_rfi },
 #endif
 };
 
-- 
2.14.3
