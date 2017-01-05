Received: from eggs.gnu.org ([2001:4830:134:3::10]:53701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIe-0007WV-27
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIc-0002pG-EO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIc-0002on-6h
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:58 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50A9F1291F4
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:23 +0100
Message-Id: <20170105165329.17227-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/20] char: rename TCPChardev and NetChardev
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

Rename the types to follow the name of the chardev kind.
- socket: TCPChardev -> SocketChardev
- udp: NetChardev -> UdpChardev

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 74 ++++++++++++++++++++++++++++++-------------------------=
------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index d6ac7d70f3..6ac52ce48d 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2686,12 +2686,12 @@ typedef struct {
     int bufcnt;
     int bufptr;
     int max_size;
-} NetChardev;
+} UdpChardev;
=20
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    NetChardev *s =3D (NetChardev *)chr;
+    UdpChardev *s =3D (UdpChardev *)chr;
=20
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2700,7 +2700,7 @@ static int udp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
 static int udp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D opaque;
-    NetChardev *s =3D opaque;
+    UdpChardev *s =3D opaque;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
=20
@@ -2718,7 +2718,7 @@ static int udp_chr_read_poll(void *opaque)
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
     Chardev *chr =3D opaque;
-    NetChardev *s =3D opaque;
+    UdpChardev *s =3D opaque;
     ssize_t ret;
=20
     if (s->max_size =3D=3D 0) {
@@ -2745,7 +2745,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
 static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    NetChardev *s =3D (NetChardev *)chr;
+    UdpChardev *s =3D (UdpChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2758,7 +2758,7 @@ static void udp_chr_update_read_handler(Chardev *ch=
r,
=20
 static void udp_chr_free(Chardev *chr)
 {
-    NetChardev *s =3D (NetChardev *)chr;
+    UdpChardev *s =3D (UdpChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2794,13 +2794,13 @@ typedef struct {
     guint reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
-} TCPChardev;
+} SocketChardev;
=20
 static gboolean socket_reconnect_timeout(gpointer opaque);
=20
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     char *name;
=20
     assert(s->connected =3D=3D 0);
@@ -2814,7 +2814,7 @@ static void qemu_chr_socket_restart_timer(Chardev *=
chr)
 static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2831,7 +2831,7 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (s->connected) {
         int ret =3D  io_channel_send_full(s->ioc, buf, len,
@@ -2855,7 +2855,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
 static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D opaque;
-    TCPChardev *s =3D opaque;
+    SocketChardev *s =3D opaque;
     if (!s->connected)
         return 0;
     s->max_size =3D qemu_chr_be_can_write(chr);
@@ -2865,7 +2865,7 @@ static int tcp_chr_read_poll(void *opaque)
 #define IAC 255
 #define IAC_BREAK 243
 static void tcp_chr_process_IAC_bytes(Chardev *chr,
-                                      TCPChardev *s,
+                                      SocketChardev *s,
                                       uint8_t *buf, int *size)
 {
     /* Handle any telnet client's basic IAC options to satisfy char by
@@ -2914,7 +2914,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
=20
 static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
=20
@@ -2940,7 +2940,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, i=
nt num)
=20
 static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2965,7 +2965,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, i=
nt num)
=20
 static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
     int ret;
     size_t i;
@@ -3022,13 +3022,13 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *b=
uf, size_t len)
=20
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
 static void tcp_chr_free_connection(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     int i;
=20
     if (!s->connected) {
@@ -3057,7 +3057,7 @@ static void tcp_chr_free_connection(Chardev *chr)
=20
 static void tcp_chr_disconnect(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (!s->connected) {
         return;
@@ -3080,7 +3080,7 @@ static void tcp_chr_disconnect(Chardev *chr)
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
     Chardev *chr =3D opaque;
-    TCPChardev *s =3D opaque;
+    SocketChardev *s =3D opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
=20
@@ -3106,7 +3106,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
=20
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     int size;
=20
     if (!s->connected) {
@@ -3125,7 +3125,7 @@ static int tcp_chr_sync_read(Chardev *chr, const ui=
nt8_t *buf, int len)
 static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr =3D opaque;
-    TCPChardev *s =3D opaque;
+    SocketChardev *s =3D opaque;
=20
     g_free(chr->filename);
     chr->filename =3D sockaddr_to_str(
@@ -3146,7 +3146,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (!s->connected) {
         return;
@@ -3197,7 +3197,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
=20
 static void tcp_chr_telnet_init(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     TCPCharDriverTelnetInit *init =3D
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n =3D 0;
@@ -3233,7 +3233,7 @@ static void tcp_chr_tls_handshake(Object *source,
                                   gpointer user_data)
 {
     Chardev *chr =3D user_data;
-    TCPChardev *s =3D user_data;
+    SocketChardev *s =3D user_data;
=20
     if (err) {
         tcp_chr_disconnect(chr);
@@ -3249,7 +3249,7 @@ static void tcp_chr_tls_handshake(Object *source,
=20
 static void tcp_chr_tls_init(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     QIOChannelTLS *tioc;
     Error *err =3D NULL;
     gchar *name;
@@ -3288,7 +3288,7 @@ static void tcp_chr_tls_init(Chardev *chr)
 static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     char *name;
     name =3D g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3300,7 +3300,7 @@ static void tcp_chr_set_client_ioc_name(Chardev *ch=
r,
=20
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (s->ioc !=3D NULL) {
 	return -1;
@@ -3372,7 +3372,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
=20
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
     QIOChannelSocket *sioc;
=20
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3420,7 +3420,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Err=
or **errp)
=20
 static void tcp_chr_free(Chardev *chr)
 {
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     tcp_chr_free_connection(chr);
=20
@@ -3448,7 +3448,7 @@ static void qemu_chr_socket_connected(Object *src, =
Error *err, void *opaque)
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(src);
     Chardev *chr =3D opaque;
-    TCPChardev *s =3D (TCPChardev *)chr;
+    SocketChardev *s =3D (SocketChardev *)chr;
=20
     if (err) {
         check_report_connect_error(chr, err);
@@ -4730,7 +4730,7 @@ static const CharDriver serial_driver =3D {
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     Chardev *chr =3D opaque;
-    TCPChardev *s =3D opaque;
+    SocketChardev *s =3D opaque;
     QIOChannelSocket *sioc;
=20
     s->reconnect_timer =3D 0;
@@ -4756,7 +4756,7 @@ static Chardev *qmp_chardev_open_socket(const CharD=
river *driver,
                                         Error **errp)
 {
     Chardev *chr;
-    TCPChardev *s;
+    SocketChardev *s;
     ChardevSocket *sock =3D backend->u.socket.data;
     SocketAddress *addr =3D sock->addr;
     bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
@@ -4771,7 +4771,7 @@ static Chardev *qmp_chardev_open_socket(const CharD=
river *driver,
     if (!chr) {
         return NULL;
     }
-    s =3D (TCPChardev *)chr;
+    s =3D (SocketChardev *)chr;
=20
     s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen =3D is_listen;
@@ -4878,7 +4878,7 @@ static Chardev *qmp_chardev_open_socket(const CharD=
river *driver,
 }
=20
 static const CharDriver socket_driver =3D {
-    .instance_size =3D sizeof(TCPChardev),
+    .instance_size =3D sizeof(SocketChardev),
     .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
     .parse =3D qemu_chr_parse_socket,
     .create =3D qmp_chardev_open_socket,
@@ -4906,7 +4906,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriv=
er *driver,
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
     char *name;
     Chardev *chr;
-    NetChardev *s;
+    UdpChardev *s;
=20
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4924,7 +4924,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriv=
er *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
-    s =3D (NetChardev *)chr;
+    s =3D (UdpChardev *)chr;
     s->ioc =3D QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
@@ -4933,7 +4933,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriv=
er *driver,
 }
=20
 static const CharDriver udp_driver =3D {
-    .instance_size =3D sizeof(NetChardev),
+    .instance_size =3D sizeof(UdpChardev),
     .kind =3D CHARDEV_BACKEND_KIND_UDP,
     .parse =3D qemu_chr_parse_udp,
     .create =3D qmp_chardev_open_udp,
--=20
2.11.0
