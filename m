Received: from eggs.gnu.org ([2001:4830:134:3::10]:36486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCru-000548-2w
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrs-0000Ty-Ew
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:50 +0000
Message-Id: <20180220184159.16483-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
References: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 02/11] macio: move ESCC device within the
 macio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Now that the ESCC device is instantiated directly via qdev, move it to within
the macio device and wire up the IRQs and memory regions using the sysbus API.

This enables to remove the now-obsolete escc_mem parameter to the macio_init()
function.

(Note this patch also contains small touch-ups to the formatting in
macio_escc_legacy_setup() and ppc_heathrow_init() in order to keep checkpatch
happy)

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c | 60 ++++++++++++++++++++++++++++++++++++---------------
 hw/ppc/mac.h          |  3 +--
 hw/ppc/mac_newworld.c | 37 ++++++++-----------------------
 hw/ppc/mac_oldworld.c | 38 +++++++++-----------------------
 4 files changed, 63 insertions(+), 75 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 7174135c8b..1c10d8a1d7 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -43,8 +43,8 @@ typedef struct MacIOState
     MemoryRegion bar;
     CUDAState cuda;
     DBDMAState dbdma;
+    ESCCState escc;
     MemoryRegion *pic_mem;
-    MemoryRegion *escc_mem;
     uint64_t frequency;
 } MacIOState;
 
@@ -56,7 +56,7 @@ typedef struct OldWorldMacIOState {
     MacIOState parent_obj;
     /*< public >*/
 
-    qemu_irq irqs[5];
+    qemu_irq irqs[7];
 
     MacIONVRAMState nvram;
     MACIOIDEState ide[2];
@@ -69,7 +69,7 @@ typedef struct NewWorldMacIOState {
     /*< private >*/
     MacIOState parent_obj;
     /*< public >*/
-    qemu_irq irqs[5];
+    qemu_irq irqs[7];
     MACIOIDEState ide[2];
 } NewWorldMacIOState;
 
@@ -84,10 +84,12 @@ typedef struct NewWorldMacIOState {
  *
  * Reference: ftp://ftp.software.ibm.com/rs6000/technology/spec/chrp/inwork/CHRP_IORef_1.0.pdf
  */
-static void macio_escc_legacy_setup(MacIOState *macio_state)
+static void macio_escc_legacy_setup(MacIOState *s)
 {
+    ESCCState *escc = ESCC(&s->escc);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(escc);
     MemoryRegion *escc_legacy = g_new(MemoryRegion, 1);
-    MemoryRegion *bar = &macio_state->bar;
+    MemoryRegion *bar = &s->bar;
     int i;
     static const int maps[] = {
         0x00, 0x00, /* Command B */
@@ -102,25 +104,26 @@ static void macio_escc_legacy_setup(MacIOState *macio_state)
         0xb0, 0xb0, /* Detect AB */
     };
 
-    memory_region_init(escc_legacy, OBJECT(macio_state), "escc-legacy", 256);
+    memory_region_init(escc_legacy, OBJECT(s), "escc-legacy", 256);
     for (i = 0; i < ARRAY_SIZE(maps); i += 2) {
         MemoryRegion *port = g_new(MemoryRegion, 1);
-        memory_region_init_alias(port, OBJECT(macio_state), "escc-legacy-port",
-                                 macio_state->escc_mem, maps[i+1], 0x2);
+        memory_region_init_alias(port, OBJECT(s), "escc-legacy-port",
+                                 sysbus_mmio_get_region(sbd, 0),
+                                 maps[i + 1], 0x2);
         memory_region_add_subregion(escc_legacy, maps[i], port);
     }
 
     memory_region_add_subregion(bar, 0x12000, escc_legacy);
 }
 
-static void macio_bar_setup(MacIOState *macio_state)
+static void macio_bar_setup(MacIOState *s)
 {
-    MemoryRegion *bar = &macio_state->bar;
+    ESCCState *escc = ESCC(&s->escc);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(escc);
+    MemoryRegion *bar = &s->bar;
 
-    if (macio_state->escc_mem) {
-        memory_region_add_subregion(bar, 0x13000, macio_state->escc_mem);
-        macio_escc_legacy_setup(macio_state);
-    }
+    memory_region_add_subregion(bar, 0x13000, sysbus_mmio_get_region(sbd, 0));
+    macio_escc_legacy_setup(s);
 }
 
 static void macio_common_realize(PCIDevice *d, Error **errp)
@@ -147,6 +150,12 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&s->bar, 0x16000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
+    object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     macio_bar_setup(s);
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar);
 }
@@ -185,6 +194,10 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
     sysbus_connect_irq(sysbus_dev, 0, os->irqs[cur_irq++]);
 
+    sysbus_dev = SYS_BUS_DEVICE(&s->escc);
+    sysbus_connect_irq(sysbus_dev, 0, os->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 1, os->irqs[cur_irq++]);
+
     object_property_set_bool(OBJECT(&os->nvram), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -297,6 +310,10 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
     sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
 
+    sysbus_dev = SYS_BUS_DEVICE(&s->escc);
+    sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
+    sysbus_connect_irq(sysbus_dev, 1, ns->irqs[cur_irq++]);
+
     if (s->pic_mem) {
         /* OpenPIC */
         memory_region_add_subregion(&s->bar, 0x40000, s->pic_mem);
@@ -347,6 +364,17 @@ static void macio_instance_init(Object *obj)
     object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
     qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
     object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
+
+    object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
+    qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
+    object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
@@ -444,13 +472,11 @@ static void macio_register_types(void)
 type_init(macio_register_types)
 
 void macio_init(PCIDevice *d,
-                MemoryRegion *pic_mem,
-                MemoryRegion *escc_mem)
+                MemoryRegion *pic_mem)
 {
     MacIOState *macio_state = MACIO(d);
 
     macio_state->pic_mem = pic_mem;
-    macio_state->escc_mem = escc_mem;
     /* Note: this code is strongly inspirated from the corresponding code
        in PearPC */
     qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency",
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 4702194f3f..261b519aa5 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -76,8 +76,7 @@ void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
 void macio_ide_register_dma(MACIOIDEState *ide);
 
 void macio_init(PCIDevice *dev,
-                MemoryRegion *pic_mem,
-                MemoryRegion *escc_mem);
+                MemoryRegion *pic_mem);
 
 /* Heathrow PIC */
 qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 4e1298ee50..5e82158759 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -159,8 +159,7 @@ static void ppc_core99_init(MachineState *machine)
     MacIONVRAMState *nvr;
     int bios_size, ndrv_size;
     uint8_t *ndrv_file;
-    MemoryRegion *pic_mem, *escc_mem;
-    MemoryRegion *escc_bar = g_new(MemoryRegion, 1);
+    MemoryRegion *pic_mem;
     int ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
@@ -368,36 +367,18 @@ static void ppc_core99_init(MachineState *machine)
         tbfreq = TBFREQ;
     }
 
-    /* init basic PC hardware */
-
-    dev = qdev_create(NULL, TYPE_ESCC);
-    qdev_prop_set_uint32(dev, "disabled", 0);
-    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
-    qdev_prop_set_uint32(dev, "it_shift", 4);
-    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
-    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
-    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
-    qdev_init_nofail(dev);
-
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(s, 0, pic[0x24]);
-    sysbus_connect_irq(s, 1, pic[0x25]);
-
-    escc_mem = &ESCC(s)->mmio;
-
-    memory_region_init_alias(escc_bar, NULL, "escc-bar",
-                             escc_mem, 0, memory_region_size(escc_mem));
-
+    /* MacIO */
     macio = pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO);
     dev = DEVICE(macio);
     qdev_connect_gpio_out(dev, 0, pic[0x19]); /* CUDA */
-    qdev_connect_gpio_out(dev, 1, pic[0x0d]); /* IDE */
-    qdev_connect_gpio_out(dev, 2, pic[0x02]); /* IDE DMA */
-    qdev_connect_gpio_out(dev, 3, pic[0x0e]); /* IDE */
-    qdev_connect_gpio_out(dev, 4, pic[0x03]); /* IDE DMA */
+    qdev_connect_gpio_out(dev, 1, pic[0x24]); /* ESCC-B */
+    qdev_connect_gpio_out(dev, 2, pic[0x25]); /* ESCC-A */
+    qdev_connect_gpio_out(dev, 3, pic[0x0d]); /* IDE */
+    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE DMA */
+    qdev_connect_gpio_out(dev, 5, pic[0x0e]); /* IDE */
+    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE DMA */
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
-    macio_init(macio, pic_mem, escc_bar);
+    macio_init(macio, pic_mem);
 
     /* We only emulate 2 out of 3 IDE controllers for now */
     ide_drive_get(hd, ARRAY_SIZE(hd));
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index d0d21d2392..4401ce5af2 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -99,12 +99,10 @@ static void ppc_heathrow_init(MachineState *machine)
     int bios_size, ndrv_size;
     uint8_t *ndrv_file;
     MemoryRegion *pic_mem;
-    MemoryRegion *escc_mem, *escc_bar = g_new(MemoryRegion, 1);
     uint16_t ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
     uint64_t tbfreq;
-    SysBusDevice *s;
 
     linux_boot = (kernel_filename != NULL);
 
@@ -265,40 +263,24 @@ static void ppc_heathrow_init(MachineState *machine)
                                get_system_io());
     pci_vga_init(pci_bus);
 
-    dev = qdev_create(NULL, TYPE_ESCC);
-    qdev_prop_set_uint32(dev, "disabled", 0);
-    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
-    qdev_prop_set_uint32(dev, "it_shift", 4);
-    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
-    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
-    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
-    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_init_nofail(dev);
-
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(s, 0, pic[0x10]);
-    sysbus_connect_irq(s, 1, pic[0x0f]);
-
-    escc_mem = &ESCC(s)->mmio;
-
-    memory_region_init_alias(escc_bar, NULL, "escc-bar",
-                             escc_mem, 0, memory_region_size(escc_mem));
-
-    for(i = 0; i < nb_nics; i++)
+    for (i = 0; i < nb_nics; i++) {
         pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
-
+    }
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
+    /* MacIO */
     macio = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
     dev = DEVICE(macio);
     qdev_connect_gpio_out(dev, 0, pic[0x12]); /* CUDA */
-    qdev_connect_gpio_out(dev, 1, pic[0x0D]); /* IDE-0 */
-    qdev_connect_gpio_out(dev, 2, pic[0x02]); /* IDE-0 DMA */
-    qdev_connect_gpio_out(dev, 3, pic[0x0E]); /* IDE-1 */
-    qdev_connect_gpio_out(dev, 4, pic[0x03]); /* IDE-1 DMA */
+    qdev_connect_gpio_out(dev, 1, pic[0x10]); /* ESCC-B */
+    qdev_connect_gpio_out(dev, 2, pic[0x0F]); /* ESCC-A */
+    qdev_connect_gpio_out(dev, 3, pic[0x0D]); /* IDE-0 */
+    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE-0 DMA */
+    qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
+    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
-    macio_init(macio, pic_mem, escc_bar);
+    macio_init(macio, pic_mem);
 
     macio_ide = MACIO_IDE(object_resolve_path_component(OBJECT(macio),
                                                         "ide[0]"));
-- 
2.11.0
