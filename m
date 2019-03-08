Received: from eggs.gnu.org ([209.51.188.92]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C57-0002DL-5T
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C55-00068v-Rp
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:21 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:46:05 +0100
Message-Id: <20190308094610.21210-11-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/15] mips_malta: Delete disabled,
 broken DEBUG_BOARD_INIT code
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

The debug code under DEBUG_BOARD_INIT doesn't compile:

      hw/mips/mips_malta.c:1273:16: error: implicit declaration of functi=
on =E2=80=98blk_name=E2=80=99; did you mean =E2=80=98basename=E2=80=99? [=
-Werror=3Dimplicit-function-declaration]
                    blk_name(dinfo->bdrv), fl_sectors);
                    ^~~~~~~~
      hw/mips/mips_malta.c:1273:16: error: nested extern declaration of =E2=
=80=98blk_name=E2=80=99 [-Werror=3Dnested-externs]
      hw/mips/mips_malta.c:1273:30: error: =E2=80=98DriveInfo=E2=80=99 {a=
ka =E2=80=98struct DriveInfo=E2=80=99} has no member named =E2=80=98bdrv=E2=
=80=99
                    blk_name(dinfo->bdrv), fl_sectors);
                                    ^~

Delete it.

Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2827074e9b..8736d3a00e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -58,8 +58,6 @@
 #include "exec/semihost.h"
 #include "hw/mips/cps.h"
=20
-//#define DEBUG_BOARD_INIT
-
 #define ENVP_ADDR		0x80002000l
 #define ENVP_NB_ENTRIES	 	16
 #define ENVP_ENTRY_SIZE	 	256
@@ -1265,14 +1263,6 @@ void mips_malta_init(MachineState *machine)
=20
     /* Load firmware in flash / BIOS. */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
-#ifdef DEBUG_BOARD_INIT
-    if (dinfo) {
-        printf("Register parallel flash %d size " TARGET_FMT_lx " at "
-               "addr %08llx '%s' %x\n",
-               fl_idx, bios_size, FLASH_ADDRESS,
-               blk_name(dinfo->bdrv), fl_sectors);
-    }
-#endif
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
                                BIOS_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
--=20
2.17.2
