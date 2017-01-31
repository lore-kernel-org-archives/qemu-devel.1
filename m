Received: from eggs.gnu.org ([2001:4830:134:3::10]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbC2-0008L6-1F
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbC1-0000qI-7S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbC1-0000q5-2G
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:05 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:50 +0400
Message-Id: <20170131162122.29408-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/41] char-ringbuf: convert to finalize
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
