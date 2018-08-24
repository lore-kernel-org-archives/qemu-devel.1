Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tm-0007Cd-RZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tl-0003bt-Lz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tl-0003ZB-CV
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tk-0006S4-E0
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:06 +0100
Message-Id: <20180824093343.11346-16-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/52] target/arm: Factor out code for taking an
 AArch32 exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Factor out the code which changes the CPU state so as to
actually take an exception to AArch32. We're going to want
to use this for handling exception entry to Hyp mode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0d5f6f48cfe..b47657c31b2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8033,6 +8033,46 @@ void aarch64_sync_64_to_32(CPUARMState *env)
     env->regs[15] = env->pc;
 }
 
+static void take_aarch32_exception(CPUARMState *env, int new_mode,
+                                   uint32_t mask, uint32_t offset,
+                                   uint32_t newpc)
+{
+    /* Change the CPU state so as to actually take the exception. */
+    switch_mode(env, new_mode);
+    /*
+     * For exceptions taken to AArch32 we must clear the SS bit in both
+     * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
+     */
+    env->uncached_cpsr &= ~PSTATE_SS;
+    env->spsr = cpsr_read(env);
+    /* Clear IT bits.  */
+    env->condexec_bits = 0;
+    /* Switch to the new mode, and to the correct instruction set.  */
+    env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
+    /* Set new mode endianness */
+    env->uncached_cpsr &= ~CPSR_E;
+    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+        env->uncached_cpsr |= CPSR_E;
+    }
+    env->daif |= mask;
+
+    if (new_mode == ARM_CPU_MODE_HYP) {
+        env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
+        env->elr_el[2] = env->regs[15];
+    } else {
+        /*
+         * this is a lie, as there was no c1_sys on V4T/V5, but who cares
+         * and we should just guard the thumb mode on V4
+         */
+        if (arm_feature(env, ARM_FEATURE_V4T)) {
+            env->thumb =
+                (A32_BANKED_CURRENT_REG_GET(env, sctlr) & SCTLR_TE) != 0;
+        }
+        env->regs[14] = env->regs[15] + offset;
+    }
+    env->regs[15] = newpc;
+}
+
 static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -8175,29 +8215,7 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         env->cp15.scr_el3 &= ~SCR_NS;
     }
 
-    switch_mode (env, new_mode);
-    /* For exceptions taken to AArch32 we must clear the SS bit in both
-     * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
-     */
-    env->uncached_cpsr &= ~PSTATE_SS;
-    env->spsr = cpsr_read(env);
-    /* Clear IT bits.  */
-    env->condexec_bits = 0;
-    /* Switch to the new mode, and to the correct instruction set.  */
-    env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
-    /* Set new mode endianness */
-    env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
-        env->uncached_cpsr |= CPSR_E;
-    }
-    env->daif |= mask;
-    /* this is a lie, as the was no c1_sys on V4T/V5, but who cares
-     * and we should just guard the thumb mode on V4 */
-    if (arm_feature(env, ARM_FEATURE_V4T)) {
-        env->thumb = (A32_BANKED_CURRENT_REG_GET(env, sctlr) & SCTLR_TE) != 0;
-    }
-    env->regs[14] = env->regs[15] + offset;
-    env->regs[15] = addr;
+    take_aarch32_exception(env, new_mode, mask, offset, addr);
 }
 
 /* Handle exception entry to a target EL which is using AArch64 */
-- 
2.18.0
