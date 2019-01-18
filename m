Received: from eggs.gnu.org ([209.51.188.92]:43114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbY-0002oZ-Cs
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0007Py-VV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbT-0007NP-JB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id x10so15384138wrs.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:43 +0000
Message-Id: <20190118145805.6852-28-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/49] target/arm: Reuse aa64_va_parameters for
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

From: Richard Henderson <richard.henderson@linaro.org>

The arm_regime_tbi{0,1} functions are replacable with the new function
by giving the lowest and highest address.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 35 -----------------------
 target/arm/helper.c | 70 ++++++++++++++++-----------------------------
 2 files changed, 24 insertions(+), 81 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ea9b8ec4a1e..8512ca35528 100644
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
index d9b580e3316..a62ce2a76e6 100644
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
@@ -13054,10 +13012,30 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
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
2.20.1
