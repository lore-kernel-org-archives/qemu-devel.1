Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBk-00083t-KE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBj-0000ly-OJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBj-0000lk-Ho
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:46 +0400
Message-Id: <20170131162122.29408-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/41] mux: convert to finalize
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 6b4a299702..91ca4cb083 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -859,9 +859,9 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCond=
ition cond)
     return cc->chr_add_watch(chr, cond);
 }
=20
-static void mux_chr_free(struct Chardev *chr)
+static void char_mux_finalize(Object *obj)
 {
-    MuxChardev *d =3D MUX_CHARDEV(chr);
+    MuxChardev *d =3D MUX_CHARDEV(obj);
     int i;
=20
     for (i =3D 0; i < d->mux_cnt; i++) {
@@ -4025,7 +4025,6 @@ static void char_mux_class_init(ObjectClass *oc, vo=
id *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D qemu_chr_open_mux;
-    cc->chr_free =3D mux_chr_free;
     cc->chr_write =3D mux_chr_write;
     cc->chr_accept_input =3D mux_chr_accept_input;
     cc->chr_add_watch =3D mux_chr_add_watch;
@@ -4036,6 +4035,7 @@ static const TypeInfo char_mux_type_info =3D {
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_mux_class_init,
     .instance_size =3D sizeof(MuxChardev),
+    .instance_finalize =3D char_mux_finalize,
 };
=20
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
--=20
2.11.0.295.gd7dffce1c.dirty
