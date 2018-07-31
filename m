Received: from eggs.gnu.org ([2001:4830:134:3::10]:57385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMPA-0005R7-9v
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMP8-0004UX-FZ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:04 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Tue, 31 Jul 2018 06:36:35 +0200
Message-Id: <20180731043635.9802-3-mail@sebastianbauer.info>
In-Reply-To: <20180731043635.9802-1-mail@sebastianbauer.info>
References: <20180731043635.9802-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH 2/2] sam460ex: Create the PCI-X bus with only
 one interrupt
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

This is done by unfolding the sysbus_create_varargs() call and by
announcing that only a single irq is needed before connecting the irqs
before the bus is initialized.

This should model the design of the SAM board better, which is that all
PCI interrupts are connected to a single interrupt pin, in particular that
the logical level of the destination pin is an combined or of all the
individual interrupt levels.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 hw/ppc/sam460ex.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b2b22f280d..28265bcb4c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -515,10 +515,16 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     ppc460ex_pcie_init(env);
-    /* All PCI ints are connected to the same UIC pin (cf. UBoot source) */
-    dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
-                                uic[1][0], uic[1][0], uic[1][0], uic[1][0],
-                                NULL);
+
+    /* All PCI ints of the PCI-X bus are connected to the same UIC pin (cf.
+     * UBoot source) so only one connection is needed. */
+    dev = qdev_create(NULL, "ppc440-pcix-host");
+    qdev_prop_set_uint16(dev, "num-irqs", 1);
+    sbdev = SYS_BUS_DEVICE(dev);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(sbdev, 0, 0xc0ec00000);
+    sysbus_connect_irq(sbdev, 0, uic[1][0]);
+
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pci_bus) {
         error_report("couldn't create PCI controller!");
-- 
2.18.0
