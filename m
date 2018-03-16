Received: from eggs.gnu.org ([2001:4830:134:3::10]:44345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1Z-00060c-MP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1X-0003Um-QY
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:25 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:10 -0400
Message-Id: <1521232280-13089-13-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 12/22] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

The pmu_counter_filtered and pmu_op_start/finish functions are generic
(as opposed to PMCCNTR-specific) to allow for the implementation of
other events.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c    |  3 ++
 target/arm/cpu.h    | 37 +++++++++++++++++++----
 target/arm/helper.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a2cb21e..b0d032c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -887,6 +887,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
         cpu->id_aa64dfr0 &= ~0xf00;
+    } else {
+        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
     }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b0ef727..9c3b5ef 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -458,6 +458,11 @@ typedef struct CPUARMState {
          * was reset. Otherwise it stores the counter value
          */
         uint64_t c15_ccnt;
+        /* ccnt_cached_cycles is used to hold the last cycle count when
+         * c15_ccnt holds the guest-visible count instead of the delta during
+         * PMU operations which require this.
+         */
+        uint64_t ccnt_cached_cycles;
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
@@ -896,15 +901,35 @@ int cpu_arm_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 
 /**
- * pmccntr_sync
+ * pmccntr_op_start/finish
  * @env: CPUARMState
  *
- * Synchronises the counter in the PMCCNTR. This must always be called twice,
- * once before any action that might affect the timer and again afterwards.
- * The function is used to swap the state of the register if required.
- * This only happens when not in user mode (!CONFIG_USER_ONLY)
+ * Convert the counter in the PMCCNTR between its delta form (the typical mode
+ * when it's enabled) and the guest-visible value. These two calls must always
+ * surround any action which might affect the counter, and the return value
+ * from pmccntr_op_start must be supplied as the second argument to
+ * pmccntr_op_finish.
+ */
+uint64_t pmccntr_op_start(CPUARMState *env);
+void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles);
+
+/**
+ * pmu_op_start/finish
+ * @env: CPUARMState
+ *
+ * Convert all PMU counters between their delta form (the typical mode when
+ * they are enabled) and the guest-visible values. These two calls must
+ * surround any action which might affect the counters, and the return value
+ * from pmu_op_start must be supplied as the second argument to pmu_op_finish.
+ */
+uint64_t pmu_op_start(CPUARMState *env);
+void pmu_op_finish(CPUARMState *env, uint64_t prev_cycles);
+
+/**
+ * Functions to register as EL change hooks for PMU mode filtering
  */
-void pmccntr_sync(CPUARMState *env);
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
+void pmu_post_el_change(ARMCPU *cpu, void *ignored);
 
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0102357..95b09d6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -908,6 +908,15 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRC   0x4
 #define PMCRE   0x1
 
+#define PMXEVTYPER_P          0x80000000
+#define PMXEVTYPER_U          0x40000000
+#define PMXEVTYPER_NSK        0x20000000
+#define PMXEVTYPER_NSU        0x10000000
+#define PMXEVTYPER_NSH        0x08000000
+#define PMXEVTYPER_M          0x04000000
+#define PMXEVTYPER_MT         0x02000000
+#define PMXEVTYPER_EVTCOUNT   0x000003ff
+
 #define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT)
 /* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
 #define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
@@ -998,7 +1007,7 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
 
 static inline bool arm_ccnt_enabled(CPUARMState *env)
 {
-    /* This does not support checking PMCCFILTR_EL0 register */
+    /* Does not check PMCCFILTR_EL0, which is handled by pmu_counter_filtered */
 
     if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
         return false;
@@ -1006,6 +1015,44 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 
     return true;
 }
+
+/* Returns true if the counter corresponding to the passed-in pmevtyper or
+ * pmccfiltr value is filtered using the current state */
+static inline bool pmu_counter_filtered(CPUARMState *env, uint64_t pmxevtyper)
+{
+    bool secure = arm_is_secure(env);
+    int el = arm_current_el(env);
+
+    bool P   = pmxevtyper & PMXEVTYPER_P;
+    bool U   = pmxevtyper & PMXEVTYPER_U;
+    bool NSK = pmxevtyper & PMXEVTYPER_NSK;
+    bool NSU = pmxevtyper & PMXEVTYPER_NSU;
+    bool NSH = pmxevtyper & PMXEVTYPER_NSH;
+    bool M   = pmxevtyper & PMXEVTYPER_M;
+
+    if (el == 1 && P) {
+        return true;
+    } else if (el == 0 && U) {
+        return true;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        if (el == 1 && !secure && NSK != P) {
+            return true;
+        } else if (el == 0 && !secure && NSU != U) {
+            return true;
+        } else if (el == 3 && secure && M != P) {
+            return true;
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL2) && el == 2 && !secure && !NSH) {
+        return true;
+    }
+
+    return false;
+}
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself,
@@ -1023,7 +1070,8 @@ uint64_t pmccntr_op_start(CPUARMState *env)
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
 #endif
 
-    if (arm_ccnt_enabled(env)) {
+    if (arm_ccnt_enabled(env) &&
+          !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
 
         uint64_t eff_cycles = cycles;
         if (env->cp15.c9_pmcr & PMCRD) {
@@ -1043,7 +1091,8 @@ uint64_t pmccntr_op_start(CPUARMState *env)
  */
 void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
 {
-    if (arm_ccnt_enabled(env)) {
+    if (arm_ccnt_enabled(env) &&
+          !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
 
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
@@ -1054,10 +1103,30 @@ void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
     }
 }
 
+uint64_t pmu_op_start(CPUARMState *env)
+{
+    return pmccntr_op_start(env);
+}
+
+void pmu_op_finish(CPUARMState *env, uint64_t prev_cycles)
+{
+    pmccntr_op_finish(env, prev_cycles);
+}
+
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
+{
+    cpu->env.cp15.ccnt_cached_cycles = pmu_op_start(&cpu->env);
+}
+
+void pmu_post_el_change(ARMCPU *cpu, void *ignored)
+{
+    pmu_op_finish(&cpu->env, cpu->env.cp15.ccnt_cached_cycles);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    uint64_t saved_cycles = pmccntr_op_start(env);
+    uint64_t saved_cycles = pmu_op_start(env);
 
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1068,7 +1137,7 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
 
-    pmccntr_op_finish(env, saved_cycles);
+    pmu_op_finish(env, saved_cycles);
 }
 
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -1117,6 +1186,14 @@ void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
 {
 }
 
+uint64_t pmu_op_start(CPUARMState *env)
+{
+}
+
+void pmu_op_finish(CPUARMState *env, uint64_t prev_cycles)
+{
+}
+
 #endif
 
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
