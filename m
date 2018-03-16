Received: from eggs.gnu.org ([2001:4830:134:3::10]:44310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1Y-0005zG-Mi
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1X-0003Uc-Ni
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:24 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:11 -0400
Message-Id: <1521232280-13089-14-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 13/22] target/arm: Allow AArch32 access for
 PMCCFILTR
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

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 95b09d6..d4f06e6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -917,6 +917,10 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMXEVTYPER_MT         0x02000000
 #define PMXEVTYPER_EVTCOUNT   0x000003ff
 
+#define PMCCFILTR             0xf8000000
+#define PMCCFILTR_M           PMXEVTYPER_M
+#define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
+
 #define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT)
 /* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
 #define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
@@ -1200,10 +1204,26 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
     uint64_t saved_cycles = pmccntr_op_start(env);
-    env->cp15.pmccfiltr_el0 = value & 0xfc000000;
+    env->cp15.pmccfiltr_el0 = value & PMCCFILTR_EL0;
+    pmccntr_op_finish(env, saved_cycles);
+}
+
+static void pmccfiltr_write_a32(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    uint64_t saved_cycles = pmccntr_op_start(env);
+    /* M is not accessible from AArch32 */
+    env->cp15.pmccfiltr_el0 = (env->cp15.pmccfiltr_el0 & PMCCFILTR_M) |
+        (value & PMCCFILTR);
     pmccntr_op_finish(env, saved_cycles);
 }
 
+static uint64_t pmccfiltr_read_a32(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* M is not visible in AArch32 */
+    return env->cp15.pmccfiltr_el0 & PMCCFILTR;
+}
+
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1421,6 +1441,11 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .readfn = pmccntr_read, .writefn = pmccntr_write, },
 #endif
+    { .name = "PMCCFILTR", .cp = 15, .opc1 = 0, .crn = 14, .crm = 15, .opc2 = 7,
+      .writefn = pmccfiltr_write_a32, .readfn = pmccfiltr_read_a32,
+      .access = PL0_RW, .accessfn = pmreg_access,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .resetvalue = 0, },
     { .name = "PMCCFILTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 15, .opc2 = 7,
       .writefn = pmccfiltr_write,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
