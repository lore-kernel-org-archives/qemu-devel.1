Received: from eggs.gnu.org ([2001:4830:134:3::10]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr2-0000zu-CH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqw-0007dC-VP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqw-0007bf-ML
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqv-0001dG-9E
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:13 +0100
Message-Id: <1504790904-17018-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/31] target/arm: Make MPU_RBAR,
 MPU_RLAR banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the MPU registers MPU_MAIR0 and MPU_MAIR1 banked if v8M security
extensions are enabled.

We can freely add more items to vmstate_m_security without
breaking migration compatibility, because no CPU currently
has the ARM_FEATURE_M_SECURITY bit enabled and so this
subsection is not yet used by anything.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-14-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  4 ++--
 hw/intc/armv7m_nvic.c |  8 ++++----
 target/arm/cpu.c      | 26 ++++++++++++++++++++------
 target/arm/helper.c   | 11 ++++++-----
 target/arm/machine.c  | 12 ++++++++----
 5 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 42a6cb2..d385ef2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -543,8 +543,8 @@ typedef struct CPUARMState {
          *  pmsav7.rnr (region number register)
          *  pmsav7_dregion (number of configured regions)
          */
-        uint32_t *rbar;
-        uint32_t *rlar;
+        uint32_t *rbar[2];
+        uint32_t *rlar[2];
         uint32_t mair0[2];
         uint32_t mair1[2];
     } pmsav8;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index e98eb95..9ced7af 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -564,7 +564,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             if (region >= cpu->pmsav7_dregion) {
                 return 0;
             }
-            return cpu->env.pmsav8.rbar[region];
+            return cpu->env.pmsav8.rbar[attrs.secure][region];
         }
 
         if (region >= cpu->pmsav7_dregion) {
@@ -591,7 +591,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             if (region >= cpu->pmsav7_dregion) {
                 return 0;
             }
-            return cpu->env.pmsav8.rlar[region];
+            return cpu->env.pmsav8.rlar[attrs.secure][region];
         }
 
         if (region >= cpu->pmsav7_dregion) {
@@ -756,7 +756,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             if (region >= cpu->pmsav7_dregion) {
                 return;
             }
-            cpu->env.pmsav8.rbar[region] = value;
+            cpu->env.pmsav8.rbar[attrs.secure][region] = value;
             tlb_flush(CPU(cpu));
             return;
         }
@@ -806,7 +806,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             if (region >= cpu->pmsav7_dregion) {
                 return;
             }
-            cpu->env.pmsav8.rlar[region] = value;
+            cpu->env.pmsav8.rlar[attrs.secure][region] = value;
             tlb_flush(CPU(cpu));
             return;
         }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7b4acc0..40ec445 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -235,10 +235,20 @@ static void arm_cpu_reset(CPUState *s)
     if (arm_feature(env, ARM_FEATURE_PMSA)) {
         if (cpu->pmsav7_dregion > 0) {
             if (arm_feature(env, ARM_FEATURE_V8)) {
-                memset(env->pmsav8.rbar, 0,
-                       sizeof(*env->pmsav8.rbar) * cpu->pmsav7_dregion);
-                memset(env->pmsav8.rlar, 0,
-                       sizeof(*env->pmsav8.rlar) * cpu->pmsav7_dregion);
+                memset(env->pmsav8.rbar[M_REG_NS], 0,
+                       sizeof(*env->pmsav8.rbar[M_REG_NS])
+                       * cpu->pmsav7_dregion);
+                memset(env->pmsav8.rlar[M_REG_NS], 0,
+                       sizeof(*env->pmsav8.rlar[M_REG_NS])
+                       * cpu->pmsav7_dregion);
+                if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+                    memset(env->pmsav8.rbar[M_REG_S], 0,
+                           sizeof(*env->pmsav8.rbar[M_REG_S])
+                           * cpu->pmsav7_dregion);
+                    memset(env->pmsav8.rlar[M_REG_S], 0,
+                           sizeof(*env->pmsav8.rlar[M_REG_S])
+                           * cpu->pmsav7_dregion);
+                }
             } else if (arm_feature(env, ARM_FEATURE_V7)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
@@ -825,8 +835,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         if (nr) {
             if (arm_feature(env, ARM_FEATURE_V8)) {
                 /* PMSAv8 */
-                env->pmsav8.rbar = g_new0(uint32_t, nr);
-                env->pmsav8.rlar = g_new0(uint32_t, nr);
+                env->pmsav8.rbar[M_REG_NS] = g_new0(uint32_t, nr);
+                env->pmsav8.rlar[M_REG_NS] = g_new0(uint32_t, nr);
+                if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+                    env->pmsav8.rbar[M_REG_S] = g_new0(uint32_t, nr);
+                    env->pmsav8.rlar[M_REG_S] = g_new0(uint32_t, nr);
+                }
             } else {
                 env->pmsav7.drbar = g_new0(uint32_t, nr);
                 env->pmsav7.drsr = g_new0(uint32_t, nr);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4685d50..bcbd087 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8437,6 +8437,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
+    uint32_t secure = regime_is_secure(env, mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -8463,10 +8464,10 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
              * with bits [4:0] all zeroes, but the limit address is bits
              * [31:5] from the register with bits [4:0] all ones.
              */
-            uint32_t base = env->pmsav8.rbar[n] & ~0x1f;
-            uint32_t limit = env->pmsav8.rlar[n] | 0x1f;
+            uint32_t base = env->pmsav8.rbar[secure][n] & ~0x1f;
+            uint32_t limit = env->pmsav8.rlar[secure][n] | 0x1f;
 
-            if (!(env->pmsav8.rlar[n] & 0x1)) {
+            if (!(env->pmsav8.rlar[secure][n] & 0x1)) {
                 /* Region disabled */
                 continue;
             }
@@ -8515,8 +8516,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
         /* hit using the background region */
         get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
     } else {
-        uint32_t ap = extract32(env->pmsav8.rbar[matchregion], 1, 2);
-        uint32_t xn = extract32(env->pmsav8.rbar[matchregion], 0, 1);
+        uint32_t ap = extract32(env->pmsav8.rbar[secure][matchregion], 1, 2);
+        uint32_t xn = extract32(env->pmsav8.rbar[secure][matchregion], 0, 1);
 
         if (m_is_system_region(env, address)) {
             /* System space is always execute never */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 80942d6..0017ea0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -225,10 +225,10 @@ static const VMStateDescription vmstate_pmsav8 = {
     .minimum_version_id = 1,
     .needed = pmsav8_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_VARRAY_UINT32(env.pmsav8.rbar, ARMCPU, pmsav7_dregion, 0,
-                              vmstate_info_uint32, uint32_t),
-        VMSTATE_VARRAY_UINT32(env.pmsav8.rlar, ARMCPU, pmsav7_dregion, 0,
-                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rbar[M_REG_NS], ARMCPU, pmsav7_dregion,
+                              0, vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_NS], ARMCPU, pmsav7_dregion,
+                              0, vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.pmsav8.mair0[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.pmsav8.mair1[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
@@ -257,6 +257,10 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.vecbase[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.pmsav8.mair0[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.pmsav8.mair1[M_REG_S], ARMCPU),
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rbar[M_REG_S], ARMCPU, pmsav7_dregion,
+                              0, vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_S], ARMCPU, pmsav7_dregion,
+                              0, vmstate_info_uint32, uint32_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
