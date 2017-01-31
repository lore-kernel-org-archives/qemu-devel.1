Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCM-0000Hm-94
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCL-0000uE-0G
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCK-0000u0-Pj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:55 +0400
Message-Id: <20170131162122.29408-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/41] char-win: convert to finalize
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
 qemu-char.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 83636d76c0..0cece8a34f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2150,8 +2150,9 @@ typedef struct {
 static int win_chr_poll(void *opaque);
 static int win_chr_pipe_poll(void *opaque);
=20
-static void win_chr_free(Chardev *chr)
+static void char_win_finalize(Object *obj)
 {
+    Chardev *chr =3D CHARDEV(obj);
     WinChardev *s =3D WIN_CHARDEV(chr);
=20
     if (s->skip_free) {
@@ -2160,15 +2161,12 @@ static void win_chr_free(Chardev *chr)
=20
     if (s->hsend) {
         CloseHandle(s->hsend);
-        s->hsend =3D NULL;
     }
     if (s->hrecv) {
         CloseHandle(s->hrecv);
-        s->hrecv =3D NULL;
     }
     if (s->hcom) {
         CloseHandle(s->hcom);
-        s->hcom =3D NULL;
     }
     if (s->fpipe)
         qemu_del_polling_cb(win_chr_pipe_poll, chr);
@@ -2241,7 +2239,6 @@ static int win_chr_init(Chardev *chr, const char *f=
ilename, Error **errp)
     return 0;
=20
  fail:
-    win_chr_free(chr);
     return -1;
 }
=20
@@ -2416,7 +2413,6 @@ static int win_chr_pipe_init(Chardev *chr, const ch=
ar *filename,
     return 0;
=20
  fail:
-    win_chr_free(chr);
     return -1;
 }
=20
@@ -2447,13 +2443,13 @@ static void char_win_class_init(ObjectClass *oc, =
void *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->chr_write =3D win_chr_write;
-    cc->chr_free =3D win_chr_free;
 }
=20
 static const TypeInfo char_win_type_info =3D {
     .name =3D TYPE_CHARDEV_WIN,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(WinChardev),
+    .instance_finalize =3D char_win_finalize,
     .class_init =3D char_win_class_init,
     .abstract =3D true,
 };
--=20
2.11.0.295.gd7dffce1c.dirty
