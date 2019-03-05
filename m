Received: from eggs.gnu.org ([209.51.188.92]:49019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cvx-0006UJ-35
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cvw-0002Lf-7v
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Cvw-0002Kx-0V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:48 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:25 +0100
Message-Id: <20190305162829.20079-2-philmd@redhat.com>
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] hw/mips/malta: Fix the DEBUG_BOARD_INIT
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
---
 hw/mips/mips_malta.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2827074e9b..b4cd8f02ad 100644
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
-               "addr %08llx '%s' %x\n",
-               fl_idx, bios_size, FLASH_ADDRESS,
-               blk_name(dinfo->bdrv), fl_sectors);
-    }
+               "addr %08llx '%s'\n",
+               fl_idx, blk_getlength(pflash_blk), FLASH_ADDRESS,
+               blk_name(pflash_blk));
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
2.20.1
