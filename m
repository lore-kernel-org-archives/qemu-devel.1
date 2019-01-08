Received: from eggs.gnu.org ([209.51.188.92]:52910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvK-0000UT-DE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvJ-00053Y-F8
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:38 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvJ-00052m-8M
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:37 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so2564207plb.5
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:21 +1000
Message-Id: <20190108223129.5570-24-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 23/31] target/arm: Reuse aa64_va_parameters
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use aa64_va_parameters_both and compute both tbii and tbid.
    Merged back from a later patch set.
---
 target/arm/cpu.h    | 35 -----------------------
 target/arm/helper.c | 70 ++++++++++++++++-----------------------------
 2 files changed, 24 insertions(+), 81 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ea9b8ec4a1..8512ca3552 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3015,41 +3015,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
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
index cc3c0d47c8..e610155166 100644
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
@@ -13051,10 +13009,30 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
-        /* Get control bits for tagged addresses */
-        flags = FIELD_DP32(flags, TBFLAG_A64, TBII,
-                           (arm_regime_tbi1(env, mmu_idx) << 1) |
-                           arm_regime_tbi0(env, mmu_idx));
+
+#ifndef CONFIG_USER_ONLY
+        /*
+         * Get control bits for tagged addresses.  Note that the
+         * translator only uses this for instruction addresses.
+         */
+        {
+            ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
+            ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+            int tbii, tbid;
+
+            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+            if (regime_el(env, stage1) < 2) {
+                ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
+                tbid = (p1.tbi << 1) | p0.tbi;
+                tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
+            } else {
+                tbid = p0.tbi;
+                tbii = tbid & !p0.tbid;
+            }
+
+            flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
+        }
+#endif
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
-- 
2.17.2
