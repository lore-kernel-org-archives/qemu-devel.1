Received: from eggs.gnu.org ([2001:4830:134:3::10]:47793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RQ-4S
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUA-0001VX-3F
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLU9-0001VD-UK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:04 -0400
Message-Id: <20180608174733.4936-2-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 01/30] ahci: trim signatures on raise/lower
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

These functions work on the AHCI device, not the individual
AHCI devices, so trim the AHCIDevice argument.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180531004323.4611-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 24dbad5125..66f55aecb3 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -131,7 +131,7 @@ static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
     return val;
 }
 
-static void ahci_irq_raise(AHCIState *s, AHCIDevice *dev)
+static void ahci_irq_raise(AHCIState *s)
 {
     DeviceState *dev_state = s->container;
     PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
@@ -146,7 +146,7 @@ static void ahci_irq_raise(AHCIState *s, AHCIDevice *dev)
     }
 }
 
-static void ahci_irq_lower(AHCIState *s, AHCIDevice *dev)
+static void ahci_irq_lower(AHCIState *s)
 {
     DeviceState *dev_state = s->container;
     PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
@@ -174,9 +174,9 @@ static void ahci_check_irq(AHCIState *s)
     trace_ahci_check_irq(s, old_irq, s->control_regs.irqstatus);
     if (s->control_regs.irqstatus &&
         (s->control_regs.ghc & HOST_CTL_IRQ_EN)) {
-            ahci_irq_raise(s, NULL);
+            ahci_irq_raise(s);
     } else {
-        ahci_irq_lower(s, NULL);
+        ahci_irq_lower(s);
     }
 }
 
-- 
2.14.3
