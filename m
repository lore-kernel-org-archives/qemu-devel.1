Received: from eggs.gnu.org ([209.51.188.92]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBz-00010z-J1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBy-0006Ul-0N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqeBx-0006SC-OP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so10069868wmh.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:21:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:21:25 +0000
Message-Id: <20190204132126.3255-4-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-1-richard.henderson@linaro.org>
References: <20190204132126.3255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/4] target/arm: Compute TB_FLAGS for TBI
 for user-only
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

Enables, but does not turn on, TBI for CONFIG_USER_ONLY.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 21 ---------------------
 target/arm/helper.c    | 13 ++++++-------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d01a3f9f44..a4bd1becb7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -963,30 +963,9 @@ typedef struct ARMVAParameters {
     bool using64k   : 1;
 } ARMVAParameters;
 
-#ifdef CONFIG_USER_ONLY
-static inline ARMVAParameters aa64_va_parameters_both(CPUARMState *env,
-                                                      uint64_t va,
-                                                      ARMMMUIdx mmu_idx)
-{
-    return (ARMVAParameters) {
-        /* 48-bit address space */
-        .tsz = 16,
-        /* We can't handle tagged addresses properly in user-only mode */
-        .tbi = false,
-    };
-}
-
-static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
-                                                 uint64_t va,
-                                                 ARMMMUIdx mmu_idx, bool data)
-{
-    return aa64_va_parameters_both(env, va, mmu_idx);
-}
-#else
 ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx);
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
-#endif
 
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 25d8ec38f8..222253a3a3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7197,7 +7197,7 @@ uint32_t HELPER(rbit)(uint32_t x)
     return revbit32(x);
 }
 
-#if defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_USER_ONLY
 
 /* These should probably raise undefined insn exceptions.  */
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
@@ -9571,6 +9571,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
         cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
     }
 }
+#endif /* !CONFIG_USER_ONLY */
 
 /* Return the exception level which controls this address translation regime */
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
@@ -9732,6 +9733,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 /* Translate section/page access permissions to page
  * R/W protection flags
  *
@@ -10419,6 +10421,7 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
@@ -10490,6 +10493,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
@@ -13746,11 +13750,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
-#ifndef CONFIG_USER_ONLY
-        /*
-         * Get control bits for tagged addresses.  Note that the
-         * translator only uses this for instruction addresses.
-         */
+        /* Get control bits for tagged addresses.  */
         {
             ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
@@ -13769,7 +13769,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
             flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
         }
-#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.17.2
