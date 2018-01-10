Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZNDt-0002E2-CE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZNDs-0002Sc-F5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:43:45 -0500
Received: from relay3-d.mail.gandi.net ([2001:4b98:c:538::195]:46853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eZNDs-0002Qc-6D
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:43:44 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 10 Jan 2018 21:43:27 +0100
Message-Id: <20180110204327.22510-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: chouteau@adacore.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
* Explicitely by software writing to the CLEAR_OFFSET register
* Implicitely when the procesor is done running the trap handler attached
  to the IRQ.

The actual IRQMP code only allows the implicit processor triggered IRQ ack.
If software write explicitely to the CLEAR_OFFSET register, this will clear
the pending bit in the register value but this will not lower the onloing
raised IRQ with the processor. The IRQ will be kept raised to the LEON
processor until the related trap handler is run and the processor implicitely
ack the interrupt. So with the actual IRQMP code trap hadler have to be run
even if the software has already done its job by clearing the pending bit.

This feature has been tested on another LEON3 simulator (tsim_leon3 from
Gaisler) and it turns out that the Qemu implementation is not equivalent to
the tsim one. In tsim, if software does clear a pending interrupt before
the related interrupt handler is triggered the said interrupt handler will
not be called.

This patch bring the Qemu IRQMP implementation in line with the tsim
implementation by allowing IRQ to be acknoledged by software only.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/intc/grlib_irqmp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 94659ee256..d6f9cb3692 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -106,6 +106,15 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
     }
 }
 
+static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
+{
+    /* Clear registers */
+    state->pending  &= ~mask;
+    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
+
+    grlib_irqmp_check_irqs(state);
+}
+
 void grlib_irqmp_ack(DeviceState *dev, int intno)
 {
     IRQMP        *irqmp = GRLIB_IRQMP(dev);
@@ -120,11 +129,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
 
     trace_grlib_irqmp_ack(intno);
 
-    /* Clear registers */
-    state->pending  &= ~mask;
-    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
-
-    grlib_irqmp_check_irqs(state);
+    grlib_irqmp_ack_mask(state, mask);
 }
 
 void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -251,7 +256,7 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 
     case CLEAR_OFFSET:
         value &= ~1; /* clean up the value */
-        state->pending &= ~value;
+        grlib_irqmp_ack_mask(state, value);
         return;
 
     case MP_STATUS_OFFSET:
-- 
2.14.1
