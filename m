Received: from eggs.gnu.org ([2001:4830:134:3::10]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dQtl6-0001ap-Re
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dQtl5-0004GO-Rw
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:06:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 12:06:31 +0100
Message-Id: <1498820791-8130-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target-arm: v7M: ignore writes to
 CONTROL.SPSEL from Thread mode
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

For v7M, writes to the CONTROL register are only permitted for
privileged code. However even if the code is privileged, the
write must not affect the SPSEL bit in the CONTROL register
if the CPU is in Thread mode (as documented in the pseudocode
for the MSR instruction). Implement this, instead of permitting
SPSEL to be written in all cases.

This was causing mbed applications not to run, because the
RTX RTOS they use relies on this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2594faa..4ed32c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8768,9 +8768,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 20: /* CONTROL */
-        switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
-        env->v7m.control = val & (R_V7M_CONTROL_SPSEL_MASK |
-                                  R_V7M_CONTROL_NPRIV_MASK);
+        /* Writing to the SPSEL bit only has an effect if we are in
+         * thread mode; other bits can be updated by any privileged code.
+         * switch_v7m_sp() deals with updating the SPSEL bit in
+         * env->v7m.control, so we only need update the others.
+         */
+        if (env->v7m.exception == 0) {
+            switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
+        }
+        env->v7m.control &= ~R_V7M_CONTROL_NPRIV_MASK;
+        env->v7m.control |= val & R_V7M_CONTROL_NPRIV_MASK;
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
-- 
2.7.4
