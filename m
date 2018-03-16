Received: from eggs.gnu.org ([2001:4830:134:3::10]:43953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1L-0005mh-6R
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1I-0003C3-H6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:11 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:03 -0400
Message-Id: <1521232280-13089-6-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 05/22] target/arm: Reorganize PMCCNTR read,
 write, sync
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

pmccntr_read and pmccntr_write contained duplicate code that was already
being handled by pmccntr_sync. Split pmccntr_sync into pmccntr_op_start
and pmccntr_op_finish, passing the clock value between the two, to avoid
losing time between the two calls.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 101 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5634561..6480b80 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1000,28 +1000,58 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 
     return true;
 }
-
-void pmccntr_sync(CPUARMState *env)
+/*
+ * Ensure c15_ccnt is the guest-visible count so that operations such as
+ * enabling/disabling the counter or filtering, modifying the count itself,
+ * etc. can be done logically. This is essentially a no-op if the counter is
+ * not enabled at the time of the call.
+ *
+ * The current cycle count is returned so that it can be passed into the paired
+ * pmccntr_op_finish() call which must follow each call to pmccntr_op_start().
+ */
+uint64_t pmccntr_op_start(CPUARMState *env)
 {
-    uint64_t temp_ticks;
-
-    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+    uint64_t cycles = 0;
+#ifndef CONFIG_USER_ONLY
+    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+#endif
+
+    if (arm_ccnt_enabled(env)) {
 
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        temp_ticks /= 64;
+        uint64_t eff_cycles = cycles;
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            eff_cycles /= 64;
+        }
+
+        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt;
     }
+    return cycles;
+}
 
+/*
+ * If enabled, convert c15_ccnt back into the delta between the clock and the
+ * guest-visible count. A call to pmccntr_op_finish should follow every call to
+ * pmccntr_op_start.
+ */
+void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
+{
     if (arm_ccnt_enabled(env)) {
-        env->cp15.c15_ccnt = temp_ticks - env->cp15.c15_ccnt;
+
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            prev_cycles /= 64;
+        }
+
+        env->cp15.c15_ccnt = prev_cycles - env->cp15.c15_ccnt;
     }
 }
 
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    pmccntr_sync(env);
+    uint64_t saved_cycles = pmccntr_op_start(env);
 
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1032,26 +1062,16 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.c9_pmcr &= ~0x39;
     env->cp15.c9_pmcr |= (value & 0x39);
 
-    pmccntr_sync(env);
+    pmccntr_op_finish(env, saved_cycles);
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
+    uint64_t saved_cycles = pmccntr_op_start(env);
+    ret = env->cp15.c15_ccnt;
+    pmccntr_op_finish(env, saved_cycles);
+    return ret;
 }
 
 static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1068,22 +1088,9 @@ static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
+    uint64_t saved_cycles = pmccntr_op_start(env);
+    env->cp15.c15_ccnt = value;
+    pmccntr_op_finish(env, saved_cycles);
 }
 
 static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1096,7 +1103,11 @@ static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
 
 #else /* CONFIG_USER_ONLY */
 
-void pmccntr_sync(CPUARMState *env)
+uint64_t pmccntr_op_start(CPUARMState *env)
+{
+}
+
+void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
 {
 }
 
@@ -1105,9 +1116,9 @@ void pmccntr_sync(CPUARMState *env)
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    pmccntr_sync(env);
+    uint64_t saved_cycles = pmccntr_op_start(env);
     env->cp15.pmccfiltr_el0 = value & 0x7E000000;
-    pmccntr_sync(env);
+    pmccntr_op_finish(env, saved_cycles);
 }
 
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
