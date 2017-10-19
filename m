Received: from eggs.gnu.org ([2001:4830:134:3::10]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Dnl-00017z-G7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Dng-0003O4-QL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:36:09 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:42757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5Dng-0003Mx-Kn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:36:04 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 48CF71461E6
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:36:03 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Oct 2017 18:35:39 +0200
Message-Id: <20171019163546.2039-2-clg@kaod.org>
In-Reply-To: <20171019163546.2039-1-clg@kaod.org>
References: <20171019163546.2039-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 1/8] aspeed: use a ROM memory region to
 catch invalid writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Some legacy firmwares access unimplemented addresses on the Aspeed SoC
(old U-Boot code using variables in the bss when it shouldn't do).
Let's use a ROM memory region to catch the invalid writes and support
new boards without using the 'ignore_memory_transaction_failures'
flag.

This change is breaking migration compatibility for the Aspeed
machines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v5 :

 - added a comment on migration compatibility
 - created the ROM memory region even if there is no file backend
   specified by the user

 Changes since v4 :

 - use a ROM memory region

 hw/arm/aspeed.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad490af..e6a890659a97 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -166,12 +166,31 @@ static void aspeed_board_init_flashes(AspeedSMCStat=
e *s, const char *flashtype,
     }
 }
=20
+/*
+ * This is to track invalid writes done in the ROM by some legacy
+ * firmwares
+ */
+static void boot_rom_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
+                  __func__, offset, value, size);
+}
+
+static const MemoryRegionOps boot_rom_ops =3D {
+    .write =3D boot_rom_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
 static void aspeed_board_init(MachineState *machine,
                               const AspeedBoardConfig *cfg)
 {
     AspeedBoardState *bmc;
     AspeedSoCClass *sc;
     DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
+    MemoryRegion *boot_rom;
+    size_t boot_rom_size;
=20
     bmc =3D g_new0(AspeedBoardState, 1);
     object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
@@ -205,22 +224,24 @@ static void aspeed_board_init(MachineState *machine=
,
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abor=
t);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_a=
bort);
=20
-    /* Install first FMC flash content as a boot rom. */
+    /*
+     * create a ROM region using the default mapping window size of
+     * the FMC CS0 flash module. The window size is 64MB for the
+     * AST2400 SoC and 128MB for the AST2500 SoC, which is twice as
+     * big as needed by the flash modules of the Aspeed machines.
+     */
+    boot_rom =3D g_new(MemoryRegion, 1);
+    boot_rom_size =3D bmc->soc.fmc.flashes[0].size;
+
+    memory_region_init_rom_device(boot_rom, OBJECT(bmc), &boot_rom_ops,
+                                  NULL, "aspeed.boot_rom", boot_rom_size=
,
+                                  &error_abort);
+    memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
+                                boot_rom);
+
+    /* Install first FMC flash content (if any) as a boot rom. */
     if (drive0) {
-        AspeedSMCFlash *fl =3D &bmc->soc.fmc.flashes[0];
-        MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
-
-        /*
-         * create a ROM region using the default mapping window size of
-         * the flash module. The window size is 64MB for the AST2400
-         * SoC and 128MB for the AST2500 SoC, which is twice as big as
-         * needed by the flash modules of the Aspeed machines.
-         */
-        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspeed.=
boot_rom",
-                               fl->size, &error_abort);
-        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
-                                    boot_rom);
-        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        write_boot_rom(drive0, FIRMWARE_ADDR, boot_rom_size, &error_abor=
t);
     }
=20
     aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
--=20
2.13.6
