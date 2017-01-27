Received: from eggs.gnu.org ([2001:4830:134:3::10]:59690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vu-00016f-Qu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vu-0005A3-5I
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vt-00055y-V8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vi-0003O7-PN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:22 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:04 +0000
Message-Id: <1485531137-2362-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/22] target/arm: Drop IS_M() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We only use the IS_M() macro in two places, and it's a bit of a
namespace grab to put in cpu.h.  Drop it in favour of just explicitly
calling arm_feature() in the places where it was used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1485285380-10565-2-git-send-email-peter.maydell@linaro.org
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
