Received: from eggs.gnu.org ([2001:4830:134:3::10]:33038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fjzy5-0007F3-Fs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fjzy2-0000VG-6P
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:39:37 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Mon, 30 Jul 2018 06:39:04 +0200
Message-Id: <20180730043904.17023-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, balaton@eik.bme.hu

The four interrupts of the PCI bus are connected to the same UIC pin on the
real Sam460ex. Evidence for this can be found in the UBoot source for the
Sam460ex in the Sam460ex.c file where PCI_INTERRUPT_LINE in written. This
change brings the connection in line with this.

This fixes the problem that can be observed when adding further PCI cards
that get their interrupt rotated to other interrupts than PCI INT A. In
particular, the bug was observed and verified to be fixed (after this
change) with an additional OHCI PCI card.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 hw/ppc/sam460ex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 0999efcc1e..b2b22f280d 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -515,9 +515,9 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     ppc460ex_pcie_init(env);
-    /* FIXME: is this correct? */
+    /* All PCI ints are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
-                                uic[1][0], uic[1][20], uic[1][21], uic[1][22],
+                                uic[1][0], uic[1][0], uic[1][0], uic[1][0],
                                 NULL);
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pci_bus) {
-- 
2.18.0
