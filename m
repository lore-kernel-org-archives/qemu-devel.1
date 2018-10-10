Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFk-0002z9-Ln
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFj-0002lJ-5p
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:44 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Date: Wed, 10 Oct 2018 16:37:35 -0400
Message-Id: <20181010203735.27918-15-aclindsa@gmail.com>
In-Reply-To: <20181010203735.27918-1-aclindsa@gmail.com>
References: <20181010203735.27918-1-aclindsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 14/14] target/arm: Send interrupts on PMU
 counter overflow
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

Setup a QEMUTimer to get a callback when we expect counters to next
overflow and trigger an interrupt at that time.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c    |  11 ++++
 target/arm/cpu.h    |   7 +++
 target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7f39f25f51..c89c7c776c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -764,6 +764,12 @@ static void arm_cpu_finalizefn(Object *obj)
         QLIST_REMOVE(hook, node);
         g_free(hook);
     }
+#ifndef CONFIG_USER_ONLY
+    if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
+        timer_deinit(cpu->pmu_timer);
+        timer_free(cpu->pmu_timer);
+    }
+#endif
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -958,6 +964,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
+
+#ifndef CONFIG_USER_ONLY
+        cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, arm_pmu_timer_cb,
+                cpu);
+#endif
     } else {
         cpu->pmceid0 = 0x00000000;
         cpu->pmceid1 = 0x00000000;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f4317f87c9..a27481658c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -721,6 +721,8 @@ struct ARMCPU {
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
+    /* Timer used by the PMU */
+    QEMUTimer *pmu_timer;
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
@@ -972,6 +974,11 @@ void pmccntr_op_finish(CPUARMState *env);
 void pmu_op_start(CPUARMState *env);
 void pmu_op_finish(CPUARMState *env);
 
+/**
+ * Called when a PMU counter is due to overflow
+ */
+void arm_pmu_timer_cb(void *opaque);
+
 /**
  * Functions to register as EL change hooks for PMU mode filtering
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6c2a899009..9699e43f0c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -944,6 +944,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRLC  0x40
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
@@ -963,6 +964,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
                                PMXEVTYPER_M | PMXEVTYPER_MT | \
                                PMXEVTYPER_EVTCOUNT)
 
+#define PMEVCNTR_OVERFLOW_MASK ((uint64_t)1 << 31)
+
 #define PMCCFILTR             0xf8000000
 #define PMCCFILTR_M           PMXEVTYPER_M
 #define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
@@ -987,6 +990,11 @@ typedef struct pm_event {
      * counters hold a difference from the return value from this function
      */
     uint64_t (*get_count)(CPUARMState *);
+    /* Return how many nanoseconds it will take (at a minimum) for count events
+     * to occur. A negative value indicates the counter will never overflow, or
+     * that the counter has otherwise arranged for the overflow bit to be set
+     * and the PMU interrupt to be raised on overflow. */
+    int64_t (*ns_per_count)(uint64_t);
 } pm_event;
 
 static bool event_always_supported(CPUARMState *env)
@@ -1003,6 +1011,11 @@ static uint64_t swinc_get_count(CPUARMState *env)
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
@@ -1018,6 +1031,11 @@ static uint64_t cycles_get_count(CPUARMState *env)
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
@@ -1027,21 +1045,29 @@ static uint64_t instructions_get_count(CPUARMState *env)
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
@@ -1240,6 +1266,13 @@ static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
     return enabled && !prohibited && !filtered;
 }
 
+static void pmu_update_irq(CPUARMState *env)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
+            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+}
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself,
@@ -1257,7 +1290,18 @@ void pmccntr_op_start(CPUARMState *env)
             eff_cycles /= 64;
         }
 
-        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt_delta;
+        uint64_t new_pmccntr = eff_cycles - env->cp15.c15_ccnt_delta;
+
+        unsigned int overflow_bit = (env->cp15.c9_pmcr & PMCRLC) ? 63 : 31;
+        uint64_t overflow_mask = (uint64_t)1 << overflow_bit;
+        if (!(new_pmccntr & overflow_mask) &&
+                (env->cp15.c15_ccnt & overflow_mask)) {
+            env->cp15.c9_pmovsr |= (1 << 31);
+            new_pmccntr &= ~overflow_mask;
+            pmu_update_irq(env);
+        }
+
+        env->cp15.c15_ccnt = new_pmccntr;
     }
     env->cp15.c15_ccnt_delta = cycles;
 }
@@ -1270,13 +1314,28 @@ void pmccntr_op_start(CPUARMState *env)
 void pmccntr_op_finish(CPUARMState *env)
 {
     if (pmu_counter_enabled(env, 31)) {
-        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
+#ifndef CONFIG_USER_ONLY
+        uint64_t delta;
+        if (env->cp15.c9_pmcr & PMCRLC) {
+            delta = UINT64_MAX - env->cp15.c15_ccnt + 1;
+        } else {
+            delta = UINT32_MAX - (uint32_t)env->cp15.c15_ccnt + 1;
+        }
+        int64_t overflow_in = cycles_ns_per(delta);
+
+        if (overflow_in > 0) {
+            int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                overflow_in;
+            ARMCPU *cpu = arm_env_get_cpu(env);
+            timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+        }
+#endif
 
+        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
             prev_cycles /= 64;
         }
-
         env->cp15.c15_ccnt_delta = prev_cycles - env->cp15.c15_ccnt;
     }
 }
@@ -1292,8 +1351,15 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
     }
 
     if (pmu_counter_enabled(env, counter)) {
-        env->cp15.c14_pmevcntr[counter] =
-            count - env->cp15.c14_pmevcntr_delta[counter];
+        uint64_t new_pmevcntr = count - env->cp15.c14_pmevcntr_delta[counter];
+
+        if (!(new_pmevcntr & PMEVCNTR_OVERFLOW_MASK) &&
+                (env->cp15.c14_pmevcntr[counter] & PMEVCNTR_OVERFLOW_MASK)) {
+            env->cp15.c9_pmovsr |= (1 << counter);
+            new_pmevcntr &= ~PMEVCNTR_OVERFLOW_MASK;
+            pmu_update_irq(env);
+        }
+        env->cp15.c14_pmevcntr[counter] = new_pmevcntr;
     }
     env->cp15.c14_pmevcntr_delta[counter] = count;
 }
@@ -1301,6 +1367,21 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
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
@@ -1334,6 +1415,19 @@ void pmu_post_el_change(ARMCPU *cpu, void *ignored)
     pmu_op_finish(&cpu->env);
 }
 
+void arm_pmu_timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    /* Update all the counter values based on the current underlying counts,
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
@@ -1370,7 +1464,21 @@ static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
                 /* counter is SW_INCR */
                 (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) == 0x0) {
             pmevcntr_op_start(env, i);
-            env->cp15.c14_pmevcntr[i]++;
+
+            /* Detect if this write causes an overflow since we can't predict
+             * PMSWINC overflows like we can for other events
+             */
+            uint64_t new_pmswinc = env->cp15.c14_pmevcntr[i] + 1;
+
+            if (!(new_pmswinc & PMEVCNTR_OVERFLOW_MASK) &&
+                    (env->cp15.c14_pmevcntr[i] & PMEVCNTR_OVERFLOW_MASK)) {
+                env->cp15.c9_pmovsr |= (1 << i);
+                new_pmswinc &= ~PMEVCNTR_OVERFLOW_MASK;
+                pmu_update_irq(env);
+            }
+
+            env->cp15.c14_pmevcntr[i] = new_pmswinc;
+
             pmevcntr_op_finish(env, i);
         }
     }
@@ -1441,6 +1549,7 @@ static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmcnten |= value;
+    pmu_update_irq(env);
 }
 
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1448,6 +1557,7 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmcnten &= ~value;
+    pmu_update_irq(env);
 }
 
 static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1455,6 +1565,7 @@ static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmovsr &= ~value;
+    pmu_update_irq(env);
 }
 
 static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1462,6 +1573,7 @@ static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmovsr |= value;
+    pmu_update_irq(env);
 }
 
 static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1648,6 +1760,7 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* We have no event counters so only the C bit can be changed */
     value &= pmu_counter_mask(env);
     env->cp15.c9_pminten |= value;
+    pmu_update_irq(env);
 }
 
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1655,6 +1768,7 @@ static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pminten &= ~value;
+    pmu_update_irq(env);
 }
 
 static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.19.1
