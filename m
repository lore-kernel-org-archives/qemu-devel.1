Received: from eggs.gnu.org ([209.51.188.92]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r2-3K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9en-0006jp-Pz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9el-0006ZN-7e
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id h11so154899wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.07
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:16 +0100
Message-Id: <20190429170030.11323-29-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/42] target/arm: Implement VLLDM for v7M CPUs
 with an FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the VLLDM instruction for v7M for the FPU present cas.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-26-peter.maydell@linaro.org
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
index b821037c3b6..81a92ab4911 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7390,6 +7390,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
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
@@ -8474,6 +8480,54 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
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
index 99b38dd5f2b..10bc53f91c6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11823,7 +11823,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
-                        /* VLLDM */
+                        gen_helper_v7m_vlldm(cpu_env, fptr);
                     } else {
                         gen_helper_v7m_vlstm(cpu_env, fptr);
                     }
-- 
2.20.1
