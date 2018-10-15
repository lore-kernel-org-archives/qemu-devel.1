Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByoh-0001wF-Dj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByog-0008Ry-9K
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gByof-0008LV-Sg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:34 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 11:05:11 +0200
Message-Id: <20181015090517.26884-2-kraxel@redhat.com>
In-Reply-To: <20181015090517.26884-1-kraxel@redhat.com>
References: <20181015090517.26884-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] edid: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Use stl_le_p() & friends instead of casts.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20181015055333.32030-1-kraxel@redhat.com
---
 hw/display/edid-generate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 37e60fe42a..bdf5e1d4d4 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -223,7 +223,7 @@ static void edid_desc_timing(uint8_t *desc,
=20
     uint32_t clock  =3D 75 * (xres + xblank) * (yres + yblank);
=20
-    *(uint32_t *)(desc) =3D cpu_to_le32(clock / 10000);
+    stl_le_p(desc, clock / 10000);
=20
     desc[2] =3D xres   & 0xff;
     desc[3] =3D xblank & 0xff;
@@ -342,9 +342,9 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
                           (((info->vendor[2] - '@') & 0x1f) <<  0));
     uint16_t model_nr =3D 0x1234;
     uint32_t serial_nr =3D info->serial ? atoi(info->serial) : 0;
-    *(uint16_t *)(edid +  8) =3D cpu_to_be16(vendor_id);
-    *(uint16_t *)(edid + 10) =3D cpu_to_le16(model_nr);
-    *(uint32_t *)(edid + 12) =3D cpu_to_le32(serial_nr);
+    stw_be_p(edid +  8, vendor_id);
+    stw_le_p(edid + 10, model_nr);
+    stl_le_p(edid + 12, serial_nr);
=20
     /* manufacture week and year */
     edid[16] =3D 42;
--=20
2.9.3
