Received: from eggs.gnu.org ([2001:4830:134:3::10]:38197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCCo-0004hx-Vn
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCCo-0006o1-1v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCCn-0006nh-SU
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:13 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02B4B80473
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:41:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:27 +0400
Message-Id: <20170130133954.31353-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/41] char-win: convert to finalize
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
