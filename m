Received: from eggs.gnu.org ([2001:4830:134:3::10]:56561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvG-0000pk-9p
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvF-00007L-50
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59099
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFgvE-0008Lp-RL
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 17 Nov 2017 13:42:35 +0000
Message-Id: <1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/15] sun4u: move ISABus inside of EBusState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Since the EBus is effectively a PCI-ISA bridge then the underlying ISA bus
should be contained within the PCI bridge itself.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 394b7d6..63b4aaa 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -84,6 +84,7 @@ typedef struct EbusState {
     /*< private >*/
     PCIDevice parent_obj;
 
+    ISABus *isa_bus;
     MemoryRegion bar0;
     MemoryRegion bar1;
 } EbusState;
@@ -245,8 +246,10 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 {
     EbusState *s = EBUS(pci_dev);
 
-    if (!isa_bus_new(DEVICE(pci_dev), get_system_memory(),
-                     pci_address_space_io(pci_dev), errp)) {
+    s->isa_bus = isa_bus_new(DEVICE(pci_dev), get_system_memory(),
+                             pci_address_space_io(pci_dev), errp);
+    if (!s->isa_bus) {
+        error_setg(errp, "unable to instantiate EBUS ISA bus");
         return;
     }
 
-- 
1.7.10.4
