Received: from eggs.gnu.org ([209.51.188.92]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfc-0005BH-Qs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfa-0001Yo-Qg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfY-0001UY-OM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h4so26944892wre.7
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:43 +0100
Message-Id: <20190416125744.27770-26-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/26] target/arm: Implement VLLDM for v7M CPUs
 with an FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Implement the VLLDM instruction for v7M for the FPU present cas.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c |  2 +-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 62051ae6d51..50cb036378b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -72,6 +72,7 @@ DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
 DEF_HELPER_1(v7m_preserve_fp_state, void, env)
 
 DEF_HELPER_2(v7m_vlstm, void, env, i32)
+DEF_HELPER_2(v7m_vlldm, void, env, i32)
 
 DEF_HELPER_2(v8m_stackcheck, void, env, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ad049b2d9bc..4b680c379dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7395,6 +7395,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /* The TT instructions can be used by unprivileged code, but in
@@ -8479,6 +8485,54 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
 }
 
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    /* fptr is the value of Rn, the frame pointer we load the FP regs from */
+    assert(env->v7m.secure);
+
+    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)) {
+        return;
+    }
+
+    /* Check access to the coprocessor is permitted */
+    if (!v7m_cpacr_pass(env, true, arm_current_el(env) != 0)) {
+        raise_exception_ra(env, EXCP_NOCP, 0, 1, GETPC());
+    }
+
+    if (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK) {
+        /* State in FP is still valid */
+        env->v7m.fpccr[M_REG_S] &= ~R_V7M_FPCCR_LSPACT_MASK;
+    } else {
+        bool ts = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK;
+        int i;
+        uint32_t fpscr;
+
+        if (fptr & 7) {
+            raise_exception_ra(env, EXCP_UNALIGNED, 0, 1, GETPC());
+        }
+
+        for (i = 0; i < (ts ? 32 : 16); i += 2) {
+            uint32_t slo, shi;
+            uint64_t dn;
+            uint32_t faddr = fptr + 4 * i;
+
+            if (i >= 16) {
+                faddr += 8; /* skip the slot for the FPSCR */
+            }
+
+            slo = cpu_ldl_data(env, faddr);
+            shi = cpu_ldl_data(env, faddr + 4);
+
+            dn = (uint64_t) shi << 32 | slo;
+            *aa32_vfp_dreg(env, i / 2) = dn;
+        }
+        fpscr = cpu_ldl_data(env, fptr + 0x40);
+        vfp_set_fpscr(env, fpscr);
+    }
+
+    env->v7m.control[M_REG_S] |= R_V7M_CONTROL_FPCA_MASK;
+}
+
 static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index db478b779a9..5ad9923715e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11822,7 +11822,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
-                        /* VLLDM */
+                        gen_helper_v7m_vlldm(cpu_env, fptr);
                     } else {
                         gen_helper_v7m_vlstm(cpu_env, fptr);
                     }
-- 
2.20.1
