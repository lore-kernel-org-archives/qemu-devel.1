Received: from eggs.gnu.org ([2001:4830:134:3::10]:33067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlE0-0005WG-Np
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDz-0004z1-SY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlDz-0004ye-Kg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 029F7305B885
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:22:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:09 +0200
Message-Id: <20181012002217.2864-4-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/11] chardev: Simplify
 IOWatchPoll::fd_can_read as a GSourceFunc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

IOWatchPoll::fd_can_read() simply returns a boolean value.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-fd.c         | 4 ++--
 chardev/char-io.c         | 4 ++--
 chardev/char-pty.c        | 4 ++--
 chardev/char-socket.c     | 6 +++---
 chardev/char-udp.c        | 4 ++--
 include/chardev/char-io.h | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 2c9b2ce567..2421d8e216 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -69,13 +69,13 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCond=
ition cond, void *opaque)
     return TRUE;
 }
=20
-static int fd_chr_read_poll(void *opaque)
+static gboolean fd_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     FDChardev *s =3D FD_CHARDEV(opaque);
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
+    return s->max_size > 0;
 }
=20
 static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
diff --git a/chardev/char-io.c b/chardev/char-io.c
index 8ced184160..a264d4e7fd 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -30,7 +30,7 @@ typedef struct IOWatchPoll {
     QIOChannel *ioc;
     GSource *src;
=20
-    IOCanReadHandler *fd_can_read;
+    GSourceFunc fd_can_read;
     GSourceFunc fd_read;
     void *opaque;
 } IOWatchPoll;
@@ -76,7 +76,7 @@ static GSourceFuncs io_watch_poll_funcs =3D {
=20
 GSource *io_add_watch_poll(Chardev *chr,
                         QIOChannel *ioc,
-                        IOCanReadHandler *fd_can_read,
+                        GSourceFunc fd_can_read,
                         QIOChannelFunc fd_read,
                         gpointer user_data,
                         GMainContext *context)
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index e8d9a53476..626ca30cb3 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -148,13 +148,13 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIO=
Condition cond)
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
-static int pty_chr_read_poll(void *opaque)
+static gboolean pty_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
     s->read_bytes =3D qemu_chr_be_can_write(chr);
-    return s->read_bytes;
+    return s->read_bytes > 0;
 }
=20
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a75b46d9fe..76cc3c48b0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -120,7 +120,7 @@ static void tcp_chr_accept(QIONetListener *listener,
                            QIOChannelSocket *cioc,
                            void *opaque);
=20
-static int tcp_chr_read_poll(void *opaque);
+static gboolean tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect(Chardev *chr);
=20
 /* Called with chr_write_lock held.  */
@@ -157,7 +157,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
     }
 }
=20
-static int tcp_chr_read_poll(void *opaque)
+static gboolean tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
@@ -165,7 +165,7 @@ static int tcp_chr_read_poll(void *opaque)
         return 0;
     }
     s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
+    return s->max_size > 0;
 }
=20
 static void tcp_chr_process_IAC_bytes(Chardev *chr,
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 097a2f0f42..b6e399e983 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -65,7 +65,7 @@ static void udp_chr_flush_buffer(UdpChardev *s)
     }
 }
=20
-static int udp_chr_read_poll(void *opaque)
+static gboolean udp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     UdpChardev *s =3D UDP_CHARDEV(opaque);
@@ -77,7 +77,7 @@ static int udp_chr_read_poll(void *opaque)
      */
     udp_chr_flush_buffer(s);
=20
-    return s->max_size;
+    return s->max_size > 0;
 }
=20
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index 9638da5100..a173874538 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -31,7 +31,7 @@
 /* Can only be used for read */
 GSource *io_add_watch_poll(Chardev *chr,
                         QIOChannel *ioc,
-                        IOCanReadHandler *fd_can_read,
+                        GSourceFunc fd_can_read,
                         QIOChannelFunc fd_read,
                         gpointer user_data,
                         GMainContext *context);
--=20
2.17.1
