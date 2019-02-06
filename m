Received: from eggs.gnu.org ([209.51.188.92]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmw-0002mo-VO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUms-00047x-F8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:20 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41960
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grUmq-00041D-H7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:17 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  6 Feb 2019 21:30:42 +0000
Message-Id: <20190206213042.12537-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
References: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 3/3] sun4m: pass initrd size to OpenBIOS via
 fw_cfg interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

This is to enable OpenBIOS to claim the initrd memory as in-use before attempting
to boot the kernel.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/sun4m.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 709ee37e08..1c9217315e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -224,11 +224,12 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
 
 static unsigned long sun4m_load_kernel(const char *kernel_filename,
                                        const char *initrd_filename,
-                                       ram_addr_t RAM_size)
+                                       ram_addr_t RAM_size,
+                                       uint32_t *initrd_size)
 {
     int linux_boot;
     unsigned int i;
-    long initrd_size, kernel_size;
+    long kernel_size;
     uint8_t *ptr;
 
     linux_boot = (kernel_filename != NULL);
@@ -258,23 +259,23 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         }
 
         /* load initrd */
-        initrd_size = 0;
+        *initrd_size = 0;
         if (initrd_filename) {
-            initrd_size = load_image_targphys(initrd_filename,
-                                              INITRD_LOAD_ADDR,
-                                              RAM_size - INITRD_LOAD_ADDR);
-            if (initrd_size < 0) {
+            *initrd_size = load_image_targphys(initrd_filename,
+                                               INITRD_LOAD_ADDR,
+                                               RAM_size - INITRD_LOAD_ADDR);
+            if ((int)*initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
                 exit(1);
             }
         }
-        if (initrd_size > 0) {
+        if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
                 ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
                 if (ptr && ldl_p(ptr) == 0x48647253) { /* HdrS */
                     stl_p(ptr + 16, INITRD_LOAD_ADDR);
-                    stl_p(ptr + 20, initrd_size);
+                    stl_p(ptr + 20, *initrd_size);
                     break;
                 }
             }
@@ -844,6 +845,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
     qemu_irq fdc_tc;
     unsigned long kernel_size;
+    uint32_t initrd_size;
     DriveInfo *fd[MAX_FD];
     FWCfgState *fw_cfg;
     unsigned int num_vsimms;
@@ -1022,9 +1024,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         empty_slot_init(hwdef->bpp_base, 0x20);
     }
 
+    initrd_size = 0;
     kernel_size = sun4m_load_kernel(machine->kernel_filename,
                                     machine->initrd_filename,
-                                    machine->ram_size);
+                                    machine->ram_size, &initrd_size);
 
     nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
                machine->boot_order, machine->ram_size, kernel_size,
@@ -1067,7 +1070,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, 0);
     }
     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, INITRD_LOAD_ADDR);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, 0); // not used
+    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, machine->boot_order[0]);
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
-- 
2.11.0
