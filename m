Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc4-0008CD-7d
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc2-0004Nd-TV
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:41:56 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Wed, 19 Apr 2017 13:41:14 -0400
Message-Id: <1492623684-25799-4-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 03/13] target/arm: Reorganize PMCCNTR read,
 write, sync
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

pmccntr_read and pmccntr_write contained duplicate code that was already
being handled by pmccntr_sync. This also moves the calls to get the
clock inside the 'if' statement so they are not executed if not needed.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 55 ++++++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8888391..390256b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -973,17 +973,18 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 
 void pmccntr_sync(CPUARMState *env)
 {
-    uint64_t temp_ticks;
+    if (arm_ccnt_enabled(env) &&
+          !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
+        uint64_t temp_ticks;
 
-    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+        temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                              ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
 
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        temp_ticks /= 64;
-    }
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            temp_ticks /= 64;
+        }
 
-    if (arm_ccnt_enabled(env)) {
         env->cp15.c15_ccnt = temp_ticks - env->cp15.c15_ccnt;
     }
 }
@@ -1007,21 +1008,11 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
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
+    pmccntr_sync(env);
+    ret = env->cp15.c15_ccnt;
+    pmccntr_sync(env);
+    return ret;
 }
 
 static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1038,22 +1029,8 @@ static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
+    env->cp15.c15_ccnt = value;
+    pmccntr_sync(env);
 }
 
 static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
