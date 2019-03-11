Received: from eggs.gnu.org ([209.51.188.92]:35786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6R-000087-LS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6N-0004cV-Kl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6N-0004b2-AS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:25 +0100
Message-Id: <20190311220843.4026-10-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] r2d: Fix flash memory size, sector size,
 width, device ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>

pflash_cfi02_register() takes a size in bytes, a block size in bytes
and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
number of blocks.  The latter happens to win: FLASH_SIZE / 4,
i.e. 8MiB.

The best information we have on the physical hardware lists a Cypress
S29PL127J60TFI130 128MiBit NOR flash addressable in words of 16 bits,
in sectors of 4 and 32 Kibiwords.  We don't model multiple sector
sizes.

Fix the flash size from 8 to 16MiB, and adjust the sector size from 16
to 64KiB.  Fix the width from 4 to 2.  While there, supply the real
device IDs 0x0001, 0x227e, 0x2220, 0x2200 instead of zeros.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190308094610.21210-10-armbru@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sh4/r2d.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 28ed6be05b..e2c46b8f8a 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -43,7 +43,7 @@
 #include "exec/address-spaces.h"
=20
 #define FLASH_BASE 0x00000000
-#define FLASH_SIZE 0x02000000
+#define FLASH_SIZE (16 * MiB)
=20
 #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
@@ -287,12 +287,20 @@ static void r2d_init(MachineState *machine)
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
=20
-    /* onboard flash memory */
+    /*
+     * Onboard flash memory
+     * According to the old board user document in Japanese (under
+     * NDA) what is referred to as FROM (Area0) is connected via a
+     * 32-bit bus and CS0 to CN8. The docs mention a Cypress
+     * S29PL127J60TFI130 chipsset.  Per the 'S29PL-J 002-00615
+     * Rev. *E' datasheet, it is a 128Mbit NOR parallel flash
+     * addressable in words of 16bit.
+     */
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          16 * KiB, FLASH_SIZE >> 16,
-                          1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
+                          64 * KiB, FLASH_SIZE >> 16,
+                          1, 2, 0x0001, 0x227e, 0x2220, 0x2200,
                           0x555, 0x2aa, 0);
=20
     /* NIC: rtl8139 on-board, and 2 slots. */
--=20
2.17.2
