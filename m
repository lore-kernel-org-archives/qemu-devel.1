Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XS-0005SX-8H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XR-0007yG-6V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XR-0007y0-09
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DC22C0467D3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:08 +0100
Message-Id: <20170110174810.17748-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/20] baum: use a common prefix for chr
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 backends/baum.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 23d3c4aeaa..8842936417 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -253,7 +253,7 @@ static int baum_deferred_init(BaumChardev *baum)
 }
=20
 /* The serial port can receive more of our data */
-static void baum_accept_input(struct Chardev *chr)
+static void baum_chr_accept_input(struct Chardev *chr)
 {
     BaumChardev *baum =3D (BaumChardev *)chr;
     int room, first;
@@ -470,7 +470,7 @@ static int baum_eat_packet(BaumChardev *baum, const u=
int8_t *buf, int len)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int baum_write(Chardev *chr, const uint8_t *buf, int len)
+static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     BaumChardev *baum =3D (BaumChardev *)chr;
     int tocopy, cur, eaten, orig_len =3D len;
@@ -613,7 +613,7 @@ static void baum_chr_read(void *opaque)
     }
 }
=20
-static void baum_free(struct Chardev *chr)
+static void baum_chr_free(struct Chardev *chr)
 {
     BaumChardev *baum =3D (BaumChardev *)chr;
=20
@@ -624,7 +624,7 @@ static void baum_free(struct Chardev *chr)
     }
 }
=20
-static Chardev *chr_baum_init(const CharDriver *driver,
+static Chardev *baum_chr_init(const CharDriver *driver,
                               const char *id,
                               ChardevBackend *backend,
                               ChardevReturn *ret,
@@ -670,10 +670,10 @@ static void register_types(void)
     static const CharDriver driver =3D {
         .instance_size =3D sizeof(BaumChardev),
         .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
-        .create =3D chr_baum_init,
-        .chr_write =3D baum_write,
-        .chr_accept_input =3D baum_accept_input,
-        .chr_free =3D baum_free,
+        .create =3D baum_chr_init,
+        .chr_write =3D baum_chr_write,
+        .chr_accept_input =3D baum_chr_accept_input,
+        .chr_free =3D baum_chr_free,
     };
=20
     register_char_driver(&driver);
--=20
2.11.0
