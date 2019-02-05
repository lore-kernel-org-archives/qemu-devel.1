Received: from eggs.gnu.org ([209.51.188.92]:36137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AX-0001y4-JY
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AT-0000cQ-6p
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000Qz-MS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id s12so4473393wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:02 +0000
Message-Id: <20190205170510.21984-15-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/22] target/arm: Compute TB_FLAGS for TBI for
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

Enables, but does not turn on, TBI for CONFIG_USER_ONLY.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190204132126.3255-4-richard.henderson@linaro.org
[PMM: adjusted #ifdeffery to placate clang, which otherwise complains
about static functions that are unused in the CONFIG_USER_ONLY build]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 21 --------------------
 target/arm/helper.c    | 45 ++++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d01a3f9f44b..a4bd1becb75 100644
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
index 25d8ec38f8e..aaf5b0cd7ab 100644
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
@@ -9600,6 +9601,8 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
@@ -9655,6 +9658,22 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
     return (regime_sctlr(env, mmu_idx) & SCTLR_EE) != 0;
 }
 
+/* Return the TTBR associated with this translation regime */
+static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
+                                   int ttbrn)
+{
+    if (mmu_idx == ARMMMUIdx_S2NS) {
+        return env->cp15.vttbr_el2;
+    }
+    if (ttbrn == 0) {
+        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
+    } else {
+        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
+    }
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
@@ -9675,20 +9694,6 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
     return mmu_idx;
 }
 
-/* Return the TTBR associated with this translation regime */
-static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
-                                   int ttbrn)
-{
-    if (mmu_idx == ARMMMUIdx_S2NS) {
-        return env->cp15.vttbr_el2;
-    }
-    if (ttbrn == 0) {
-        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
-    } else {
-        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
-    }
-}
-
 /* Return true if the translation regime is using LPAE format page tables */
 static inline bool regime_using_lpae_format(CPUARMState *env,
                                             ARMMMUIdx mmu_idx)
@@ -9714,6 +9719,7 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }
 
+#ifndef CONFIG_USER_ONLY
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
@@ -10419,6 +10425,7 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
@@ -10490,6 +10497,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
@@ -13746,11 +13754,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
@@ -13769,7 +13773,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
             flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
         }
-#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.20.1
