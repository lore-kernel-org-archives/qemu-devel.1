Received: from eggs.gnu.org ([209.51.188.92]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNs-00052I-FG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNr-0004Kl-7I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:08 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLNq-0004JB-VT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:07 -0500
Received: by mail-pl1-x644.google.com with SMTP id p4so320722plq.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:33 -0800
Message-Id: <20190211235258.542-4-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/28] target/arm: Add clear_pstate_bits,
 share gen_ss_advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

We do not need an out-of-line helper for clearing bits in pstate.
While changing things, share the implementation of gen_ss_advance.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 --
 target/arm/translate.h     | 19 +++++++++++++++++++
 target/arm/op_helper.c     |  5 -----
 target/arm/translate-a64.c | 11 -----------
 target/arm/translate.c     | 11 -----------
 5 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 28b1dd6252..c21fa2edfe 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -77,8 +77,6 @@ DEF_HELPER_2(get_cp_reg, i32, env, ptr)
 DEF_HELPER_3(set_cp_reg64, void, env, ptr, i64)
 DEF_HELPER_2(get_cp_reg64, i64, env, ptr)
 
-DEF_HELPER_1(clear_pstate_ss, void, env)
-
 DEF_HELPER_2(get_r13_banked, i32, env, i32)
 DEF_HELPER_3(set_r13_banked, void, env, i32, i32)
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 17748ddfb9..33af50a13f 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -202,6 +202,25 @@ static inline TCGv_i32 get_ahp_flag(void)
     return ret;
 }
 
+/* Clear bits within PSTATE.  */
+static inline void clear_pstate_bits(uint32_t bits)
+{
+    TCGv_i32 p = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_gen_andi_i32(p, p, ~bits);
+    tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_temp_free_i32(p);
+}
+
+/* If the singlestep state is Active-not-pending, advance to Active-pending. */
+static inline void gen_ss_advance(DisasContext *s)
+{
+    if (s->ss_active) {
+        s->pstate_ss = 0;
+        clear_pstate_bits(PSTATE_SS);
+    }
+}
 
 /* Vector operations shared between ARM and AArch64.  */
 extern const GVecGen3 bsl_op;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c5721a866d..8698b4dc83 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -861,11 +861,6 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
     return res;
 }
 
-void HELPER(clear_pstate_ss)(CPUARMState *env)
-{
-    env->pstate &= ~PSTATE_SS;
-}
-
 void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 13e010d27b..ba139bba26 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -421,17 +421,6 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_ss_advance(DisasContext *s)
-{
-    /* If the singlestep state is Active-not-pending, advance to
-     * Active-pending.
-     */
-    if (s->ss_active) {
-        s->pstate_ss = 0;
-        gen_helper_clear_pstate_ss(cpu_env);
-    }
-}
-
 static void gen_step_complete_exception(DisasContext *s)
 {
     /* We just completed step of an insn. Move from Active-not-pending
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66cf28c8cb..baf6068ec1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -298,17 +298,6 @@ static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
     tcg_temp_free_i32(tcg_excp);
 }
 
-static void gen_ss_advance(DisasContext *s)
-{
-    /* If the singlestep state is Active-not-pending, advance to
-     * Active-pending.
-     */
-    if (s->ss_active) {
-        s->pstate_ss = 0;
-        gen_helper_clear_pstate_ss(cpu_env);
-    }
-}
-
 static void gen_step_complete_exception(DisasContext *s)
 {
     /* We just completed step of an insn. Move from Active-not-pending
-- 
2.17.2
