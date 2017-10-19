Received: from eggs.gnu.org ([2001:4830:134:3::10]:43526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e57go-0002nN-Ly
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e57gk-0007wA-Mf
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:34 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:43800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e57gk-0007v6-GW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:30 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 103A7145A18
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 12:04:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Oct 2017 12:04:03 +0200
Message-Id: <20171019100410.26239-2-clg@kaod.org>
In-Reply-To: <20171019100410.26239-1-clg@kaod.org>
References: <20171019100410.26239-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/8] aspeed: introduce a dummy ROM device to
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
Let's add a dummy ROM device to catch the invalid writes and support
new board without using the 'ignore_memory_transaction_failures' flags.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad490af..e44733153819 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -166,6 +166,19 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
     }
 }
=20
+static void boot_rom_rw_flash_write(void *opaque, hwaddr offset, uint64_=
t value,
+                              unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
+                  __func__, offset, value, size);
+}
+
+static const MemoryRegionOps boot_rom_rw_flash_ops =3D {
+    .write =3D boot_rom_rw_flash_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
 static void aspeed_board_init(MachineState *machine,
                               const AspeedBoardConfig *cfg)
 {
@@ -209,6 +222,7 @@ static void aspeed_board_init(MachineState *machine,
     if (drive0) {
         AspeedSMCFlash *fl =3D &bmc->soc.fmc.flashes[0];
         MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
+        MemoryRegion *boot_rom_rw =3D  g_new(MemoryRegion, 1);
=20
         /*
          * create a ROM region using the default mapping window size of
@@ -221,6 +235,16 @@ static void aspeed_board_init(MachineState *machine,
         memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                     boot_rom);
         write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+
+        /*
+         * Create a fake ROM region to track invalid writes done by
+         * some legacy firmwares
+         */
+        memory_region_init_rom_device(boot_rom_rw, NULL, &boot_rom_rw_fl=
ash_ops,
+                                      NULL, "aspeed.boot_rom_rw", fl->si=
ze,
+                                      &error_abort);
+        memory_region_add_subregion_overlap(get_system_memory(), FIRMWAR=
E_ADDR,
+                                            boot_rom_rw, 0);
     }
=20
     aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
--=20
2.13.6
