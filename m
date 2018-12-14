Received: from eggs.gnu.org ([2001:4830:134:3::10]:55877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004ma-5v
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxo-0005Tx-5X
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxk-0005Rp-Hi
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:38 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so3631596oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:01 -0600
Message-Id: <20181214052410.11863-19-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/27] target/arm: Reuse aa64_va_parameters
 for setting tbflags
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

The arm_regime_tbi{0,1} functions are replacable with the new function
by giving the lowest and highest address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 35 --------------------------
 target/arm/helper.c | 61 ++++++++++++---------------------------------
 2 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3cc7a069ce..7c7dbc216c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3079,41 +3079,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
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
index 3422fa5943..bd1b683766 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8957,48 +8957,6 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
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
@@ -13048,9 +13006,22 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
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
+        {
+            ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
+            ARMVAParameters p0, p1;
+
+            p0 = aa64_va_parameters(env, 0, stage1, false);
+            p1 = aa64_va_parameters(env, -1, stage1, false);
+
+            flags |= p0.tbi << ARM_TBFLAG_TBI0_SHIFT;
+            flags |= p1.tbi << ARM_TBFLAG_TBI1_SHIFT;
+        }
+#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.17.2
