Received: from eggs.gnu.org ([2001:4830:134:3::10]:59317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS6-0007e3-Tl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS4-0006Fa-Ik
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:34 -0400
Received: from orth.archaic.org.uk ([81.2.115.148]:48421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUsS4-000683-Bf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:32 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsPq-0002yC-UY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:29:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:29:12 +0100
Message-Id: <1499768952-24990-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
References: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/4] target-arm: v7M: ignore writes to
 CONTROL.SPSEL from Thread mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For v7M, writes to the CONTROL register are only permitted for
privileged code. However even if the code is privileged, the
write must not affect the SPSEL bit in the CONTROL register
if the CPU is in Thread mode (as documented in the pseudocode
for the MSR instruction). Implement this, instead of permitting
SPSEL to be written in all cases.

This was causing mbed applications not to run, because the
RTX RTOS they use relies on this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1498820791-8130-1-git-send-email-peter.maydell@linaro.org
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
