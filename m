Received: from eggs.gnu.org ([2001:4830:134:3::10]:45453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zc-00061f-6w
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zb-00079Y-A7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:08 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:42 +0200
Message-Id: <20170403153355.19722-3-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] nbd sockets vnc: Mark problematic address
 family tests TODO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

Certain features make sense only with certain address families.  For
instance, passing file descriptors requires AF_UNIX.  Testing
SocketAddress's saddr->type == SOCKET_ADDRESS_KIND_UNIX is obvious,
but problematic: it can't recognize AF_UNIX when type ==
SOCKET_ADDRESS_KIND_FD.

Mark such tests of saddr->type TODO.  We may want to check the address
family with getsockname() there.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1490895797-29094-2-git-send-email-armbru@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c           | 1 +
 blockdev-nbd.c        | 1 +
 chardev/char-socket.c | 5 ++---
 ui/vnc.c              | 1 +
 util/qemu-sockets.c   | 4 ++++
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 1b832c2132..36ea617989 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -421,6 +421,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
             goto error;
         }
 
+        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
         if (s->saddr->type != SOCKET_ADDRESS_KIND_INET) {
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 7ea836b46e..8a11807df3 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -124,6 +124,7 @@ void qmp_nbd_server_start(SocketAddress *addr,
             goto error;
         }
 
+        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
         if (addr->type != SOCKET_ADDRESS_KIND_INET) {
             error_setg(errp, "TLS is only supported with IPv4/IPv6");
             goto error;
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d7e92e1bd3..6344b07822 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -47,7 +47,6 @@ typedef struct {
     int max_size;
     int do_telnetopt;
     int do_nodelay;
-    int is_unix;
     int *read_msgfds;
     size_t read_msgfds_num;
     int *write_msgfds;
@@ -825,7 +824,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
     QIOChannelSocket *sioc = NULL;
 
-    s->is_unix = addr->type == SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
     s->do_nodelay = do_nodelay;
@@ -865,7 +863,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->addr = QAPI_CLONE(SocketAddress, sock->addr);
 
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
-    if (s->is_unix) {
+    /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
+    if (addr->type == SOCKET_ADDRESS_KIND_UNIX) {
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 243e99bb95..1095f9de68 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3642,6 +3642,7 @@ static int vnc_display_connect(VncDisplay *vd,
         error_setg(errp, "Expected a single address in reverse mode");
         return -1;
     }
+    /* TODO SOCKET_ADDRESS_KIND_FD when fd has AF_UNIX */
     vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_KIND_UNIX;
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 40164bf681..9b7368113c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1154,6 +1154,10 @@ int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
 {
     int fd;
 
+    /*
+     * TODO SOCKET_ADDRESS_KIND_FD when fd is AF_INET or AF_INET6
+     * (although other address families can do SOCK_DGRAM, too)
+     */
     switch (remote->type) {
     case SOCKET_ADDRESS_KIND_INET:
         fd = inet_dgram_saddr(remote->u.inet.data,
-- 
2.12.1
