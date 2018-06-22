Received: from eggs.gnu.org ([2001:4830:134:3::10]:54259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjb-00026f-82
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjZ-0005QJ-MJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:43 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:15 -0400
Message-Id: <1529699547-17044-2-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 01/13] target/arm: Reorganize PMCCNTR
 accesses
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

pmccntr_read and pmccntr_write contained duplicate code that was already
being handled by pmccntr_sync. Consolidate the duplicated code into two
functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
c15_ccnt in CPUARMState so that we can simultaneously save both the
architectural register value and the last underlying cycle count - this
ensure time isn't lost and will also allow us to access the 'old'
architectural register value in order to detect overflows in later
patches.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.h    |  28 ++++++++++-----
 target/arm/helper.c | 100 ++++++++++++++++++++++++++++------------------------
 2 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8488273..ba2c876 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -467,10 +467,20 @@ typedef struct CPUARMState {
         uint64_t oslsr_el1; /* OS Lock Status */
         uint64_t mdcr_el2;
         uint64_t mdcr_el3;
-        /* If the counter is enabled, this stores the last time the counter
-         * was reset. Otherwise it stores the counter value
+        /* Stores the architectural value of the counter *the last time it was
+         * updated* by pmccntr_op_start. Accesses should always be surrounded
+         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
+         * architecturally-corect value is being read/set.
          */
         uint64_t c15_ccnt;
+        /* Stores the delta between the architectural value and the underlying
+         * cycle count during normal operation. It is used to update c15_ccnt
+         * to be the correct architectural value before accesses. During
+         * accesses, c15_ccnt_delta contains the underlying count being used
+         * for the access, after which it reverts to the delta value in
+         * pmccntr_op_finish.
+         */
+        uint64_t c15_ccnt_delta;
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
@@ -924,15 +934,17 @@ int cpu_arm_signal_handler(int host_signum, void *pinfo,
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
  */
-void pmccntr_sync(CPUARMState *env);
+void pmccntr_op_start(CPUARMState *env);
+void pmccntr_op_finish(CPUARMState *env);
 
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1248d84..23b3a16 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1044,28 +1044,53 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 
     return true;
 }
-
-void pmccntr_sync(CPUARMState *env)
+/*
+ * Ensure c15_ccnt is the guest-visible count so that operations such as
+ * enabling/disabling the counter or filtering, modifying the count itself,
+ * etc. can be done logically. This is essentially a no-op if the counter is
+ * not enabled at the time of the call.
+ */
+void pmccntr_op_start(CPUARMState *env)
 {
-    uint64_t temp_ticks;
-
-    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+    uint64_t cycles = 0;
+    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
 
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        temp_ticks /= 64;
-    }
-
     if (arm_ccnt_enabled(env)) {
-        env->cp15.c15_ccnt = temp_ticks - env->cp15.c15_ccnt;
+        uint64_t eff_cycles = cycles;
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            eff_cycles /= 64;
+        }
+
+        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt_delta;
+    }
+    env->cp15.c15_ccnt_delta = cycles;
+}
+
+/*
+ * If PMCCNTR is enabled, recalculate the delta between the clock and the
+ * guest-visible count. A call to pmccntr_op_finish should follow every call to
+ * pmccntr_op_start.
+ */
+void pmccntr_op_finish(CPUARMState *env)
+{
+    if (arm_ccnt_enabled(env)) {
+        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
+
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            prev_cycles /= 64;
+        }
+
+        env->cp15.c15_ccnt_delta = prev_cycles - env->cp15.c15_ccnt;
     }
 }
 
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    pmccntr_sync(env);
+    pmccntr_op_start(env);
 
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1076,26 +1101,16 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
 
-    pmccntr_sync(env);
+    pmccntr_op_finish(env);
 }
 
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    uint64_t total_ticks;
-
-    if (!arm_ccnt_enabled(env)) {
-        /* Counter is disabled, do not change value */
-        return env->cp15.c15_ccnt;
-    }
-
-    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
-
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        total_ticks /= 64;
-    }
-    return total_ticks - env->cp15.c15_ccnt;
+    uint64_t ret;
+    pmccntr_op_start(env);
+    ret = env->cp15.c15_ccnt;
+    pmccntr_op_finish(env);
+    return ret;
 }
 
 static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1112,22 +1127,9 @@ static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    uint64_t total_ticks;
-
-    if (!arm_ccnt_enabled(env)) {
-        /* Counter is disabled, set the absolute value */
-        env->cp15.c15_ccnt = value;
-        return;
-    }
-
-    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
-
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        total_ticks /= 64;
-    }
-    env->cp15.c15_ccnt = total_ticks - value;
+    pmccntr_op_start(env);
+    env->cp15.c15_ccnt = value;
+    pmccntr_op_finish(env);
 }
 
 static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1140,7 +1142,11 @@ static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
 
 #else /* CONFIG_USER_ONLY */
 
-void pmccntr_sync(CPUARMState *env)
+void pmccntr_op_start(CPUARMState *env)
+{
+}
+
+void pmccntr_op_finish(CPUARMState *env)
 {
 }
 
@@ -1149,9 +1155,9 @@ void pmccntr_sync(CPUARMState *env)
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    pmccntr_sync(env);
+    pmccntr_op_start(env);
     env->cp15.pmccfiltr_el0 = value & 0xfc000000;
-    pmccntr_sync(env);
+    pmccntr_op_finish(env);
 }
 
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
