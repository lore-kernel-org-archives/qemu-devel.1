Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSs-0000oj-IA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSr-0007Gv-FJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:22 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:47012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSr-0007GM-8d
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:21 -0400
Received: by mail-pl0-x242.google.com with SMTP id t17-v6so1967497ply.13
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:54 -0700
Message-Id: <20180809042206.15726-9-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/20] target/arm: Pass in current_el to fp and
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

We are going to want to determine whether sve is enabled
for EL than current.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 26e9098c5f..290b1a849e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4344,12 +4344,10 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
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
@@ -4360,7 +4358,7 @@ static int sve_exception_el(CPUARMState *env)
         if (!extract32(env->cp15.cpacr_el1, 16, 1)) {
             disabled = true;
         } else if (!extract32(env->cp15.cpacr_el1, 17, 1)) {
-            disabled = current_el == 0;
+            disabled = el == 0;
         }
         if (disabled) {
             /* route_to_el2 */
@@ -4373,7 +4371,7 @@ static int sve_exception_el(CPUARMState *env)
         if (!extract32(env->cp15.cpacr_el1, 20, 1)) {
             disabled = true;
         } else if (!extract32(env->cp15.cpacr_el1, 21, 1)) {
-            disabled = current_el == 0;
+            disabled = el == 0;
         }
         if (disabled) {
             return 0;
@@ -4383,7 +4381,7 @@ static int sve_exception_el(CPUARMState *env)
     /* CPTR_EL2.  Since TZ and TFP are positive,
      * they will be zero when EL2 is not present.
      */
-    if (current_el <= 2 && !arm_is_secure_below_el3(env)) {
+    if (el <= 2 && !arm_is_secure_below_el3(env)) {
         if (env->cp15.cptr_el[2] & CPTR_TZ) {
             return 2;
         }
@@ -12318,11 +12316,10 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
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
@@ -12385,11 +12382,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
-    int fp_el = fp_exception_el(env);
+    int current_el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, current_el);
     uint32_t flags;
 
     if (is_a64(env)) {
-        int sve_el = sve_exception_el(env);
+        int sve_el = sve_exception_el(env, current_el);
         uint32_t zcr_len;
 
         *pc = env->pc;
@@ -12404,7 +12402,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (sve_el != 0 && fp_el == 0) {
             zcr_len = 0;
         } else {
-            int current_el = arm_current_el(env);
             ARMCPU *cpu = arm_env_get_cpu(env);
 
             zcr_len = cpu->sve_max_vq - 1;
-- 
2.17.1
