Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjk-0002JR-Qk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSji-0005Vl-VM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:52 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:22 -0400
Message-Id: <1529699547-17044-9-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 08/13] target/arm: Finish implementation of
 PM[X]EVCNTR and PM[X]EVTYPER
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

Add arrays to hold the registers, the definitions themselves, access
functions, and logic to reset counters when PMCR.P is set. Update
filtering code to support counters other than PMCCNTR.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.h    |   3 +
 target/arm/helper.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 209 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 430b8d5..c240b38 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -481,6 +481,9 @@ typedef struct CPUARMState {
          * pmccntr_op_finish.
          */
         uint64_t c15_ccnt_delta;
+        uint64_t c14_pmevcntr[31];
+        uint64_t c14_pmevcntr_delta[31];
+        uint64_t c14_pmevtyper[31];
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9f81747..f1fd21c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -938,6 +938,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
+#define PMCRP   0x2
 #define PMCRE   0x1
 
 #define PMXEVTYPER_P          0x80000000
@@ -1120,9 +1121,11 @@ static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
         prohibited = env->cp15.c9_pmcr & PMCRDP;
     }
 
-    /* TODO Remove assert, set filter to correct PMEVTYPER */
-    assert(counter == 31);
-    filter = env->cp15.pmccfiltr_el0;
+    if (counter == 31) {
+        filter = env->cp15.pmccfiltr_el0;
+    } else {
+        filter = env->cp15.c14_pmevtyper[counter];
+    }
 
     p   = filter & PMXEVTYPER_P;
     u   = filter & PMXEVTYPER_U;
@@ -1142,6 +1145,21 @@ static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
         filtered = m != p;
     }
 
+    if (counter != 31) {
+        /* If not checking PMCCNTR, ensure the counter is setup to an event we
+         * support */
+        uint16_t event = filter & PMXEVTYPER_EVTCOUNT;
+        if (event > 0x3f) {
+            return false; /* We only support common architectural and
+                             microarchitectural events */
+        }
+
+        uint16_t event_idx = supported_event_map[event];
+        if (event_idx == SUPPORTED_EVENT_SENTINEL) {
+            return false;
+        }
+    }
+
     return enabled && !prohibited && !filtered;
 }
 
@@ -1188,14 +1206,44 @@ void pmccntr_op_finish(CPUARMState *env)
     }
 }
 
+static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
+{
+
+    uint16_t event = env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_EVTCOUNT;
+    uint16_t event_idx = supported_event_map[event];
+    uint64_t count = pm_events[event_idx].get_count(env);
+
+    if (pmu_counter_enabled(env, counter)) {
+        env->cp15.c14_pmevcntr[counter] =
+            count - env->cp15.c14_pmevcntr_delta[counter];
+    }
+    env->cp15.c14_pmevcntr_delta[counter] = count;
+}
+
+static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
+{
+    if (pmu_counter_enabled(env, counter)) {
+        env->cp15.c14_pmevcntr_delta[counter] -=
+            env->cp15.c14_pmevcntr[counter];
+    }
+}
+
 void pmu_op_start(CPUARMState *env)
 {
+    unsigned int i;
     pmccntr_op_start(env);
+    for (i = 0; i < pmu_num_counters(env); i++) {
+        pmevcntr_op_start(env, i);
+    }
 }
 
 void pmu_op_finish(CPUARMState *env)
 {
+    unsigned int i;
     pmccntr_op_finish(env);
+    for (i = 0; i < pmu_num_counters(env); i++) {
+        pmevcntr_op_finish(env, i);
+    }
 }
 
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
@@ -1218,6 +1266,13 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         env->cp15.c15_ccnt = 0;
     }
 
+    if (value & PMCRP) {
+        unsigned int i;
+        for (i = 0; i < pmu_num_counters(env); i++) {
+            env->cp15.c14_pmevcntr[i] = 0;
+        }
+    }
+
     /* only the DP, X, D and E bits are writable */
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
@@ -1271,6 +1326,14 @@ void pmccntr_op_finish(CPUARMState *env)
 {
 }
 
+void pmevcntr_op_start(CPUARMState *env, uint8_t i)
+{
+}
+
+void pmevcntr_op_finish(CPUARMState *env, uint8_t i)
+{
+}
+
 void pmu_op_start(CPUARMState *env)
 {
 }
@@ -1341,30 +1404,113 @@ static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmovsr |= value;
 }
 
-static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
+static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value, const uint8_t counter)
 {
+    if (counter == 0x1f) {
+        pmccfiltr_write(env, ri, value);
+    } else if (counter < pmu_num_counters(env)) {
+        pmevcntr_op_start(env, counter);
+        env->cp15.c14_pmevtyper[counter] = value & 0xfe0003ff;
+        pmevcntr_op_finish(env, counter);
+    }
     /* Attempts to access PMXEVTYPER are CONSTRAINED UNPREDICTABLE when
      * PMSELR value is equal to or greater than the number of implemented
      * counters, but not equal to 0x1f. We opt to behave as a RAZ/WI.
      */
-    if (env->cp15.c9_pmselr == 0x1f) {
-        pmccfiltr_write(env, ri, value);
+}
+
+static uint64_t pmevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri,
+                               const uint8_t counter)
+{
+    if (counter == 0x1f) {
+        return env->cp15.pmccfiltr_el0;
+    } else if (counter < pmu_num_counters(env)) {
+        return env->cp15.c14_pmevtyper[counter];
+    } else {
+      /* We opt to behave as a RAZ/WI when attempts to access PMXEVTYPER
+       * are CONSTRAINED UNPREDICTABLE. See comments in pmevtyper_write().
+       */
+        return 0;
     }
 }
 
+static void pmevtyper_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    uint8_t counter = ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    pmevtyper_write(env, ri, value, counter);
+}
+
+static uint64_t pmevtyper_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint8_t counter = ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    return pmevtyper_read(env, ri, counter);
+}
+
+static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    pmevtyper_write(env, ri, value, env->cp15.c9_pmselr & 31);
+}
+
 static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* We opt to behave as a RAZ/WI when attempts to access PMXEVTYPER
-     * are CONSTRAINED UNPREDICTABLE. See comments in pmxevtyper_write().
-     */
-    if (env->cp15.c9_pmselr == 0x1f) {
-        return env->cp15.pmccfiltr_el0;
+    return pmevtyper_read(env, ri, env->cp15.c9_pmselr & 31);
+}
+
+static void pmevcntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value, uint8_t counter)
+{
+    if (counter < pmu_num_counters(env)) {
+        pmevcntr_op_start(env, counter);
+        env->cp15.c14_pmevcntr[counter] = value;
+        pmevcntr_op_finish(env, counter);
+    }
+    /* We opt to behave as a RAZ/WI when attempts to access PM[X]EVCNTR
+     * are CONSTRAINED UNPREDICTABLE. */
+}
+
+static uint64_t pmevcntr_read(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint8_t counter)
+{
+    if (counter < pmu_num_counters(env)) {
+        uint64_t ret;
+        pmevcntr_op_start(env, counter);
+        ret = env->cp15.c14_pmevcntr[counter];
+        pmevcntr_op_finish(env, counter);
+        return ret;
     } else {
+      /* We opt to behave as a RAZ/WI when attempts to access PM[X]EVCNTR
+       * are CONSTRAINED UNPREDICTABLE. */
         return 0;
     }
 }
 
+static void pmevcntr_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint8_t counter = ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    pmevcntr_write(env, ri, value, counter);
+}
+
+static uint64_t pmevcntr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint8_t counter = ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    return pmevcntr_read(env, ri, counter);
+}
+
+static void pmxevcntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    pmevcntr_write(env, ri, value, env->cp15.c9_pmselr & 31);
+}
+
+static uint64_t pmxevcntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return pmevcntr_read(env, ri, env->cp15.c9_pmselr & 31);
+}
+
 static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1552,16 +1698,23 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
       .resetvalue = 0, },
     { .name = "PMXEVTYPER", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 1,
-      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
+      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = pmreg_access,
       .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
     { .name = "PMXEVTYPER_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 1,
-      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
+      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = pmreg_access,
       .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
-    /* Unimplemented, RAZ/WI. */
     { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
-      .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
-      .accessfn = pmreg_access_xevcntr },
+      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = pmreg_access_xevcntr,
+      .writefn = pmxevcntr_write, .readfn = pmxevcntr_read },
+    { .name = "PMXEVCNTR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 2,
+      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = pmreg_access_xevcntr,
+      .writefn = pmxevcntr_write, .readfn = pmxevcntr_read },
     { .name = "PMUSERENR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 0,
       .access = PL0_R | PL1_RW, .accessfn = access_tpm,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmuserenr),
@@ -4250,7 +4403,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
 #endif
     /* The only field of MDCR_EL2 that has a defined architectural reset value
      * is MDCR_EL2.HPMN which should reset to the value of PMCR_EL0.N; but we
-     * don't impelment any PMU event counters, so using zero as a reset
+     * don't implement any PMU event counters, so using zero as a reset
      * value for MDCR_EL2 is okay
      */
     { .name = "MDCR_EL2", .state = ARM_CP_STATE_BOTH,
@@ -5062,6 +5215,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
+        unsigned int i;
         /* v7 performance monitor control register: same implementor
          * field as main ID register, and we implement only the cycle
          * count register.
@@ -5086,6 +5240,40 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         };
         define_one_arm_cp_reg(cpu, &pmcr);
         define_one_arm_cp_reg(cpu, &pmcr64);
+        for (i = 0; i < 31; i++) {
+            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
+            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
+            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
+            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
+            ARMCPRegInfo pmev_regs[] = {
+                { .name = pmevcntr_name, .cp = 15, .crn = 15,
+                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+                  .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
+                  .accessfn = pmreg_access },
+                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
+                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
+                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+                  .type = ARM_CP_NO_RAW | ARM_CP_IO,
+                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn },
+                { .name = pmevtyper_name, .cp = 15, .crn = 15,
+                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+                  .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
+                  .accessfn = pmreg_access },
+                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
+                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),
+                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+                  .type = ARM_CP_NO_RAW | ARM_CP_IO,
+                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn },
+                REGINFO_SENTINEL
+            };
+            define_arm_cp_regs(cpu, pmev_regs);
+            g_free(pmevcntr_name);
+            g_free(pmevcntr_el0_name);
+            g_free(pmevtyper_name);
+            g_free(pmevtyper_el0_name);
+        }
 #endif
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
