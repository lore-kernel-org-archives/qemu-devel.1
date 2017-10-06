Received: from eggs.gnu.org ([2001:4830:134:3::10]:58021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1i-00048S-0E
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1h-0007kd-6b
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1g-0007js-W5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1f-0002x9-Sv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:39 +0100
Message-Id: <1507305585-20608-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/20] target/arm: Add support for restoring v8M
 additional state context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For v8M, exceptions from Secure to Non-Secure state will save
callee-saved registers to the exception frame as well as the
caller-saved registers. Add support for unstacking these
registers in exception exit when necessary.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-12-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4aa32d0..f93a214 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6463,6 +6463,36 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                           "for destination state is UNPREDICTABLE\n");
         }
 
+        /* Do we need to pop callee-saved registers? */
+        if (return_to_secure &&
+            ((excret & R_V7M_EXCRET_ES_MASK) == 0 ||
+             (excret & R_V7M_EXCRET_DCRS_MASK) == 0)) {
+            uint32_t expected_sig = 0xfefa125b;
+            uint32_t actual_sig = ldl_phys(cs->as, frameptr);
+
+            if (expected_sig != actual_sig) {
+                /* Take a SecureFault on the current stack */
+                env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
+                armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+                v7m_exception_taken(cpu, excret);
+                qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
+                              "stackframe: failed exception return integrity "
+                              "signature check\n");
+                return;
+            }
+
+            env->regs[4] = ldl_phys(cs->as, frameptr + 0x8);
+            env->regs[5] = ldl_phys(cs->as, frameptr + 0xc);
+            env->regs[6] = ldl_phys(cs->as, frameptr + 0x10);
+            env->regs[7] = ldl_phys(cs->as, frameptr + 0x14);
+            env->regs[8] = ldl_phys(cs->as, frameptr + 0x18);
+            env->regs[9] = ldl_phys(cs->as, frameptr + 0x1c);
+            env->regs[10] = ldl_phys(cs->as, frameptr + 0x20);
+            env->regs[11] = ldl_phys(cs->as, frameptr + 0x24);
+
+            frameptr += 0x28;
+        }
+
         /* Pop registers. TODO: make these accesses use the correct
          * attributes and address space (S/NS, priv/unpriv) and handle
          * memory transaction failures.
-- 
2.7.4
