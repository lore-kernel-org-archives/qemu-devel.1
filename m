Received: from eggs.gnu.org ([2001:4830:134:3::10]:47295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvsW-0006Mi-7f
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvsU-0001GZ-28
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:40 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNvsT-0001GD-Qx
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:37 -0400
Received: from player770.ha.ovh.net (unknown [10.109.108.50])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7BA64E5546
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 09:50:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 09:50:02 +0200
Message-Id: <20180530075002.4618-5-clg@kaod.org>
In-Reply-To: <20180530075002.4618-1-clg@kaod.org>
References: <20180530075002.4618-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] hw/arm/aspeed: boot from the FMC CE0 flash
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When MMIO execution is activated on the FMC controller, remove the
copy of the flash module contents in a ROM memory region and boot
directly from CE0.

Booting from an alternate module (FMC CE1) should be possible. There
is still some work to support the module swap when the watchdog resets
the system.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e28170b7e1d8..e87a5899845f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -160,6 +160,32 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr =
addr, size_t rom_size,
     g_free(storage);
 }
=20
+static void install_boot_rom(AspeedBoardState *bmc, DriveInfo *drive,
+                             hwaddr addr)
+{
+    AspeedSMCState *fmc =3D &bmc->soc.fmc;
+    AspeedSMCFlash *fl =3D &fmc->flashes[0];
+    bool mmio_exec =3D object_property_get_bool(OBJECT(fmc), "mmio-exec"=
,
+                                              &error_abort);
+    if (mmio_exec) {
+        memory_region_add_subregion(get_system_memory(), addr,
+                                    &fl->mmio_rom);
+    } else {
+        MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
+
+        /*
+         * create a ROM region using the default mapping window size of
+         * the flash module. The window size is 64MB for the AST2400
+         * SoC and 128MB for the AST2500 SoC, which is twice as big as
+         * needed by the flash modules of the Aspeed machines.
+         */
+        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+                               fl->size, &error_abort);
+        memory_region_add_subregion(get_system_memory(), addr, boot_rom)=
;
+        write_boot_rom(drive, addr, fl->size, &error_abort);
+    }
+}
+
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *fla=
shtype,
                                       Error **errp)
 {
@@ -232,20 +258,7 @@ static void aspeed_board_init(MachineState *machine,
=20
     /* Install first FMC flash content as a boot rom. */
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
-        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
-                               fl->size, &error_abort);
-        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
-                                    boot_rom);
-        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        install_boot_rom(bmc, drive0, FIRMWARE_ADDR);
     }
=20
     aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
--=20
2.13.6
