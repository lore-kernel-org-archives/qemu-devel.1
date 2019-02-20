Received: from eggs.gnu.org ([209.51.188.92]:41112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGR3-00059h-Iv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGJ0-0001j3-VI
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:04:12 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:08 +0100
Message-Id: <20190220010232.18731-2-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/25] chardev: Simplify
 IOWatchPoll::fd_can_read as a GSourceFunc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

IOWatchPoll::fd_can_read() really is a GSourceFunc type, it simply
returns a boolean value.
Update the backends to return a boolean, whether there is data to
read from the source or not.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-fd.c         | 4 ++--
 chardev/char-io.c         | 6 +++---
 chardev/char-pty.c        | 4 ++--
 chardev/char-socket.c     | 6 +++---
 chardev/char-udp.c        | 4 ++--
 include/chardev/char-io.h | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

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
index 8ced184160..2c1c69098e 100644
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
@@ -44,7 +44,7 @@ static gboolean io_watch_poll_prepare(GSource *source,
                                       gint *timeout)
 {
     IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
-    bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;
+    bool now_active =3D iwp->fd_can_read(iwp->opaque);
     bool was_active =3D iwp->src !=3D NULL;
     if (was_active =3D=3D now_active) {
         return FALSE;
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
index b034332edd..7777f6ddef 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -119,13 +119,13 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIO=
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
index 4fcdd8aedd..262a59b64f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -147,7 +147,7 @@ static void tcp_chr_accept(QIONetListener *listener,
                            QIOChannelSocket *cioc,
                            void *opaque);
=20
-static int tcp_chr_read_poll(void *opaque);
+static gboolean tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect(Chardev *chr);
=20
 /* Called with chr_write_lock held.  */
@@ -184,7 +184,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
     }
 }
=20
-static int tcp_chr_read_poll(void *opaque)
+static gboolean tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
@@ -192,7 +192,7 @@ static int tcp_chr_read_poll(void *opaque)
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
2.20.1
