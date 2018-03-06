Received: from eggs.gnu.org ([2001:4830:134:3::10]:49202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3np-0001Ou-3M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nn-0004Oj-VO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:39 +1100
Message-Id: <20180306040154.3669-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/30] mac_oldworld: use object link to pass
 heathrow PIC object to macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also switch macio_oldworld_realize() over to use it rather than using the pic_mem
memory region directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c         | 14 ++++++++++----
 hw/ppc/mac_oldworld.c         |  8 +++++---
 include/hw/misc/macio/macio.h |  2 ++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 4e502ede2e..d4c1d190c4 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
+#include "hw/intc/heathrow_pic.h"
 
 /*
  * The mac-io has two interfaces to the ESCC. One is called "escc-legacy",
@@ -167,10 +168,10 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
                                 sysbus_mmio_get_region(sysbus_dev, 0));
     pmac_format_nvram_partition(&os->nvram, os->nvram.size);
 
-    if (s->pic_mem) {
-        /* Heathrow PIC */
-        memory_region_add_subregion(&s->bar, 0x00000, s->pic_mem);
-    }
+    /* Heathrow PIC */
+    sysbus_dev = SYS_BUS_DEVICE(os->pic);
+    memory_region_add_subregion(&s->bar, 0x0,
+                                sysbus_mmio_get_region(sysbus_dev, 0));
 
     /* IDE buses */
     for (i = 0; i < ARRAY_SIZE(os->ide); i++) {
@@ -208,6 +209,11 @@ static void macio_oldworld_init(Object *obj)
 
     qdev_init_gpio_out(DEVICE(obj), os->irqs, ARRAY_SIZE(os->irqs));
 
+    object_property_add_link(obj, "pic", TYPE_HEATHROW,
+                             (Object **) &os->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
     dev = DEVICE(&os->nvram);
     qdev_prop_set_uint32(dev, "size", 0x2000);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 5903ff47d3..3ac5b19073 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -93,7 +93,7 @@ static void ppc_heathrow_init(MachineState *machine)
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
     PCIBus *pci_bus;
-    PCIDevice *macio;
+    OldWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
     DeviceState *dev, *pic_dev;
     SysBusDevice *sbd;
@@ -271,7 +271,7 @@ static void ppc_heathrow_init(MachineState *machine)
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     /* MacIO */
-    macio = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
+    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
     dev = DEVICE(macio);
     qdev_connect_gpio_out(dev, 0, pic[0x12]); /* CUDA */
     qdev_connect_gpio_out(dev, 1, pic[0x10]); /* ESCC-B */
@@ -281,8 +281,10 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
     qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
+    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
+                             &error_abort);
     sbd = SYS_BUS_DEVICE(pic_dev);
-    macio_init(macio, sysbus_mmio_get_region(sbd, 0));
+    macio_init(PCI_DEVICE(macio), sysbus_mmio_get_region(sbd, 0));
 
     macio_ide = MACIO_IDE(object_resolve_path_component(OBJECT(macio),
                                                         "ide[0]"));
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index e1e249f898..843c114c07 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -26,6 +26,7 @@
 #ifndef MACIO_H
 #define MACIO_H
 
+#include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/ppc/mac_dbdma.h"
 
@@ -54,6 +55,7 @@ typedef struct OldWorldMacIOState {
     MacIOState parent_obj;
     /*< public >*/
 
+    HeathrowState *pic;
     qemu_irq irqs[7];
 
     MacIONVRAMState nvram;
-- 
2.14.3
