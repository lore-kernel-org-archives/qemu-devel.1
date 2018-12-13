Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOi-0004eP-9J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOg-0007vD-HS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOg-00071P-3w
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOH-0007Nj-IW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:44 +0000
Message-Id: <20181213145445.17935-37-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/37] target/arm: Use arm_hcr_el2_eff more
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

From: Richard Henderson <richard.henderson@linaro.org>

Since arm_hcr_el2_eff includes a check against
arm_is_secure_below_el3, we can often remove a
nearby check against secure state.

In some cases, sort the call to arm_hcr_el2_eff
to the end of a short-circuit logical sequence.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181210150501.7990-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    | 12 +++++-------
 target/arm/op_helper.c | 14 ++++++--------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 95d59e07fb9..d6f8be9f4e1 100644
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
@@ -4566,8 +4566,7 @@ int sve_exception_el(CPUARMState *env, int el)
         if (disabled) {
             /* route_to_el2 */
             return (arm_feature(env, ARM_FEATURE_EL2)
-                    && !arm_is_secure(env)
-                    && (env->cp15.hcr_el2 & HCR_TGE) ? 2 : 1);
+                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
         }
 
         /* Check CPACR.FPEN.  */
@@ -6216,9 +6215,8 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
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
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 0d6e89e474a..ef72361a36d 100644
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
+    if (cur_el == 1 && (arm_hcr_el2_eff(env) & HCR_TSC)) {
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
2.19.2
