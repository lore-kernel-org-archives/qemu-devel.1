Received: from eggs.gnu.org ([2001:4830:134:3::10]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwPEi-0000XN-GL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwPEf-0003Ms-Uf
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:59:32 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:34769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dwPEf-0003MO-PR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:59:29 -0400
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4571D15EFEF
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:59:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 25 Sep 2017 10:58:25 +0200
Message-Id: <20170925085825.20549-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] ppc/pnv: check for OPAL firmware file
 presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

and exit before uselessly trying to load it if the file does not
exists.

Issue discovered by Coverity Scan.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - fixed spelling
 - improved OPAL naming by adding firmware=20

 hw/ppc/pnv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 47221158d415..d46d91c76f5c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -570,10 +570,14 @@ static void ppc_powernv_init(MachineState *machine)
     }
=20
     fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!fw_filename) {
+        error_report("Could not find OPAL firmware '%s'", bios_name);
+        exit(1);
+    }
=20
     fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
     if (fw_size < 0) {
-        error_report("Could not load OPAL '%s'", fw_filename);
+        error_report("Could not load OPAL firmware '%s'", fw_filename);
         exit(1);
     }
     g_free(fw_filename);
--=20
2.13.5
