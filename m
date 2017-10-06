Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1m-0004FK-Nm
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1i-0007n8-Mn
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1i-0007eF-EE
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1e-0002vn-5F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:36 +0100
Message-Id: <1507305585-20608-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/20] target/arm: Don't warn about exception
 return with PC low bit set for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the v8M architecture, return from an exception to a PC which
has bit 0 set is not UNPREDICTABLE; it is defined that bit 0
is discarded [R_HRJH]. Restrict our complaint about this to v7M.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-9-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb57be7..c7cf24c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6431,16 +6431,24 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         env->regs[12] = ldl_phys(cs->as, frameptr + 0x10);
         env->regs[14] = ldl_phys(cs->as, frameptr + 0x14);
         env->regs[15] = ldl_phys(cs->as, frameptr + 0x18);
+
+        /* Returning from an exception with a PC with bit 0 set is defined
+         * behaviour on v8M (bit 0 is ignored), but for v7M it was specified
+         * to be UNPREDICTABLE. In practice actual v7M hardware seems to ignore
+         * the lsbit, and there are several RTOSes out there which incorrectly
+         * assume the r15 in the stack frame should be a Thumb-style "lsbit
+         * indicates ARM/Thumb" value, so ignore the bit on v7M as well, but
+         * complain about the badly behaved guest.
+         */
         if (env->regs[15] & 1) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "M profile return from interrupt with misaligned "
-                          "PC is UNPREDICTABLE\n");
-            /* Actual hardware seems to ignore the lsbit, and there are several
-             * RTOSes out there which incorrectly assume the r15 in the stack
-             * frame should be a Thumb-style "lsbit indicates ARM/Thumb" value.
-             */
             env->regs[15] &= ~1U;
+            if (!arm_feature(env, ARM_FEATURE_V8)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "M profile return from interrupt with misaligned "
+                              "PC is UNPREDICTABLE on v7M\n");
+            }
         }
+
         xpsr = ldl_phys(cs->as, frameptr + 0x1c);
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
-- 
2.7.4
