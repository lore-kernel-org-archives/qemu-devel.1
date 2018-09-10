Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzT5C-000696-KO
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzT59-00036j-BR
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:46:54 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 10 Sep 2018 21:46:30 +0100
Message-Id: <20180910204631.24106-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 1/2] lsi53c895a: add optional external IRQ
 via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On some early machines the on-board PCI devices IRQs are wired directly to
the interrupt controller instead of via the PCI host bridge.

Add an optional external IRQ that if wired up via qdev will replace the
in-built PCI IRQ.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/lsi53c895a.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f5cbbf653c..996b40650d 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -207,6 +207,7 @@ typedef struct {
     PCIDevice parent_obj;
     /*< public >*/
 
+    qemu_irq ext_irq;
     MemoryRegion mmio_io;
     MemoryRegion ram_io;
     MemoryRegion io_io;
@@ -443,9 +444,19 @@ static void lsi_stop_script(LSIState *s)
     s->istat1 &= ~LSI_ISTAT1_SRUN;
 }
 
-static void lsi_update_irq(LSIState *s)
+static void lsi_set_irq(LSIState *s, int level)
 {
     PCIDevice *d = PCI_DEVICE(s);
+
+    if (s->ext_irq) {
+        qemu_set_irq(s->ext_irq, level);
+    } else {
+        pci_set_irq(d, level);
+    }
+}
+
+static void lsi_update_irq(LSIState *s)
+{
     int level;
     static int last_level;
     lsi_request *p;
@@ -477,7 +488,7 @@ static void lsi_update_irq(LSIState *s)
                 level, s->dstat, s->sist1, s->sist0);
         last_level = level;
     }
-    pci_set_irq(d, level);
+    lsi_set_irq(s, level);
 
     if (!level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) {
         DPRINTF("Handled IRQs & disconnected, looking for pending "
@@ -2213,6 +2224,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-io", 256);
 
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
+    qdev_init_gpio_out(d, &s->ext_irq, 1);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_io);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio_io);
-- 
2.11.0
