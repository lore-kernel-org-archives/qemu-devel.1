Received: from eggs.gnu.org ([2001:4830:134:3::10]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP83-0001cu-02
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP82-0002AW-7K
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:51:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:52:07 +0100
Message-Id: <1505137930-13255-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/7] nvic: Don't apply group priority mask to
 negative priorities
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

In several places we were unconditionally applying the
nvic_gprio_mask() to a priority value. This is incorrect
if the priority is one of the fixed negative priority
values (for NMI and HardFault), so don't do it.

This bug would have caused both NMI and HardFault to be
considered as the same priority and so NMI wouldn't
correctly preempt HardFault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 1fecfd6..d3e2056 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -152,8 +152,12 @@ static void nvic_recompute_state(NVICState *s)
         }
     }
 
+    if (active_prio > 0) {
+        active_prio &= nvic_gprio_mask(s);
+    }
+
     s->vectpending = pend_irq;
-    s->exception_prio = active_prio & nvic_gprio_mask(s);
+    s->exception_prio = active_prio;
 
     trace_nvic_recompute_state(s->vectpending, s->exception_prio);
 }
@@ -329,7 +333,10 @@ void armv7m_nvic_acknowledge_irq(void *opaque)
     assert(vec->enabled);
     assert(vec->pending);
 
-    pendgroupprio = vec->prio & nvic_gprio_mask(s);
+    pendgroupprio = vec->prio;
+    if (pendgroupprio > 0) {
+        pendgroupprio &= nvic_gprio_mask(s);
+    }
     assert(pendgroupprio < running);
 
     trace_nvic_acknowledge_irq(pending, vec->prio);
-- 
2.7.4
