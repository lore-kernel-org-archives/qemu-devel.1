Received: from eggs.gnu.org ([2001:4830:134:3::10]:53284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf8-00007v-3s
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf4-0006kh-SW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 22:01:58 +0000
Message-Id: <20180306220159.4287-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
References: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/6] mac_oldworld: remove pics IRQ array and
 wire up macio to heathrow directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Introduce constants for the pre-defined Old World IRQs to help keep things
readable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac.h          |  8 ++++++++
 hw/ppc/mac_oldworld.c | 27 ++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 04568c2a22..6f3603c21e 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -45,6 +45,14 @@
 
 #define ESCC_CLOCK 3686400
 
+/* Old World IRQs */
+#define OLDWORLD_CUDA_IRQ      0x12
+#define OLDWORLD_ESCCB_IRQ     0x10
+#define OLDWORLD_ESCCA_IRQ     0xf
+#define OLDWORLD_IDE0_IRQ      0xd
+#define OLDWORLD_IDE0_DMA_IRQ  0x2
+#define OLDWORLD_IDE1_IRQ      0xe
+#define OLDWORLD_IDE1_DMA_IRQ  0x3
 
 /* MacIO */
 #define TYPE_MACIO_IDE "macio-ide"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 2bf70c4375..048b0cea7e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -88,7 +88,6 @@ static void ppc_heathrow_init(MachineState *machine)
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
-    qemu_irq *pic;
     int linux_boot, i;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
@@ -242,11 +241,6 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
 
-    pic = g_new0(qemu_irq, HEATHROW_NUM_IRQS);
-    for (i = 0; i < HEATHROW_NUM_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(pic_dev, i);
-    }
-
     /* Timebase Frequency */
     if (kvm_enabled()) {
         tbfreq = kvmppc_get_tbfreq();
@@ -288,13 +282,20 @@ static void ppc_heathrow_init(MachineState *machine)
     /* MacIO */
     macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
     dev = DEVICE(macio);
-    qdev_connect_gpio_out(dev, 0, pic[0x12]); /* CUDA */
-    qdev_connect_gpio_out(dev, 1, pic[0x10]); /* ESCC-B */
-    qdev_connect_gpio_out(dev, 2, pic[0x0F]); /* ESCC-A */
-    qdev_connect_gpio_out(dev, 3, pic[0x0D]); /* IDE-0 */
-    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE-0 DMA */
-    qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
-    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
+    qdev_connect_gpio_out(dev, 0,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_CUDA_IRQ));
+    qdev_connect_gpio_out(dev, 1,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCB_IRQ));
+    qdev_connect_gpio_out(dev, 2,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCA_IRQ));
+    qdev_connect_gpio_out(dev, 3,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_IRQ));
+    qdev_connect_gpio_out(dev, 4,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_DMA_IRQ));
+    qdev_connect_gpio_out(dev, 5,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_IRQ));
+    qdev_connect_gpio_out(dev, 6,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_DMA_IRQ));
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
-- 
2.11.0
