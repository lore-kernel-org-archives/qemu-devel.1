Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjl-0002K2-6n
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjk-0005WC-1k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:53 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:25 -0400
Message-Id: <1529699547-17044-12-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 11/13] target/arm: Implement PMSWINC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3720239..96667e6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -980,6 +980,15 @@ static bool event_always_supported(CPUARMState *env)
     return true;
 }
 
+static uint64_t swinc_get_count(CPUARMState *env)
+{
+    /*
+     * SW_INCR events are written directly to the pmevcntr's by writes to
+     * PMSWINC, so there is no underlying count maintained by the PMU itself
+     */
+    return 0;
+}
+
 /*
  * Return the underlying cycle count for the PMU cycle counters. If we're in
  * usermode, simply return 0.
@@ -1008,6 +1017,10 @@ static uint64_t instructions_get_count(CPUARMState *env)
 
 #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
 static const pm_event pm_events[] = {
+    { .number = 0x000, /* SW_INCR */
+      .supported = event_always_supported,
+      .get_count = swinc_get_count
+    },
 #ifndef CONFIG_USER_ONLY
     { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
       .supported = instructions_supported,
@@ -1318,6 +1331,24 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pmu_op_finish(env);
 }
 
+static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    unsigned int i;
+    for (i = 0; i < pmu_num_counters(env); i++) {
+        /* Increment a counter's count iff: */
+        if ((value & (1 << i)) && /* counter's bit is set */
+                /* counter is enabled and not filtered */
+                pmu_counter_enabled(env, i) &&
+                /* counter is SW_INCR */
+                (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) == 0x0) {
+            pmevcntr_op_start(env, i);
+            env->cp15.c14_pmevcntr[i]++;
+            pmevcntr_op_finish(env, i);
+        }
+    }
+}
+
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     uint64_t ret;
@@ -1663,9 +1694,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn = pmovsr_write,
       .raw_writefn = raw_write },
-    /* Unimplemented so WI. */
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
-      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NOP },
+      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NO_RAW,
+      .writefn = pmswinc_write },
+    { .name = "PMSWINC_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 4,
+      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NO_RAW,
+      .writefn = pmswinc_write },
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
       .access = PL0_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
