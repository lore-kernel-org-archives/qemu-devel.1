Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2a-0004uI-0C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2X-0008U6-RR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:35 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eZk2X-0008TF-Fb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:33 -0500
Received: by mail-lf0-x241.google.com with SMTP id v74so2030273lfa.7
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:05:33 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Jan 2018 13:04:56 -0800
Message-Id: <1515704703-10347-3-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/9] hw/xtensa/xtfpga: clean up
 function/structure names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Function/structure naming inconsistently uses lx, lx60 and xtensa
prefixes where xtfpga would be appropriate. Fix that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 140 ++++++++++++++++++++++++++---------------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index ba681683d608..ccc1ed8d8d7f 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -45,32 +45,32 @@
 #include "qemu/error-report.h"
 #include "bootparam.h"
 
-typedef struct LxBoardDesc {
+typedef struct XtfpgaBoardDesc {
     hwaddr flash_base;
     size_t flash_size;
     size_t flash_boot_base;
     size_t flash_sector_size;
     size_t sram_size;
-} LxBoardDesc;
+} XtfpgaBoardDesc;
 
-typedef struct Lx60FpgaState {
+typedef struct XtfpgaFpgaState {
     MemoryRegion iomem;
     uint32_t leds;
     uint32_t switches;
-} Lx60FpgaState;
+} XtfpgaFpgaState;
 
-static void lx60_fpga_reset(void *opaque)
+static void xtfpga_fpga_reset(void *opaque)
 {
-    Lx60FpgaState *s = opaque;
+    XtfpgaFpgaState *s = opaque;
 
     s->leds = 0;
     s->switches = 0;
 }
 
-static uint64_t lx60_fpga_read(void *opaque, hwaddr addr,
+static uint64_t xtfpga_fpga_read(void *opaque, hwaddr addr,
         unsigned size)
 {
-    Lx60FpgaState *s = opaque;
+    XtfpgaFpgaState *s = opaque;
 
     switch (addr) {
     case 0x0: /*build date code*/
@@ -88,10 +88,10 @@ static uint64_t lx60_fpga_read(void *opaque, hwaddr addr,
     return 0;
 }
 
-static void lx60_fpga_write(void *opaque, hwaddr addr,
+static void xtfpga_fpga_write(void *opaque, hwaddr addr,
         uint64_t val, unsigned size)
 {
-    Lx60FpgaState *s = opaque;
+    XtfpgaFpgaState *s = opaque;
 
     switch (addr) {
     case 0x8: /*LEDs (off = 0, on = 1)*/
@@ -106,26 +106,26 @@ static void lx60_fpga_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps lx60_fpga_ops = {
-    .read = lx60_fpga_read,
-    .write = lx60_fpga_write,
+static const MemoryRegionOps xtfpga_fpga_ops = {
+    .read = xtfpga_fpga_read,
+    .write = xtfpga_fpga_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static Lx60FpgaState *lx60_fpga_init(MemoryRegion *address_space,
+static XtfpgaFpgaState *xtfpga_fpga_init(MemoryRegion *address_space,
         hwaddr base)
 {
-    Lx60FpgaState *s = g_malloc(sizeof(Lx60FpgaState));
+    XtfpgaFpgaState *s = g_malloc(sizeof(XtfpgaFpgaState));
 
-    memory_region_init_io(&s->iomem, NULL, &lx60_fpga_ops, s,
-            "lx60.fpga", 0x10000);
+    memory_region_init_io(&s->iomem, NULL, &xtfpga_fpga_ops, s,
+            "xtfpga.fpga", 0x10000);
     memory_region_add_subregion(address_space, base, &s->iomem);
-    lx60_fpga_reset(s);
-    qemu_register_reset(lx60_fpga_reset, s);
+    xtfpga_fpga_reset(s);
+    qemu_register_reset(xtfpga_fpga_reset, s);
     return s;
 }
 
-static void lx60_net_init(MemoryRegion *address_space,
+static void xtfpga_net_init(MemoryRegion *address_space,
         hwaddr base,
         hwaddr descriptors,
         hwaddr buffers,
@@ -154,7 +154,7 @@ static void lx60_net_init(MemoryRegion *address_space,
 }
 
 static pflash_t *xtfpga_flash_init(MemoryRegion *address_space,
-                                   const LxBoardDesc *board,
+                                   const XtfpgaBoardDesc *board,
                                    DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
@@ -167,7 +167,7 @@ static pflash_t *xtfpga_flash_init(MemoryRegion *address_space,
     qdev_prop_set_uint64(dev, "sector-length", board->flash_sector_size);
     qdev_prop_set_uint8(dev, "width", 2);
     qdev_prop_set_bit(dev, "big-endian", be);
-    qdev_prop_set_string(dev, "name", "lx60.io.flash");
+    qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(address_space, board->flash_base,
@@ -182,31 +182,31 @@ static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
     return cpu_get_phys_page_debug(CPU(cpu), addr);
 }
 
-static void lx60_reset(void *opaque)
+static void xtfpga_reset(void *opaque)
 {
     XtensaCPU *cpu = opaque;
 
     cpu_reset(CPU(cpu));
 }
 
-static uint64_t lx60_io_read(void *opaque, hwaddr addr,
+static uint64_t xtfpga_io_read(void *opaque, hwaddr addr,
         unsigned size)
 {
     return 0;
 }
 
-static void lx60_io_write(void *opaque, hwaddr addr,
+static void xtfpga_io_write(void *opaque, hwaddr addr,
         uint64_t val, unsigned size)
 {
 }
 
-static const MemoryRegionOps lx60_io_ops = {
-    .read = lx60_io_read,
-    .write = lx60_io_write,
+static const MemoryRegionOps xtfpga_io_ops = {
+    .read = xtfpga_io_read,
+    .write = xtfpga_io_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void lx_init(const LxBoardDesc *board, MachineState *machine)
+static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 {
 #ifdef TARGET_WORDS_BIGENDIAN
     int be = 1;
@@ -231,7 +231,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
         env = &cpu->env;
 
         env->sregs[PRID] = n;
-        qemu_register_reset(lx60_reset, cpu);
+        qemu_register_reset(xtfpga_reset, cpu);
         /* Need MMU initialized prior to ELF loading,
          * so that ELF gets loaded into virtual addresses
          */
@@ -239,17 +239,17 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "lx60.dram", machine->ram_size,
+    memory_region_init_ram(ram, NULL, "xtfpga.dram", machine->ram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, 0, ram);
 
     system_io = g_malloc(sizeof(*system_io));
-    memory_region_init_io(system_io, NULL, &lx60_io_ops, NULL, "lx60.io",
+    memory_region_init_io(system_io, NULL, &xtfpga_io_ops, NULL, "xtfpga.io",
                           224 * 1024 * 1024);
     memory_region_add_subregion(system_memory, 0xf0000000, system_io);
-    lx60_fpga_init(system_io, 0x0d020000);
+    xtfpga_fpga_init(system_io, 0x0d020000);
     if (nd_table[0].used) {
-        lx60_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000,
+        xtfpga_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000,
                 xtensa_get_extint(env, 1), nd_table);
     }
 
@@ -281,7 +281,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
         uint32_t cur_lowmem = QEMU_ALIGN_UP(lowmem_end / 2, 4096);
 
         rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "lx60.sram", board->sram_size,
+        memory_region_init_ram(rom, NULL, "xtfpga.sram", board->sram_size,
                                &error_fatal);
         memory_region_add_subregion(system_memory, 0xfe000000, rom);
 
@@ -405,7 +405,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
             MemoryRegion *flash_mr = pflash_cfi01_get_memory(flash);
             MemoryRegion *flash_io = g_malloc(sizeof(*flash_io));
 
-            memory_region_init_alias(flash_io, NULL, "lx60.flash",
+            memory_region_init_alias(flash_io, NULL, "xtfpga.flash",
                     flash_mr, board->flash_boot_base,
                     board->flash_size - board->flash_boot_base < 0x02000000 ?
                     board->flash_size - board->flash_boot_base : 0x02000000);
@@ -415,121 +415,121 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 }
 
-static void xtensa_lx60_init(MachineState *machine)
+static void xtfpga_lx60_init(MachineState *machine)
 {
-    static const LxBoardDesc lx60_board = {
+    static const XtfpgaBoardDesc lx60_board = {
         .flash_base = 0x08000000,
         .flash_size = 0x00400000,
         .flash_sector_size = 0x10000,
         .sram_size = 0x20000,
     };
-    lx_init(&lx60_board, machine);
+    xtfpga_init(&lx60_board, machine);
 }
 
-static void xtensa_lx200_init(MachineState *machine)
+static void xtfpga_lx200_init(MachineState *machine)
 {
-    static const LxBoardDesc lx200_board = {
+    static const XtfpgaBoardDesc lx200_board = {
         .flash_base = 0x08000000,
         .flash_size = 0x01000000,
         .flash_sector_size = 0x20000,
         .sram_size = 0x2000000,
     };
-    lx_init(&lx200_board, machine);
+    xtfpga_init(&lx200_board, machine);
 }
 
-static void xtensa_ml605_init(MachineState *machine)
+static void xtfpga_ml605_init(MachineState *machine)
 {
-    static const LxBoardDesc ml605_board = {
+    static const XtfpgaBoardDesc ml605_board = {
         .flash_base = 0x08000000,
         .flash_size = 0x01000000,
         .flash_sector_size = 0x20000,
         .sram_size = 0x2000000,
     };
-    lx_init(&ml605_board, machine);
+    xtfpga_init(&ml605_board, machine);
 }
 
-static void xtensa_kc705_init(MachineState *machine)
+static void xtfpga_kc705_init(MachineState *machine)
 {
-    static const LxBoardDesc kc705_board = {
+    static const XtfpgaBoardDesc kc705_board = {
         .flash_base = 0x00000000,
         .flash_size = 0x08000000,
         .flash_boot_base = 0x06000000,
         .flash_sector_size = 0x20000,
         .sram_size = 0x2000000,
     };
-    lx_init(&kc705_board, machine);
+    xtfpga_init(&kc705_board, machine);
 }
 
-static void xtensa_lx60_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
-    mc->init = xtensa_lx60_init;
+    mc->init = xtfpga_lx60_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-static const TypeInfo xtensa_lx60_type = {
+static const TypeInfo xtfpga_lx60_type = {
     .name = MACHINE_TYPE_NAME("lx60"),
     .parent = TYPE_MACHINE,
-    .class_init = xtensa_lx60_class_init,
+    .class_init = xtfpga_lx60_class_init,
 };
 
-static void xtensa_lx200_class_init(ObjectClass *oc, void *data)
+static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
-    mc->init = xtensa_lx200_init;
+    mc->init = xtfpga_lx200_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-static const TypeInfo xtensa_lx200_type = {
+static const TypeInfo xtfpga_lx200_type = {
     .name = MACHINE_TYPE_NAME("lx200"),
     .parent = TYPE_MACHINE,
-    .class_init = xtensa_lx200_class_init,
+    .class_init = xtfpga_lx200_class_init,
 };
 
-static void xtensa_ml605_class_init(ObjectClass *oc, void *data)
+static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
-    mc->init = xtensa_ml605_init;
+    mc->init = xtfpga_ml605_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-static const TypeInfo xtensa_ml605_type = {
+static const TypeInfo xtfpga_ml605_type = {
     .name = MACHINE_TYPE_NAME("ml605"),
     .parent = TYPE_MACHINE,
-    .class_init = xtensa_ml605_class_init,
+    .class_init = xtfpga_ml605_class_init,
 };
 
-static void xtensa_kc705_class_init(ObjectClass *oc, void *data)
+static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
-    mc->init = xtensa_kc705_init;
+    mc->init = xtfpga_kc705_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-static const TypeInfo xtensa_kc705_type = {
+static const TypeInfo xtfpga_kc705_type = {
     .name = MACHINE_TYPE_NAME("kc705"),
     .parent = TYPE_MACHINE,
-    .class_init = xtensa_kc705_class_init,
+    .class_init = xtfpga_kc705_class_init,
 };
 
-static void xtensa_lx_machines_init(void)
+static void xtfpga_machines_init(void)
 {
-    type_register_static(&xtensa_lx60_type);
-    type_register_static(&xtensa_lx200_type);
-    type_register_static(&xtensa_ml605_type);
-    type_register_static(&xtensa_kc705_type);
+    type_register_static(&xtfpga_lx60_type);
+    type_register_static(&xtfpga_lx200_type);
+    type_register_static(&xtfpga_ml605_type);
+    type_register_static(&xtfpga_kc705_type);
 }
 
-type_init(xtensa_lx_machines_init)
+type_init(xtfpga_machines_init)
-- 
2.1.4
