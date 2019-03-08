Received: from eggs.gnu.org ([209.51.188.92]:43155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C5A-0002Hz-Ex
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C59-0006Ga-Bx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:46:04 +0100
Message-Id: <20190308094610.21210-10-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/15] r2d: Fix flash memory size,
 sector size, width, device ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu, Magnus Damm <magnus.damm@gmail.com>

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
---
 hw/sh4/r2d.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index dcdb3728cb..cd23c60b86 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -44,7 +44,7 @@
 #include "exec/address-spaces.h"
=20
 #define FLASH_BASE 0x00000000
-#define FLASH_SIZE 0x02000000
+#define FLASH_SIZE (16 * MiB)
=20
 #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
@@ -288,12 +288,20 @@ static void r2d_init(MachineState *machine)
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
