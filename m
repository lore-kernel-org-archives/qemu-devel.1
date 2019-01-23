Received: from eggs.gnu.org ([209.51.188.92]:42042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKY-00030o-Fd
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKT-0002ql-Ui
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKT-0002ne-Hd
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:45 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:35 +0000
Message-Id: <20190123172740.32452-12-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/16] chardev: use a state machine for
 socket connection state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The socket connection state is indicated via the 'bool connected' field
in the SocketChardev struct. This variable is somewhat misleading
though, as it is only set to true once the connection has completed all
required handshakes (eg for TLS, telnet or websockets). IOW there is a
period of time in which the socket is connected, but the "connected"
flag is still false.

The socket chardev really has three states that it can be in,
disconnected, connecting and connected and those should be tracked
explicitly.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 63 +++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 90dafef7d4..d6de5d2305 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -46,6 +46,12 @@ typedef struct {
     size_t buflen;
 } TCPChardevTelnetInit;
=20
+typedef enum {
+    TCP_CHARDEV_STATE_DISCONNECTED,
+    TCP_CHARDEV_STATE_CONNECTING,
+    TCP_CHARDEV_STATE_CONNECTED,
+} TCPChardevState;
+
 typedef struct {
     Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
@@ -53,7 +59,7 @@ typedef struct {
     QIONetListener *listener;
     GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
-    int connected;
+    TCPChardevState state;
     int max_size;
     int do_telnetopt;
     int do_nodelay;
@@ -82,6 +88,21 @@ typedef struct {
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
=20
+static void tcp_chr_change_state(SocketChardev *s, TCPChardevState state=
)
+{
+    switch (state) {
+    case TCP_CHARDEV_STATE_DISCONNECTED:
+        break;
+    case TCP_CHARDEV_STATE_CONNECTING:
+        assert(s->state =3D=3D TCP_CHARDEV_STATE_DISCONNECTED);
+        break;
+    case TCP_CHARDEV_STATE_CONNECTED:
+        assert(s->state =3D=3D TCP_CHARDEV_STATE_CONNECTING);
+        break;
+    }
+    s->state =3D state;
+}
+
 static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 {
     if (s->reconnect_timer) {
@@ -96,7 +117,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr=
)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     char *name;
=20
-    assert(s->connected =3D=3D 0);
+    assert(s->state =3D=3D TCP_CHARDEV_STATE_DISCONNECTED);
     name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer =3D qemu_chr_timeout_add_ms(chr,
                                                  s->reconnect_time * 100=
0,
@@ -131,7 +152,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
-    if (s->connected) {
+    if (s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED) {
         int ret =3D  io_channel_send_full(s->ioc, buf, len,
                                         s->write_msgfds,
                                         s->write_msgfds_num);
@@ -164,7 +185,7 @@ static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-    if (!s->connected) {
+    if (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
         return 0;
     }
     s->max_size =3D qemu_chr_be_can_write(chr);
@@ -277,7 +298,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, int=
 num)
     s->write_msgfds =3D NULL;
     s->write_msgfds_num =3D 0;
=20
-    if (!s->connected ||
+    if ((s->state !=3D TCP_CHARDEV_STATE_CONNECTED) ||
         !qio_channel_has_feature(s->ioc,
                                  QIO_CHANNEL_FEATURE_FD_PASS)) {
         return -1;
@@ -389,7 +410,7 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->ioc =3D NULL;
     g_free(chr->filename);
     chr->filename =3D NULL;
-    s->connected =3D 0;
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
 }
=20
 static const char *qemu_chr_socket_protocol(SocketChardev *s)
@@ -442,12 +463,12 @@ static void update_disconnected_filename(SocketChar=
dev *s)
=20
 /* NB may be called even if tcp_chr_connect has not been
  * reached, due to TLS or telnet initialization failure,
- * so can *not* assume s->connected =3D=3D true
+ * so can *not* assume s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED
  */
 static void tcp_chr_disconnect(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    bool emit_close =3D s->connected;
+    bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
=20
     tcp_chr_free_connection(chr);
=20
@@ -471,7 +492,8 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
     uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
=20
-    if (!s->connected || s->max_size <=3D 0) {
+    if ((s->state !=3D TCP_CHARDEV_STATE_CONNECTED) ||
+        s->max_size <=3D 0) {
         return TRUE;
     }
     len =3D sizeof(buf);
@@ -508,7 +530,7 @@ static int tcp_chr_sync_read(Chardev *chr, const uint=
8_t *buf, int len)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     int size;
=20
-    if (!s->connected) {
+    if (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
         return 0;
     }
=20
@@ -564,7 +586,7 @@ static void update_ioc_handlers(SocketChardev *s)
 {
     Chardev *chr =3D CHARDEV(s);
=20
-    if (!s->connected) {
+    if (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
         return;
     }
=20
@@ -589,7 +611,7 @@ static void tcp_chr_connect(void *opaque)
     g_free(chr->filename);
     chr->filename =3D qemu_chr_compute_filename(s);
=20
-    s->connected =3D 1;
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);
     update_ioc_handlers(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
@@ -828,7 +850,7 @@ static int tcp_chr_new_client(Chardev *chr, QIOChanne=
lSocket *sioc)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
-    if (s->ioc !=3D NULL) {
+    if (s->state !=3D TCP_CHARDEV_STATE_CONNECTING) {
         return -1;
     }
=20
@@ -865,11 +887,17 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
 {
     int ret;
     QIOChannelSocket *sioc;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (s->state !=3D TCP_CHARDEV_STATE_DISCONNECTED) {
+        return -1;
+    }
=20
     sioc =3D qio_channel_socket_new_fd(fd, NULL);
     if (!sioc) {
         return -1;
     }
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
     ret =3D tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
@@ -881,7 +909,9 @@ static void tcp_chr_accept(QIONetListener *listener,
                            void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
     tcp_chr_new_client(chr, cioc);
 }
@@ -891,8 +921,10 @@ static int tcp_chr_connect_client_sync(Chardev *chr,=
 Error **errp)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
     if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0) {
+        tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
         object_unref(OBJECT(sioc));
         return -1;
     }
@@ -908,6 +940,7 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     QIOChannelSocket *sioc;
     info_report("QEMU waiting for connection on: %s",
                 chr->filename);
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
     tcp_chr_new_client(chr, sioc);
@@ -963,6 +996,7 @@ static void qemu_chr_socket_connected(QIOTask *task, =
void *opaque)
     Error *err =3D NULL;
=20
     if (qio_task_propagate_error(task, &err)) {
+        tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
         check_report_connect_error(chr, err);
         error_free(err);
         goto cleanup;
@@ -980,6 +1014,7 @@ static void tcp_chr_connect_client_async(Chardev *ch=
r)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
=20
+    tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
     qio_channel_socket_connect_async(sioc, s->addr,
@@ -1307,7 +1342,7 @@ char_socket_get_connected(Object *obj, Error **errp=
)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(obj);
=20
-    return s->connected;
+    return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
 }
=20
 static void char_socket_class_init(ObjectClass *oc, void *data)
--=20
2.20.1
