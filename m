Received: from eggs.gnu.org ([2001:4830:134:3::10]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKmm-0007hj-OJ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKml-0007OQ-Jq
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:04 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  3 May 2018 21:24:41 +0100
Message-Id: <20180503202441.26293-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
References: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] mac_newworld: move wiring of macio IRQs to
 macio_newworld_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Since the macio device has a link to the PIC device, we can now wire up the
IRQs directly via qdev GPIOs rather than having to use an intermediate array.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c         | 39 +++++++++++++++++++++++----------------
 hw/ppc/mac_newworld.c         | 14 --------------
 include/hw/misc/macio/macio.h |  1 -
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index dac7bcd15e..79621eb879 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -279,11 +279,10 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     NewWorldMacIOState *ns = NEWWORLD_MACIO(d);
+    DeviceState *pic_dev = DEVICE(ns->pic);
     Error *err = NULL;
     SysBusDevice *sysbus_dev;
     MemoryRegion *timer_memory = NULL;
-    int i;
-    int cur_irq = 0;
 
     macio_common_realize(d, &err);
     if (err) {
@@ -292,11 +291,14 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     }
 
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
-    sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                       NEWWORLD_CUDA_IRQ));
 
     sysbus_dev = SYS_BUS_DEVICE(&s->escc);
-    sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
-    sysbus_connect_irq(sysbus_dev, 1, ns->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                       NEWWORLD_ESCCB_IRQ));
+    sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
+                                                       NEWWORLD_ESCCA_IRQ));
 
     /* OpenPIC */
     sysbus_dev = SYS_BUS_DEVICE(ns->pic);
@@ -304,15 +306,22 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
     /* IDE buses */
-    for (i = 0; i < ARRAY_SIZE(ns->ide); i++) {
-        qemu_irq irq0 = ns->irqs[cur_irq++];
-        qemu_irq irq1 = ns->irqs[cur_irq++];
-
-        macio_realize_ide(s, &ns->ide[i], irq0, irq1, 0x16 + (i * 4), &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+    macio_realize_ide(s, &ns->ide[0],
+                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ),
+                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ),
+                      0x16, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    macio_realize_ide(s, &ns->ide[1],
+                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ),
+                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ),
+                      0x1a, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
     }
 
     /* Timer */
@@ -328,8 +337,6 @@ static void macio_newworld_init(Object *obj)
     NewWorldMacIOState *ns = NEWWORLD_MACIO(obj);
     int i;
 
-    qdev_init_gpio_out(DEVICE(obj), ns->irqs, ARRAY_SIZE(ns->irqs));
-
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &ns->pic,
                              qdev_prop_allow_set_link_before_realize,
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 6a070f13bd..744acdfd2e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -375,20 +375,6 @@ static void ppc_core99_init(MachineState *machine)
     /* MacIO */
     macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
-    qdev_connect_gpio_out(dev, 0,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_CUDA_IRQ));
-    qdev_connect_gpio_out(dev, 1,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCB_IRQ));
-    qdev_connect_gpio_out(dev, 2,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCA_IRQ));
-    qdev_connect_gpio_out(dev, 3,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ));
-    qdev_connect_gpio_out(dev, 4,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ));
-    qdev_connect_gpio_out(dev, 5,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ));
-    qdev_connect_gpio_out(dev, 6,
-        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ));
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 64a2584a77..838eaf1db0 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -71,7 +71,6 @@ typedef struct NewWorldMacIOState {
     /*< public >*/
 
     OpenPICState *pic;
-    qemu_irq irqs[7];
     MACIOIDEState ide[2];
 } NewWorldMacIOState;
 
-- 
2.11.0
