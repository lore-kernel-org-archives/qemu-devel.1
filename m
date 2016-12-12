Received: from eggs.gnu.org ([2001:4830:134:3::10]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLW-0004Zw-ES
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLV-00043R-KU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLV-00042I-E6
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9592F61BA5
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:59 +0300
Message-Id: <20161212224325.20790-29-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/54] char-win: convert to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 63b254f632..939c598c35 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2145,8 +2145,9 @@ typedef struct {
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
@@ -2236,7 +2237,6 @@ static int win_chr_init(Chardev *chr, const char *f=
ilename, Error **errp)
     return 0;
=20
  fail:
-    win_chr_free(chr);
     return -1;
 }
=20
@@ -2411,7 +2411,6 @@ static int win_chr_pipe_init(Chardev *chr, const ch=
ar *filename,
     return 0;
=20
  fail:
-    win_chr_free(chr);
     return -1;
 }
=20
@@ -2442,13 +2441,13 @@ static void char_win_class_init(ObjectClass *oc, =
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
2.11.0
