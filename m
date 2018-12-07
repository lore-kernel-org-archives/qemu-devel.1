Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVH-0008EA-4y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVG-0007sD-7A
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:03 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVG-0007qb-1T
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:02 -0500
Received: by mail-oi1-x241.google.com with SMTP id c206so3018048oib.0
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:22 -0600
Message-Id: <20181207103631.28193-18-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/26] target/arm: Reuse aa64_va_parameters for
 setting tbflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

The arm_regime_tbi{0,1} functions are replacable with the new function
by giving the lowest and highest address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 35 -----------------------------
 target/arm/helper.c | 55 +++++++++------------------------------------
 2 files changed, 10 insertions(+), 80 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6bac5c18d0..f7a0eace68 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3065,41 +3065,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
-/**
- * arm_regime_tbi0:
- * @env: CPUARMState
- * @mmu_idx: MMU index indicating required translation regime
- *
- * Extracts the TBI0 value from the appropriate TCR for the current EL
- *
- * Returns: the TBI0 value.
- */
-uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx);
-
-/**
- * arm_regime_tbi1:
- * @env: CPUARMState
- * @mmu_idx: MMU index indicating required translation regime
- *
- * Extracts the TBI1 value from the appropriate TCR for the current EL
- *
- * Returns: the TBI1 value.
- */
-uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx);
-#else
-/* We can't handle tagged addresses properly in user-only mode */
-static inline uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    return 0;
-}
-
-static inline uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    return 0;
-}
-#endif
-
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *flags);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 99ceed2cab..3ad5909b1e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8967,48 +8967,6 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
     return mmu_idx;
 }
 
-/* Returns TBI0 value for current regime el */
-uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    TCR *tcr;
-    uint32_t el;
-
-    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
-     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
-     */
-    mmu_idx = stage_1_mmu_idx(mmu_idx);
-
-    tcr = regime_tcr(env, mmu_idx);
-    el = regime_el(env, mmu_idx);
-
-    if (el > 1) {
-        return extract64(tcr->raw_tcr, 20, 1);
-    } else {
-        return extract64(tcr->raw_tcr, 37, 1);
-    }
-}
-
-/* Returns TBI1 value for current regime el */
-uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    TCR *tcr;
-    uint32_t el;
-
-    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
-     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
-     */
-    mmu_idx = stage_1_mmu_idx(mmu_idx);
-
-    tcr = regime_tcr(env, mmu_idx);
-    el = regime_el(env, mmu_idx);
-
-    if (el > 1) {
-        return 0;
-    } else {
-        return extract64(tcr->raw_tcr, 38, 1);
-    }
-}
-
 /* Return the TTBR associated with this translation regime */
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
@@ -13041,9 +12999,16 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
-        /* Get control bits for tagged addresses */
-        flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
-        flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+
+#ifndef CONFIG_USER_ONLY
+        /* Get control bits for tagged addresses.  Note that the
+         * translator only uses this for instruction addresses.
+         */
+        flags |= (aa64_va_parameters(env, 0, mmu_idx, false).tbi
+                  << ARM_TBFLAG_TBI0_SHIFT);
+        flags |= (aa64_va_parameters(env, -1, mmu_idx, false).tbi
+                  << ARM_TBFLAG_TBI1_SHIFT);
+#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.17.2
