Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5Bca-0006XR-PN
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5BcY-0002Jr-K8
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 14:43:32 +0100
Message-Id: <1493646214-3342-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/5] ppc: add qemu_vga.ndrv ROM to fw_cfg
 interface for OldWorld Macs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 5df94e2..97bb854 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -53,6 +53,8 @@
 #define CLOCKFREQ 266000000UL
 #define BUSFREQ 66000000UL
 
+#define NDRV_VGA_FILENAME "qemu_vga.ndrv"
+
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
@@ -99,7 +101,8 @@ static void ppc_heathrow_init(MachineState *machine)
     MACIOIDEState *macio_ide;
     DeviceState *dev;
     BusState *adb_bus;
-    int bios_size;
+    int bios_size, ndrv_size;
+    uint8_t *ndrv_file;
     MemoryRegion *pic_mem;
     MemoryRegion *escc_mem, *escc_bar = g_new(MemoryRegion, 1);
     uint16_t ppc_boot_device;
@@ -355,6 +358,19 @@ static void ppc_heathrow_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_CLOCKFREQ, CLOCKFREQ);
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_BUSFREQ, BUSFREQ);
 
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
1.7.10.4
