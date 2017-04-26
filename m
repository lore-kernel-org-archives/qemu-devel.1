Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxH-0006ds-UR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxD-0002xP-Cj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:43 -0400
Received: from [59.151.112.132] (port=16366 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxC-0002ta-NE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:39 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Apr 2017 16:04:16 +0800
Message-ID: <6fcd733f02438a401c902e1a3b62564cb8c5c23a.1493191677.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/4] net/socket: Improve -net socket error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

When -net socket fails, it first reports a specific error, then
a generic one, like this:

    $ qemu-system-x86_64 -net socket,
    qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
    qemu-system-x86_64: -net socket: Device 'socket' could not be initialized

Convert net_init_socket() to Error to get rid of the unwanted second
error message.

CC: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 After the repair, the effect is as follows:

    $ qemu-system-x86_64 -net socket,
    qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required

 include/qemu/sockets.h |  2 +-
 net/socket.c           | 57 +++++++++++++++++++++++++++++---------------------
 util/qemu-sockets.c    |  2 +-
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index af28532..528b802 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -118,7 +118,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  *
  * Returns: the socket address in string format, or NULL on error
  */
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
+char *socket_address_to_string(struct SocketAddress *addr);
 
 /**
  * socket_address_crumple:
diff --git a/net/socket.c b/net/socket.c
index 52f9dce..b0decbe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -486,7 +486,8 @@ static void net_socket_accept(void *opaque)
 static int net_socket_listen_init(NetClientState *peer,
                                   const char *model,
                                   const char *name,
-                                  const char *host_str)
+                                  const char *host_str,
+                                  Error **errp)
 {
     NetClientState *nc;
     NetSocketState *s;
@@ -496,14 +497,14 @@ static int net_socket_listen_init(NetClientState *peer,
 
     saddr = socket_parse(host_str, &local_error);
     if (saddr == NULL) {
-        error_report_err(local_error);
+        error_propagate(errp, local_error);
         return -1;
     }
 
     ret = socket_listen(saddr, &local_error);
     if (ret < 0) {
         qapi_free_SocketAddress(saddr);
-        error_report_err(local_error);
+        error_propagate(errp, local_error);
         return -1;
     }
 
@@ -545,11 +546,9 @@ static void net_socket_connected(QIOTask *task, void *opaque)
     socket_connect_data *c = opaque;
     NetSocketState *s;
     char *addr_str = NULL;
-    Error *local_error = NULL;
 
-    addr_str = socket_address_to_string(c->saddr, &local_error);
+    addr_str = socket_address_to_string(c->saddr);
     if (addr_str == NULL) {
-        error_report_err(local_error);
         closesocket(sioc->fd);
         goto end;
     }
@@ -571,7 +570,8 @@ end:
 static int net_socket_connect_init(NetClientState *peer,
                                    const char *model,
                                    const char *name,
-                                   const char *host_str)
+                                   const char *host_str,
+                                   Error **errp)
 {
     socket_connect_data *c = g_new0(socket_connect_data, 1);
     QIOChannelSocket *sioc;
@@ -594,7 +594,7 @@ static int net_socket_connect_init(NetClientState *peer,
     return 0;
 
 err:
-    error_report_err(local_error);
+    error_propagate(errp, local_error);
     socket_connect_data_free(c);
     return -1;
 }
@@ -603,7 +603,8 @@ static int net_socket_mcast_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
                                  const char *host_str,
-                                 const char *localaddr_str)
+                                 const char *localaddr_str,
+                                 Error **errp)
 {
     NetSocketState *s;
     int fd;
@@ -614,8 +615,11 @@ static int net_socket_mcast_init(NetClientState *peer,
         return -1;
 
     if (localaddr_str != NULL) {
-        if (inet_aton(localaddr_str, &localaddr) == 0)
+        if (inet_aton(localaddr_str, &localaddr) == 0) {
+            error_setg(errp, "Convert the local address to network"
+                        " byte order failed");
             return -1;
+        }
         param_localaddr = &localaddr;
     } else {
         param_localaddr = NULL;
@@ -642,7 +646,8 @@ static int net_socket_udp_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
                                  const char *rhost,
-                                 const char *lhost)
+                                 const char *lhost,
+                                 Error **errp)
 {
     NetSocketState *s;
     int fd, ret;
@@ -658,7 +663,7 @@ static int net_socket_udp_init(NetClientState *peer,
 
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "socket(PF_INET, SOCK_DGRAM)");
         return -1;
     }
 
@@ -669,7 +674,7 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "bind");
         closesocket(fd);
         return -1;
     }
@@ -691,7 +696,6 @@ static int net_socket_udp_init(NetClientState *peer,
 int net_init_socket(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
     Error *err = NULL;
     const NetdevSocketOptions *sock;
 
@@ -700,13 +704,13 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
         sock->has_udp != 1) {
-        error_report("exactly one of fd=, listen=, connect=, mcast= or udp="
+        error_setg(errp, "exactly one of fd=, listen=, connect=, mcast= or udp="
                      " is required");
         return -1;
     }
 
     if (sock->has_localaddr && !sock->has_mcast && !sock->has_udp) {
-        error_report("localaddr= is only valid with mcast= or udp=");
+        error_setg(errp, "localaddr= is only valid with mcast= or udp=");
         return -1;
     }
 
@@ -715,7 +719,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
         fd = monitor_fd_param(cur_mon, sock->fd, &err);
         if (fd == -1) {
-            error_report_err(err);
+            error_propagate(errp, err);
             return -1;
         }
         qemu_set_nonblock(fd);
@@ -726,15 +730,18 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->has_listen) {
-        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
+        if (net_socket_listen_init(peer, "socket", name, sock->listen,
+            &err) == -1) {
+            error_propagate(errp, err);
             return -1;
         }
         return 0;
     }
 
     if (sock->has_connect) {
-        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
-            -1) {
+        if (net_socket_connect_init(peer, "socket", name, sock->connect,
+            &err) == -1) {
+            error_propagate(errp, err);
             return -1;
         }
         return 0;
@@ -744,7 +751,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
         /* if sock->localaddr is missing, it has been initialized to "all bits
          * zero" */
         if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
-            sock->localaddr) == -1) {
+            sock->localaddr, &err) == -1) {
+            error_propagate(errp, err);
             return -1;
         }
         return 0;
@@ -752,11 +760,12 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     assert(sock->has_udp);
     if (!sock->has_localaddr) {
-        error_report("localaddr= is mandatory with udp=");
+        error_setg(errp, "localaddr= is mandatory with udp=");
         return -1;
     }
-    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
-        -1) {
+    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
+        &err) == -1) {
+        error_propagate(errp, err);
         return -1;
     }
     return 0;
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8188d9a..0da33d7 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1312,7 +1312,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp)
     return socket_sockaddr_to_address(&ss, sslen, errp);
 }
 
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
+char *socket_address_to_string(struct SocketAddress *addr)
 {
     char *buf;
     InetSocketAddress *inet;
-- 
2.9.3
