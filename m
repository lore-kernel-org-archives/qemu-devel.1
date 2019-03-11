Received: from eggs.gnu.org ([209.51.188.92]:35789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6R-00008B-LP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6N-0004cp-VG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6N-0004bf-Jr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4185C05242C
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:27 +0100
Message-Id: <20190311220843.4026-12-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/27] hw/mips/malta: Remove fl_sectors variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Variable fl_sectors is used just once.  Since
fl_sectors =3D bios_size >> 16 and bios_size =3D FLASH_SIZE there,
we can simply use FLASH_SIZE >> 16, and eliminate variable.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190308094610.21210-12-armbru@redhat.com>
---
 hw/mips/mips_malta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 8736d3a00e..51a3ecab59 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1206,7 +1206,6 @@ void mips_malta_init(MachineState *machine)
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int fl_idx =3D 0;
-    int fl_sectors =3D bios_size >> 16;
     int be;
=20
     DeviceState *dev =3D qdev_create(NULL, TYPE_MIPS_MALTA);
@@ -1266,7 +1265,7 @@ void mips_malta_init(MachineState *machine)
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
                                BIOS_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               65536, fl_sectors,
+                               65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
     bios =3D pflash_cfi01_get_memory(fl);
     fl_idx++;
--=20
2.17.2
