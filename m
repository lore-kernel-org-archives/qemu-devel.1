Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNm-00039U-68
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNi-00077K-Bc
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:39:17 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Tue, 17 Apr 2018 16:37:58 -0400
Message-Id: <1523997485-1905-15-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v4 14/21] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

Adding an array for v7VE+ CP registers was necessary so that PMOVSSET
wasn't defined for all v7 processors.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20b42b4..572709e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1262,9 +1262,17 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
+    value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmovsr &= ~value;
 }
 
+static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    value &= PMU_COUNTER_MASK(env);
+    env->cp15.c9_pmovsr |= value;
+}
+
 static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
@@ -1614,6 +1622,25 @@ static const ARMCPRegInfo v7mp_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static const ARMCPRegInfo v7ve_cp_reginfo[] = {
+    /* Performance monitor registers which are not implemented in v7 before
+     * v7ve:
+     */
+    { .name = "PMOVSSET", .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 3,
+      .access = PL0_RW, .accessfn = pmreg_access,
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
+      .writefn = pmovsset_write,
+      .raw_writefn = raw_write },
+    { .name = "PMOVSSET_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 14, .opc2 = 3,
+      .access = PL0_RW, .accessfn = pmreg_access,
+      .type = ARM_CP_ALIAS,
+      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
+      .writefn = pmovsset_write,
+      .raw_writefn = raw_write },
+    REGINFO_SENTINEL
+};
+
 static void teecr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -4965,6 +4992,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         !arm_feature(env, ARM_FEATURE_PMSA)) {
         define_arm_cp_regs(cpu, v7mp_cp_reginfo);
     }
+    if (arm_feature(env, ARM_FEATURE_V7VE)) {
+        define_arm_cp_regs(cpu, v7ve_cp_reginfo);
+    }
     if (arm_feature(env, ARM_FEATURE_V7)) {
         /* v7 performance monitor control register: same implementor
          * field as main ID register, and we implement only the cycle
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
