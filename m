Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwOqM-0006OT-KO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwOqI-00014X-HQ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:34:22 -0400
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:47931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dwOqI-00011A-BD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:34:18 -0400
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 87ADF159414
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:34:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 25 Sep 2017 10:33:48 +0200
Message-Id: <20170925083348.17126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: check for firmware file presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

and exit before uslessly trying to load it if the file does
not exists.

Issue dicovered by Coverity Scan.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 47221158d415..7728eece2eec 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -570,6 +570,10 @@ static void ppc_powernv_init(MachineState *machine)
     }
=20
     fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!fw_filename) {
+        error_report("Could not find OPAL '%s'", bios_name);
+        exit(1);
+    }
=20
     fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
     if (fw_size < 0) {
--=20
2.13.5
