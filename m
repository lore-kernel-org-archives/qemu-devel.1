Received: from eggs.gnu.org ([2001:4830:134:3::10]:49460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwl7-0003WX-0P
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwl6-0004hb-6K
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:58 +0100
Message-Id: <1501692241-23310-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/15] target/arm: Don't calculate lr in
 arm_v7m_cpu_do_interrupt() until needed
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

Move the code in arm_v7m_cpu_do_interrupt() that calculates the
magic LR value down to when we're actually going to use it.
Having the calculation and use so far apart makes the code
a little harder to understand than it needs to be.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b64ddb1..0ecc8f1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6311,13 +6311,6 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
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
@@ -6408,6 +6401,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
