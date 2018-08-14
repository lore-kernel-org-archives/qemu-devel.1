Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfK-0005Yd-Dz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfJ-0002NE-Cb
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:14 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:49 +0100
Message-Id: <20180814124254.5229-6-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/10] target/arm: Implement AArch32 HCR and
 HCR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

The AArch32 HCR and HCR2 registers alias HCR_EL2
bits [31:0] and [63:32]; implement them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b6412fe9d1f..9701e413859 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3754,11 +3754,15 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
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
+    { .name = "HCR2", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
+      .access = PL2_RW,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
@@ -3872,10 +3876,26 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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
@@ -3883,6 +3903,17 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
       .writefn = hcr_write },
+    { .name = "HCR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
+      .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
+      .writefn = hcr_writelow },
+    { .name = "HCR2", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
+      .access = PL2_RW,
+      .fieldoffset = offsetofhigh32(CPUARMState, cp15.hcr_el2),
+      .writefn = hcr_writehigh },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-- 
2.18.0
