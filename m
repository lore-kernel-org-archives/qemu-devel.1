Received: from eggs.gnu.org ([2001:4830:134:3::10]:33013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eyHWH-0003Hj-BO
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eyHWB-00049C-Fc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:41:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 13:41:14 +0000
Message-Id: <20180320134114.30418-5-peter.maydell@linaro.org>
In-Reply-To: <20180320134114.30418-1-peter.maydell@linaro.org>
References: <20180320134114.30418-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12 4/4] target/arm: Always set FAR to a
 known unknown value for debug exceptions
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

For debug exceptions due to breakpoints or the BKPT instruction which
are taken to AArch32, the Fault Address Register is architecturally
UNKNOWN.  We were using that as license to simply not set
env->exception.vaddress, but this isn't correct, because it will
expose to the guest whatever old value was in that field when
arm_cpu_do_interrupt_aarch32() writes it to the guest IFSR.  That old
value might be a FAR for a previous guest EL2 or secure exception, in
which case we shouldn't show it to an EL1 or non-secure exception
handler. It might also be a non-deterministic value, which is bad
for record-and-replay.

Clear env->exception.vaddress before taking breakpoint debug
exceptions, to avoid this minor information leak.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8e1e521193..a266cc0116 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -490,6 +490,11 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 {
     /* FSR will only be used if the debug target EL is AArch32. */
     env->exception.fsr = arm_debug_exception_fsr(env);
+    /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+     * values to the guest that it shouldn't be able to see at its
+     * exception/security level.
+     */
+    env->exception.vaddress = 0;
     raise_exception(env, EXCP_BKPT, syndrome, arm_debug_target_el(env));
 }
 
@@ -1353,7 +1358,11 @@ void arm_debug_excp_handler(CPUState *cs)
         }
 
         env->exception.fsr = arm_debug_exception_fsr(env);
-        /* FAR is UNKNOWN, so doesn't need setting */
+        /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+         * values to the guest that it shouldn't be able to see at its
+         * exception/security level.
+         */
+        env->exception.vaddress = 0;
         raise_exception(env, EXCP_PREFETCH_ABORT,
                         syn_breakpoint(same_el),
                         arm_debug_target_el(env));
-- 
2.16.2
