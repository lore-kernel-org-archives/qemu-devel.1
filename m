Received: from eggs.gnu.org ([2001:4830:134:3::10]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQY-0007wN-Gd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQX-000454-Fu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:38 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:53 +0100
Message-Id: <1506092407-26985-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/20] target/arm: Check for xPSR mismatch
 usage faults earlier for v8M
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

ARM v8M specifies that the INVPC usage fault for mismatched
xPSR exception field and handler mode bit should be checked
before updating the PSR and SP, so that the fault is taken
with the existing stack frame rather than by pushing a new one.
Perform this check in the right place for v8M.

Since v7M specifies in its pseudocode that this usage fault
check should happen later, we have to retain the original
code for that check rather than being able to merge the two.
(The distinction is architecturally visible but only in
very obscure corner cases like attempting an invalid exception
return with an exception frame in read only memory.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4444d04..a2e46fb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6426,6 +6426,29 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
         xpsr = ldl_phys(cs->as, frameptr + 0x1c);
 
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            /* For v8M we have to check whether the xPSR exception field
+             * matches the EXCRET value for return to handler/thread
+             * before we commit to changing the SP and xPSR.
+             */
+            bool will_be_handler = (xpsr & XPSR_EXCP) != 0;
+            if (return_to_handler != will_be_handler) {
+                /* Take an INVPC UsageFault on the current stack.
+                 * By this point we will have switched to the security state
+                 * for the background state, so this UsageFault will target
+                 * that state.
+                 */
+                armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
+                                        env->v7m.secure);
+                env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
+                v7m_exception_taken(cpu, excret);
+                qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
+                              "stackframe: failed exception return integrity "
+                              "check\n");
+                return;
+            }
+        }
+
         /* Commit to consuming the stack frame */
         frameptr += 0x20;
         /* Undo stack alignment (the SPREALIGN bit indicates that the original
@@ -6445,12 +6468,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     /* The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
      * exception return excret specified then this is a UsageFault.
+     * v7M requires we make this check here; v8M did it earlier.
      */
     if (return_to_handler != arm_v7m_is_handler_mode(env)) {
-        /* Take an INVPC UsageFault by pushing the stack again.
-         * TODO: the v8M version of this code should target the
-         * background state for this exception.
+        /* Take an INVPC UsageFault by pushing the stack again;
+         * we know we're v7M so this is never a Secure UsageFault.
          */
+        assert(!arm_feature(env, ARM_FEATURE_V8));
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, false);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         v7m_push_stack(cpu);
-- 
2.7.4
