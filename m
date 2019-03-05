Received: from eggs.gnu.org ([209.51.188.92]:54531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHU-0001Zy-3Y
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHT-0000nK-2Q
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHS-0000lw-Qg
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id w17so10240582wrn.12
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:35 +0000
Message-Id: <20190305165051.26860-7-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/22] target/arm: Add set/clear_pstate_bits,
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

From: Richard Henderson <richard.henderson@linaro.org>

We do not need an out-of-line helper for manipulating bits in pstate.
While changing things, share the implementation of gen_ss_advance.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  2 --
 target/arm/translate.h     | 34 ++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c     |  5 -----
 target/arm/translate-a64.c | 11 -----------
 target/arm/translate.c     | 11 -----------
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6f0f3869262..583adba9b04 100644
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
index f25fe756859..912cc2a4a52 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -202,6 +202,40 @@ static inline TCGv_i32 get_ahp_flag(void)
     return ret;
 }
 
+/* Set bits within PSTATE.  */
+static inline void set_pstate_bits(uint32_t bits)
+{
+    TCGv_i32 p = tcg_temp_new_i32();
+
+    tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
+
+    tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_gen_ori_i32(p, p, bits);
+    tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_temp_free_i32(p);
+}
+
+/* Clear bits within PSTATE.  */
+static inline void clear_pstate_bits(uint32_t bits)
+{
+    TCGv_i32 p = tcg_temp_new_i32();
+
+    tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
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
index c5721a866d3..8698b4dc83e 100644
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
index 1e49d333655..eaeb43577df 100644
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
index 9f71206f857..d408e4d7ef4 100644
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
2.20.1
