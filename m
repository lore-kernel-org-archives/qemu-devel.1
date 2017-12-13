Received: from eggs.gnu.org ([2001:4830:134:3::10]:51549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWc-0004kI-H9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWb-0007sM-C5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWb-0007pU-5o
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWa-0007gs-0e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:17 +0000
Message-Id: <1513188761-20784-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/43] target/arm: Allow explicit writes to
 CONTROL.SPSEL in Handler mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In ARMv7M the CPU ignores explicit writes to CONTROL.SPSEL
in Handler mode. In v8M the behaviour is slightly different:
writes to the bit are permitted but will have no effect.

We've already done the hard work to handle the value in
CONTROL.SPSEL being out of sync with what stack pointer is
actually in use, so all we need to do to fix this last loose
end is to update the condition we use to guard whether we
call write_v7m_control_spsel() on the register write.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1512153879-5291-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88394d4..f21c142 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10091,8 +10091,11 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
          * thread mode; other bits can be updated by any privileged code.
          * write_v7m_control_spsel() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
+         * For v7M, we must just ignore explicit writes to SPSEL in handler
+         * mode; for v8M the write is permitted but will have no effect.
          */
-        if (!arm_v7m_is_handler_mode(env)) {
+        if (arm_feature(env, ARM_FEATURE_V8) ||
+            !arm_v7m_is_handler_mode(env)) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
         env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
-- 
2.7.4
