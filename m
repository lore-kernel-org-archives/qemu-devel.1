Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ91-0007sm-K1
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ90-0001lI-C4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:39 -0400
Received: from [59.151.112.132] (port=61554 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ8z-0001ij-FN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:38 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 22:15:05 +0800
Message-ID: <7e6ebf3f253314160b8a17ca4a3211140992cfc0.1497276062.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 4/4] net/socket: Improve -net socket error
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

Convert net_init_socket() to Error to get rid of the superfluous second
error message. After the patch, the effect like this:

    $ qemu-system-x86_64 -net socket,
    qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required

At the same time, add many explicit error handling message when it fails.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 9825422..a8f2d7f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -510,7 +510,8 @@ static int net_socket_listen_init(NetClientState *peer,
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
+        error_setg_errno(errp, errno, "Create socket(PF_INET,"
+                         " SOCK_STREAM) failed");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -519,13 +520,14 @@ static int net_socket_listen_init(NetClientState *peer,
 
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
@@ -557,7 +559,8 @@ static int net_socket_connect_init(NetClientState *peer,
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
+        error_setg_errno(errp, errno, "Create socket(PF_INET,"
+                         " SOCK_STREAM) failed");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -573,7 +576,7 @@ static int net_socket_connect_init(NetClientState *peer,
                        errno == EINVAL) {
                 break;
             } else {
-                perror("connect");
+                error_setg_errno(errp, errno, "Connection failed");
                 closesocket(fd);
                 return -1;
             }
@@ -607,8 +610,11 @@ static int net_socket_mcast_init(NetClientState *peer,
         return -1;
 
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
@@ -652,18 +658,22 @@ static int net_socket_udp_init(NetClientState *peer,
 
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
+                   " SO_REUSEADDR failed", fd);
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
@@ -685,8 +695,6 @@ static int net_socket_udp_init(NetClientState *peer,
 int net_init_socket(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
-    Error *err = NULL;
     const NetdevSocketOptions *sock;
 
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
@@ -694,22 +702,21 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
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
@@ -747,7 +754,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     assert(sock->has_udp);
     if (!sock->has_localaddr) {
-        error_report("localaddr= is mandatory with udp=");
+        error_setg(errp, "localaddr= is mandatory with udp=");
         return -1;
     }
     if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
-- 
2.9.3
