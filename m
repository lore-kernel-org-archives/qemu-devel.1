Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5CVX-00019d-3y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5CVR-00018Q-EC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:13:15 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:40167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5CVR-00017z-7T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:13:09 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 015D314614D
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 17:13:07 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Oct 2017 17:12:42 +0200
Message-Id: <20171019151249.13663-2-clg@kaod.org>
In-Reply-To: <20171019151249.13663-1-clg@kaod.org>
References: <20171019151249.13663-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/8] aspeed: use a ROM memory region to
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v4 :

 - use a ROM memory region

=20
 hw/arm/aspeed.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad490af..d88a8b5120b6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -166,6 +166,23 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
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
@@ -216,8 +233,9 @@ static void aspeed_board_init(MachineState *machine,
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspeed.=
boot_rom",
-                               fl->size, &error_abort);
+        memory_region_init_rom_device(boot_rom, OBJECT(bmc), &boot_rom_o=
ps,
+                                      NULL, "aspeed.boot_rom", fl->size,
+                                      &error_abort);
         memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                     boot_rom);
         write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
--=20
2.13.6
