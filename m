Received: from eggs.gnu.org ([2001:4830:134:3::10]:35426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tm-0007Br-1Z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tk-0003Yu-LW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tk-0003Sa-BW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tj-0006Ra-Ej
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:05 +0100
Message-Id: <20180824093343.11346-15-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/52] target/arm: Implement AArch32 HCR and HCR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The AArch32 HCR and HCR2 registers alias HCR_EL2
bits [31:0] and [63:32]; implement them.

Since HCR2 exists in ARMv8 but not ARMv7, we need new
regdef arrays for "we have EL3, not EL2, we're ARMv8"
and "we have EL2, we're ARMv8" to hold the definitions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 54 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 336ce6ffa89..0d5f6f48cfe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3754,11 +3754,11 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
       .access = PL2_RW,
       .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
-    { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
+    { .name = "HCR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NO_RAW,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW,
-      .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
       .access = PL2_RW,
@@ -3857,6 +3857,15 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Ditto, but for registers which exist in ARMv8 but not v7 */
+static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
+    { .name = "HCR2", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
+      .access = PL2_RW,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -3883,10 +3892,26 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
      * HCR_PTW forbids certain page-table setups
      * HCR_DC Disables stage1 and enables stage2 translation
      */
-    if ((raw_read(env, ri) ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
+    if ((env->cp15.hcr_el2 ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
         tlb_flush(CPU(cpu));
     }
-    raw_write(env, ri, value);
+    env->cp15.hcr_el2 = value;
+}
+
+static void hcr_writehigh(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Handle HCR2 write, i.e. write to high half of HCR_EL2 */
+    value = deposit64(env->cp15.hcr_el2, 32, 32, value);
+    hcr_write(env, NULL, value);
+}
+
+static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    /* Handle HCR write, i.e. write to low half of HCR_EL2 */
+    value = deposit64(env->cp15.hcr_el2, 0, 32, value);
+    hcr_write(env, NULL, value);
 }
 
 static const ARMCPRegInfo el2_cp_reginfo[] = {
@@ -3894,6 +3919,11 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
       .writefn = hcr_write },
+    { .name = "HCR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
+      .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
+      .writefn = hcr_writelow },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
@@ -4128,6 +4158,16 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static const ARMCPRegInfo el2_v8_cp_reginfo[] = {
+    { .name = "HCR2", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
+      .access = PL2_RW,
+      .fieldoffset = offsetofhigh32(CPUARMState, cp15.hcr_el2),
+      .writefn = hcr_writehigh },
+    REGINFO_SENTINEL
+};
+
 static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -5179,6 +5219,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         };
         define_arm_cp_regs(cpu, vpidr_regs);
         define_arm_cp_regs(cpu, el2_cp_reginfo);
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            define_arm_cp_regs(cpu, el2_v8_cp_reginfo);
+        }
         /* RVBAR_EL2 is only implemented if EL2 is the highest EL */
         if (!arm_feature(env, ARM_FEATURE_EL3)) {
             ARMCPRegInfo rvbar = {
@@ -5211,6 +5254,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             };
             define_arm_cp_regs(cpu, vpidr_regs);
             define_arm_cp_regs(cpu, el3_no_el2_cp_reginfo);
+            if (arm_feature(env, ARM_FEATURE_V8)) {
+                define_arm_cp_regs(cpu, el3_no_el2_v8_cp_reginfo);
+            }
         }
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.18.0
