Received: from eggs.gnu.org ([2001:4830:134:3::10]:51502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eWKVP-0008UA-NB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eWKVK-0002xO-Ot
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:13:15 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eWKVK-0002vq-IT
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:13:10 -0500
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
Date: Tue, 2 Jan 2018 12:13:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] [SPARC] question on LEON IRQMP interrupt controller.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>

Hi Mark, Artyom,

I am wondering if the IRQMP code in hw/intc/grlib_irqmp.c is correct 
when it comes to acknowledging interrupts.

With the actual code an interrupt can be lowered/acked only by an "ack" 
from the processor which means that the trap handler related to this 
external interrupt needs to be run for the ack to happen.

In particular this means that the interrupt cannot be acked only by 
software. Even if the software clears the "pending" interrupts (by 
writing to the CLEAR_OFFSET register before the interrupt handler is 
run) this does not clear the interrupt to the processor (which is kept 
asserted until the handler is run and the interrupt acked by the 
processor). Do you know if this is indeed the intended behavior (I 
understand that for most operating system the interrupt handler will be 
run at last and this does not make a difference)?

I would expect that clearing interrupt through software (by writing to 
the CLEAR_OFFSET register) would have the same effect as the processor 
acknowledgment (and could avoid to run the interrupt handler if things 
have already been taken care of by software).

Unfortunately the documentation I got (on the web) on the IRQMP is not 
very clear on the topic.

Anyway you can find below the patch I'd like to provide for IRQMP.

Thanks

JC

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 94659ee256..d6f9cb3692 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -106,6 +106,15 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
      }
  }

+static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
+{
+    /* Clear registers */
+    state->pending  &= ~mask;
+    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
+
+    grlib_irqmp_check_irqs(state);
+}
+
  void grlib_irqmp_ack(DeviceState *dev, int intno)
  {
      IRQMP        *irqmp = GRLIB_IRQMP(dev);
@@ -120,11 +129,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)

      trace_grlib_irqmp_ack(intno);

-    /* Clear registers */
-    state->pending  &= ~mask;
-    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
-
-    grlib_irqmp_check_irqs(state);
+    grlib_irqmp_ack_mask(state, mask);
  }

  void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -251,7 +256,7 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,

      case CLEAR_OFFSET:
          value &= ~1; /* clean up the value */
-        state->pending &= ~value;
+        grlib_irqmp_ack_mask(state, value);
          return;

      case MP_STATUS_OFFSET:
