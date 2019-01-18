Received: from eggs.gnu.org ([209.51.188.92]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVc0-0003Ls-2U
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbu-0007oz-8J
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbt-0007n1-1p
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:06 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m22so4811295wml.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:59:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.59.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:59:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:58:04 +0000
Message-Id: <20190118145805.6852-49-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/49] target/arm: Implement PMSWINC
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

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181211151945.29137-14-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44f1340ee13..92666e52085 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1027,6 +1027,15 @@ static bool event_always_supported(CPUARMState *env)
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
@@ -1054,6 +1063,10 @@ static uint64_t instructions_get_count(CPUARMState *env)
 #endif
 
 static const pm_event pm_events[] = {
+    { .number = 0x000, /* SW_INCR */
+      .supported = event_always_supported,
+      .get_count = swinc_get_count,
+    },
 #ifndef CONFIG_USER_ONLY
     { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
       .supported = instructions_supported,
@@ -1393,6 +1406,24 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -1822,9 +1853,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
2.20.1
