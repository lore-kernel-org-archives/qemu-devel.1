Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkw-0005Mg-BZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIks-0004TZ-OK
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIks-0004TJ-IX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A652D7E9CD
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:35 +0400
Message-Id: <20170202145141.17138-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/22] char-udp: flush as much buffer as
 possible
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

Instead of flushing the buffer byte by byte, call qemu_chr_be_write()
with as much byte possible accepted by the front-end.

Factor out buffer flushing in a common function udp_chr_flush_buffer().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-udp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 2c6c7ddd73..5364b5fc59 100644
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
2.11.0.295.gd7dffce1c.dirty
