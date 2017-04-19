Received: from eggs.gnu.org ([2001:4830:134:3::10]:44085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc8-0008HR-Eb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc6-0004Qa-PT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:00 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Wed, 19 Apr 2017 13:41:17 -0400
Message-Id: <1492623684-25799-7-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 06/13] target/arm: Filter cycle counter based
 on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mspradli@codeaurora.org, Aaron Lindsay <alindsay@codeaurora.org>

The pmu_counter_filtered and pmu_sync functions are generic (as opposed
to PMCCNTR-specific) to allow for the implementation of other events.

RFC: I know that many of the locations of the calls to pmu_sync are
problematic when icount is enabled because can_do_io will not be set.
The documentation says that for deterministic execution, IO must only be
performed by the last instruction of a thread block. Because
cpu_handle_interrupt() and cpu_handle_exception() are actually made
outside of a thread block, is it safe to set can_do_io=1 for them to
allow this to succeed? Is there a better mechanism for handling this?

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c       |  4 +++
 target/arm/cpu.h       | 15 +++++++++++
 target/arm/helper.c    | 73 +++++++++++++++++++++++++++++++++++++++++++++++---
 target/arm/kvm64.c     |  2 ++
 target/arm/machine.c   |  2 ++
 target/arm/op_helper.c |  4 +++
 6 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 921b028..44c965c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -139,6 +139,8 @@ static void arm_cpu_reset(CPUState *s)
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
     }
 
+    pmu_sync(env); /* Surround writes to uncached_cpsr, pstate, and aarch64 */
+
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
         env->aarch64 = 1;
@@ -180,6 +182,8 @@ static void arm_cpu_reset(CPUState *s)
     env->uncached_cpsr = ARM_CPU_MODE_SVC;
     env->daif = PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F;
 
+    pmu_sync(env); /* Surround writes to uncached_cpsr, pstate, and aarch64 */
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8aabce..ae2a294 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -767,6 +767,19 @@ int cpu_arm_signal_handler(int host_signum, void *pinfo,
  */
 void pmccntr_sync(CPUARMState *env);
 
+/**
+ * pmu_sync
+ * @env: CPUARMState
+ *
+ * Synchronises all PMU counters. This must always be called twice, once before
+ * any action that might affect the filtering of all counters and again
+ * afterwards. The function is used to swap the state of the registers if
+ * required. This only happens when not in user mode (!CONFIG_USER_ONLY). Any
+ * writes to env's aarch64, pstate, uncached_cpsr, cp15.scr_el3, or
+ * cp15.hcr_el2 must be protected by calls to this function.
+ */
+void pmu_sync(CPUARMState *env);
+
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
  * for both old and new bit meanings. Code which tests against those
@@ -947,7 +960,9 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
     env->CF = (val >> 29) & 1;
     env->VF = (val << 3) & 0x80000000;
     env->daif = val & PSTATE_DAIF;
+    pmu_sync(env);
     env->pstate = val & ~CACHED_PSTATE_BITS;
+    pmu_sync(env);
 }
 
 /* Return the current CPSR value.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 530fc7c..bf9f164 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -878,6 +878,15 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
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
 #define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN) >> PMCRN_SHIFT)
 /* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
 #define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
@@ -968,7 +977,7 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
 
 static inline bool arm_ccnt_enabled(CPUARMState *env)
 {
-    /* This does not support checking PMCCFILTR_EL0 register */
+    /* Does not check PMCCFILTR_EL0, which is handled by pmu_counter_filtered */
 
     if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
         return false;
@@ -977,6 +986,43 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
     return true;
 }
 
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
 void pmccntr_sync(CPUARMState *env)
 {
     if (arm_ccnt_enabled(env) &&
@@ -995,10 +1041,15 @@ void pmccntr_sync(CPUARMState *env)
     }
 }
 
+void pmu_sync(CPUARMState *env)
+{
+    pmccntr_sync(env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    pmccntr_sync(env);
+    pmu_sync(env);
 
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1009,7 +1060,7 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
 
-    pmccntr_sync(env);
+    pmu_sync(env);
 }
 
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -1053,6 +1104,10 @@ void pmccntr_sync(CPUARMState *env)
 {
 }
 
+void pmu_sync(CPUARMState *env)
+{
+}
+
 #endif
 
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1184,7 +1239,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
+    pmu_sync(env);
     raw_write(env, ri, value);
+    pmu_sync(env);
 }
 
 static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -3735,7 +3792,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if ((raw_read(env, ri) ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
         tlb_flush(CPU(cpu));
     }
+    pmu_sync(env);
     raw_write(env, ri, value);
+    pmu_sync(env);
 }
 
 static const ARMCPRegInfo el2_cp_reginfo[] = {
@@ -5819,7 +5878,9 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
         }
     }
     mask &= ~CACHED_CPSR_BITS;
+    pmu_sync(env);
     env->uncached_cpsr = (env->uncached_cpsr & ~mask) | (val & mask);
+    pmu_sync(env);
 }
 
 /* Sign/zero extend */
@@ -6702,6 +6763,8 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         addr += A32_BANKED_CURRENT_REG_GET(env, vbar);
     }
 
+    pmu_sync(env); /* Surrounds updates to scr_el3 and uncached_cpsr */
+
     if ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_MON) {
         env->cp15.scr_el3 &= ~SCR_NS;
     }
@@ -6729,6 +6792,8 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     }
     env->regs[14] = env->regs[15] + offset;
     env->regs[15] = addr;
+
+    pmu_sync(env); /* Surrounds updates to scr_el3 and uncached_cpsr */
 }
 
 /* Handle exception entry to a target EL which is using AArch64 */
@@ -6818,7 +6883,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   env->elr_el[new_el]);
 
     pstate_write(env, PSTATE_DAIF | new_mode);
+    pmu_sync(env);
     env->aarch64 = 1;
+    pmu_sync(env);
     aarch64_restore_sp(env, new_el);
 
     env->pc = addr;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6111109..8ea9662 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -774,7 +774,9 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
+    pmu_sync(env);
     env->aarch64 = ((val & PSTATE_nRW) == 0);
+    pmu_sync(env);
     if (is_a64(env)) {
         pstate_write(env, val);
     } else {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index d8094a8..833e400 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -177,7 +177,9 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
     CPUARMState *env = &cpu->env;
     uint32_t val = qemu_get_be32(f);
 
+    pmu_sync(env);
     env->aarch64 = ((val & PSTATE_nRW) == 0);
+    pmu_sync(env);
 
     if (is_a64(env)) {
         pstate_write(env, val);
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index d64c867..8009c1c 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -997,7 +997,9 @@ void HELPER(exception_return)(CPUARMState *env)
     }
 
     if (!return_to_aa64) {
+        pmu_sync(env);
         env->aarch64 = 0;
+        pmu_sync(env);
         /* We do a raw CPSR write because aarch64_sync_64_to_32()
          * will sort the register banks out for us, and we've already
          * caught all the bad-mode cases in el_from_spsr().
@@ -1017,7 +1019,9 @@ void HELPER(exception_return)(CPUARMState *env)
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
     } else {
+        pmu_sync(env);
         env->aarch64 = 1;
+        pmu_sync(env);
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
