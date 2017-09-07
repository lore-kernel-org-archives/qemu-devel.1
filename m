Received: from eggs.gnu.org ([2001:4830:134:3::10]:56434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr2-000100-PF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqx-0007dU-F0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqx-0007cY-3q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqw-0001dm-1C
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:14 +0100
Message-Id: <1504790904-17018-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/31] target/arm: Make MPU_RNR register banked
 for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the MPU_RNR register banked if v8M security extensions are
enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-15-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  2 +-
 hw/intc/armv7m_nvic.c | 18 +++++++++---------
 target/arm/cpu.c      |  3 ++-
 target/arm/helper.c   |  6 +++---
 target/arm/machine.c  | 13 +++++++++++--
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d385ef2..425adc3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -533,7 +533,7 @@ typedef struct CPUARMState {
         uint32_t *drbar;
         uint32_t *drsr;
         uint32_t *dracr;
-        uint32_t rnr;
+        uint32_t rnr[2];
     } pmsav7;
 
     /* PMSAv8 MPU */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 9ced7af..c3c214c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -543,13 +543,13 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd94: /* MPU_CTRL */
         return cpu->env.v7m.mpu_ctrl;
     case 0xd98: /* MPU_RNR */
-        return cpu->env.pmsav7.rnr;
+        return cpu->env.pmsav7.rnr[attrs.secure];
     case 0xd9c: /* MPU_RBAR */
     case 0xda4: /* MPU_RBAR_A1 */
     case 0xdac: /* MPU_RBAR_A2 */
     case 0xdb4: /* MPU_RBAR_A3 */
     {
-        int region = cpu->env.pmsav7.rnr;
+        int region = cpu->env.pmsav7.rnr[attrs.secure];
 
         if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             /* PMSAv8M handling of the aliases is different from v7M:
@@ -577,7 +577,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
     {
-        int region = cpu->env.pmsav7.rnr;
+        int region = cpu->env.pmsav7.rnr[attrs.secure];
 
         if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             /* PMSAv8M handling of the aliases is different from v7M:
@@ -731,7 +731,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                           PRIu32 "/%" PRIu32 "\n",
                           value, cpu->pmsav7_dregion);
         } else {
-            cpu->env.pmsav7.rnr = value;
+            cpu->env.pmsav7.rnr[attrs.secure] = value;
         }
         break;
     case 0xd9c: /* MPU_RBAR */
@@ -749,7 +749,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
              */
             int aliasno = (offset - 0xd9c) / 8; /* 0..3 */
 
-            region = cpu->env.pmsav7.rnr;
+            region = cpu->env.pmsav7.rnr[attrs.secure];
             if (aliasno) {
                 region = deposit32(region, 0, 2, aliasno);
             }
@@ -772,9 +772,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                               region, cpu->pmsav7_dregion);
                 return;
             }
-            cpu->env.pmsav7.rnr = region;
+            cpu->env.pmsav7.rnr[attrs.secure] = region;
         } else {
-            region = cpu->env.pmsav7.rnr;
+            region = cpu->env.pmsav7.rnr[attrs.secure];
         }
 
         if (region >= cpu->pmsav7_dregion) {
@@ -790,7 +790,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
     {
-        int region = cpu->env.pmsav7.rnr;
+        int region = cpu->env.pmsav7.rnr[attrs.secure];
 
         if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             /* PMSAv8M handling of the aliases is different from v7M:
@@ -799,7 +799,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
              */
             int aliasno = (offset - 0xd9c) / 8; /* 0..3 */
 
-            region = cpu->env.pmsav7.rnr;
+            region = cpu->env.pmsav7.rnr[attrs.secure];
             if (aliasno) {
                 region = deposit32(region, 0, 2, aliasno);
             }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 40ec445..b7f5ec2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -258,7 +258,8 @@ static void arm_cpu_reset(CPUState *s)
                        sizeof(*env->pmsav7.dracr) * cpu->pmsav7_dregion);
             }
         }
-        env->pmsav7.rnr = 0;
+        env->pmsav7.rnr[M_REG_NS] = 0;
+        env->pmsav7.rnr[M_REG_S] = 0;
         env->pmsav8.mair0[M_REG_NS] = 0;
         env->pmsav8.mair0[M_REG_S] = 0;
         env->pmsav8.mair1[M_REG_NS] = 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bcbd087..4db191e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2385,7 +2385,7 @@ static uint64_t pmsav7_read(CPUARMState *env, const ARMCPRegInfo *ri)
         return 0;
     }
 
-    u32p += env->pmsav7.rnr;
+    u32p += env->pmsav7.rnr[M_REG_NS];
     return *u32p;
 }
 
@@ -2399,7 +2399,7 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    u32p += env->pmsav7.rnr;
+    u32p += env->pmsav7.rnr[M_REG_NS];
     tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
     *u32p = value;
 }
@@ -2442,7 +2442,7 @@ static const ARMCPRegInfo pmsav7_cp_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
     { .name = "RGNR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 2, .opc2 = 0,
       .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, pmsav7.rnr),
+      .fieldoffset = offsetof(CPUARMState, pmsav7.rnr[M_REG_NS]),
       .writefn = pmsav7_rgnr_write,
       .resetfn = arm_cp_reset_ignore },
     REGINFO_SENTINEL
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0017ea0..7f894e5 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -167,7 +167,7 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.pmsav7.rnr < cpu->pmsav7_dregion;
+    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
 }
 
 static const VMStateDescription vmstate_pmsav7 = {
@@ -205,7 +205,7 @@ static const VMStateDescription vmstate_pmsav7_rnr = {
     .minimum_version_id = 1,
     .needed = pmsav7_rnr_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(env.pmsav7.rnr, ARMCPU),
+        VMSTATE_UINT32(env.pmsav7.rnr[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -235,6 +235,13 @@ static const VMStateDescription vmstate_pmsav8 = {
     }
 };
 
+static bool s_rnr_vmstate_validate(void *opaque, int version_id)
+{
+    ARMCPU *cpu = opaque;
+
+    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
+}
+
 static bool m_security_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -261,6 +268,8 @@ static const VMStateDescription vmstate_m_security = {
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_S], ARMCPU, pmsav7_dregion,
                               0, vmstate_info_uint32, uint32_t),
+        VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
+        VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
