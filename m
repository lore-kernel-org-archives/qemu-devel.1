Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQg-00086K-GJ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQe-0004G5-N9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:00:00 +0100
Message-Id: <1506092407-26985-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 13/20] nvic: Implement Security Attribution
 Unit registers
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

Implement the register interface for the SAU: SAU_CTRL,
SAU_TYPE, SAU_RNR, SAU_RBAR and SAU_RLAR. None of the
actual behaviour is implemented here; registers just
read back as written.

When the CPU definition for Cortex-M33 is eventually
added, its initfn will set cpu->sau_sregion, in the same
way that we currently set cpu->pmsav7_dregion for the
M3 and M4.

Number of SAU regions is typically a configurable
CPU parameter, but this patch doesn't provide a
QEMU CPU property for it. We can easily add one when
we have a board that requires it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  10 +++++
 hw/intc/armv7m_nvic.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c      |  27 ++++++++++++
 target/arm/machine.c  |  14 ++++++
 4 files changed, 167 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e3a16d..441e584 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -568,6 +568,14 @@ typedef struct CPUARMState {
         uint32_t mair1[M_REG_NUM_BANKS];
     } pmsav8;
 
+    /* v8M SAU */
+    struct {
+        uint32_t *rbar;
+        uint32_t *rlar;
+        uint32_t rnr;
+        uint32_t ctrl;
+    } sau;
+
     void *nvic;
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
@@ -663,6 +671,8 @@ struct ARMCPU {
     bool has_mpu;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
+    /* v8M SAU number of supported regions */
+    uint32_t sau_sregion;
 
     /* PSCI conduit used to invoke PSCI methods
      * 0 - disabled, 1 - smc, 2 - hvc
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index deea637..bd1d5d3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1017,6 +1017,60 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             goto bad_offset;
         }
         return cpu->env.pmsav8.mair1[attrs.secure];
+    case 0xdd0: /* SAU_CTRL */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        return cpu->env.sau.ctrl;
+    case 0xdd4: /* SAU_TYPE */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        return cpu->sau_sregion;
+    case 0xdd8: /* SAU_RNR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        return cpu->env.sau.rnr;
+    case 0xddc: /* SAU_RBAR */
+    {
+        int region = cpu->env.sau.rnr;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        if (region >= cpu->sau_sregion) {
+            return 0;
+        }
+        return cpu->env.sau.rbar[region];
+    }
+    case 0xde0: /* SAU_RLAR */
+    {
+        int region = cpu->env.sau.rnr;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        if (region >= cpu->sau_sregion) {
+            return 0;
+        }
+        return cpu->env.sau.rlar[region];
+    }
     case 0xde4: /* SFSR */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             goto bad_offset;
@@ -1384,6 +1438,68 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
          * only affect cacheability, and we don't implement caching.
          */
         break;
+    case 0xdd0: /* SAU_CTRL */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        cpu->env.sau.ctrl = value & 3;
+    case 0xdd4: /* SAU_TYPE */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        break;
+    case 0xdd8: /* SAU_RNR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        if (value >= cpu->sau_sregion) {
+            qemu_log_mask(LOG_GUEST_ERROR, "SAU region out of range %"
+                          PRIu32 "/%" PRIu32 "\n",
+                          value, cpu->sau_sregion);
+        } else {
+            cpu->env.sau.rnr = value;
+        }
+        break;
+    case 0xddc: /* SAU_RBAR */
+    {
+        int region = cpu->env.sau.rnr;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        if (region >= cpu->sau_sregion) {
+            return;
+        }
+        cpu->env.sau.rbar[region] = value & ~0x1f;
+        tlb_flush(CPU(cpu));
+        break;
+    }
+    case 0xde0: /* SAU_RLAR */
+    {
+        int region = cpu->env.sau.rnr;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        if (region >= cpu->sau_sregion) {
+            return;
+        }
+        cpu->env.sau.rlar[region] = value & ~0x1c;
+        tlb_flush(CPU(cpu));
+        break;
+    }
     case 0xde4: /* SFSR */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             goto bad_offset;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3344979..1627836 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -285,6 +285,18 @@ static void arm_cpu_reset(CPUState *s)
         env->pmsav8.mair1[M_REG_S] = 0;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        if (cpu->sau_sregion > 0) {
+            memset(env->sau.rbar, 0, sizeof(*env->sau.rbar) * cpu->sau_sregion);
+            memset(env->sau.rlar, 0, sizeof(*env->sau.rlar) * cpu->sau_sregion);
+        }
+        env->sau.rnr = 0;
+        /* SAU_CTRL reset value is IMPDEF; we choose 0, which is what
+         * the Cortex-M33 does.
+         */
+        env->sau.ctrl = 0;
+    }
+
     set_flush_to_zero(1, &env->vfp.standard_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
@@ -870,6 +882,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        uint32_t nr = cpu->sau_sregion;
+
+        if (nr > 0xff) {
+            error_setg(errp, "v8M SAU #regions invalid %" PRIu32, nr);
+            return;
+        }
+
+        if (nr) {
+            env->sau.rbar = g_new0(uint32_t, nr);
+            env->sau.rlar = g_new0(uint32_t, nr);
+        }
+    }
+
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         set_feature(env, ARM_FEATURE_VBAR);
     }
@@ -1141,6 +1167,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
 }
+
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index d4b3baf..a52d0f9 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -242,6 +242,13 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
     return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
 }
 
+static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
+{
+    ARMCPU *cpu = opaque;
+
+    return cpu->env.sau.rnr < cpu->sau_sregion;
+}
+
 static bool m_security_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -278,6 +285,13 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.cfsr[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.sfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.sfar, ARMCPU),
+        VMSTATE_VARRAY_UINT32(env.sau.rbar, ARMCPU, sau_sregion, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(env.sau.rlar, ARMCPU, sau_sregion, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_UINT32(env.sau.rnr, ARMCPU),
+        VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
+        VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
