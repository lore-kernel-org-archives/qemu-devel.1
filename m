Received: from eggs.gnu.org ([2001:4830:134:3::10]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rL-0005UZ-By
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rI-0004Gw-5M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:35 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rH-0004Gb-SQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so58372878wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:42 +0100
Message-Id: <1485524749-118532-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/41] char: rename TCPChardev and NetChardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Rename the types to follow the name of the chardev kind.
- socket: TCPChardev -> SocketChardev
- udp: NetChardev -> UdpChardev

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-char.c | 74 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index f828e61..c82d6d2 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2691,12 +2691,12 @@ typedef struct {
     int bufcnt;
     int bufptr;
     int max_size;
-} NetChardev;
+} UdpChardev;
 
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    NetChardev *s = (NetChardev *)chr;
+    UdpChardev *s = (UdpChardev *)chr;
 
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2705,7 +2705,7 @@ static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 static int udp_chr_read_poll(void *opaque)
 {
     Chardev *chr = opaque;
-    NetChardev *s = opaque;
+    UdpChardev *s = opaque;
 
     s->max_size = qemu_chr_be_can_write(chr);
 
@@ -2723,7 +2723,7 @@ static int udp_chr_read_poll(void *opaque)
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = opaque;
-    NetChardev *s = opaque;
+    UdpChardev *s = opaque;
     ssize_t ret;
 
     if (s->max_size == 0) {
@@ -2750,7 +2750,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    NetChardev *s = (NetChardev *)chr;
+    UdpChardev *s = (UdpChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2763,7 +2763,7 @@ static void udp_chr_update_read_handler(Chardev *chr,
 
 static void udp_chr_free(Chardev *chr)
 {
-    NetChardev *s = (NetChardev *)chr;
+    UdpChardev *s = (UdpChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2799,13 +2799,13 @@ typedef struct {
     guint reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
-} TCPChardev;
+} SocketChardev;
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     char *name;
 
     assert(s->connected == 0);
@@ -2819,7 +2819,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
 static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2836,7 +2836,7 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     if (s->connected) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
@@ -2860,7 +2860,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr = opaque;
-    TCPChardev *s = opaque;
+    SocketChardev *s = opaque;
     if (!s->connected)
         return 0;
     s->max_size = qemu_chr_be_can_write(chr);
@@ -2870,7 +2870,7 @@ static int tcp_chr_read_poll(void *opaque)
 #define IAC 255
 #define IAC_BREAK 243
 static void tcp_chr_process_IAC_bytes(Chardev *chr,
-                                      TCPChardev *s,
+                                      SocketChardev *s,
                                       uint8_t *buf, int *size)
 {
     /* Handle any telnet client's basic IAC options to satisfy char by
@@ -2919,7 +2919,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
 
 static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     int to_copy = (s->read_msgfds_num < num) ? s->read_msgfds_num : num;
 
@@ -2945,7 +2945,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 
 static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2970,7 +2970,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 
 static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     struct iovec iov = { .iov_base = buf, .iov_len = len };
     int ret;
     size_t i;
@@ -3027,13 +3027,13 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
 
 static void tcp_chr_free_connection(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     int i;
 
     if (!s->connected) {
@@ -3062,7 +3062,7 @@ static void tcp_chr_free_connection(Chardev *chr)
 
 static void tcp_chr_disconnect(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     if (!s->connected) {
         return;
@@ -3085,7 +3085,7 @@ static void tcp_chr_disconnect(Chardev *chr)
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = opaque;
-    TCPChardev *s = opaque;
+    SocketChardev *s = opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
 
@@ -3111,7 +3111,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     int size;
 
     if (!s->connected) {
@@ -3130,7 +3130,7 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr = opaque;
-    TCPChardev *s = opaque;
+    SocketChardev *s = opaque;
 
     g_free(chr->filename);
     chr->filename = sockaddr_to_str(
@@ -3151,7 +3151,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     if (!s->connected) {
         return;
@@ -3202,7 +3202,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
 
 static void tcp_chr_telnet_init(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     TCPCharDriverTelnetInit *init =
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n = 0;
@@ -3237,7 +3237,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
     Chardev *chr = user_data;
-    TCPChardev *s = user_data;
+    SocketChardev *s = user_data;
 
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
@@ -3253,7 +3253,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 
 static void tcp_chr_tls_init(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     QIOChannelTLS *tioc;
     Error *err = NULL;
     gchar *name;
@@ -3292,7 +3292,7 @@ static void tcp_chr_tls_init(Chardev *chr)
 static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     char *name;
     name = g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3304,7 +3304,7 @@ static void tcp_chr_set_client_ioc_name(Chardev *chr,
 
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     if (s->ioc != NULL) {
 	return -1;
@@ -3376,7 +3376,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
 
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     QIOChannelSocket *sioc;
 
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3424,7 +3424,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
 
 static void tcp_chr_free(Chardev *chr)
 {
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
 
     tcp_chr_free_connection(chr);
 
@@ -3452,7 +3452,7 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     Chardev *chr = opaque;
-    TCPChardev *s = (TCPChardev *)chr;
+    SocketChardev *s = (SocketChardev *)chr;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -4733,7 +4733,7 @@ static const CharDriver serial_driver = {
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     Chardev *chr = opaque;
-    TCPChardev *s = opaque;
+    SocketChardev *s = opaque;
     QIOChannelSocket *sioc;
 
     s->reconnect_timer = 0;
@@ -4759,7 +4759,7 @@ static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
                                         Error **errp)
 {
     Chardev *chr;
-    TCPChardev *s;
+    SocketChardev *s;
     ChardevSocket *sock = backend->u.socket.data;
     SocketAddress *addr = sock->addr;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
@@ -4774,7 +4774,7 @@ static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = (TCPChardev *)chr;
+    s = (SocketChardev *)chr;
 
     s->is_unix = addr->type == SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen = is_listen;
@@ -4881,7 +4881,7 @@ static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
 }
 
 static const CharDriver socket_driver = {
-    .instance_size = sizeof(TCPChardev),
+    .instance_size = sizeof(SocketChardev),
     .kind = CHARDEV_BACKEND_KIND_SOCKET,
     .parse = qemu_chr_parse_socket,
     .create = qmp_chardev_open_socket,
@@ -4909,7 +4909,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
     Chardev *chr;
-    NetChardev *s;
+    UdpChardev *s;
 
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4927,7 +4927,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
 
-    s = (NetChardev *)chr;
+    s = (UdpChardev *)chr;
     s->ioc = QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
     *be_opened = false;
@@ -4936,7 +4936,7 @@ static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
 }
 
 static const CharDriver udp_driver = {
-    .instance_size = sizeof(NetChardev),
+    .instance_size = sizeof(UdpChardev),
     .kind = CHARDEV_BACKEND_KIND_UDP,
     .parse = qemu_chr_parse_udp,
     .create = qmp_chardev_open_udp,
-- 
1.8.3.1
