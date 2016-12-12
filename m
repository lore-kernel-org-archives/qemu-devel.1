Received: from eggs.gnu.org ([2001:4830:134:3::10]:43217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLC-0004Fy-Tu
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLA-0003qJ-64
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLA-0003px-0F
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2062480510
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:53 +0300
Message-Id: <20161212224325.20790-23-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/54] char-pty: convert to finalize
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
 qemu-char.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index ea8b12fa4f..21eb2d9135 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1654,9 +1654,10 @@ static void pty_chr_state(Chardev *chr, int connec=
ted)
     }
 }
=20
-static void pty_chr_free(struct Chardev *chr)
+static void char_pty_finalize(Object *obj)
 {
-    PtyChardev *s =3D PTY_CHARDEV(chr);
+    Chardev *chr =3D CHARDEV(obj);
+    PtyChardev *s =3D PTY_CHARDEV(obj);
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1713,13 +1714,13 @@ static void char_pty_class_init(ObjectClass *oc, =
void *data)
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
     cc->chr_add_watch =3D pty_chr_add_watch;
-    cc->chr_free =3D pty_chr_free;
 }
=20
 static const TypeInfo char_pty_type_info =3D {
     .name =3D TYPE_CHARDEV_PTY,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(PtyChardev),
+    .instance_finalize =3D char_pty_finalize,
     .class_init =3D char_pty_class_init,
 };
=20
--=20
2.11.0
