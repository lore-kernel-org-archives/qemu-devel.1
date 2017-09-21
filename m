Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-00033i-5c
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XK-0002uP-Eh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XK-0002la-4t
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XI-00058K-RZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:23 +0100
Message-Id: <1506012099-13605-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/31] nvic: Handle v8M changes in
 nvic_exec_prio()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Update nvic_exec_prio() to support the v8M changes:
 * BASEPRI, FAULTMASK and PRIMASK are all banked
 * AIRCR.PRIS can affect NS priorities
 * AIRCR.BFHFNMINS affects FAULTMASK behaviour

These changes mean that it's no longer possible to
definitely say that if FAULTMASK is set it overrides
PRIMASK, and if PRIMASK is set it overrides BASEPRI
(since if PRIMASK_NS is set and AIRCR.PRIS is set then
whether that 0x80 priority should take effect or the
priority in BASEPRI_S depends on the value of BASEPRI_S,
for instance). So we switch to the same approach used
by the pseudocode of working through BASEPRI, PRIMASK
and FAULTMASK and overriding the previous values if
needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-16-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 35225c8..1f9e1aa 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -319,18 +319,51 @@ static void nvic_recompute_state(NVICState *s)
 static inline int nvic_exec_prio(NVICState *s)
 {
     CPUARMState *env = &s->cpu->env;
-    int running;
+    int running = NVIC_NOEXC_PRIO;
 
-    if (env->v7m.faultmask[env->v7m.secure]) {
-        running = -1;
-    } else if (env->v7m.primask[env->v7m.secure]) {
+    if (env->v7m.basepri[M_REG_NS] > 0) {
+        running = exc_group_prio(s, env->v7m.basepri[M_REG_NS], M_REG_NS);
+    }
+
+    if (env->v7m.basepri[M_REG_S] > 0) {
+        int basepri = exc_group_prio(s, env->v7m.basepri[M_REG_S], M_REG_S);
+        if (running > basepri) {
+            running = basepri;
+        }
+    }
+
+    if (env->v7m.primask[M_REG_NS]) {
+        if (env->v7m.aircr & R_V7M_AIRCR_PRIS_MASK) {
+            if (running > NVIC_NS_PRIO_LIMIT) {
+                running = NVIC_NS_PRIO_LIMIT;
+            }
+        } else {
+            running = 0;
+        }
+    }
+
+    if (env->v7m.primask[M_REG_S]) {
         running = 0;
-    } else if (env->v7m.basepri[env->v7m.secure] > 0) {
-        running = env->v7m.basepri[env->v7m.secure] &
-            nvic_gprio_mask(s, env->v7m.secure);
-    } else {
-        running = NVIC_NOEXC_PRIO; /* lower than any possible priority */
     }
+
+    if (env->v7m.faultmask[M_REG_NS]) {
+        if (env->v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+            running = -1;
+        } else {
+            if (env->v7m.aircr & R_V7M_AIRCR_PRIS_MASK) {
+                if (running > NVIC_NS_PRIO_LIMIT) {
+                    running = NVIC_NS_PRIO_LIMIT;
+                }
+            } else {
+                running = 0;
+            }
+        }
+    }
+
+    if (env->v7m.faultmask[M_REG_S]) {
+        running = (env->v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) ? -3 : -1;
+    }
+
     /* consider priority of active handler */
     return MIN(running, s->exception_prio);
 }
-- 
2.7.4
