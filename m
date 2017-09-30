Received: from eggs.gnu.org ([2001:4830:134:3::10]:49668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7Dn-0002fj-Aq
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7Dm-0005Nc-45
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:39 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 29 Sep 2017 22:08:28 -0400
Message-Id: <1506737310-21880-12-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 11/13] target/arm: PMU: Add instruction and
 cycle events
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

The instruction event is only enabled when icount is used, cycles are
always supported.

Note: Setting can_do_io=1 should not be done here. It is ugly and wrong,
but I am not sure of the proper way to handle this (See 'target/arm:
Filter cycle counter based on PMCCFILTR_EL0')

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 75 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f183199..e48bb67 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14,6 +14,7 @@
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
@@ -901,8 +902,57 @@ typedef struct pm_event {
     uint64_t (*get_count)(CPUARMState *);
 } pm_event;
 
+static bool event_always_supported(CPUARMState *env)
+{
+    return true;
+}
+
+#ifndef CONFIG_USER_ONLY
+static uint64_t cycles_get_count(CPUARMState *env)
+{
+    uint64_t ret;
+    CPUState *cpu = ENV_GET_CPU(env);
+    uint32_t saved_can_do_io = cpu->can_do_io;
+    cpu->can_do_io = 1;
+
+    ret = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+
+    cpu->can_do_io = saved_can_do_io;
+    return ret;
+}
+
+static bool instructions_supported(CPUARMState *env)
+{
+    return use_icount == 1 /* Precise instruction counting */;
+}
+
+static uint64_t instructions_get_count(CPUARMState *env)
+{
+    uint64_t ret;
+    CPUState *cpu = ENV_GET_CPU(env);
+    uint32_t saved_can_do_io = cpu->can_do_io;
+    cpu->can_do_io = 1;
+
+    ret = (uint64_t)cpu_get_icount_raw();
+
+    cpu->can_do_io = saved_can_do_io;
+    return ret;
+}
+#endif
+
 #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
 static const pm_event pm_events[] = {
+#ifndef CONFIG_USER_ONLY
+    { .number = 0x008, /* INST_RETIRED */
+      .supported = instructions_supported,
+      .get_count = instructions_get_count
+    },
+    { .number = 0x011, /* CPU_CYCLES */
+      .supported = event_always_supported,
+      .get_count = cycles_get_count
+    },
+#endif
     { .number = SUPPORTED_EVENT_SENTINEL }
 };
 static uint16_t supported_event_map[0x3f];
@@ -982,8 +1032,6 @@ static CPAccessResult pmreg_access_swinc(CPUARMState *env,
     return pmreg_access(env, ri, isread);
 }
 
-#ifndef CONFIG_USER_ONLY
-
 static CPAccessResult pmreg_access_selr(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
@@ -1085,10 +1133,11 @@ void pmccntr_sync(CPUARMState *env)
 {
     if (arm_ccnt_enabled(env) &&
           !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
-        uint64_t temp_ticks;
+        uint64_t temp_ticks = 0;
 
-        temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                              ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+#ifndef CONFIG_USER_ONLY
+        temp_ticks = cycles_get_count(env);
+#endif
 
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
@@ -1181,18 +1230,6 @@ static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
     pmccntr_write(env, ri, deposit64(cur_val, 0, 32, value));
 }
 
-#else /* CONFIG_USER_ONLY */
-
-void pmccntr_sync(CPUARMState *env)
-{
-}
-
-void pmu_sync(CPUARMState *env)
-{
-}
-
-#endif
-
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1517,7 +1554,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* Unimplemented so WI. */
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
       .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NOP },
-#ifndef CONFIG_USER_ONLY
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
       .access = PL0_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
@@ -1537,7 +1573,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL0_RW, .accessfn = pmreg_access_ccntr,
       .type = ARM_CP_IO,
       .readfn = pmccntr_read, .writefn = pmccntr_write, },
-#endif
     { .name = "PMCCFILTR", .cp = 15, .opc1 = 0, .crn = 14, .crm = 15, .opc2 = 7,
       .writefn = pmccfiltr_write_a32, .readfn = pmccfiltr_read_a32,
       .access = PL0_RW, .accessfn = pmreg_access,
@@ -4877,7 +4912,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * field as main ID register, and we implement only the cycle
          * count register.
          */
-#ifndef CONFIG_USER_ONLY
         ARMCPRegInfo pmcr = {
             .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
             .access = PL0_RW,
@@ -4931,7 +4965,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             g_free(pmevtyper_name);
             g_free(pmevtyper_el0_name);
         }
-#endif
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.\nQualcomm Technologies, Inc. is a member of the\nCode Aurora Forum, a Linux Foundation Collaborative Project.
