Received: from eggs.gnu.org ([209.51.188.92]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNA-0002g8-9O
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN8-0008PY-Py
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:04 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN8-0008NJ-I4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:02 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so15036222wml.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:30 +0000
Message-Id: <20190128181047.20781-10-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/26] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay OS <aaron@os.amperecomputing.com>

A bug was introduced during a respin of:

	commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
	target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0

This patch introduced two calls to get_pmceid() during CPU
initialization - one each for PMCEID0 and PMCEID1. In addition to
building the register values, get_pmceid() clears an internal array
mapping event numbers to their implementations (supported_event_map)
before rebuilding it. This is an optimization since much of the logic is
shared. However, since it was called twice, the contents of
supported_event_map reflect only the events in PMCEID1 (the second call
to get_pmceid()).

Fix this bug by moving the initialization of PMCEID0 and PMCEID1 back
into a single function call, and name it more appropriately since it is
doing more than simply generating the contents of the PMCEID[01]
registers.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190123195814.29253-1-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 11 +++++------
 target/arm/cpu.c    |  3 +--
 target/arm/helper.c | 27 ++++++++++++++++-----------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff81db420d5..b8161cb6d73 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1012,14 +1012,13 @@ void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
 void pmu_post_el_change(ARMCPU *cpu, void *ignored);
 
 /*
- * get_pmceid
- * @env: CPUARMState
- * @which: which PMCEID register to return (0 or 1)
+ * pmu_init
+ * @cpu: ARMCPU
  *
- * Return the PMCEID[01]_EL0 register values corresponding to the counters
- * which are supported given the current configuration
+ * Initialize the CPU's PMCEID[01]_EL0 registers and associated internal state
+ * for the current configuration
  */
-uint64_t get_pmceid(CPUARMState *env, unsigned which);
+void pmu_init(ARMCPU *cpu);
 
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e1f3dd637a..d6da3f4fed3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1039,8 +1039,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         unset_feature(env, ARM_FEATURE_PMU);
     }
     if (arm_feature(env, ARM_FEATURE_PMU)) {
-        cpu->pmceid0 = get_pmceid(&cpu->env, 0);
-        cpu->pmceid1 = get_pmceid(&cpu->env, 1);
+        pmu_init(cpu);
 
         if (!kvm_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 676059cb386..66faebea8ec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1090,22 +1090,24 @@ static const pm_event pm_events[] = {
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
 
 /*
- * Called upon initialization to build PMCEID0_EL0 or PMCEID1_EL0 (indicated by
- * 'which'). We also use it to build a map of ARM event numbers to indices in
- * our pm_events array.
+ * Called upon CPU initialization to initialize PMCEID[01]_EL0 and build a map
+ * of ARM event numbers to indices in our pm_events array.
  *
  * Note: Events in the 0x40XX range are not currently supported.
  */
-uint64_t get_pmceid(CPUARMState *env, unsigned which)
+void pmu_init(ARMCPU *cpu)
 {
-    uint64_t pmceid = 0;
     unsigned int i;
 
-    assert(which <= 1);
-
+    /*
+     * Empty supported_event_map and cpu->pmceid[01] before adding supported
+     * events to them
+     */
     for (i = 0; i < ARRAY_SIZE(supported_event_map); i++) {
         supported_event_map[i] = UNSUPPORTED_EVENT;
     }
+    cpu->pmceid0 = 0;
+    cpu->pmceid1 = 0;
 
     for (i = 0; i < ARRAY_SIZE(pm_events); i++) {
         const pm_event *cnt = &pm_events[i];
@@ -1113,13 +1115,16 @@ uint64_t get_pmceid(CPUARMState *env, unsigned which)
         /* We do not currently support events in the 0x40xx range */
         assert(cnt->number <= 0x3f);
 
-        if ((cnt->number & 0x20) == (which << 6) &&
-                cnt->supported(env)) {
-            pmceid |= (1 << (cnt->number & 0x1f));
+        if (cnt->supported(&cpu->env)) {
             supported_event_map[cnt->number] = i;
+            uint64_t event_mask = 1 << (cnt->number & 0x1f);
+            if (cnt->number & 0x20) {
+                cpu->pmceid1 |= event_mask;
+            } else {
+                cpu->pmceid0 |= event_mask;
+            }
         }
     }
-    return pmceid;
 }
 
 /*
-- 
2.20.1
