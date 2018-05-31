Received: from eggs.gnu.org ([2001:4830:134:3::10]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOBgf-0005H4-NL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 20:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOBgf-0006uY-1B
	for qemu-devel@nongnu.org; Wed, 30 May 2018 20:43:29 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 30 May 2018 20:43:21 -0400
Message-Id: <20180531004323.4611-2-jsnow@redhat.com>
In-Reply-To: <20180531004323.4611-1-jsnow@redhat.com>
References: <20180531004323.4611-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] ahci: trim signatures on raise/lower
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

These functions work on the AHCI device, not the individual
AHCI devices, so trim the AHCIDevice argument.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be05f..b7a6f68790 100644
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
