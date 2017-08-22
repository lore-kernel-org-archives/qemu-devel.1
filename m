Received: from eggs.gnu.org ([2001:4830:134:3::10]:53443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnr-0006Vn-En
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnp-0003FB-20
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:54 +0100
Message-Id: <1503414539-28762-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 15/20] target/arm: Make MPU_CTRL register
 banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Make the MPU_CTRL register banked if v8M security extensions are
enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 2 +-
 hw/intc/armv7m_nvic.c | 9 +++++----
 target/arm/helper.c   | 5 +++--
 target/arm/machine.c  | 3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 43d36d6..78cd3f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -429,7 +429,7 @@ typedef struct CPUARMState {
         uint32_t dfsr; /* Debug Fault Status Register */
         uint32_t mmfar; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
-        unsigned mpu_ctrl; /* MPU_CTRL */
+        unsigned mpu_ctrl[2]; /* MPU_CTRL */
         int exception;
         uint32_t primask[2];
         uint32_t faultmask[2];
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c3c214c..a4c298f 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -541,7 +541,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         return cpu->pmsav7_dregion << 8;
         break;
     case 0xd94: /* MPU_CTRL */
-        return cpu->env.v7m.mpu_ctrl;
+        return cpu->env.v7m.mpu_ctrl[attrs.secure];
     case 0xd98: /* MPU_RNR */
         return cpu->env.pmsav7.rnr[attrs.secure];
     case 0xd9c: /* MPU_RBAR */
@@ -720,9 +720,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             qemu_log_mask(LOG_GUEST_ERROR, "MPU_CTRL: HFNMIENA and !ENABLE is "
                           "UNPREDICTABLE\n");
         }
-        cpu->env.v7m.mpu_ctrl = value & (R_V7M_MPU_CTRL_ENABLE_MASK |
-                                         R_V7M_MPU_CTRL_HFNMIENA_MASK |
-                                         R_V7M_MPU_CTRL_PRIVDEFENA_MASK);
+        cpu->env.v7m.mpu_ctrl[attrs.secure]
+            = value & (R_V7M_MPU_CTRL_ENABLE_MASK |
+                       R_V7M_MPU_CTRL_HFNMIENA_MASK |
+                       R_V7M_MPU_CTRL_PRIVDEFENA_MASK);
         tlb_flush(CPU(cpu));
         break;
     case 0xd98: /* MPU_RNR */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 48e0fc6..4a2148c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7096,7 +7096,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
-        switch (env->v7m.mpu_ctrl &
+        switch (env->v7m.mpu_ctrl[regime_is_secure(env, mmu_idx)] &
                 (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
         case R_V7M_MPU_CTRL_ENABLE_MASK:
             /* Enabled, but not for HardFault and NMI */
@@ -8256,7 +8256,8 @@ static bool pmsav7_use_background_region(ARMCPU *cpu,
     }
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-        return env->v7m.mpu_ctrl & R_V7M_MPU_CTRL_PRIVDEFENA_MASK;
+        return env->v7m.mpu_ctrl[regime_is_secure(env, mmu_idx)]
+            & R_V7M_MPU_CTRL_PRIVDEFENA_MASK;
     } else {
         return regime_sctlr(env, mmu_idx) & SCTLR_BR;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6941e35..5cc95e8 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -123,7 +123,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar, ARMCPU),
         VMSTATE_UINT32(env.v7m.bfar, ARMCPU),
-        VMSTATE_UINT32(env.v7m.mpu_ctrl, ARMCPU),
+        VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_NS], ARMCPU),
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
         VMSTATE_END_OF_LIST()
     },
@@ -270,6 +270,7 @@ static const VMStateDescription vmstate_m_security = {
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
         VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
+        VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
