Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zx-0000bO-67
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zw-0000av-91
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:29 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:19 +0000
Message-Id: <1485285380-10565-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/10] armv7m: FAULTMASK should be 0 on reset
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

From: Michael Davidsaver <mdavidsaver@gmail.com>

For M profile CPUs, FAULTMASK should be 0 on reset, like PRIMASK.
QEMU stores FAULTMASK in the PSTATE F bit, so (as with PRIMASK in the
I bit) we have to clear these to undo the A profile default of 1.

Update the comment accordingly and move it so that it's closer to the
code it's referring to.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: rewrote commit message, moved comments]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c804f59..0814f73 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -179,15 +179,16 @@ static void arm_cpu_reset(CPUState *s)
     /* SVC mode with interrupts disabled.  */
     env->uncached_cpsr = ARM_CPU_MODE_SVC;
     env->daif = PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F;
-    /* On ARMv7-M the CPSR_I is the value of the PRIMASK register, and is
-     * clear at reset. Initial SP and PC are loaded from ROM.
-     */
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
 
-        env->daif &= ~PSTATE_I;
+        /* For M profile we store FAULTMASK and PRIMASK in the
+         * PSTATE F and I bits; these are both clear at reset.
+         */
+        env->daif &= ~(PSTATE_I | PSTATE_F);
 
         /* The reset value of this bit is IMPDEF, but ARM recommends
          * that it resets to 1, so QEMU always does that rather than making
@@ -195,6 +196,7 @@ static void arm_cpu_reset(CPUState *s)
          */
         env->v7m.ccr = R_V7M_CCR_STKALIGN_MASK;
 
+        /* Load the initial SP and PC from the vector table at address 0 */
         rom = rom_ptr(0);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
-- 
2.7.4
