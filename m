Received: from eggs.gnu.org ([2001:4830:134:3::10]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zv-0000ZU-Da
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zu-0000ZD-EQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:27 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:11 +0000
Message-Id: <1485285380-10565-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/10] target/arm: Drop IS_M() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

We only use the IS_M() macro in two places, and it's a bit of a
namespace grab to put in cpu.h.  Drop it in favour of just explicitly
calling arm_feature() in the places where it was used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 6 ------
 target/arm/cpu.c    | 2 +-
 target/arm/helper.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 521c11b..b2cc329 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1762,12 +1762,6 @@ bool write_list_to_cpustate(ARMCPU *cpu);
  */
 bool write_cpustate_to_list(ARMCPU *cpu);
 
-/* Does the core conform to the "MicroController" profile. e.g. Cortex-M3.
-   Note the M in older cores (eg. ARM7TDMI) stands for Multiply. These are
-   conventional cores (ie. Application or Realtime profile).  */
-
-#define IS_M(env) arm_feature(env, ARM_FEATURE_M)
-
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9075989..6395d5a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -182,7 +182,7 @@ static void arm_cpu_reset(CPUState *s)
     /* On ARMv7-M the CPSR_I is the value of the PRIMASK register, and is
      * clear at reset. Initial SP and PC are loaded from ROM.
      */
-    if (IS_M(env)) {
+    if (arm_feature(env, ARM_FEATURE_M)) {
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cfbc622..ce7e43b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6695,7 +6695,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
 
-    assert(!IS_M(env));
+    assert(!arm_feature(env, ARM_FEATURE_M));
 
     arm_log_exception(cs->exception_index);
     qemu_log_mask(CPU_LOG_INT, "...from EL%d to EL%d\n", arm_current_el(env),
-- 
2.7.4
