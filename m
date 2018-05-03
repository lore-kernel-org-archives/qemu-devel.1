Received: from eggs.gnu.org ([2001:4830:134:3::10]:53083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKml-0007gI-D1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKmj-0007NN-Ro
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:03 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  3 May 2018 21:24:39 +0100
Message-Id: <20180503202441.26293-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
References: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] uninorth: create new uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Commit 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" added a TODO
which was to convert the uninorth registers hack to a proper device. Move
these registers to a new uninorth device, removing the old hacks from
mac_newworld.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/trace-events       |  2 ++
 hw/pci-host/uninorth.c         | 58 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/mac_newworld.c          | 41 +++++------------------------
 hw/ppc/trace-events            |  4 ---
 include/hw/pci-host/uninorth.h | 11 ++++++++
 5 files changed, 77 insertions(+), 39 deletions(-)

diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 341a87a702..dd7a398e96 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -18,3 +18,5 @@ unin_set_irq(int irq_num, int level) "setting INT %d = %d"
 unin_get_config_reg(uint32_t reg, uint32_t addr, uint32_t retval) "converted config space accessor 0x%"PRIx32 "/0x%"PRIx32 " -> 0x%"PRIx32
 unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx64 " len %d val 0x%"PRIx64
 unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx64
+unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
+unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index fada0ffd5f..ba76b84dbc 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -519,6 +519,62 @@ static const TypeInfo pci_unin_internal_info = {
     .class_init    = pci_unin_internal_class_init,
 };
 
+/* UniN device */
+static void unin_write(void *opaque, hwaddr addr, uint64_t value,
+                       unsigned size)
+{
+    trace_unin_write(addr, value);
+    if (addr == 0x0) {
+        *(int *)opaque = value;
+    }
+}
+
+static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t value;
+
+    value = 0;
+    switch (addr) {
+    case 0:
+        value = *(int *)opaque;
+    }
+
+    trace_unin_read(addr, value);
+
+    return value;
+}
+
+static const MemoryRegionOps unin_ops = {
+    .read = unin_read,
+    .write = unin_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void unin_init(Object *obj)
+{
+    UNINState *s = UNI_NORTH(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->mem);
+}
+
+static void unin_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo unin_info = {
+    .name          = TYPE_UNI_NORTH,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(UNINState),
+    .instance_init = unin_init,
+    .class_init    = unin_class_init,
+};
+
 static void unin_register_types(void)
 {
     type_register_static(&unin_main_pci_host_info);
@@ -530,6 +586,8 @@ static void unin_register_types(void)
     type_register_static(&pci_u3_agp_info);
     type_register_static(&pci_unin_agp_info);
     type_register_static(&pci_unin_internal_info);
+
+    type_register_static(&unin_info);
 }
 
 type_init(unin_register_types)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 29bd3838bf..9a382f992d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -82,36 +82,6 @@
 
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
 
-/* UniN device */
-static void unin_write(void *opaque, hwaddr addr, uint64_t value,
-                       unsigned size)
-{
-    trace_mac99_uninorth_write(addr, value);
-    if (addr == 0x0) {
-        *(int*)opaque = value;
-    }
-}
-
-static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
-{
-    uint32_t value;
-
-    value = 0;
-    switch (addr) {
-    case 0:
-        value = *(int*)opaque;
-    }
-
-    trace_mac99_uninorth_read(addr, value);
-
-    return value;
-}
-
-static const MemoryRegionOps unin_ops = {
-    .read = unin_read,
-    .write = unin_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
@@ -145,7 +115,6 @@ static void ppc_core99_init(MachineState *machine)
     CPUPPCState *env = NULL;
     char *filename;
     qemu_irq *pic, **openpic_irqs;
-    MemoryRegion *unin_memory = g_new(MemoryRegion, 1);
     int linux_boot, i, j, k;
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
@@ -164,7 +133,6 @@ static void ppc_core99_init(MachineState *machine)
     int machine_arch;
     SysBusDevice *s;
     DeviceState *dev, *pic_dev;
-    int *token = g_new(int, 1);
     hwaddr nvram_addr = 0xFFF04000;
     uint64_t tbfreq;
 
@@ -272,9 +240,12 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    /* UniN init: XXX should be a real device */
-    memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0x1000);
-    memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_memory);
+    /* UniN init */
+    dev = qdev_create(NULL, TYPE_UNI_NORTH);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(get_system_memory(), 0xf8000000,
+                                sysbus_mmio_get_region(s, 0));
 
     openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
     openpic_irqs[0] =
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 66ec7eda6e..dc5e65aee9 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -92,10 +92,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# hw/ppc/mac_newworld.c
-mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
-mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
-
 # hw/ppc/ppc4xx_pci.c
 ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index f0e6836c76..f6654bad9b 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -53,4 +53,15 @@ typedef struct UNINHostState {
     MemoryRegion pci_io;
 } UNINHostState;
 
+typedef struct UNINState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mem;
+    int token[1];
+} UNINState;
+
+#define TYPE_UNI_NORTH "uni-north"
+#define UNI_NORTH(obj) \
+    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH)
+
 #endif /* UNINORTH_H */
-- 
2.11.0
