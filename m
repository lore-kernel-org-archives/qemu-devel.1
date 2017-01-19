Received: from eggs.gnu.org ([2001:4830:134:3::10]:47526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-0000zp-GR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005Bp-3t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPp-000582-R1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPf-00039H-GB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:35 +0000
Message-Id: <1484834995-26826-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/36] aspeed: use first FMC flash as a boot ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Create a ROM region, using the default size of the mapping window for
the CE0 FMC flash module, and fill it with the flash content.

This is a little hacky but until we can boot from a MMIO region, it
seems difficult to do anything else.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-11-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 40c1383..a92c2f1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -20,6 +20,8 @@
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
@@ -104,6 +106,28 @@ static const AspeedBoardConfig aspeed_boards[] = {
     },
 };
 
+#define FIRMWARE_ADDR 0x0
+
+static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
+                           Error **errp)
+{
+    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
+    uint8_t *storage;
+
+    if (rom_size > blk_getlength(blk)) {
+        rom_size = blk_getlength(blk);
+    }
+
+    storage = g_new0(uint8_t, rom_size);
+    if (blk_pread(blk, 0, storage, rom_size) < 0) {
+        error_setg(errp, "failed to read the initial flash content");
+        return;
+    }
+
+    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
+    g_free(storage);
+}
+
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                       Error **errp)
 {
@@ -135,6 +159,7 @@ static void aspeed_board_init(MachineState *machine,
 {
     AspeedBoardState *bmc;
     AspeedSoCClass *sc;
+    DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
 
     bmc = g_new0(AspeedBoardState, 1);
     object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
@@ -168,6 +193,22 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
 
+    /* Install first FMC flash content as a boot rom. */
+    if (drive0) {
+        AspeedSMCFlash *fl = &bmc->soc.fmc.flashes[0];
+        MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+
+        /*
+         * create a ROM region using the default mapping window size of
+         * the flash module.
+         */
+        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+                               fl->size, &error_abort);
+        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
+                                    boot_rom);
+        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+    }
+
     aspeed_board_binfo.kernel_filename = machine->kernel_filename;
     aspeed_board_binfo.initrd_filename = machine->initrd_filename;
     aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
-- 
2.7.4
