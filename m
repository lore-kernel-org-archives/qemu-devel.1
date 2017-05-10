Received: from eggs.gnu.org ([2001:4830:134:3::10]:42685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcr-0002Tx-Kp
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcq-0007qg-Eg
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:33 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:06 +1000
Message-Id: <20170510070115.13063-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/22] ppc: add qemu_vga.ndrv ROM to fw_cfg
 interface for NewWorld Macs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 68aaedc..bae1c0a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -80,6 +80,8 @@
 #define CLOCKFREQ (266UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
 
+#define NDRV_VGA_FILENAME "qemu_vga.ndrv"
+
 /* UniN device */
 static void unin_write(void *opaque, hwaddr addr, uint64_t value,
                        unsigned size)
@@ -160,7 +162,8 @@ static void ppc_core99_init(MachineState *machine)
     MACIOIDEState *macio_ide;
     BusState *adb_bus;
     MacIONVRAMState *nvr;
-    int bios_size;
+    int bios_size, ndrv_size;
+    uint8_t *ndrv_file;
     MemoryRegion *pic_mem, *escc_mem;
     MemoryRegion *escc_bar = g_new(MemoryRegion, 1);
     int ppc_boot_device;
@@ -494,6 +497,19 @@ static void ppc_core99_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_BUSFREQ, BUSFREQ);
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_NVRAM_ADDR, nvram_addr);
 
+    /* MacOS NDRV VGA driver */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, NDRV_VGA_FILENAME);
+    if (filename) {
+        ndrv_size = get_image_size(filename);
+        if (ndrv_size != -1) {
+            ndrv_file = g_malloc(ndrv_size);
+            ndrv_size = load_image(filename, ndrv_file);
+
+            fw_cfg_add_file(fw_cfg, "ndrv/qemu_vga.ndrv", ndrv_file, ndrv_size);
+        }
+        g_free(filename);
+    }
+
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
-- 
2.9.3
