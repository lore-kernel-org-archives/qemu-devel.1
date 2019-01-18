Received: from eggs.gnu.org ([209.51.188.92]:43413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbr-0003A5-NL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbq-0007lG-NL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbq-0007ky-HP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so4752309wmf.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:59:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:58:02 +0000
Message-Id: <20190118145805.6852-47-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/49] target/arm: PMU: Add instruction and
 cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

The instruction event is only enabled when icount is used, cycles are
always supported. Always defining get_cycle_count (but altering its
behavior depending on CONFIG_USER_ONLY) allows us to remove some
CONFIG_USER_ONLY #defines throughout the rest of the code.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-12-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 90 ++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 168727242c8..35c105a8618 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -15,6 +15,7 @@
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
@@ -1021,7 +1022,48 @@ typedef struct pm_event {
     uint64_t (*get_count)(CPUARMState *);
 } pm_event;
 
+static bool event_always_supported(CPUARMState *env)
+{
+    return true;
+}
+
+/*
+ * Return the underlying cycle count for the PMU cycle counters. If we're in
+ * usermode, simply return 0.
+ */
+static uint64_t cycles_get_count(CPUARMState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+#else
+    return cpu_get_host_ticks();
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
+static bool instructions_supported(CPUARMState *env)
+{
+    return use_icount == 1 /* Precise instruction counting */;
+}
+
+static uint64_t instructions_get_count(CPUARMState *env)
+{
+    return (uint64_t)cpu_get_icount_raw();
+}
+#endif
+
 static const pm_event pm_events[] = {
+#ifndef CONFIG_USER_ONLY
+    { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
+      .supported = instructions_supported,
+      .get_count = instructions_get_count,
+    },
+    { .number = 0x011, /* CPU_CYCLES, Cycle */
+      .supported = event_always_supported,
+      .get_count = cycles_get_count,
+    }
+#endif
 };
 
 /*
@@ -1030,7 +1072,7 @@ static const pm_event pm_events[] = {
  * should first be updated to something sparse instead of the current
  * supported_event_map[] array.
  */
-#define MAX_EVENT_ID 0x0
+#define MAX_EVENT_ID 0x11
 #define UNSUPPORTED_EVENT UINT16_MAX
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
 
@@ -1131,8 +1173,6 @@ static CPAccessResult pmreg_access_swinc(CPUARMState *env,
     return pmreg_access(env, ri, isread);
 }
 
-#ifndef CONFIG_USER_ONLY
-
 static CPAccessResult pmreg_access_selr(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
@@ -1243,9 +1283,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
  */
 void pmccntr_op_start(CPUARMState *env)
 {
-    uint64_t cycles = 0;
-    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+    uint64_t cycles = cycles_get_count(env);
 
     if (pmu_counter_enabled(env, 31)) {
         uint64_t eff_cycles = cycles;
@@ -1391,42 +1429,6 @@ static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
     pmccntr_write(env, ri, deposit64(cur_val, 0, 32, value));
 }
 
-#else /* CONFIG_USER_ONLY */
-
-void pmccntr_op_start(CPUARMState *env)
-{
-}
-
-void pmccntr_op_finish(CPUARMState *env)
-{
-}
-
-void pmevcntr_op_start(CPUARMState *env, uint8_t i)
-{
-}
-
-void pmevcntr_op_finish(CPUARMState *env, uint8_t i)
-{
-}
-
-void pmu_op_start(CPUARMState *env)
-{
-}
-
-void pmu_op_finish(CPUARMState *env)
-{
-}
-
-void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
-{
-}
-
-void pmu_post_el_change(ARMCPU *cpu, void *ignored)
-{
-}
-
-#endif
-
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1823,7 +1825,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* Unimplemented so WI. */
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
       .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NOP },
-#ifndef CONFIG_USER_ONLY
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
       .access = PL0_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
@@ -1845,7 +1846,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c15_ccnt),
       .readfn = pmccntr_read, .writefn = pmccntr_write,
       .raw_readfn = raw_read, .raw_writefn = raw_write, },
-#endif
     { .name = "PMCCFILTR", .cp = 15, .opc1 = 0, .crn = 14, .crm = 15, .opc2 = 7,
       .writefn = pmccfiltr_write_a32, .readfn = pmccfiltr_read_a32,
       .access = PL0_RW, .accessfn = pmreg_access,
@@ -5675,7 +5675,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * count register.
          */
         unsigned int i, pmcrn = 0;
-#ifndef CONFIG_USER_ONLY
         ARMCPRegInfo pmcr = {
             .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
             .access = PL0_RW,
@@ -5732,7 +5731,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             g_free(pmevtyper_name);
             g_free(pmevtyper_el0_name);
         }
-#endif
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
-- 
2.20.1
