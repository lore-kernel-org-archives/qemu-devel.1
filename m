Received: from eggs.gnu.org ([2001:4830:134:3::10]:60436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6fqx-00065q-BS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6fqv-00019r-FD
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:17:43 -0400
Date: Thu, 12 Apr 2018 13:17:28 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180412171728.GJ24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3] RFC: target/arm: Send interrupts on PMU
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
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Mar 16 16:30, Aaron Lindsay wrote:
> I aim to eventually add raising interrupts on counter overflow, but that is not
> covered by this patchset. I think I have a reasonable grasp of the mechanics of
> *how* to raise them, but am curious if anyone has thoughts on how to determine
> *when* to raise them - we don't want to call into PMU code every time an
> instruction is executed to check if any instruction counters have overflowed,
> etc. The main candidate I've seen for doing this so far would be to set up a
> QEMUTimer, but I haven't fully explored it. Does that seem plausible? Any
> other/better ideas?

I'm planning to post a full v4 of this patchset soon, pending a few
review fixes, but I figured I'd throw out an early version of a patch to
add interrupts on overflow in case it obviously has major issues that
will need to be addressed.

This patch sets up a QEMUTimer to get a callback when we expect counters
to next overflow and triggers an interrupt at that time.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c    |  11 +++++
 target/arm/cpu.h    |   7 +++
 target/arm/helper.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index df27188..9108c6b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -740,6 +740,12 @@ static void arm_cpu_finalizefn(Object *obj)
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
@@ -907,6 +913,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
         arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+
+#ifndef CONFIG_USER_ONLY
+        cpu->pmu_timer = timer_new(QEMU_CLOCK_VIRTUAL, 1, arm_pmu_timer_cb,
+                cpu);
+#endif
     } else {
         cpu->pmceid0 = 0x00000000;
         cpu->pmceid1 = 0x00000000;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5e6bbd3..bc0867f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -703,6 +703,8 @@ struct ARMCPU {
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
+    /* Timer used by the PMU */
+    QEMUTimer *pmu_timer;
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
@@ -934,6 +936,11 @@ void pmu_op_start(CPUARMState *env);
 void pmu_op_finish(CPUARMState *env);
 
 /**
+ * Called when a PMU counter is due to overflow
+ */
+void arm_pmu_timer_cb(void *opaque);
+
+/**
  * Functions to register as EL change hooks for PMU mode filtering
  */
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2147678..abe24dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -905,6 +905,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRLC  0x40
 #define PMCRD   0x8
 #define PMCRC   0x4
 #define PMCRP   0x2
@@ -919,6 +920,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMXEVTYPER_MT         0x02000000
 #define PMXEVTYPER_EVTCOUNT   0x000003ff
 
+#define PMEVCNTR_OVERFLOW_MASK ((uint64_t)1 << 31)
+
 #define PMCCFILTR             0xf8000000
 #define PMCCFILTR_M           PMXEVTYPER_M
 #define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
@@ -934,6 +937,11 @@ typedef struct pm_event {
     /* Retrieve the current count of the underlying event. The programmed
      * counters hold a difference from the return value from this function */
     uint64_t (*get_count)(CPUARMState *);
+    /* Return how many nanoseconds it will take (at a minimum) for count events
+     * to occur. A negative value indicates the counter will never overflow, or
+     * that the counter has otherwise arranged for the overflow bit to be set
+     * and the PMU interrupt to be raised on overflow. */
+    int64_t (*ns_per_count)(uint64_t);
 } pm_event;
 
 static bool event_always_supported(CPUARMState *env)
@@ -950,6 +958,11 @@ static uint64_t swinc_get_count(CPUARMState *env)
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
@@ -965,6 +978,11 @@ static uint64_t cycles_get_count(CPUARMState *env)
 }
 
 #ifndef CONFIG_USER_ONLY
+static int64_t cycles_ns_per(uint64_t cycles)
+{
+    return ARM_CPU_FREQ/NANOSECONDS_PER_SECOND;
+}
+
 static bool instructions_supported(CPUARMState *env)
 {
     return use_icount == 1 /* Precise instruction counting */;
@@ -974,22 +992,30 @@ static uint64_t instructions_get_count(CPUARMState *env)
 {
     return (uint64_t)cpu_get_icount_raw();
 }
+
+static int64_t instructions_ns_per(uint64_t icount)
+{
+    return cpu_icount_to_ns((int64_t)icount);
+}
 #endif
 
 #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
 static const pm_event pm_events[] = {
     { .number = 0x000, /* SW_INCR */
       .supported = event_always_supported,
-      .get_count = swinc_get_count
+      .get_count = swinc_get_count,
+      .ns_per_count = swinc_ns_per
     },
 #ifndef CONFIG_USER_ONLY
     { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
       .supported = instructions_supported,
-      .get_count = instructions_get_count
+      .get_count = instructions_get_count,
+      .ns_per_count = instructions_ns_per
     },
     { .number = 0x011, /* CPU_CYCLES, Cycle */
       .supported = event_always_supported,
-      .get_count = cycles_get_count
+      .get_count = cycles_get_count,
+      .ns_per_count = cycles_ns_per
     },
 #endif
     { .number = SUPPORTED_EVENT_SENTINEL }
@@ -1168,6 +1194,13 @@ static inline bool pmu_counter_filtered(CPUARMState *env, uint64_t pmxevtyper)
     return false;
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
@@ -1186,7 +1219,18 @@ void pmccntr_op_start(CPUARMState *env)
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
@@ -1200,13 +1244,25 @@ void pmccntr_op_finish(CPUARMState *env)
 {
     if (arm_ccnt_enabled(env) &&
           !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
-        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
+#ifndef CONFIG_USER_ONLY
+        uint64_t delta = ((env->cp15.c9_pmcr & PMCRLC) ?
+                UINT64_MAX : UINT32_MAX) - (uint32_t)env->cp15.c15_ccnt;
+        int64_t overflow_in = cycles_ns_per(delta);
 
+        if (overflow_in >= 0)
+        {
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
@@ -1220,8 +1276,16 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
 
     if (pmu_counter_enabled(env, counter) &&
             !pmu_counter_filtered(env, env->cp15.c14_pmevtyper[counter])) {
-        env->cp15.c14_pmevcntr[counter] =
-            count - env->cp15.c14_pmevcntr_delta[counter];
+
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
@@ -1230,6 +1294,21 @@ static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
 {
     if (pmu_counter_enabled(env, counter) &&
             !pmu_counter_filtered(env, env->cp15.c14_pmevtyper[counter])) {
+#ifndef CONFIG_USER_ONLY
+        uint16_t event = env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_EVTCOUNT;
+        uint16_t event_idx = supported_event_map[event];
+        uint64_t delta = UINT32_MAX - (uint32_t)env->cp15.c14_pmevcntr[counter];
+        int64_t overflow_in = pm_events[event_idx].ns_per_count(delta);
+
+        if (overflow_in >= 0)
+        {
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
@@ -1263,6 +1342,18 @@ void pmu_post_el_change(ARMCPU *cpu, void *ignored)
     pmu_op_finish(&cpu->env);
 }
 
+void arm_pmu_timer_cb(void *opaque) {
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
@@ -1300,7 +1391,21 @@ static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -1371,6 +1476,7 @@ static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmcnten |= value;
+    pmu_update_irq(env);
 }
 
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1378,6 +1484,7 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmcnten &= ~value;
+    pmu_update_irq(env);
 }
 
 static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1385,6 +1492,7 @@ static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmovsr &= ~value;
+    pmu_update_irq(env);
 }
 
 static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1392,6 +1500,7 @@ static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmovsr |= value;
+    pmu_update_irq(env);
 }
 
 static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1517,6 +1626,7 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* We have no event counters so only the C bit can be changed */
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pminten |= value;
+    pmu_update_irq(env);
 }
 
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1524,6 +1634,7 @@ static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pminten &= ~value;
+    pmu_update_irq(env);
 }
 
 static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
