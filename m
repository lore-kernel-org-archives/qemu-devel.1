Received: from eggs.gnu.org ([2001:4830:134:3::10]:46628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeBE-00033o-09
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeBD-0002WV-AH
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:44:56 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 18:44:43 +0000
Message-Id: <1484937883-1068-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] armv7m: Clear FAULTMASK on return from
 non-NMI exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>

From: Michael Davidsaver <mdavidsaver@gmail.com>

FAULTMASK must be cleared on return from all
exceptions other than NMI.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
