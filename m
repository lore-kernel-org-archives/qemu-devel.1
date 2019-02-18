Received: from eggs.gnu.org ([209.51.188.92]:34879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhnj-00064F-V3
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhne-0006cY-9g
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:35 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvhna-0006Xi-1X
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:27 -0500
Message-Id: <b47ef6e4eb1ff275ac2eec7293914e62936caf47.1550491301.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1550491301.git.balaton@eik.bme.hu>
References: <cover.1550491301.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 13:01:41 +0100
Subject: [Qemu-devel] [PATCH v2 3/3] mips_fulong2e: Dynamically generate SPD
 EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>, philmd@redhat.com

The machine comes with 256M memory module by default but it's
upgradable so it could have different memory size. There was a TODO
comment to replace static SPD EEPROM data with dynamically generated
one to support this. Now that we have a function for that, it's easy
to do. Although this would allow larger RAM sizes, the peculiar memory
map of the machine may need some special handling to map it as low and
high memory. Because I don't know what the correct place would be for
highmem, I've left memory size fixed at 256M for now and TODO is moved
there instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/mips_fulong2e.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 10e6ed585a..eec6fd02c8 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -214,20 +214,6 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static const uint8_t eeprom_spd[0x80] = {
-    0x80,0x08,0x07,0x0d,0x09,0x02,0x40,0x00,0x04,0x70,
-    0x70,0x00,0x82,0x10,0x00,0x01,0x0e,0x04,0x0c,0x01,
-    0x02,0x20,0x80,0x75,0x70,0x00,0x00,0x50,0x3c,0x50,
-    0x2d,0x20,0xb0,0xb0,0x50,0x50,0x00,0x00,0x00,0x00,
-    0x00,0x41,0x48,0x3c,0x32,0x75,0x00,0x00,0x00,0x00,
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-    0x00,0x00,0x00,0x9c,0x7b,0x07,0x00,0x00,0x00,0x00,
-    0x00,0x00,0x00,0x00,0x48,0x42,0x35,0x34,0x41,0x32,
-    0x35,0x36,0x38,0x4b,0x4e,0x2d,0x41,0x37,0x35,0x42,
-    0x20,0x30,0x20
-};
-
 static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
                                        I2CBus **i2c_bus, ISABus **p_isa_bus)
 {
@@ -284,7 +270,6 @@ static void network_init (PCIBus *pci_bus)
 
 static void mips_fulong2e_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -292,7 +277,10 @@ static void mips_fulong2e_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
+    ram_addr_t ram_size = machine->ram_size;
     long bios_size;
+    uint8_t *spd_data;
+    Error *err = NULL;
     int64_t kernel_entry;
     PCIBus *pci_bus;
     ISABus *isa_bus;
@@ -306,7 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     qemu_register_reset(main_cpu_reset, cpu);
 
-    /* fulong 2e has 256M ram. */
+    /* TODO: support more than 256M RAM as highmem */
     ram_size = 256 * MiB;
 
     /* allocate RAM */
@@ -359,8 +347,14 @@ static void mips_fulong2e_init(MachineState *machine)
     vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
 
-    /* TODO: Populate SPD eeprom data.  */
-    smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
+    /* Populate SPD eeprom data */
+    spd_data = spd_data_generate(DDR, ram_size, &err);
+    if (err) {
+        warn_report_err(err);
+    }
+    if (spd_data) {
+        smbus_eeprom_init_one(smbus, 0x50, spd_data);
+    }
 
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
@@ -374,6 +368,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
     mc->init = mips_fulong2e_init;
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
+    mc->default_ram_size = 256 * MiB;
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
-- 
2.13.7
