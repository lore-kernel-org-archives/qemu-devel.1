Received: from eggs.gnu.org ([209.51.188.92]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMI-0008JZ-7F
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003lI-QB
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003cd-Cs
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id t6so7610184wrr.12
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:42 +0000
Message-Id: <20190201160653.13829-37-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/47] target/arm: Add a timer to predict PMU
 counter overflow
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

Make PMU overflow interrupts more accurate by using a timer to predict
when they will overflow rather than waiting for an event to occur which
allows us to otherwise check them.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190124162401.5111-3-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 10 +++++++
 target/arm/cpu.c    | 12 ++++++++
 target/arm/helper.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b8161cb6d73..63934a200ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -746,6 +746,11 @@ struct ARMCPU {
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
+    /*
+     * Timer used by the PMU. Its state is restored after migration by
+     * pmu_op_finish() - it does not need other handling during migration
+     */
+    QEMUTimer *pmu_timer;
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
@@ -1005,6 +1010,11 @@ void pmccntr_op_finish(CPUARMState *env);
 void pmu_op_start(CPUARMState *env);
 void pmu_op_finish(CPUARMState *env);
 
+/*
+ * Called when a PMU counter is due to overflow
+ */
+void arm_pmu_timer_cb(void *opaque);
+
 /**
  * Functions to register as EL change hooks for PMU mode filtering
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d6da3f4fed3..8a9cd0900d2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -836,6 +836,13 @@ static void arm_cpu_finalizefn(Object *obj)
         QLIST_REMOVE(hook, node);
         g_free(hook);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu->pmu_timer) {
+        timer_del(cpu->pmu_timer);
+        timer_deinit(cpu->pmu_timer);
+        timer_free(cpu->pmu_timer);
+    }
+#endif
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -1045,6 +1052,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
+
+#ifndef CONFIG_USER_ONLY
+        cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, arm_pmu_timer_cb,
+                cpu);
+#endif
     } else {
         cpu->id_aa64dfr0 &= ~0xf00;
         cpu->pmceid0 = 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c27e349dd05..e6f69180ba0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1021,6 +1021,13 @@ typedef struct pm_event {
      * counters hold a difference from the return value from this function
      */
     uint64_t (*get_count)(CPUARMState *);
+    /*
+     * Return how many nanoseconds it will take (at a minimum) for count events
+     * to occur. A negative value indicates the counter will never overflow, or
+     * that the counter has otherwise arranged for the overflow bit to be set
+     * and the PMU interrupt to be raised on overflow.
+     */
+    int64_t (*ns_per_count)(uint64_t);
 } pm_event;
 
 static bool event_always_supported(CPUARMState *env)
@@ -1037,6 +1044,11 @@ static uint64_t swinc_get_count(CPUARMState *env)
     return 0;
 }
 
+static int64_t swinc_ns_per(uint64_t ignored)
+{
+    return -1;
+}
+
 /*
  * Return the underlying cycle count for the PMU cycle counters. If we're in
  * usermode, simply return 0.
@@ -1052,6 +1064,11 @@ static uint64_t cycles_get_count(CPUARMState *env)
 }
 
 #ifndef CONFIG_USER_ONLY
+static int64_t cycles_ns_per(uint64_t cycles)
+{
+    return (ARM_CPU_FREQ / NANOSECONDS_PER_SECOND) * cycles;
+}
+
 static bool instructions_supported(CPUARMState *env)
 {
     return use_icount == 1 /* Precise instruction counting */;
@@ -1061,21 +1078,29 @@ static uint64_t instructions_get_count(CPUARMState *env)
 {
     return (uint64_t)cpu_get_icount_raw();
 }
+
+static int64_t instructions_ns_per(uint64_t icount)
+{
+    return cpu_icount_to_ns((int64_t)icount);
+}
 #endif
 
 static const pm_event pm_events[] = {
     { .number = 0x000, /* SW_INCR */
       .supported = event_always_supported,
       .get_count = swinc_get_count,
+      .ns_per_count = swinc_ns_per,
     },
 #ifndef CONFIG_USER_ONLY
     { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
       .supported = instructions_supported,
       .get_count = instructions_get_count,
+      .ns_per_count = instructions_ns_per,
     },
     { .number = 0x011, /* CPU_CYCLES, Cycle */
       .supported = event_always_supported,
       .get_count = cycles_get_count,
+      .ns_per_count = cycles_ns_per,
     }
 #endif
 };
@@ -1340,13 +1365,27 @@ void pmccntr_op_start(CPUARMState *env)
 void pmccntr_op_finish(CPUARMState *env)
 {
     if (pmu_counter_enabled(env, 31)) {
-        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
+#ifndef CONFIG_USER_ONLY
+        /* Calculate when the counter will next overflow */
+        uint64_t remaining_cycles = -env->cp15.c15_ccnt;
+        if (!(env->cp15.c9_pmcr & PMCRLC)) {
+            remaining_cycles = (uint32_t)remaining_cycles;
+        }
+        int64_t overflow_in = cycles_ns_per(remaining_cycles);
 
+        if (overflow_in > 0) {
+            int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                overflow_in;
+            ARMCPU *cpu = arm_env_get_cpu(env);
+            timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+        }
+#endif
+
+        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
             prev_cycles /= 64;
         }
-
         env->cp15.c15_ccnt_delta = prev_cycles - env->cp15.c15_ccnt;
     }
 }
@@ -1376,6 +1415,21 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
 static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
 {
     if (pmu_counter_enabled(env, counter)) {
+#ifndef CONFIG_USER_ONLY
+        uint16_t event = env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_EVTCOUNT;
+        uint16_t event_idx = supported_event_map[event];
+        uint64_t delta = UINT32_MAX -
+            (uint32_t)env->cp15.c14_pmevcntr[counter] + 1;
+        int64_t overflow_in = pm_events[event_idx].ns_per_count(delta);
+
+        if (overflow_in > 0) {
+            int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                overflow_in;
+            ARMCPU *cpu = arm_env_get_cpu(env);
+            timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+        }
+#endif
+
         env->cp15.c14_pmevcntr_delta[counter] -=
             env->cp15.c14_pmevcntr[counter];
     }
@@ -1409,6 +1463,20 @@ void pmu_post_el_change(ARMCPU *cpu, void *ignored)
     pmu_op_finish(&cpu->env);
 }
 
+void arm_pmu_timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    /*
+     * Update all the counter values based on the current underlying counts,
+     * triggering interrupts to be raised, if necessary. pmu_op_finish() also
+     * has the effect of setting the cpu->pmu_timer to the next earliest time a
+     * counter may expire.
+     */
+    pmu_op_start(&cpu->env);
+    pmu_op_finish(&cpu->env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-- 
2.20.1
