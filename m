Received: from eggs.gnu.org ([209.51.188.92]:35897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gobjM-0000zg-SX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gobjL-0002AD-Jd
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:19:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gobjL-00029X-E7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:19:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so14023675wmd.1
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 14:19:43 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Tue, 29 Jan 2019 23:19:28 +0100
Message-Id: <20190129221928.11522-1-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH] hw/m68k/mcf5208: Support loading of bios images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The MCF5208EVB supports 2 MiB of flash at address 0. Add support
for this memory region and some code to load the file that can
be specified with the "-bios" command line option.
This can be used for example to load U-Boot images for the
MCF5208EVB (we still lack some features in the CPU emulation for
this firmware, though, so it can not be run successfully yet).

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5208.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0f2245dd81..021194498d 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -27,6 +27,8 @@
 
 #define SYS_FREQ 166666666
 
+#define ROM_SIZE 0x200000
+
 #define PCSR_EN         0x0001
 #define PCSR_RLD        0x0002
 #define PCSR_PIF        0x0004
@@ -227,6 +229,7 @@ static void mcf5208evb_init(MachineState *machine)
     hwaddr entry;
     qemu_irq *pic;
     MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *rom = g_new(MemoryRegion, 1);
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
@@ -237,6 +240,10 @@ static void mcf5208evb_init(MachineState *machine)
     env->vbr = 0;
     /* TODO: Configure BARs.  */
 
+    /* ROM at 0x00000000 */
+    memory_region_init_rom(rom, NULL, "mcf5208.rom", ROM_SIZE, &error_fatal);
+    memory_region_add_subregion(address_space_mem, 0x0, rom);
+
     /* DRAM at 0x40000000 */
     memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_size);
     memory_region_add_subregion(address_space_mem, 0x40000000, ram);
@@ -285,9 +292,29 @@ static void mcf5208evb_init(MachineState *machine)
     /*  0xfc0a4000 GPIO.  */
     /* 0xfc0a8000 SDRAM controller.  */
 
+    /* Load firmware */
+    if (bios_name) {
+        char *fn;
+        uint8_t *ptr;
+
+        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!fn) {
+            error_report("Could not find ROM image '%s'", bios_name);
+            exit(1);
+        }
+        if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
+            error_report("Could not load ROM image '%s'", bios_name);
+            exit(1);
+        }
+        g_free(fn);
+        ptr = rom_ptr(0x4, 4);
+        assert(ptr != NULL);
+        env->pc = ldl_p(ptr);
+    }
+
     /* Load kernel.  */
     if (!kernel_filename) {
-        if (qtest_enabled()) {
+        if (qtest_enabled() || bios_name) {
             return;
         }
         error_report("Kernel image must be specified");
-- 
2.17.2
