Received: from eggs.gnu.org ([2001:4830:134:3::10]:60177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XL-00032l-EZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XJ-0002rN-Pv
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XJ-0002Bq-Hm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XG-00057D-TZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:20 +0100
Message-Id: <1506012099-13605-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/31] nvic: In escalation to HardFault,
 support HF not being priority -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When escalating to HardFault, we must go into Lockup if we
can't take the synchronous HardFault because the current
execution priority is already at or below the priority of
HardFault. In v7M HF is always priority -1 so a simple < 0
comparison sufficed; in v8M the priority of HardFault can
vary depending on whether it is a Secure or NonSecure
HardFault, so we must check against the priority of the
HardFault exception vector we're about to use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-13-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d4b410d..1a8ce01 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -487,18 +487,8 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
         }
 
         if (escalate) {
-            if (running < 0) {
-                /* We want to escalate to HardFault but we can't take a
-                 * synchronous HardFault at this point either. This is a
-                 * Lockup condition due to a guest bug. We don't model
-                 * Lockup, so report via cpu_abort() instead.
-                 */
-                cpu_abort(&s->cpu->parent_obj,
-                          "Lockup: can't escalate %d to HardFault "
-                          "(current priority %d)\n", irq, running);
-            }
 
-            /* We can do the escalation, so we take HardFault instead.
+            /* We need to escalate this exception to a synchronous HardFault.
              * If BFHFNMINS is set then we escalate to the banked HF for
              * the target security state of the original exception; otherwise
              * we take a Secure HardFault.
@@ -511,6 +501,17 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
             } else {
                 vec = &s->vectors[irq];
             }
+            if (running <= vec->prio) {
+                /* We want to escalate to HardFault but we can't take the
+                 * synchronous HardFault at this point either. This is a
+                 * Lockup condition due to a guest bug. We don't model
+                 * Lockup, so report via cpu_abort() instead.
+                 */
+                cpu_abort(&s->cpu->parent_obj,
+                          "Lockup: can't escalate %d to HardFault "
+                          "(current priority %d)\n", irq, running);
+            }
+
             /* HF may be banked but there is only one shared HFSR */
             s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
         }
-- 
2.7.4
