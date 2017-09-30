Received: from eggs.gnu.org ([2001:4830:134:3::10]:49662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7Dn-0002fS-33
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7Dl-0005NT-VH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:39 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 29 Sep 2017 22:08:30 -0400
Message-Id: <1506737310-21880-14-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 13/13] target/arm: Implement PMSWINC
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Digant Desai <digantd@codeaurora.org>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 659b2b8..c688e56 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -907,6 +907,15 @@ static bool event_always_supported(CPUARMState *env)
     return true;
 }
 
+static uint64_t swinc_get_count(CPUARMState *env)
+{
+    /*
+     * SW_INCR events are written directly to the pmevcntr's by writes to
+     * PMSWINC, so don't do anything here...
+     */
+    return 0;
+}
+
 #ifndef CONFIG_USER_ONLY
 static uint64_t cycles_get_count(CPUARMState *env)
 {
@@ -943,6 +952,10 @@ static uint64_t instructions_get_count(CPUARMState *env)
 
 #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
 static const pm_event pm_events[] = {
+    { .number = 0x000, /* SW_INCR */
+      .supported = event_always_supported,
+      .get_count = swinc_get_count
+    },
 #ifndef CONFIG_USER_ONLY
     { .number = 0x008, /* INST_RETIRED */
       .supported = instructions_supported,
@@ -1195,6 +1208,25 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pmu_sync(env);
 }
 
+static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    unsigned int i;
+    for (i = 0; i < PMU_NUM_COUNTERS(env); i++) {
+        /* Increment a counter's count iff: */
+        if ((value & (1 << i)) && /* counter's bit is set */
+                /* counter is enabled and not filtered */
+                pmu_counter_enabled(env, i) &&
+                !pmu_counter_filtered(env, env->cp15.c14_pmevtyper[i]) &&
+                /* counter is SW_INCR */
+                (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) == 0x0) {
+            pmu_sync_counter(env, i);
+            env->cp15.c14_pmevcntr[i]++;
+            pmu_sync_counter(env, i);
+        }
+    }
+}
+
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     uint64_t ret;
@@ -1551,9 +1583,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn = pmovsset_write,
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.\nQualcomm Technologies, Inc. is a member of the\nCode Aurora Forum, a Linux Foundation Collaborative Project.
