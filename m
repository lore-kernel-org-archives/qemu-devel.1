Received: from eggs.gnu.org ([209.51.188.92]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbn-00039x-Uw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbm-0007it-Of
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbm-0007hH-Fq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so4752117wmf.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:58:00 +0000
Message-Id: <20190118145805.6852-45-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/49] target/arm: Add array for supported PMU
 events, generate PMCEID[01]_EL0
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

This commit doesn't add any supported events, but provides the framework
for adding them. We store the pm_event structs in a simple array, and
provide the mapping from the event numbers to array indexes in the
supported_event_map array. Because the value of PMCEID[01] depends upon
which events are supported at runtime, generate it dynamically.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-10-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 10 ++++++++
 target/arm/cpu.c    | 19 +++++++++------
 target/arm/cpu64.c  |  4 ----
 target/arm/helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 34c7fceefb9..396abf4f6cd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1008,6 +1008,16 @@ void pmu_op_finish(CPUARMState *env);
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
 void pmu_post_el_change(ARMCPU *cpu, void *ignored);
 
+/*
+ * get_pmceid
+ * @env: CPUARMState
+ * @which: which PMCEID register to return (0 or 1)
+ *
+ * Return the PMCEID[01]_EL0 register values corresponding to the counters
+ * which are supported given the current configuration
+ */
+uint64_t get_pmceid(CPUARMState *env, unsigned which);
+
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
  * for both old and new bit meanings. Code which tests against those
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 317e10c895b..7e1f3dd637a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1037,10 +1037,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
+    }
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        cpu->pmceid0 = get_pmceid(&cpu->env, 0);
+        cpu->pmceid1 = get_pmceid(&cpu->env, 1);
+
+        if (!kvm_enabled()) {
+            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+        }
+    } else {
         cpu->id_aa64dfr0 &= ~0xf00;
-    } else if (!kvm_enabled()) {
-        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
-        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+        cpu->pmceid0 = 0;
+        cpu->pmceid1 = 0;
     }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
@@ -1685,8 +1694,6 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
     cpu->id_dfr0 = 0x02010555;
-    cpu->pmceid0 = 0x00000000;
-    cpu->pmceid1 = 0x00000000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10101105;
     cpu->id_mmfr1 = 0x40000000;
@@ -1732,8 +1739,6 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
     cpu->id_dfr0 = 0x02010555;
-    cpu->pmceid0 = 0x0000000;
-    cpu->pmceid1 = 0x00000000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10201105;
     cpu->id_mmfr1 = 0x20000000;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d0de0d5dcfa..e9bc461c362 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -138,8 +138,6 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar6 = 0;
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
-    cpu->pmceid0 = 0x00000000;
-    cpu->pmceid1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
@@ -246,8 +244,6 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
-    cpu->pmceid0 = 0x00000000;
-    cpu->pmceid1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5c00e0164cc..1dc267de46b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1009,6 +1009,63 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
   return (1 << 31) | ((1 << pmu_num_counters(env)) - 1);
 }
 
+typedef struct pm_event {
+    uint16_t number; /* PMEVTYPER.evtCount is 16 bits wide */
+    /* If the event is supported on this CPU (used to generate PMCEID[01]) */
+    bool (*supported)(CPUARMState *);
+    /*
+     * Retrieve the current count of the underlying event. The programmed
+     * counters hold a difference from the return value from this function
+     */
+    uint64_t (*get_count)(CPUARMState *);
+} pm_event;
+
+static const pm_event pm_events[] = {
+};
+
+/*
+ * Note: Before increasing MAX_EVENT_ID beyond 0x3f into the 0x40xx range of
+ * events (i.e. the statistical profiling extension), this implementation
+ * should first be updated to something sparse instead of the current
+ * supported_event_map[] array.
+ */
+#define MAX_EVENT_ID 0x0
+#define UNSUPPORTED_EVENT UINT16_MAX
+static uint16_t supported_event_map[MAX_EVENT_ID + 1];
+
+/*
+ * Called upon initialization to build PMCEID0_EL0 or PMCEID1_EL0 (indicated by
+ * 'which'). We also use it to build a map of ARM event numbers to indices in
+ * our pm_events array.
+ *
+ * Note: Events in the 0x40XX range are not currently supported.
+ */
+uint64_t get_pmceid(CPUARMState *env, unsigned which)
+{
+    uint64_t pmceid = 0;
+    unsigned int i;
+
+    assert(which <= 1);
+
+    for (i = 0; i < ARRAY_SIZE(supported_event_map); i++) {
+        supported_event_map[i] = UNSUPPORTED_EVENT;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(pm_events); i++) {
+        const pm_event *cnt = &pm_events[i];
+        assert(cnt->number <= MAX_EVENT_ID);
+        /* We do not currently support events in the 0x40xx range */
+        assert(cnt->number <= 0x3f);
+
+        if ((cnt->number & 0x20) == (which << 6) &&
+                cnt->supported(env)) {
+            pmceid |= (1 << (cnt->number & 0x1f));
+            supported_event_map[cnt->number] = i;
+        }
+    }
+    return pmceid;
+}
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
-- 
2.20.1
