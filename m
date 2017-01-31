Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCr-0000kc-Nd
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCq-00019Z-Ln
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCq-00019M-Fj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:03 +0400
Message-Id: <20170131162122.29408-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/41] char: make null_chr_write() the default
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

All chardev must implement chr_write(), but parallel and null chardev
both use null_chr_write(). Move it to the base class, so we don't need
to export the function when splitting the chardev in respective files.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 15f4a853bc..ee6ceb3471 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -522,6 +522,18 @@ static void char_init(Object *obj)
     qemu_mutex_init(&chr->chr_write_lock);
 }
=20
+static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    return len;
+}
+
+static void char_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_write =3D null_chr_write;
+}
+
 static void char_finalize(Object *obj)
 {
     Chardev *chr =3D CHARDEV(obj);
@@ -545,13 +557,9 @@ static const TypeInfo char_type_info =3D {
     .instance_finalize =3D char_finalize,
     .abstract =3D true,
     .class_size =3D sizeof(ChardevClass),
+    .class_init =3D char_class_init,
 };
=20
-static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    return len;
-}
-
 static void null_chr_open(Chardev *chr,
                           ChardevBackend *backend,
                           bool *be_opened,
@@ -565,7 +573,6 @@ static void char_null_class_init(ObjectClass *oc, voi=
d *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D null_chr_open;
-    cc->chr_write =3D null_chr_write;
 }
=20
 static const TypeInfo char_null_type_info =3D {
@@ -4712,10 +4719,8 @@ static void char_parallel_class_init(ObjectClass *=
oc, void *data)
     cc->parse =3D qemu_chr_parse_parallel;
     cc->open =3D qmp_chardev_open_parallel;
 #if defined(__linux__)
-    cc->chr_write =3D null_chr_write;
     cc->chr_ioctl =3D pp_ioctl;
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
-    cc->chr_write =3D null_chr_write;
     cc->chr_ioctl =3D pp_ioctl;
 #endif
 }
--=20
2.11.0.295.gd7dffce1c.dirty
