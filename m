Received: from eggs.gnu.org ([2001:4830:134:3::10]:51059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6F-0003cM-7V
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6E-0004R0-85
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:07 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43106
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRw6E-0004Ke-18
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:06 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:32 +0000
Message-Id: <20171221082045.14022-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 03/16] sun4u: move ISABus inside of EBusState
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
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc64/sun4u.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 394b7d6c59..63b4aaa6eb 100644
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
2.11.0
