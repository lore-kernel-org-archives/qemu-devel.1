Received: from eggs.gnu.org ([2001:4830:134:3::10]:52487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSN-0004xq-GD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSA-0004kU-Li
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSA-0004k3-Ex
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS9-0005V0-GH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:44 +0100
Message-Id: <1504527967-29248-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/36] target/arm: Create and use new function
 arm_v7m_is_handler_mode()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a utility function for testing whether the CPU is in Handler
mode; this is just a check whether v7m.exception is non-zero, but
we do it in several places and it makes the code a bit easier
to read to not have to mentally figure out what the test is testing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-14-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 10 ++++++++--
 target/arm/helper.c |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8ef552a..eabef00 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1629,13 +1629,19 @@ static inline int arm_highest_el(CPUARMState *env)
     return 1;
 }
 
+/* Return true if a v7M CPU is in Handler mode */
+static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
+{
+    return env->v7m.exception != 0;
+}
+
 /* Return the current Exception Level (as per ARMv8; note that this differs
  * from the ARMv7 Privilege Level).
  */
 static inline int arm_current_el(CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
-        return !((env->v7m.exception == 0) && (env->v7m.control & 1));
+        return arm_v7m_is_handler_mode(env) || !(env->v7m.control & 1);
     }
 
     if (is_a64(env)) {
@@ -2635,7 +2641,7 @@ static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
     *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
-    if (env->v7m.exception != 0) {
+    if (arm_v7m_is_handler_mode(env)) {
         *flags |= ARM_TBFLAG_HANDLER_MASK;
     }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 267a170..37e7fd9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6142,7 +6142,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      * that jumps to magic addresses don't have magic behaviour unless
      * we're in Handler mode (compare pseudocode BXWritePC()).
      */
-    assert(env->v7m.exception != 0);
+    assert(arm_v7m_is_handler_mode(env));
 
     /* In the spec pseudocode ExceptionReturn() is called directly
      * from BXWritePC() and gets the full target PC value including
@@ -6249,7 +6249,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      * resuming in Thread mode. If that doesn't match what the
      * exception return type specified then this is a UsageFault.
      */
-    if (return_to_handler == (env->v7m.exception == 0)) {
+    if (return_to_handler != arm_v7m_is_handler_mode(env)) {
         /* Take an INVPC UsageFault by pushing the stack again. */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         env->v7m.cfsr |= R_V7M_CFSR_INVPC_MASK;
@@ -6400,7 +6400,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
         lr |= 4;
     }
-    if (env->v7m.exception == 0) {
+    if (!arm_v7m_is_handler_mode(env)) {
         lr |= 8;
     }
 
@@ -8793,7 +8793,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
          * switch_v7m_sp() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
          */
-        if (env->v7m.exception == 0) {
+        if (!arm_v7m_is_handler_mode(env)) {
             switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
         env->v7m.control &= ~R_V7M_CONTROL_NPRIV_MASK;
-- 
2.7.4
