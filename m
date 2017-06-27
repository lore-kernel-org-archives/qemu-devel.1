Received: from eggs.gnu.org ([2001:4830:134:3::10]:39540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPh7i-0004vs-Dy
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPh7g-0007S1-Ao
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:25:06 -0400
Received: from [59.151.112.132] (port=17509 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPh7f-0007RI-Bk
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:25:04 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 27 Jun 2017 11:24:42 +0800
Message-ID: <fb85d3239d6e83b6066a5a5d4f5d5304bc4495ba.1498530543.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1498530543.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1498530543.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/4] net/socket: Improve -net socket error
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
Cc: jasowang@redhat.com, armbru@redhat.com

When -net socket fails, it first reports a specific error, then
a generic one, like this:

    $ qemu-system-x86_64 -net socket,
    qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
    qemu-system-x86_64: -net socket: Device 'socket' could not be initialized

Convert net_socket_*_init() to Error to get rid of the superfluous second
error message. After the patch, the effect like this:

    $ qemu-system-x86_64 -net socket,
    qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required

At the same time, add many explicit error handling message when it fails.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 95 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index a875205..8be37d1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -495,22 +495,22 @@ static void net_socket_accept(void *opaque)
 static int net_socket_listen_init(NetClientState *peer,
                                   const char *model,
                                   const char *name,
-                                  const char *host_str)
+                                  const char *host_str,
+                                  Error **errp)
 {
     NetClientState *nc;
     NetSocketState *s;
     struct sockaddr_in saddr;
     int fd, ret;
-    Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str, &err) < 0) {
-        error_report_err(err);
+    if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
     }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
+        error_setg_errno(errp, errno, "Create socket(PF_INET,"
+                         " SOCK_STREAM) failed");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -519,13 +519,14 @@ static int net_socket_listen_init(NetClientState *peer,
 
     ret = bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "Bind ip=%s to fd=%d failed",
+                         inet_ntoa(saddr.sin_addr), fd);
         closesocket(fd);
         return -1;
     }
     ret = listen(fd, 0);
     if (ret < 0) {
-        perror("listen");
+        error_setg_errno(errp, errno, "Listen socket fd=%d failed", fd);
         closesocket(fd);
         return -1;
     }
@@ -544,21 +545,21 @@ static int net_socket_listen_init(NetClientState *peer,
 static int net_socket_connect_init(NetClientState *peer,
                                    const char *model,
                                    const char *name,
-                                   const char *host_str)
+                                   const char *host_str,
+                                   Error **errp)
 {
     NetSocketState *s;
     int fd, connected, ret;
     struct sockaddr_in saddr;
-    Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str, &err) < 0) {
-        error_report_err(err);
+    if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
     }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
+        error_setg_errno(errp, errno, "Create socket(PF_INET,"
+                         " SOCK_STREAM) failed");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -574,7 +575,7 @@ static int net_socket_connect_init(NetClientState *peer,
                        errno == EINVAL) {
                 break;
             } else {
-                perror("connect");
+                error_setg_errno(errp, errno, "Connection failed");
                 closesocket(fd);
                 return -1;
             }
@@ -583,9 +584,8 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, &err);
+    s = net_socket_fd_init(peer, model, name, fd, connected, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
@@ -598,36 +598,36 @@ static int net_socket_mcast_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
                                  const char *host_str,
-                                 const char *localaddr_str)
+                                 const char *localaddr_str,
+                                 Error **errp)
 {
     NetSocketState *s;
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
-    Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str, &err) < 0) {
-        error_report_err(err);
+    if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
     }
 
     if (localaddr_str != NULL) {
-        if (inet_aton(localaddr_str, &localaddr) == 0)
+        if (inet_aton(localaddr_str, &localaddr) == 0) {
+            error_setg(errp, "localaddr '%s' is not a valid IPv4 address",
+                       localaddr_str);
             return -1;
+        }
         param_localaddr = &localaddr;
     } else {
         param_localaddr = NULL;
     }
 
-    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
+    fd = net_socket_mcast_create(&saddr, param_localaddr, errp);
     if (fd < 0) {
-        error_report_err(err);
         return -1;
     }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
+    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
 
@@ -644,45 +644,46 @@ static int net_socket_udp_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
                                  const char *rhost,
-                                 const char *lhost)
+                                 const char *lhost,
+                                 Error **errp)
 {
     NetSocketState *s;
     int fd, ret;
     struct sockaddr_in laddr, raddr;
-    Error *err = NULL;
 
-    if (parse_host_port(&laddr, lhost, &err) < 0) {
-        error_report_err(err);
+    if (parse_host_port(&laddr, lhost, errp) < 0) {
         return -1;
     }
 
-    if (parse_host_port(&raddr, rhost, &err) < 0) {
-        error_report_err(err);
+    if (parse_host_port(&raddr, rhost, errp) < 0) {
         return -1;
     }
 
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "Create socket(PF_INET,"
+                         " SOCK_DGRAM) failed");
         return -1;
     }
 
     ret = socket_set_fast_reuse(fd);
     if (ret < 0) {
+        error_setg_errno(errp, errno, "Set the socket fd=%d attribute"
+                         " SO_REUSEADDR failed", fd);
         closesocket(fd);
         return -1;
     }
     ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "Bind ip=%s to fd=%d failed",
+                         inet_ntoa(laddr.sin_addr), fd);
         closesocket(fd);
         return -1;
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
+    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
 
@@ -697,8 +698,6 @@ static int net_socket_udp_init(NetClientState *peer,
 int net_init_socket(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
-    Error *err = NULL;
     const NetdevSocketOptions *sock;
 
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
@@ -706,22 +705,21 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
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
 
     if (sock->has_fd) {
         int fd;
 
-        fd = monitor_fd_param(cur_mon, sock->fd, &err);
+        fd = monitor_fd_param(cur_mon, sock->fd, errp);
         if (fd == -1) {
-            error_report_err(err);
             return -1;
         }
         qemu_set_nonblock(fd);
@@ -732,15 +730,16 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->has_listen) {
-        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
+        if (net_socket_listen_init(peer, "socket", name,
+            sock->listen, errp) == -1) {
             return -1;
         }
         return 0;
     }
 
     if (sock->has_connect) {
-        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
-            -1) {
+        if (net_socket_connect_init(peer, "socket", name,
+            sock->connect, errp) == -1) {
             return -1;
         }
         return 0;
@@ -749,8 +748,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
     if (sock->has_mcast) {
         /* if sock->localaddr is missing, it has been initialized to "all bits
          * zero" */
-        if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
-            sock->localaddr) == -1) {
+        if (net_socket_mcast_init(peer, "socket", name,
+            sock->mcast, sock->localaddr, errp) == -1) {
             return -1;
         }
         return 0;
@@ -758,11 +757,11 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     assert(sock->has_udp);
     if (!sock->has_localaddr) {
-        error_report("localaddr= is mandatory with udp=");
+        error_setg(errp, "localaddr= is mandatory with udp=");
         return -1;
     }
-    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
-        -1) {
+    if (net_socket_udp_init(peer, "socket", name,
+        sock->udp, sock->localaddr, errp) == -1) {
         return -1;
     }
     return 0;
-- 
2.9.4
