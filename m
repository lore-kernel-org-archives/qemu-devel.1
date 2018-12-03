Received: from eggs.gnu.org ([2001:4830:134:3::10]:42367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzX-00063N-2p
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzV-0005mn-OJ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:55 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzV-0005lT-Fg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so12988772otk.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:35 -0600
Message-Id: <20181203203839.757-7-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/10] target/arm: Use arm_hcr_el2_eff more
 places
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

Since arm_hcr_el2_eff includes a check against
arm_is_secure_below_el3, we can often remove a
nearby check against secure state.

In some cases, sort the call to arm_hcr_el2_eff
to the end of a short-circuit logical sequence.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c    | 22 ++++++++++++----------
 target/arm/op_helper.c | 14 ++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5874c5a73f..b248dfcd39 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -448,7 +448,7 @@ static CPAccessResult access_tdosa(CPUARMState *env, const ARMCPRegInfo *ri,
     int el = arm_current_el(env);
     bool mdcr_el2_tdosa = (env->cp15.mdcr_el2 & MDCR_TDOSA) ||
         (env->cp15.mdcr_el2 & MDCR_TDE) ||
-        (env->cp15.hcr_el2 & HCR_TGE);
+        (arm_hcr_el2_eff(env) & HCR_TGE);
 
     if (el < 2 && mdcr_el2_tdosa && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
@@ -468,7 +468,7 @@ static CPAccessResult access_tdra(CPUARMState *env, const ARMCPRegInfo *ri,
     int el = arm_current_el(env);
     bool mdcr_el2_tdra = (env->cp15.mdcr_el2 & MDCR_TDRA) ||
         (env->cp15.mdcr_el2 & MDCR_TDE) ||
-        (env->cp15.hcr_el2 & HCR_TGE);
+        (arm_hcr_el2_eff(env) & HCR_TGE);
 
     if (el < 2 && mdcr_el2_tdra && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
@@ -488,7 +488,7 @@ static CPAccessResult access_tda(CPUARMState *env, const ARMCPRegInfo *ri,
     int el = arm_current_el(env);
     bool mdcr_el2_tda = (env->cp15.mdcr_el2 & MDCR_TDA) ||
         (env->cp15.mdcr_el2 & MDCR_TDE) ||
-        (env->cp15.hcr_el2 & HCR_TGE);
+        (arm_hcr_el2_eff(env) & HCR_TGE);
 
     if (el < 2 && mdcr_el2_tda && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
@@ -4548,8 +4548,7 @@ int sve_exception_el(CPUARMState *env, int el)
         if (disabled) {
             /* route_to_el2 */
             return (arm_feature(env, ARM_FEATURE_EL2)
-                    && !arm_is_secure(env)
-                    && (env->cp15.hcr_el2 & HCR_TGE) ? 2 : 1);
+                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
         }
 
         /* Check CPACR.FPEN.  */
@@ -6194,9 +6193,8 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
          * and CPS are treated as illegal mode changes.
          */
         if (write_type == CPSRWriteByInstr &&
-            (env->cp15.hcr_el2 & HCR_TGE) &&
             (env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_MON &&
-            !arm_is_secure_below_el3(env)) {
+            (arm_hcr_el2_eff(env) & HCR_TGE)) {
             return 1;
         }
         return 0;
@@ -8797,6 +8795,8 @@ static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
 {
+    uint64_t hcr_el2;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         switch (env->v7m.mpu_ctrl[regime_is_secure(env, mmu_idx)] &
                 (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
@@ -8815,19 +8815,21 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
+    hcr_el2 = arm_hcr_el2_eff(env);
+
     if (mmu_idx == ARMMMUIdx_S2NS) {
         /* HCR.DC means HCR.VM behaves as 1 */
-        return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
+        return (hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
 
-    if (env->cp15.hcr_el2 & HCR_TGE) {
+    if (hcr_el2 & HCR_TGE) {
         /* TGE means that NS EL0/1 act as if SCTLR_EL1.M is zero */
         if (!regime_is_secure(env, mmu_idx) && regime_el(env, mmu_idx) == 1) {
             return true;
         }
     }
 
-    if ((env->cp15.hcr_el2 & HCR_DC) &&
+    if ((hcr_el2 & HCR_DC) &&
         (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 0d6e89e474..780caf387b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -33,8 +33,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
 
-    if ((env->cp15.hcr_el2 & HCR_TGE) &&
-        target_el == 1 && !arm_is_secure(env)) {
+    if (target_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         /*
          * Redirect NS EL1 exceptions to NS EL2. These are reported with
          * their original syndrome register value, with the exception of
@@ -428,9 +427,9 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
      * No need for ARM_FEATURE check as if HCR_EL2 doesn't exist the
      * bits will be zero indicating no trap.
      */
-    if (cur_el < 2 && !arm_is_secure(env)) {
-        mask = (is_wfe) ? HCR_TWE : HCR_TWI;
-        if (env->cp15.hcr_el2 & mask) {
+    if (cur_el < 2) {
+        mask = is_wfe ? HCR_TWE : HCR_TWI;
+        if (arm_hcr_el2_eff(env) & mask) {
             return 2;
         }
     }
@@ -995,7 +994,7 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
                         exception_target_el(env));
     }
 
-    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
+    if (!secure && cur_el == 1 && (arm_hcr_el2_eff(env) & HCR_TSC)) {
         /* In NS EL1, HCR controlled routing to EL2 has priority over SMD.
          * We also want an EL2 guest to be able to forbid its EL1 from
          * making PSCI calls into QEMU's "firmware" via HCR.TSC.
@@ -1098,8 +1097,7 @@ void HELPER(exception_return)(CPUARMState *env)
         goto illegal_return;
     }
 
-    if (new_el == 1 && (env->cp15.hcr_el2 & HCR_TGE)
-        && !arm_is_secure_below_el3(env)) {
+    if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         goto illegal_return;
     }
 
-- 
2.17.2
