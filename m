Received: from eggs.gnu.org ([2001:4830:134:3::10]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjqY-0004XO-BU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjqU-0001sd-3O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:21:18 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 15:20:56 +0000
Message-ID: <20181211151945.29137-15-aaron@os.amperecomputing.com>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 14/14] target/arm: Send interrupts on PMU
 counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <alindsay@codeaurora.org>

Setup a QEMUTimer to get a callback when we expect counters to next
overflow and trigger an interrupt at that time.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/cpu.c    |  12 +++++
 target/arm/cpu.h    |   8 +++
 target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 208a08e867..85cec59fc9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -827,6 +827,13 @@ static void arm_cpu_finalizefn(Object *obj)
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
=20
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -1028,6 +1035,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
+
+#ifndef CONFIG_USER_ONLY
+        cpu->pmu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, arm_pmu_timer_=
cb,
+                cpu);
+#endif
     } else {
         cpu->id_aa64dfr0 &=3D ~0xf00;
         cpu->pmceid0 =3D 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a479625790..24821c8292 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -733,6 +733,9 @@ struct ARMCPU {
=20
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
+    /* Timer used by the PMU. Its state is restored after migration by
+     * pmu_op_finish() - it does not need other handling during migration =
*/
+    QEMUTimer *pmu_timer;
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
@@ -990,6 +993,11 @@ void pmccntr_op_finish(CPUARMState *env);
 void pmu_op_start(CPUARMState *env);
 void pmu_op_finish(CPUARMState *env);
=20
+/**
+ * Called when a PMU counter is due to overflow
+ */
+void arm_pmu_timer_cb(void *opaque);
+
 /**
  * Functions to register as EL change hooks for PMU mode filtering
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 881d49c662..2466f91995 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -977,6 +977,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRLC  0x40
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
@@ -996,6 +997,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
                                PMXEVTYPER_M | PMXEVTYPER_MT | \
                                PMXEVTYPER_EVTCOUNT)
=20
+#define PMEVCNTR_OVERFLOW_MASK ((uint64_t)1 << 31)
+
 #define PMCCFILTR             0xf8000000
 #define PMCCFILTR_M           PMXEVTYPER_M
 #define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
@@ -1020,6 +1023,11 @@ typedef struct pm_event {
      * counters hold a difference from the return value from this function
      */
     uint64_t (*get_count)(CPUARMState *);
+    /* Return how many nanoseconds it will take (at a minimum) for count e=
vents
+     * to occur. A negative value indicates the counter will never overflo=
w, or
+     * that the counter has otherwise arranged for the overflow bit to be =
set
+     * and the PMU interrupt to be raised on overflow. */
+    int64_t (*ns_per_count)(uint64_t);
 } pm_event;
=20
 static bool event_always_supported(CPUARMState *env)
@@ -1036,6 +1044,11 @@ static uint64_t swinc_get_count(CPUARMState *env)
     return 0;
 }
=20
+static int64_t swinc_ns_per(uint64_t ignored)
+{
+    return -1;
+}
+
 /*
  * Return the underlying cycle count for the PMU cycle counters. If we're =
in
  * usermode, simply return 0.
@@ -1051,6 +1064,11 @@ static uint64_t cycles_get_count(CPUARMState *env)
 }
=20
 #ifndef CONFIG_USER_ONLY
+static int64_t cycles_ns_per(uint64_t cycles)
+{
+    return (ARM_CPU_FREQ / NANOSECONDS_PER_SECOND) * cycles;
+}
+
 static bool instructions_supported(CPUARMState *env)
 {
     return use_icount =3D=3D 1 /* Precise instruction counting */;
@@ -1060,21 +1078,29 @@ static uint64_t instructions_get_count(CPUARMState =
*env)
 {
     return (uint64_t)cpu_get_icount_raw();
 }
+
+static int64_t instructions_ns_per(uint64_t icount)
+{
+    return cpu_icount_to_ns((int64_t)icount);
+}
 #endif
=20
 static const pm_event pm_events[] =3D {
     { .number =3D 0x000, /* SW_INCR */
       .supported =3D event_always_supported,
       .get_count =3D swinc_get_count,
+      .ns_per_count =3D swinc_ns_per,
     },
 #ifndef CONFIG_USER_ONLY
     { .number =3D 0x008, /* INST_RETIRED, Instruction architecturally exec=
uted */
       .supported =3D instructions_supported,
       .get_count =3D instructions_get_count,
+      .ns_per_count =3D instructions_ns_per,
     },
     { .number =3D 0x011, /* CPU_CYCLES, Cycle */
       .supported =3D event_always_supported,
       .get_count =3D cycles_get_count,
+      .ns_per_count =3D cycles_ns_per,
     }
 #endif
 };
@@ -1288,6 +1314,13 @@ static bool pmu_counter_enabled(CPUARMState *env, ui=
nt8_t counter)
     return enabled && !prohibited && !filtered;
 }
=20
+static void pmu_update_irq(CPUARMState *env)
+{
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
+    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
+            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+}
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself=
,
@@ -1305,7 +1338,19 @@ void pmccntr_op_start(CPUARMState *env)
             eff_cycles /=3D 64;
         }
=20
-        env->cp15.c15_ccnt =3D eff_cycles - env->cp15.c15_ccnt_delta;
+        uint64_t new_pmccntr =3D eff_cycles - env->cp15.c15_ccnt_delta;
+
+        unsigned int overflow_bit =3D (env->cp15.c9_pmcr & PMCRLC) ? 63 : =
31;
+        uint64_t overflow_mask =3D (uint64_t)1 << overflow_bit;
+        if (env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask) {
+            env->cp15.c9_pmovsr |=3D (1 << 31);
+            if (!(env->cp15.c9_pmcr & PMCRLC)) {
+                new_pmccntr &=3D 0xffffffff;
+            }
+            pmu_update_irq(env);
+        }
+
+        env->cp15.c15_ccnt =3D new_pmccntr;
     }
     env->cp15.c15_ccnt_delta =3D cycles;
 }
@@ -1318,13 +1363,27 @@ void pmccntr_op_start(CPUARMState *env)
 void pmccntr_op_finish(CPUARMState *env)
 {
     if (pmu_counter_enabled(env, 31)) {
-        uint64_t prev_cycles =3D env->cp15.c15_ccnt_delta;
+#ifndef CONFIG_USER_ONLY
+        /* Calculate when the counter will next overflow */
+        uint64_t delta =3D -env->cp15.c15_ccnt;
+        if (!(env->cp15.c9_pmcr & PMCRLC)) {
+            delta =3D (uint32_t)delta;
+        }
+        int64_t overflow_in =3D cycles_ns_per(delta);
+
+        if (overflow_in > 0) {
+            int64_t overflow_at =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) =
+
+                overflow_in;
+            ARMCPU *cpu =3D arm_env_get_cpu(env);
+            timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+        }
+#endif
=20
+        uint64_t prev_cycles =3D env->cp15.c15_ccnt_delta;
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
             prev_cycles /=3D 64;
         }
-
         env->cp15.c15_ccnt_delta =3D prev_cycles - env->cp15.c15_ccnt;
     }
 }
@@ -1340,8 +1399,15 @@ static void pmevcntr_op_start(CPUARMState *env, uint=
8_t counter)
     }
=20
     if (pmu_counter_enabled(env, counter)) {
-        env->cp15.c14_pmevcntr[counter] =3D
-            count - env->cp15.c14_pmevcntr_delta[counter];
+        uint64_t new_pmevcntr =3D count - env->cp15.c14_pmevcntr_delta[cou=
nter];
+
+        if (!(new_pmevcntr & PMEVCNTR_OVERFLOW_MASK) &&
+                (env->cp15.c14_pmevcntr[counter] & PMEVCNTR_OVERFLOW_MASK)=
) {
+            env->cp15.c9_pmovsr |=3D (1 << counter);
+            new_pmevcntr &=3D ~PMEVCNTR_OVERFLOW_MASK;
+            pmu_update_irq(env);
+        }
+        env->cp15.c14_pmevcntr[counter] =3D new_pmevcntr;
     }
     env->cp15.c14_pmevcntr_delta[counter] =3D count;
 }
@@ -1349,6 +1415,21 @@ static void pmevcntr_op_start(CPUARMState *env, uint=
8_t counter)
 static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
 {
     if (pmu_counter_enabled(env, counter)) {
+#ifndef CONFIG_USER_ONLY
+        uint16_t event =3D env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_E=
VTCOUNT;
+        uint16_t event_idx =3D supported_event_map[event];
+        uint64_t delta =3D UINT32_MAX -
+            (uint32_t)env->cp15.c14_pmevcntr[counter] + 1;
+        int64_t overflow_in =3D pm_events[event_idx].ns_per_count(delta);
+
+        if (overflow_in > 0) {
+            int64_t overflow_at =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) =
+
+                overflow_in;
+            ARMCPU *cpu =3D arm_env_get_cpu(env);
+            timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+        }
+#endif
+
         env->cp15.c14_pmevcntr_delta[counter] -=3D
             env->cp15.c14_pmevcntr[counter];
     }
@@ -1382,6 +1463,19 @@ void pmu_post_el_change(ARMCPU *cpu, void *ignored)
     pmu_op_finish(&cpu->env);
 }
=20
+void arm_pmu_timer_cb(void *opaque)
+{
+    ARMCPU *cpu =3D opaque;
+
+    /* Update all the counter values based on the current underlying count=
s,
+     * triggering interrupts to be raised, if necessary. pmu_op_finish() a=
lso
+     * has the effect of setting the cpu->pmu_timer to the next earliest t=
ime a
+     * counter may expire.
+     */
+    pmu_op_start(&cpu->env);
+    pmu_op_finish(&cpu->env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
@@ -1418,7 +1512,21 @@ static void pmswinc_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
                 /* counter is SW_INCR */
                 (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) =3D=3D =
0x0) {
             pmevcntr_op_start(env, i);
-            env->cp15.c14_pmevcntr[i]++;
+
+            /* Detect if this write causes an overflow since we can't pred=
ict
+             * PMSWINC overflows like we can for other events
+             */
+            uint64_t new_pmswinc =3D env->cp15.c14_pmevcntr[i] + 1;
+
+            if (!(new_pmswinc & PMEVCNTR_OVERFLOW_MASK) &&
+                    (env->cp15.c14_pmevcntr[i] & PMEVCNTR_OVERFLOW_MASK)) =
{
+                env->cp15.c9_pmovsr |=3D (1 << i);
+                new_pmswinc &=3D ~PMEVCNTR_OVERFLOW_MASK;
+                pmu_update_irq(env);
+            }
+
+            env->cp15.c14_pmevcntr[i] =3D new_pmswinc;
+
             pmevcntr_op_finish(env, i);
         }
     }
@@ -1489,6 +1597,7 @@ static void pmcntenset_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmcnten |=3D value;
+    pmu_update_irq(env);
 }
=20
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1496,6 +1605,7 @@ static void pmcntenclr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmcnten &=3D ~value;
+    pmu_update_irq(env);
 }
=20
 static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1503,6 +1613,7 @@ static void pmovsr_write(CPUARMState *env, const ARMC=
PRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmovsr &=3D ~value;
+    pmu_update_irq(env);
 }
=20
 static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1510,6 +1621,7 @@ static void pmovsset_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmovsr |=3D value;
+    pmu_update_irq(env);
 }
=20
 static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1696,6 +1808,7 @@ static void pmintenset_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
     /* We have no event counters so only the C bit can be changed */
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pminten |=3D value;
+    pmu_update_irq(env);
 }
=20
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1703,6 +1816,7 @@ static void pmintenclr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pminten &=3D ~value;
+    pmu_update_irq(env);
 }
=20
 static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
--=20
2.19.2
