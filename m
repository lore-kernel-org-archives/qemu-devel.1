Received: from eggs.gnu.org ([2001:4830:134:3::10]:49423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nw-0001VI-Mi
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nu-0004Te-PN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:44 +1100
Message-Id: <20180306040154.3669-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/30] macio: remove macio_init() function
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

Move the remaining comment into macio.c for reference, then remove the
macio_init() function and instantiate the macio devices for both Old World
and New World machines via qdev_init_nofail() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c | 11 +++--------
 hw/ppc/mac_newworld.c |  4 +---
 hw/ppc/mac_oldworld.c |  4 +---
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index f71ed61819..af1bd46b4b 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -33,6 +33,9 @@
 #include "hw/misc/macio/macio.h"
 #include "hw/intc/heathrow_pic.h"
 
+/* Note: this code is strongly inspirated from the corresponding code
+ * in PearPC */
+
 /*
  * The mac-io has two interfaces to the ESCC. One is called "escc-legacy",
  * while the other one is the normal, current ESCC interface.
@@ -442,11 +445,3 @@ static void macio_register_types(void)
 }
 
 type_init(macio_register_types)
-
-void macio_init(PCIDevice *d,
-                MemoryRegion *pic_mem)
-{
-    /* Note: this code is strongly inspirated from the corresponding code
-       in PearPC */
-    qdev_init_nofail(DEVICE(d));
-}
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c7960ab67a..a749e2565d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -160,7 +160,6 @@ static void ppc_core99_init(MachineState *machine)
     MacIONVRAMState *nvr;
     int bios_size, ndrv_size;
     uint8_t *ndrv_file;
-    MemoryRegion *pic_mem;
     int ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
@@ -337,7 +336,6 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
     qdev_init_nofail(pic_dev);
     s = SYS_BUS_DEVICE(pic_dev);
-    pic_mem = s->mmio[0].memory;
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < OPENPIC_OUTPUT_NB; j++) {
@@ -381,7 +379,7 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
-    macio_init(PCI_DEVICE(macio), pic_mem);
+    qdev_init_nofail(dev);
 
     /* We only emulate 2 out of 3 IDE controllers for now */
     ide_drive_get(hd, ARRAY_SIZE(hd));
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 3ac5b19073..935493c966 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -96,7 +96,6 @@ static void ppc_heathrow_init(MachineState *machine)
     OldWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
     DeviceState *dev, *pic_dev;
-    SysBusDevice *sbd;
     BusState *adb_bus;
     int bios_size, ndrv_size;
     uint8_t *ndrv_file;
@@ -283,8 +282,7 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
-    sbd = SYS_BUS_DEVICE(pic_dev);
-    macio_init(PCI_DEVICE(macio), sysbus_mmio_get_region(sbd, 0));
+    qdev_init_nofail(dev);
 
     macio_ide = MACIO_IDE(object_resolve_path_component(OBJECT(macio),
                                                         "ide[0]"));
-- 
2.14.3
