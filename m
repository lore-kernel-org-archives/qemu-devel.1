Received: from eggs.gnu.org ([2001:4830:134:3::10]:59716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vv-00016r-LT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vu-0005AW-Vf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vu-00055y-PQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vh-0003NN-S0
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:02 +0000
Message-Id: <1485531137-2362-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/22] armv7m: Clear FAULTMASK on return from
 non-NMI exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

FAULTMASK must be cleared on return from all
exceptions other than NMI.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1484937883-1068-7-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc383d1..cfbc622 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5969,8 +5969,13 @@ static void do_v7m_exception_exit(CPUARMState *env)
     uint32_t xpsr;
 
     type = env->regs[15];
-    if (env->v7m.exception != 0)
+    if (env->v7m.exception != ARMV7M_EXCP_NMI) {
+        /* Auto-clear FAULTMASK on return from other than NMI */
+        env->daif &= ~PSTATE_F;
+    }
+    if (env->v7m.exception != 0) {
         armv7m_nvic_complete_irq(env->nvic, env->v7m.exception);
+    }
 
     /* Switch to the target stack.  */
     switch_v7m_sp(env, (type & 4) != 0);
-- 
2.7.4
