Received: from eggs.gnu.org ([2001:4830:134:3::10]:45514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcmM-0001sS-Dy
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcmI-0004VL-Di
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:38 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:60269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQcmI-0004V2-7M
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:34 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4E013D336
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:26:31 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:46 +0100
Message-Id: <1483979087-32663-11-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/11] aspeed: use first FMC flash as a boot
 ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Create a ROM region, using the default size of the mapping window for
the CE0 FMC flash module, and fill it with the flash content.

This is a little hacky but until we can boot from a MMIO region, it
seems difficult to do anything else.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 40c13838fb2d..a92c2f1c362b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -20,6 +20,8 @@
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
=20
 static struct arm_boot_info aspeed_board_binfo =3D {
     .board_id =3D -1, /* device-tree-only board */
@@ -104,6 +106,28 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
     },
 };
=20
+#define FIRMWARE_ADDR 0x0
+
+static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_siz=
e,
+                           Error **errp)
+{
+    BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
+    uint8_t *storage;
+
+    if (rom_size > blk_getlength(blk)) {
+        rom_size =3D blk_getlength(blk);
+    }
+
+    storage =3D g_new0(uint8_t, rom_size);
+    if (blk_pread(blk, 0, storage, rom_size) < 0) {
+        error_setg(errp, "failed to read the initial flash content");
+        return;
+    }
+
+    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
+    g_free(storage);
+}
+
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *fla=
shtype,
                                       Error **errp)
 {
@@ -135,6 +159,7 @@ static void aspeed_board_init(MachineState *machine,
 {
     AspeedBoardState *bmc;
     AspeedSoCClass *sc;
+    DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
=20
     bmc =3D g_new0(AspeedBoardState, 1);
     object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
@@ -168,6 +193,22 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abor=
t);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_a=
bort);
=20
+    /* Install first FMC flash content as a boot rom. */
+    if (drive0) {
+        AspeedSMCFlash *fl =3D &bmc->soc.fmc.flashes[0];
+        MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
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
     aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
     aspeed_board_binfo.initrd_filename =3D machine->initrd_filename;
     aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
--=20
2.7.4
