Received: from eggs.gnu.org ([2001:4830:134:3::10]:53666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnz-0006iZ-U9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnx-0003Mo-MO
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:40 +0100
Message-Id: <1503414539-28762-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/20] target/arm: Implement ARMv8M's PMSAv8
 registers
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

As part of ARMv8M, we need to add support for the PMSAv8 MPU
architecture.

PMSAv8 differs from PMSAv7 both in register/data layout (for instance
using base and limit registers rather than base and size) and also in
behaviour (for example it does not have subregions); rather than
trying to wedge it into the existing PMSAv7 code and data structures,
we define separate ones.

This commit adds the data structures which hold the state for a
PMSAv8 MPU and the register interface to it.  The implementation of
the MPU behaviour will be added in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  13 ++++++
 hw/intc/armv7m_nvic.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++----
 target/arm/cpu.c      |  36 ++++++++++-----
 target/arm/machine.c  |  28 +++++++++++-
 4 files changed, 179 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fe6edb7..b6bb78a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -522,6 +522,19 @@ typedef struct CPUARMState {
         uint32_t rnr;
     } pmsav7;
 
+    /* PMSAv8 MPU */
+    struct {
+        /* The PMSAv8 implementation also shares some PMSAv7 config
+         * and state:
+         *  pmsav7.rnr (region number register)
+         *  pmsav7_dregion (number of configured regions)
+         */
+        uint32_t *rbar;
+        uint32_t *rlar;
+        uint32_t mair0;
+        uint32_t mair1;
+    } pmsav8;
+
     void *nvic;
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index bbfe2d5..c0dbbad 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -544,25 +544,67 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
     {
         int region = cpu->env.pmsav7.rnr;
 
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            /* PMSAv8M handling of the aliases is different from v7M:
+             * aliases A1, A2, A3 override the low two bits of the region
+             * number in MPU_RNR, and there is no 'region' field in the
+             * RBAR register.
+             */
+            int aliasno = (offset - 0xd9c) / 8; /* 0..3 */
+            if (aliasno) {
+                region = deposit32(region, 0, 2, aliasno);
+            }
+            if (region >= cpu->pmsav7_dregion) {
+                return 0;
+            }
+            return cpu->env.pmsav8.rbar[region];
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return 0;
         }
         return (cpu->env.pmsav7.drbar[region] & 0x1f) | (region & 0xf);
     }
-    case 0xda0: /* MPU_RASR */
-    case 0xda8: /* MPU_RASR_A1 */
-    case 0xdb0: /* MPU_RASR_A2 */
-    case 0xdb8: /* MPU_RASR_A3 */
+    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+    case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
+    case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
+    case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
     {
         int region = cpu->env.pmsav7.rnr;
 
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            /* PMSAv8M handling of the aliases is different from v7M:
+             * aliases A1, A2, A3 override the low two bits of the region
+             * number in MPU_RNR.
+             */
+            int aliasno = (offset - 0xda0) / 8; /* 0..3 */
+            if (aliasno) {
+                region = deposit32(region, 0, 2, aliasno);
+            }
+            if (region >= cpu->pmsav7_dregion) {
+                return 0;
+            }
+            return cpu->env.pmsav8.rlar[region];
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return 0;
         }
         return ((cpu->env.pmsav7.dracr[region] & 0xffff) << 16) |
             (cpu->env.pmsav7.drsr[region] & 0xffff);
     }
+    case 0xdc0: /* MPU_MAIR0 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        return cpu->env.pmsav8.mair0;
+    case 0xdc4: /* MPU_MAIR1 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        return cpu->env.pmsav8.mair1;
     default:
+    bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
         return 0;
     }
@@ -691,6 +733,26 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
     {
         int region;
 
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            /* PMSAv8M handling of the aliases is different from v7M:
+             * aliases A1, A2, A3 override the low two bits of the region
+             * number in MPU_RNR, and there is no 'region' field in the
+             * RBAR register.
+             */
+            int aliasno = (offset - 0xd9c) / 8; /* 0..3 */
+
+            region = cpu->env.pmsav7.rnr;
+            if (aliasno) {
+                region = deposit32(region, 0, 2, aliasno);
+            }
+            if (region >= cpu->pmsav7_dregion) {
+                return;
+            }
+            cpu->env.pmsav8.rbar[region] = value;
+            tlb_flush(CPU(cpu));
+            return;
+        }
+
         if (value & (1 << 4)) {
             /* VALID bit means use the region number specified in this
              * value and also update MPU_RNR.REGION with that value.
@@ -715,13 +777,32 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         tlb_flush(CPU(cpu));
         break;
     }
-    case 0xda0: /* MPU_RASR */
-    case 0xda8: /* MPU_RASR_A1 */
-    case 0xdb0: /* MPU_RASR_A2 */
-    case 0xdb8: /* MPU_RASR_A3 */
+    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+    case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
+    case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
+    case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
     {
         int region = cpu->env.pmsav7.rnr;
 
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            /* PMSAv8M handling of the aliases is different from v7M:
+             * aliases A1, A2, A3 override the low two bits of the region
+             * number in MPU_RNR.
+             */
+            int aliasno = (offset - 0xd9c) / 8; /* 0..3 */
+
+            region = cpu->env.pmsav7.rnr;
+            if (aliasno) {
+                region = deposit32(region, 0, 2, aliasno);
+            }
+            if (region >= cpu->pmsav7_dregion) {
+                return;
+            }
+            cpu->env.pmsav8.rlar[region] = value;
+            tlb_flush(CPU(cpu));
+            return;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return;
         }
@@ -731,6 +812,30 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         tlb_flush(CPU(cpu));
         break;
     }
+    case 0xdc0: /* MPU_MAIR0 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (cpu->pmsav7_dregion) {
+            /* Register is RES0 if no MPU regions are implemented */
+            cpu->env.pmsav8.mair0 = value;
+        }
+        /* We don't need to do anything else because memory attributes
+         * only affect cacheability, and we don't implement caching.
+         */
+        break;
+    case 0xdc4: /* MPU_MAIR1 */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (cpu->pmsav7_dregion) {
+            /* Register is RES0 if no MPU regions are implemented */
+            cpu->env.pmsav8.mair1 = value;
+        }
+        /* We don't need to do anything else because memory attributes
+         * only affect cacheability, and we don't implement caching.
+         */
+        break;
     case 0xf00: /* Software Triggered Interrupt Register */
     {
         int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
@@ -740,6 +845,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         break;
     }
     default:
+    bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "NVIC: Bad write offset 0x%x\n", offset);
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 41ae6ba..8b610de 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -228,17 +228,25 @@ static void arm_cpu_reset(CPUState *s)
     env->vfp.xregs[ARM_VFP_FPEXC] = 0;
 #endif
 
-    if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
         if (cpu->pmsav7_dregion > 0) {
-            memset(env->pmsav7.drbar, 0,
-                   sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
-            memset(env->pmsav7.drsr, 0,
-                   sizeof(*env->pmsav7.drsr) * cpu->pmsav7_dregion);
-            memset(env->pmsav7.dracr, 0,
-                   sizeof(*env->pmsav7.dracr) * cpu->pmsav7_dregion);
+            if (arm_feature(env, ARM_FEATURE_V8)) {
+                memset(env->pmsav8.rbar, 0,
+                       sizeof(*env->pmsav8.rbar) * cpu->pmsav7_dregion);
+                memset(env->pmsav8.rlar, 0,
+                       sizeof(*env->pmsav8.rlar) * cpu->pmsav7_dregion);
+            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+                memset(env->pmsav7.drbar, 0,
+                       sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
+                memset(env->pmsav7.drsr, 0,
+                       sizeof(*env->pmsav7.drsr) * cpu->pmsav7_dregion);
+                memset(env->pmsav7.dracr, 0,
+                       sizeof(*env->pmsav7.dracr) * cpu->pmsav7_dregion);
+            }
         }
         env->pmsav7.rnr = 0;
+        env->pmsav8.mair0 = 0;
+        env->pmsav8.mair1 = 0;
     }
 
     set_flush_to_zero(1, &env->vfp.standard_fp_status);
@@ -809,9 +817,15 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
 
         if (nr) {
-            env->pmsav7.drbar = g_new0(uint32_t, nr);
-            env->pmsav7.drsr = g_new0(uint32_t, nr);
-            env->pmsav7.dracr = g_new0(uint32_t, nr);
+            if (arm_feature(env, ARM_FEATURE_V8)) {
+                /* PMSAv8 */
+                env->pmsav8.rbar = g_new0(uint32_t, nr);
+                env->pmsav8.rlar = g_new0(uint32_t, nr);
+            } else {
+                env->pmsav7.drbar = g_new0(uint32_t, nr);
+                env->pmsav7.drsr = g_new0(uint32_t, nr);
+                env->pmsav7.dracr = g_new0(uint32_t, nr);
+            }
         }
     }
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 3193b00..05e2909 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -159,7 +159,8 @@ static bool pmsav7_needed(void *opaque)
     CPUARMState *env = &cpu->env;
 
     return arm_feature(env, ARM_FEATURE_PMSA) &&
-           arm_feature(env, ARM_FEATURE_V7);
+           arm_feature(env, ARM_FEATURE_V7) &&
+           !arm_feature(env, ARM_FEATURE_V8);
 }
 
 static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
@@ -209,6 +210,31 @@ static const VMStateDescription vmstate_pmsav7_rnr = {
     }
 };
 
+static bool pmsav8_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_PMSA) &&
+        arm_feature(env, ARM_FEATURE_V8);
+}
+
+static const VMStateDescription vmstate_pmsav8 = {
+    .name = "cpu/pmsav8",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pmsav8_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rbar, ARMCPU, pmsav7_dregion, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(env.pmsav8.rlar, ARMCPU, pmsav7_dregion, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_UINT32(env.pmsav8.mair0, ARMCPU),
+        VMSTATE_UINT32(env.pmsav8.mair1, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
                     VMStateField *field)
 {
-- 
2.7.4
