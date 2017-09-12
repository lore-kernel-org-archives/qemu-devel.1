Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph3-0003SS-4J
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph1-0006Rv-Rf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:58 +0100
Message-Id: <1505240046-11454-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/19] nvic: Compare group priority for
 escalation to HF
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

In armv7m_nvic_set_pending() we have to compare the
priority of an exception against the execution priority
to decide whether it needs to be escalated to HardFault.
In the specification this is a comparison against the
exception's group priority; for v7M we implemented it
as a comparison against the raw exception priority
because the two comparisons will always give the
same answer. For v8M the existence of AIRCR.PRIS and
the possibility of different PRIGROUP values for secure
and nonsecure exceptions means we need to explicitly
calculate the vector's group priority for this check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 00c03b4..3361a28 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -478,7 +478,7 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
         int running = nvic_exec_prio(s);
         bool escalate = false;
 
-        if (vec->prio >= running) {
+        if (exc_group_prio(s, vec->prio, secure) >= running) {
             trace_nvic_escalate_prio(irq, vec->prio, running);
             escalate = true;
         } else if (!vec->enabled) {
-- 
2.7.4
