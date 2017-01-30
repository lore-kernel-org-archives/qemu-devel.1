Received: from eggs.gnu.org ([2001:4830:134:3::10]:38003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCCF-00045s-D6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCCE-0006cQ-Hm
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCCE-0006cI-43
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F95F81240
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:40:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:22 +0400
Message-Id: <20170130133954.31353-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/41] char-ringbuf: convert to finalize
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
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index fecebde87a..74e78b56d1 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3550,9 +3550,9 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t *=
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
@@ -3982,7 +3982,6 @@ static void char_ringbuf_class_init(ObjectClass *oc=
, void *data)
=20
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
-    cc->chr_free =3D ringbuf_chr_free;
 }
=20
 static const TypeInfo char_ringbuf_type_info =3D {
@@ -3990,6 +3989,7 @@ static const TypeInfo char_ringbuf_type_info =3D {
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_ringbuf_class_init,
     .instance_size =3D sizeof(RingBufChardev),
+    .instance_finalize =3D char_ringbuf_finalize,
 };
=20
 /* Bug-compatibility: */
--=20
2.11.0.295.gd7dffce1c.dirty
