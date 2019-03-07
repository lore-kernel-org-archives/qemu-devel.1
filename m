Received: from eggs.gnu.org ([209.51.188.92]:52441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgU-0004xS-SY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgT-0003dt-Ti
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:38 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 14:03:18 +0100
Message-Id: <20190307130323.9353-10-armbru@redhat.com>
In-Reply-To: <20190307130323.9353-1-armbru@redhat.com>
References: <20190307130323.9353-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/14] hw/mips/malta: Fix the
 DEBUG_BOARD_INIT code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit fa1d36df746 missed to convert this ifdef'ed out code.
Introduce the pflash_blk variable.

This fixes:

  hw/mips/mips_malta.c:1273:16: error: implicit declaration of function =E2=
=80=98blk_name=E2=80=99; did you mean =E2=80=98basename=E2=80=99? [-Werro=
r=3Dimplicit-function-declaration]
                blk_name(dinfo->bdrv), fl_sectors);
                ^~~~~~~~
  hw/mips/mips_malta.c:1273:16: error: nested extern declaration of =E2=80=
=98blk_name=E2=80=99 [-Werror=3Dnested-externs]
  hw/mips/mips_malta.c:1273:30: error: =E2=80=98DriveInfo=E2=80=99 {aka =E2=
=80=98struct DriveInfo=E2=80=99} has no member named =E2=80=98bdrv=E2=80=99
                blk_name(dinfo->bdrv), fl_sectors);
                                ^~

Fixes: fa1d36df746
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/mips_malta.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2827074e9b..639ccefa98 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -40,6 +40,7 @@
 #include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/block-backend.h"
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
 #include "hw/ide.h"
@@ -1205,6 +1206,7 @@ void mips_malta_init(MachineState *machine)
     qemu_irq cbus_irq, i8259_irq;
     int piix4_devfn;
     I2CBus *smbus;
+    BlockBackend *pflash_blk =3D NULL;
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int fl_idx =3D 0;
@@ -1265,17 +1267,18 @@ void mips_malta_init(MachineState *machine)
=20
     /* Load firmware in flash / BIOS. */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
-#ifdef DEBUG_BOARD_INIT
     if (dinfo) {
+        pflash_blk =3D blk_by_legacy_dinfo(dinfo);
+#ifdef DEBUG_BOARD_INIT
         printf("Register parallel flash %d size " TARGET_FMT_lx " at "
                "addr %08llx '%s' %x\n",
-               fl_idx, bios_size, FLASH_ADDRESS,
-               blk_name(dinfo->bdrv), fl_sectors);
-    }
+               fl_idx, blk_getlength(pflash_blk), FLASH_ADDRESS,
+               blk_name(pflash_blk), fl_sectors);
 #endif
+    }
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
                                BIOS_SIZE,
-                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
+                               pflash_blk,
                                65536, fl_sectors,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
     bios =3D pflash_cfi01_get_memory(fl);
--=20
2.17.2
