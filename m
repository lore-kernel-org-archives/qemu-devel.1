Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBM-0004E2-49
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBL-0004q3-7L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FBL-0004pc-14
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:26 +0400
Message-Id: <20170504114232.20318-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/21] char-udp: flush as much buffer as possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Instead of flushing the buffer byte by byte, call qemu_chr_be_write()
with as much byte possible accepted by the front-end.

Factor out buffer flushing in a common function udp_chr_flush_buffer().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char-udp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 804bd22efa..1958c36de4 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -51,6 +51,18 @@ static int udp_chr_write(Chardev *chr, const uint8_t *=
buf, int len)
         s->ioc, (const char *)buf, len, NULL);
 }
=20
+static void udp_chr_flush_buffer(UdpChardev *s)
+{
+    Chardev *chr =3D CHARDEV(s);
+
+    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
+        int n =3D MIN(s->max_size, s->bufcnt - s->bufptr);
+        qemu_chr_be_write(chr, &s->buf[s->bufptr], n);
+        s->bufptr +=3D n;
+        s->max_size =3D qemu_chr_be_can_write(chr);
+    }
+}
+
 static int udp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
@@ -61,11 +73,8 @@ static int udp_chr_read_poll(void *opaque)
     /* If there were any stray characters in the queue process them
      * first
      */
-    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
-        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
-        s->bufptr++;
-        s->max_size =3D qemu_chr_be_can_write(chr);
-    }
+    udp_chr_flush_buffer(s);
+
     return s->max_size;
 }
=20
@@ -85,13 +94,8 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCond=
ition cond, void *opaque)
         return FALSE;
     }
     s->bufcnt =3D ret;
-
     s->bufptr =3D 0;
-    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
-        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
-        s->bufptr++;
-        s->max_size =3D qemu_chr_be_can_write(chr);
-    }
+    udp_chr_flush_buffer(s);
=20
     return TRUE;
 }
--=20
2.12.0.191.gc5d8de91d
