Received: from eggs.gnu.org ([2001:4830:134:3::10]:47926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUI-0002T3-3J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0001cR-S8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUF-0001b4-Ju
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:23 -0400
Message-Id: <20180608174733.4936-21-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/30] tests/boot-sector: Add magic bytes to
 s390x boot code header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We're going to use the s390x boot code for testing CD-ROM booting.
But the ISO loader of the s390-ccw bios is a little bit more picky
than the network loader and expects some magic bytes in the header
of the file (see linux_s390_magic in pc-bios/s390-ccw/bootmap.c), so
we've got to add them in our boot code here, too.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Acked-By: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/boot-sector.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index c373f0e715..7824286b9a 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -68,8 +68,11 @@ static uint8_t x86_boot_sector[512] =3D {
 };
=20
 /* For s390x, use a mini "kernel" with the appropriate signature */
-static const uint8_t s390x_psw[] =3D {
-    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
+static const uint8_t s390x_psw_and_magic[] =3D {
+    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00,  /* Program status w=
ord  */
+    0x02, 0x00, 0x00, 0x18, 0x60, 0x00, 0x00, 0x50,  /* Magic:          =
     */
+    0x02, 0x00, 0x00, 0x68, 0x60, 0x00, 0x00, 0x50,  /* see linux_s390_m=
agic */
+    0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40   /* in the s390-ccw =
bios */
 };
 static const uint8_t s390x_code[] =3D {
     0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 =
*/
@@ -110,7 +113,7 @@ int boot_sector_init(char *fname)
     } else if (g_str_equal(arch, "s390x")) {
         len =3D 0x10000 + sizeof(s390x_code);
         boot_code =3D g_malloc0(len);
-        memcpy(boot_code, s390x_psw, sizeof(s390x_psw));
+        memcpy(boot_code, s390x_psw_and_magic, sizeof(s390x_psw_and_magi=
c));
         memcpy(&boot_code[0x10000], s390x_code, sizeof(s390x_code));
     } else {
         g_assert_not_reached();
--=20
2.14.3
