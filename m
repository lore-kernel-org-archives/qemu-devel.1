Received: from eggs.gnu.org ([2001:4830:134:3::10]:46818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6Y-0001v7-5U
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6U-0007sf-Bn
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W6T-0006uy-R4
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W51-0003fT-Dl
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:38 +0100
Message-Id: <20181008140004.12612-8-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/33] target/arm: Pass in current_el to fp and
 sve_exception_el
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

We are going to want to determine whether sve is enabled
for EL other than current.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9bb81da2c7f..35458ad4a76 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4406,12 +4406,10 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
  * take care of raising that exception.
  * C.f. the ARM pseudocode function CheckSVEEnabled.
  */
-static int sve_exception_el(CPUARMState *env)
+static int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    unsigned current_el = arm_current_el(env);
-
-    if (current_el <= 1) {
+    if (el <= 1) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -4422,7 +4420,7 @@ static int sve_exception_el(CPUARMState *env)
         if (!extract32(env->cp15.cpacr_el1, 16, 1)) {
             disabled = true;
         } else if (!extract32(env->cp15.cpacr_el1, 17, 1)) {
-            disabled = current_el == 0;
+            disabled = el == 0;
         }
         if (disabled) {
             /* route_to_el2 */
@@ -4435,7 +4433,7 @@ static int sve_exception_el(CPUARMState *env)
         if (!extract32(env->cp15.cpacr_el1, 20, 1)) {
             disabled = true;
         } else if (!extract32(env->cp15.cpacr_el1, 21, 1)) {
-            disabled = current_el == 0;
+            disabled = el == 0;
         }
         if (disabled) {
             return 0;
@@ -4445,7 +4443,7 @@ static int sve_exception_el(CPUARMState *env)
     /* CPTR_EL2.  Since TZ and TFP are positive,
      * they will be zero when EL2 is not present.
      */
-    if (current_el <= 2 && !arm_is_secure_below_el3(env)) {
+    if (el <= 2 && !arm_is_secure_below_el3(env)) {
         if (env->cp15.cptr_el[2] & CPTR_TZ) {
             return 2;
         }
@@ -12512,11 +12510,10 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 /* Return the exception level to which FP-disabled exceptions should
  * be taken, or 0 if FP is enabled.
  */
-static inline int fp_exception_el(CPUARMState *env)
+static int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
     int fpen;
-    int cur_el = arm_current_el(env);
 
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
@@ -12579,7 +12576,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
-    int fp_el = fp_exception_el(env);
+    int current_el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, current_el);
     uint32_t flags;
 
     if (is_a64(env)) {
@@ -12590,7 +12588,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
 
         if (arm_feature(env, ARM_FEATURE_SVE)) {
-            int sve_el = sve_exception_el(env);
+            int sve_el = sve_exception_el(env, current_el);
             uint32_t zcr_len;
 
             /* If SVE is disabled, but FP is enabled,
@@ -12599,7 +12597,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             if (sve_el != 0 && fp_el == 0) {
                 zcr_len = 0;
             } else {
-                int current_el = arm_current_el(env);
                 ARMCPU *cpu = arm_env_get_cpu(env);
 
                 zcr_len = cpu->sve_max_vq - 1;
-- 
2.19.0
