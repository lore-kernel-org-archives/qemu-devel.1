Received: from eggs.gnu.org ([2001:4830:134:3::10]:52439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSK-0004uN-93
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS9-0004jD-1N
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS8-0004ia-QO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS7-0005UZ-RO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:43 +0100
Message-Id: <1504527967-29248-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/36] target/arm: Don't calculate lr in
 arm_v7m_cpu_do_interrupt() until needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the code in arm_v7m_cpu_do_interrupt() that calculates the
magic LR value down to when we're actually going to use it.
Having the calculation and use so far apart makes the code
a little harder to understand than it needs to be.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-13-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9410856..267a170 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6306,13 +6306,6 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     arm_log_exception(cs->exception_index);
 
-    lr = 0xfffffff1;
-    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
-        lr |= 4;
-    }
-    if (env->v7m.exception == 0)
-        lr |= 8;
-
     /* For exceptions we just mark as pending on the NVIC, and let that
        handle it.  */
     switch (cs->exception_index) {
@@ -6403,6 +6396,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         return; /* Never happens.  Keep compiler happy.  */
     }
 
+    lr = 0xfffffff1;
+    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
+        lr |= 4;
+    }
+    if (env->v7m.exception == 0) {
+        lr |= 8;
+    }
+
     v7m_push_stack(cpu);
     v7m_exception_taken(cpu, lr);
     qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
-- 
2.7.4
