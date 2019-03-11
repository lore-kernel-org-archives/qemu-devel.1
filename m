Received: from eggs.gnu.org ([209.51.188.92]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6O-00005e-44
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6M-0004b8-LV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6M-0004ZP-AL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E618C057F3E
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D20860C4C
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:26 +0100
Message-Id: <20190311220843.4026-11-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/27] mips_malta: Delete disabled,
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
Message-Id: <20190308094610.21210-11-armbru@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
