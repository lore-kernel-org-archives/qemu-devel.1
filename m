Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjb-00027O-US
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSja-0005Qk-Fx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:43 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:16 -0400
Message-Id: <1529699547-17044-3-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 02/13] target/arm: Filter cycle counter
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
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

The pmu_counter_enabled and pmu_op_start/finish functions are generic
(as opposed to PMCCNTR-specific) to allow for the implementation of
other events.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c    |   3 ++
 target/arm/cpu.h    |  22 +++++++++-
 target/arm/helper.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 129 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e1de45e..08ce1bc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -916,6 +916,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
         cpu->id_aa64dfr0 &= ~0xf00;
+    } else if (!kvm_enabled()) {
+        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
     }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ba2c876..800c4ec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -946,6 +946,24 @@ int cpu_arm_signal_handler(int host_signum, void *pinfo,
 void pmccntr_op_start(CPUARMState *env);
 void pmccntr_op_finish(CPUARMState *env);
 
+/**
+ * pmu_op_start/finish
+ * @env: CPUARMState
+ *
+ * Convert all PMU counters between their delta form (the typical mode when
+ * they are enabled) and the guest-visible values. These two calls must
+ * surround any action which might affect the counters, and the return value
+ * from pmu_op_start must be supplied as the second argument to pmu_op_finish.
+ */
+void pmu_op_start(CPUARMState *env);
+void pmu_op_finish(CPUARMState *env);
+
+/**
+ * Functions to register as EL change hooks for PMU mode filtering
+ */
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
+void pmu_post_el_change(ARMCPU *cpu, void *ignored);
+
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
  * for both old and new bit meanings. Code which tests against those
@@ -1007,7 +1025,8 @@ void pmccntr_op_finish(CPUARMState *env);
 
 #define MDCR_EPMAD    (1U << 21)
 #define MDCR_EDAD     (1U << 20)
-#define MDCR_SPME     (1U << 17)
+#define MDCR_SPME     (1U << 17)  /* MDCR_EL3 */
+#define MDCR_HPMD     (1U << 17)  /* MDCR_EL2 */
 #define MDCR_SDD      (1U << 16)
 #define MDCR_SPD      (3U << 14)
 #define MDCR_TDRA     (1U << 11)
@@ -1017,6 +1036,7 @@ void pmccntr_op_finish(CPUARMState *env);
 #define MDCR_HPME     (1U << 7)
 #define MDCR_TPM      (1U << 6)
 #define MDCR_TPMCR    (1U << 5)
+#define MDCR_HPMN     (0x1fU)
 
 /* Not all of the MDCR_EL3 bits are present in the 32-bit SDCR */
 #define SDCR_VALID_MASK (MDCR_EPMAD | MDCR_EDAD | MDCR_SPME | MDCR_SPD)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 23b3a16..7c66977 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -935,10 +935,20 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRDP  0x10
 #define PMCRD   0x8
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
 static inline uint32_t pmu_num_counters(CPUARMState *env)
 {
   return (env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT;
@@ -1034,16 +1044,66 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
     return pmreg_access(env, ri, isread);
 }
 
-static inline bool arm_ccnt_enabled(CPUARMState *env)
+/* Returns true if the counter (pass 31 for PMCCNTR) should count events using
+ * the current EL, security state, and register configuration.
+ */
+static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 {
-    /* This does not support checking PMCCFILTR_EL0 register */
+    uint64_t filter;
+    bool e, p, u, nsk, nsu, nsh, m;
+    bool enabled, prohibited, filtered;
+    bool secure = arm_is_secure(env);
+    int el = arm_current_el(env);
+    uint8_t hpmn = env->cp15.mdcr_el2 & MDCR_HPMN;
 
-    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
-        return false;
+    if (!arm_feature(env, ARM_FEATURE_EL2) ||
+            (counter < hpmn || counter == 31)) {
+        e = env->cp15.c9_pmcr & PMCRE;
+    } else {
+        e = env->cp15.mdcr_el2 & MDCR_HPME;
+    }
+    enabled = e && (env->cp15.c9_pmcnten & (1 << counter));
+
+    if (!secure) {
+        if (el == 2 && (counter < hpmn || counter == 31)) {
+            prohibited = env->cp15.mdcr_el2 & MDCR_HPMD;
+        } else {
+            prohibited = false;
+        }
+    } else {
+        prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
+           (env->cp15.mdcr_el3 & MDCR_SPME);
     }
 
-    return true;
+    if (prohibited && counter == 31) {
+        prohibited = env->cp15.c9_pmcr & PMCRDP;
+    }
+
+    /* TODO Remove assert, set filter to correct PMEVTYPER */
+    assert(counter == 31);
+    filter = env->cp15.pmccfiltr_el0;
+
+    p   = filter & PMXEVTYPER_P;
+    u   = filter & PMXEVTYPER_U;
+    nsk = arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSK);
+    nsu = arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSU);
+    nsh = arm_feature(env, ARM_FEATURE_EL2) && (filter & PMXEVTYPER_NSH);
+    m   = arm_el_is_aa64(env, 1) &&
+              arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_M);
+
+    if (el == 0) {
+        filtered = secure ? u : u != nsu;
+    } else if (el == 1) {
+        filtered = secure ? p : p != nsk;
+    } else if (el == 2) {
+        filtered = !nsh;
+    } else { /* EL3 */
+        filtered = m != p;
+    }
+
+    return enabled && !prohibited && !filtered;
 }
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself,
@@ -1056,7 +1116,7 @@ void pmccntr_op_start(CPUARMState *env)
     cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
 
-    if (arm_ccnt_enabled(env)) {
+    if (pmu_counter_enabled(env, 31)) {
         uint64_t eff_cycles = cycles;
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
@@ -1075,7 +1135,7 @@ void pmccntr_op_start(CPUARMState *env)
  */
 void pmccntr_op_finish(CPUARMState *env)
 {
-    if (arm_ccnt_enabled(env)) {
+    if (pmu_counter_enabled(env, 31)) {
         uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
 
         if (env->cp15.c9_pmcr & PMCRD) {
@@ -1087,10 +1147,30 @@ void pmccntr_op_finish(CPUARMState *env)
     }
 }
 
+void pmu_op_start(CPUARMState *env)
+{
+    pmccntr_op_start(env);
+}
+
+void pmu_op_finish(CPUARMState *env)
+{
+    pmccntr_op_finish(env);
+}
+
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
+{
+    pmu_op_start(&cpu->env);
+}
+
+void pmu_post_el_change(ARMCPU *cpu, void *ignored)
+{
+    pmu_op_finish(&cpu->env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    pmccntr_op_start(env);
+    pmu_op_start(env);
 
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1101,7 +1181,7 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
 
-    pmccntr_op_finish(env);
+    pmu_op_finish(env);
 }
 
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -1150,6 +1230,22 @@ void pmccntr_op_finish(CPUARMState *env)
 {
 }
 
+void pmu_op_start(CPUARMState *env)
+{
+}
+
+void pmu_op_finish(CPUARMState *env)
+{
+}
+
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
+{
+}
+
+void pmu_post_el_change(ARMCPU *cpu, void *ignored)
+{
+}
+
 #endif
 
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
