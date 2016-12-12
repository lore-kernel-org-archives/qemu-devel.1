Received: from eggs.gnu.org ([2001:4830:134:3::10]:43261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLJ-0004OH-FR
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLD-0003r7-Vh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLD-0003qs-Q2
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:03 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAD05C04D2A8
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:54 +0300
Message-Id: <20161212224325.20790-24-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/54] char-ringbuf: convert to finalize
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
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 21eb2d9135..4d7f82a45b 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3543,9 +3543,9 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t *=
buf, int len)
     return i;
 }
=20
-static void ringbuf_chr_free(struct Chardev *chr)
+static void char_ringbuf_finalize(Object *obj)
 {
-    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
+    RingBufChardev *d =3D RINGBUF_CHARDEV(obj);
=20
     g_free(d->cbuf);
 }
@@ -3975,7 +3975,6 @@ static void char_ringbuf_class_init(ObjectClass *oc=
, void *data)
=20
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
-    cc->chr_free =3D ringbuf_chr_free;
 }
=20
 static const TypeInfo char_ringbuf_type_info =3D {
@@ -3983,6 +3982,7 @@ static const TypeInfo char_ringbuf_type_info =3D {
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_ringbuf_class_init,
     .instance_size =3D sizeof(RingBufChardev),
+    .instance_finalize =3D char_ringbuf_finalize,
 };
=20
 /* Bug-compatibility: */
--=20
2.11.0
