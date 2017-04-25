Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zhv-0007zw-3k
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zht-00053R-K7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:09 +0100
Message-Id: <1493122030-32191-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/13] arm: add MPU support to M profile CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

From: Michael Davidsaver <mdavidsaver@gmail.com>

The M series MPU is almost the same as the already implemented R
profile MPU (v7 PMSA).  So all we need to implement here is the MPU
register interface in the system register space.

This implementation has the same restriction as the R profile MPU
that it doesn't permit regions to be sized down smaller than 1K.

We also do not yet implement support for MPU_CTRL.HFNMIENA; this
bit should if zero disable use of the MPU when running HardFault,
NMI or with FAULTMASK set to 1 (ie at an execution priority of
less than zero) -- if the MPU is enabled we don't treat these
cases any differently.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: Keep all the bits in mpu_ctrl field, rather than
 using SCTLR bits for them; drop broken HFNMIENA support;
 various cleanup]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |   6 +++
 hw/intc/armv7m_nvic.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c   |  25 +++++++++++-
 target/arm/machine.c  |   5 ++-
 4 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0718955..bbdd064 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -418,6 +418,7 @@ typedef struct CPUARMState {
         uint32_t dfsr; /* Debug Fault Status Register */
         uint32_t mmfar; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
+        unsigned mpu_ctrl; /* MPU_CTRL (some bits kept in sctlr_el[1]) */
         int exception;
     } v7m;
 
@@ -1166,6 +1167,11 @@ FIELD(V7M_DFSR, DWTTRAP, 2, 1)
 FIELD(V7M_DFSR, VCATCH, 3, 1)
 FIELD(V7M_DFSR, EXTERNAL, 4, 1)
 
+/* v7M MPU_CTRL bits */
+FIELD(V7M_MPU_CTRL, ENABLE, 0, 1)
+FIELD(V7M_MPU_CTRL, HFNMIENA, 1, 1)
+FIELD(V7M_MPU_CTRL, PRIVDEFENA, 2, 1)
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 32ffa0b..26a4b2d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -19,6 +19,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/armv7m_nvic.h"
 #include "target/arm/cpu.h"
+#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "trace.h"
 
@@ -528,6 +529,39 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
     case 0xd70: /* ISAR4.  */
         return 0x01310102;
     /* TODO: Implement debug registers.  */
+    case 0xd90: /* MPU_TYPE */
+        /* Unified MPU; if the MPU is not present this value is zero */
+        return cpu->pmsav7_dregion << 8;
+        break;
+    case 0xd94: /* MPU_CTRL */
+        return cpu->env.v7m.mpu_ctrl;
+    case 0xd98: /* MPU_RNR */
+        return cpu->env.cp15.c6_rgnr;
+    case 0xd9c: /* MPU_RBAR */
+    case 0xda4: /* MPU_RBAR_A1 */
+    case 0xdac: /* MPU_RBAR_A2 */
+    case 0xdb4: /* MPU_RBAR_A3 */
+    {
+        int region = cpu->env.cp15.c6_rgnr;
+
+        if (region >= cpu->pmsav7_dregion) {
+            return 0;
+        }
+        return (cpu->env.pmsav7.drbar[region] & 0x1f) | (region & 0xf);
+    }
+    case 0xda0: /* MPU_RASR */
+    case 0xda8: /* MPU_RASR_A1 */
+    case 0xdb0: /* MPU_RASR_A2 */
+    case 0xdb8: /* MPU_RASR_A3 */
+    {
+        int region = cpu->env.cp15.c6_rgnr;
+
+        if (region >= cpu->pmsav7_dregion) {
+            return 0;
+        }
+        return ((cpu->env.pmsav7.dracr[region] & 0xffff) << 16) |
+            (cpu->env.pmsav7.drsr[region] & 0xffff);
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
         return 0;
@@ -627,6 +661,76 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         qemu_log_mask(LOG_UNIMP,
                       "NVIC: Aux fault status registers unimplemented\n");
         break;
+    case 0xd90: /* MPU_TYPE */
+        return; /* RO */
+    case 0xd94: /* MPU_CTRL */
+        if ((value &
+             (R_V7M_MPU_CTRL_HFNMIENA_MASK | R_V7M_MPU_CTRL_ENABLE_MASK))
+            == R_V7M_MPU_CTRL_HFNMIENA_MASK) {
+            qemu_log_mask(LOG_GUEST_ERROR, "MPU_CTRL: HFNMIENA and !ENABLE is "
+                          "UNPREDICTABLE\n");
+        }
+        cpu->env.v7m.mpu_ctrl = value & (R_V7M_MPU_CTRL_ENABLE_MASK |
+                                         R_V7M_MPU_CTRL_HFNMIENA_MASK |
+                                         R_V7M_MPU_CTRL_PRIVDEFENA_MASK);
+        tlb_flush(CPU(cpu));
+        break;
+    case 0xd98: /* MPU_RNR */
+        if (value >= cpu->pmsav7_dregion) {
+            qemu_log_mask(LOG_GUEST_ERROR, "MPU region out of range %"
+                          PRIu32 "/%" PRIu32 "\n",
+                          value, cpu->pmsav7_dregion);
+        } else {
+            cpu->env.cp15.c6_rgnr = value;
+        }
+        break;
+    case 0xd9c: /* MPU_RBAR */
+    case 0xda4: /* MPU_RBAR_A1 */
+    case 0xdac: /* MPU_RBAR_A2 */
+    case 0xdb4: /* MPU_RBAR_A3 */
+    {
+        int region;
+
+        if (value & (1 << 4)) {
+            /* VALID bit means use the region number specified in this
+             * value and also update MPU_RNR.REGION with that value.
+             */
+            region = extract32(value, 0, 4);
+            if (region >= cpu->pmsav7_dregion) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "MPU region out of range %u/%" PRIu32 "\n",
+                              region, cpu->pmsav7_dregion);
+                return;
+            }
+            cpu->env.cp15.c6_rgnr = region;
+        } else {
+            region = cpu->env.cp15.c6_rgnr;
+        }
+
+        if (region >= cpu->pmsav7_dregion) {
+            return;
+        }
+
+        cpu->env.pmsav7.drbar[region] = value & ~0x1f;
+        tlb_flush(CPU(cpu));
+        break;
+    }
+    case 0xda0: /* MPU_RASR */
+    case 0xda8: /* MPU_RASR_A1 */
+    case 0xdb0: /* MPU_RASR_A2 */
+    case 0xdb8: /* MPU_RASR_A3 */
+    {
+        int region = cpu->env.cp15.c6_rgnr;
+
+        if (region >= cpu->pmsav7_dregion) {
+            return;
+        }
+
+        cpu->env.pmsav7.drsr[region] = value & 0xff3f;
+        cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        tlb_flush(CPU(cpu));
+        break;
+    }
     case 0xf00: /* Software Triggered Interrupt Register */
     {
         /* user mode can only write to STIR if CCR.USERSETMPEND permits it */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 49b6d01..5bf706d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7076,6 +7076,10 @@ static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
 {
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return !(env->v7m.mpu_ctrl & R_V7M_MPU_CTRL_ENABLE_MASK);
+    }
+
     if (mmu_idx == ARMMMUIdx_S2NS) {
         return (env->cp15.hcr_el2 & HCR_VM) == 0;
     }
@@ -8199,6 +8203,25 @@ static inline void get_phys_addr_pmsav7_default(CPUARMState *env,
     }
 }
 
+static bool pmsav7_use_background_region(ARMCPU *cpu,
+                                         ARMMMUIdx mmu_idx, bool is_user)
+{
+    /* Return true if we should use the default memory map as a
+     * "background" region if there are no hits against any MPU regions.
+     */
+    CPUARMState *env = &cpu->env;
+
+    if (is_user) {
+        return false;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return env->v7m.mpu_ctrl & R_V7M_MPU_CTRL_PRIVDEFENA_MASK;
+    } else {
+        return regime_sctlr(env, mmu_idx) & SCTLR_BR;
+    }
+}
+
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  int access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
@@ -8286,7 +8309,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         }
 
         if (n == -1) { /* no hits */
-            if (is_user || !(regime_sctlr(env, mmu_idx) & SCTLR_BR)) {
+            if (!pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
                 /* background fault */
                 *fsr = 0;
                 return true;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index ac6b758..1a40469 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -99,8 +99,8 @@ static bool m_needed(void *opaque)
 
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = m_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
@@ -112,6 +112,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar, ARMCPU),
         VMSTATE_UINT32(env.v7m.bfar, ARMCPU),
+        VMSTATE_UINT32(env.v7m.mpu_ctrl, ARMCPU),
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
-- 
2.7.4
