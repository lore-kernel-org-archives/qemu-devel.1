Received: from eggs.gnu.org ([2001:4830:134:3::10]:56843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0001aA-6N
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70Q-0004A6-PP
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:10 +1000
Message-Id: <20170927074316.4454-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/26] ppc/pnv: check for OPAL firmware file
 presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

and exit before uselessly trying to load it if the file does not
exists.

Issue discovered by Coverity Scan.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 47221158d4..d46d91c76f 100644
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
