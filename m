Received: from eggs.gnu.org ([2001:4830:134:3::10]:49237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nq-0001QF-C3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3no-0004PR-Um
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:42 +1100
Message-Id: <20180306040154.3669-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/30] mac_newworld: use object link to pass
 OpenPIC object to macio
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

Also switch macio_newworld_realize() over to use it rather than using the pic_mem
memory region directly.

Now that both Old World and New World macio devices no longer make use of the
pic_mem memory region directly, we can remove it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c         | 14 +++++++++-----
 hw/ppc/mac_newworld.c         | 20 +++++++++++---------
 include/hw/misc/macio/macio.h |  4 +++-
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index d4c1d190c4..e5288f1084 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -279,10 +279,10 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
     sysbus_connect_irq(sysbus_dev, 1, ns->irqs[cur_irq++]);
 
-    if (s->pic_mem) {
-        /* OpenPIC */
-        memory_region_add_subregion(&s->bar, 0x40000, s->pic_mem);
-    }
+    /* OpenPIC */
+    sysbus_dev = SYS_BUS_DEVICE(ns->pic);
+    memory_region_add_subregion(&s->bar, 0x40000,
+                                sysbus_mmio_get_region(sysbus_dev, 0));
 
     /* IDE buses */
     for (i = 0; i < ARRAY_SIZE(ns->ide); i++) {
@@ -311,6 +311,11 @@ static void macio_newworld_init(Object *obj)
 
     qdev_init_gpio_out(DEVICE(obj), ns->irqs, ARRAY_SIZE(ns->irqs));
 
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &ns->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     for (i = 0; i < 2; i++) {
         macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
     }
@@ -441,7 +446,6 @@ void macio_init(PCIDevice *d,
 {
     MacIOState *macio_state = MACIO(d);
 
-    macio_state->pic_mem = pic_mem;
     /* Note: this code is strongly inspirated from the corresponding code
        in PearPC */
     qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency",
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 396216954e..c7960ab67a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -154,7 +154,7 @@ static void ppc_core99_init(MachineState *machine)
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
     long kernel_size, initrd_size;
     PCIBus *pci_bus;
-    PCIDevice *macio;
+    NewWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
     BusState *adb_bus;
     MacIONVRAMState *nvr;
@@ -166,7 +166,7 @@ static void ppc_core99_init(MachineState *machine)
     void *fw_cfg;
     int machine_arch;
     SysBusDevice *s;
-    DeviceState *dev;
+    DeviceState *dev, *pic_dev;
     int *token = g_new(int, 1);
     hwaddr nvram_addr = 0xFFF04000;
     uint64_t tbfreq;
@@ -333,10 +333,10 @@ static void ppc_core99_init(MachineState *machine)
 
     pic = g_new0(qemu_irq, 64);
 
-    dev = qdev_create(NULL, TYPE_OPENPIC);
-    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
+    pic_dev = qdev_create(NULL, TYPE_OPENPIC);
+    qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
+    qdev_init_nofail(pic_dev);
+    s = SYS_BUS_DEVICE(pic_dev);
     pic_mem = s->mmio[0].memory;
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
@@ -346,7 +346,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     for (i = 0; i < 64; i++) {
-        pic[i] = qdev_get_gpio_in(dev, i);
+        pic[i] = qdev_get_gpio_in(pic_dev, i);
     }
 
     if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
@@ -369,7 +369,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* MacIO */
-    macio = pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO);
+    macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
     qdev_connect_gpio_out(dev, 0, pic[0x19]); /* CUDA */
     qdev_connect_gpio_out(dev, 1, pic[0x24]); /* ESCC-B */
@@ -379,7 +379,9 @@ static void ppc_core99_init(MachineState *machine)
     qdev_connect_gpio_out(dev, 5, pic[0x0e]); /* IDE */
     qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE DMA */
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
-    macio_init(macio, pic_mem);
+    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
+                             &error_abort);
+    macio_init(PCI_DEVICE(macio), pic_mem);
 
     /* We only emulate 2 out of 3 IDE controllers for now */
     ide_drive_get(hd, ARRAY_SIZE(hd));
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 843c114c07..4528282b36 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -29,6 +29,7 @@
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "hw/ppc/openpic.h"
 
 #define TYPE_MACIO "macio"
 #define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
@@ -42,7 +43,6 @@ typedef struct MacIOState {
     CUDAState cuda;
     DBDMAState dbdma;
     ESCCState escc;
-    MemoryRegion *pic_mem;
     uint64_t frequency;
 } MacIOState;
 
@@ -70,6 +70,8 @@ typedef struct NewWorldMacIOState {
     /*< private >*/
     MacIOState parent_obj;
     /*< public >*/
+
+    OpenPICState *pic;
     qemu_irq irqs[7];
     MACIOIDEState ide[2];
 } NewWorldMacIOState;
-- 
2.14.3
