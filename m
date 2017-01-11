Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMiw-0000gx-2C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMiv-0006JH-8D
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMiv-0006HY-1y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:09 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46F3A4E4D2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:24 +0100
Message-Id: <20170111172956.11255-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/40] char-ringbuf: convert to finalize
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
---
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 1d8a7bc732..98d4a17990 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3548,9 +3548,9 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t *=
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
@@ -3980,7 +3980,6 @@ static void char_ringbuf_class_init(ObjectClass *oc=
, void *data)
=20
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
-    cc->chr_free =3D ringbuf_chr_free;
 }
=20
 static const TypeInfo char_ringbuf_type_info =3D {
@@ -3988,6 +3987,7 @@ static const TypeInfo char_ringbuf_type_info =3D {
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_ringbuf_class_init,
     .instance_size =3D sizeof(RingBufChardev),
+    .instance_finalize =3D char_ringbuf_finalize,
 };
=20
 /* Bug-compatibility: */
--=20
2.11.0
