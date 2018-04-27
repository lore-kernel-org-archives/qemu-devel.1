Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZa-00011v-DU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZY-0001t3-OW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:49 +1000
Message-Id: <20180427092126.24812-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/49] mac_oldworld: move wiring of macio IRQs
 to macio_oldworld_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since the macio device has a link to the PIC device, we can now wire up the
IRQs directly via qdev GPIOs rather than having to use an intermediate array.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c         | 37 ++++++++++++++++++++++---------------
 hw/ppc/mac_oldworld.c         | 14 --------------
 include/hw/misc/macio/macio.h |  1 -
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index a0cefe5719..dac7bcd15e 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -152,10 +152,9 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     OldWorldMacIOState *os = OLDWORLD_MACIO(d);
+    DeviceState *pic_dev = DEVICE(os->pic);
     Error *err = NULL;
     SysBusDevice *sysbus_dev;
-    int i;
-    int cur_irq = 0;
 
     macio_common_realize(d, &err);
     if (err) {
@@ -164,11 +163,14 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     }
 
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
-    sysbus_connect_irq(sysbus_dev, 0, os->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                       OLDWORLD_CUDA_IRQ));
 
     sysbus_dev = SYS_BUS_DEVICE(&s->escc);
-    sysbus_connect_irq(sysbus_dev, 0, os->irqs[cur_irq++]);
-    sysbus_connect_irq(sysbus_dev, 1, os->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                       OLDWORLD_ESCCB_IRQ));
+    sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
+                                                       OLDWORLD_ESCCA_IRQ));
 
     object_property_set_bool(OBJECT(&os->nvram), true, "realized", &err);
     if (err) {
@@ -186,15 +188,22 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
     /* IDE buses */
-    for (i = 0; i < ARRAY_SIZE(os->ide); i++) {
-        qemu_irq irq0 = os->irqs[cur_irq++];
-        qemu_irq irq1 = os->irqs[cur_irq++];
+    macio_realize_ide(s, &os->ide[0],
+                      qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_IRQ),
+                      qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_DMA_IRQ),
+                      0x16, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
-        macio_realize_ide(s, &os->ide[i], irq0, irq1, 0x16 + (i * 4), &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+    macio_realize_ide(s, &os->ide[1],
+                      qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_IRQ),
+                      qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_DMA_IRQ),
+                      0x1a, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
     }
 }
 
@@ -219,8 +228,6 @@ static void macio_oldworld_init(Object *obj)
     DeviceState *dev;
     int i;
 
-    qdev_init_gpio_out(DEVICE(obj), os->irqs, ARRAY_SIZE(os->irqs));
-
     object_property_add_link(obj, "pic", TYPE_HEATHROW,
                              (Object **) &os->pic,
                              qdev_prop_allow_set_link_before_realize,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 2bbcefa076..4608bab014 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -281,20 +281,6 @@ static void ppc_heathrow_init(MachineState *machine)
     /* MacIO */
     macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
     dev = DEVICE(macio);
-    qdev_connect_gpio_out(dev, 0,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_CUDA_IRQ));
-    qdev_connect_gpio_out(dev, 1,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCB_IRQ));
-    qdev_connect_gpio_out(dev, 2,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCA_IRQ));
-    qdev_connect_gpio_out(dev, 3,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_IRQ));
-    qdev_connect_gpio_out(dev, 4,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_DMA_IRQ));
-    qdev_connect_gpio_out(dev, 5,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_IRQ));
-    qdev_connect_gpio_out(dev, 6,
-        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_DMA_IRQ));
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 4528282b36..64a2584a77 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -56,7 +56,6 @@ typedef struct OldWorldMacIOState {
     /*< public >*/
 
     HeathrowState *pic;
-    qemu_irq irqs[7];
 
     MacIONVRAMState nvram;
     MACIOIDEState ide[2];
-- 
2.14.3
