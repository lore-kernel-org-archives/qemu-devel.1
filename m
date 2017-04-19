Received: from eggs.gnu.org ([2001:4830:134:3::10]:44174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tcC-0008NP-Hu
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tcB-0004Te-FT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:04 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Wed, 19 Apr 2017 13:41:22 -0400
Message-Id: <1492623684-25799-12-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 11/13] target/arm: PMU: Add instruction and
 cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mspradli@codeaurora.org, Aaron Lindsay <alindsay@codeaurora.org>

The instruction event is only enabled when icount is used, cycles are
always supported.

Note: Setting can_do_io=1 should not be done here. It is ugly and wrong,
but I am not sure of the proper way to handle this (See 'target/arm:
Filter cycle counter based on PMCCFILTR_EL0')

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66e576a..5972984 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14,6 +14,7 @@
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
@@ -901,8 +902,53 @@ typedef struct pm_event {
     uint64_t (*get_count)(CPUARMState *);
 } pm_event;
 
+static bool event_always_supported(CPUARMState *env)
+{
+    return true;
+}
+
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
+
 #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
 static const pm_event pm_events[] = {
+    { .number = 0x008, /* INST_RETIRED */
+      .supported = instructions_supported,
+      .get_count = instructions_get_count
+    },
+    { .number = 0x011, /* CPU_CYCLES */
+      .supported = event_always_supported,
+      .get_count = cycles_get_count
+    },
     { .number = SUPPORTED_EVENT_SENTINEL }
 };
 static uint16_t supported_event_map[0x3f];
@@ -1087,8 +1133,7 @@ void pmccntr_sync(CPUARMState *env)
           !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
         uint64_t temp_ticks;
 
-        temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                              ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+        temp_ticks = cycles_get_count(env);
 
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
