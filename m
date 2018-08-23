Received: from eggs.gnu.org ([2001:4830:134:3::10]:50782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsq0k-0003EZ-Us
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsq0k-0003VM-5p
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:50:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 14:50:47 +0100
Message-Id: <20180823135047.16525-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Start AArch32 CPUs with EL2 but
 not EL3 in Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The ARMv8 architecture defines that an AArch32 CPU starts
in SVC mode, unless EL2 is the highest available EL, in
which case it starts in Hyp mode. (In ARMv7 a CPU with EL2
but not EL3 was not a valid configuration, but we don't
specifically reject this if the user asks for one.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 258ba6dcaad..b5e61cc1775 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -199,8 +199,18 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.c15_cpar = 1;
     }
 #else
-    /* SVC mode with interrupts disabled.  */
-    env->uncached_cpsr = ARM_CPU_MODE_SVC;
+
+    /*
+     * If the highest available EL is EL2, AArch32 will start in Hyp
+     * mode; otherwise it starts in SVC. Note that if we start in
+     * AArch64 then these values in the uncached_cpsr will be ignored.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL2) &&
+        !arm_feature(env, ARM_FEATURE_EL3)) {
+        env->uncached_cpsr = ARM_CPU_MODE_HYP;
+    } else {
+        env->uncached_cpsr = ARM_CPU_MODE_SVC;
+    }
     env->daif = PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F;
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-- 
2.18.0
