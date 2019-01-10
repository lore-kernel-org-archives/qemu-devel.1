Received: from eggs.gnu.org ([209.51.188.92]:37349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZmh-0003Q4-ST
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZmh-0007Bs-1z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:07 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZmg-00079z-Sc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:06 -0500
Received: by mail-pf1-x444.google.com with SMTP id b7so5263526pfi.8
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:50:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:49:50 +1100
Message-Id: <20190110124951.15473-4-richard.henderson@linaro.org>
In-Reply-To: <20190110124951.15473-1-richard.henderson@linaro.org>
References: <20190110124951.15473-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/arm: Compute TB_FLAGS for TBI for
 user-only
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
index 8c28c6d044..0ceb1fa2b8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6549,7 +6549,7 @@ uint32_t HELPER(rbit)(uint32_t x)
     return revbit32(x);
 }
 
-#if defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_USER_ONLY
 
 /* These should probably raise undefined insn exceptions.  */
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
@@ -8923,6 +8923,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
         cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
     }
 }
+#endif /* !CONFIG_USER_ONLY */
 
 /* Return the exception level which controls this address translation regime */
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
@@ -9084,6 +9085,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 /* Translate section/page access permissions to page
  * R/W protection flags
  *
@@ -9771,6 +9773,7 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
@@ -9841,6 +9844,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
@@ -13087,11 +13091,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
@@ -13110,7 +13110,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
             flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
         }
-#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.17.2
