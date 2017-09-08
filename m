Received: from eggs.gnu.org ([2001:4830:134:3::10]:60995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gd-0003Z1-TY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gY-0002Qp-Gn
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gY-0002Q9-7T
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:22 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:17 +0800
Message-Id: <1504836324-4871-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 11/18] net/socket: Improve -net socket error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

When -net socket fails, it first reports a specific error, then
a generic one, like this:

    $ ./x86_64-softmmu/qemu-system-x86_64 -net socket,mcast=230.0.0.1:1234,listen
    qemu-system-x86_64: -net socket,mcast=230.0.0.1:1234,listen: exactly one of listen=, connect=, mcast= or udp= is required
    qemu-system-x86_64: -net socket,mcast=230.0.0.1:1234,listen: Device 'socket' could not be initialized

Convert net_socket_*_init() to Error to get rid of the superfluous second
error message. After the patch, the effect like this:

    $ ./x86_64-softmmu/qemu-system-x86_64 -net socket,mcast=230.0.0.1:1234,listen
    qemu-system-x86_64: -net socket,mcast=230.0.0.1:1234,listen: exactly one of listen=, connect=, mcast= or udp= is requireda

This also fixes a few silent failures to report an error.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 92 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 12495d1..e6b471c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -489,22 +489,21 @@ static void net_socket_accept(void *opaque)
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
+        error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -513,13 +512,14 @@ static int net_socket_listen_init(NetClientState *peer,
 
     ret = bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
+                         inet_ntoa(saddr.sin_addr));
         closesocket(fd);
         return -1;
     }
     ret = listen(fd, 0);
     if (ret < 0) {
-        perror("listen");
+        error_setg_errno(errp, errno, "can't listen on socket");
         closesocket(fd);
         return -1;
     }
@@ -538,21 +538,20 @@ static int net_socket_listen_init(NetClientState *peer,
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
+        error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
     qemu_set_nonblock(fd);
@@ -568,7 +567,7 @@ static int net_socket_connect_init(NetClientState *peer,
                        errno == EINVAL) {
                 break;
             } else {
-                perror("connect");
+                error_setg_errno(errp, errno, "can't connect socket");
                 closesocket(fd);
                 return -1;
             }
@@ -577,9 +576,8 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, &err);
+    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
 
@@ -593,36 +591,36 @@ static int net_socket_mcast_init(NetClientState *peer,
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
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, &err);
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
 
@@ -639,45 +637,45 @@ static int net_socket_udp_init(NetClientState *peer,
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
+        error_setg_errno(errp, errno, "can't create datagram socket");
         return -1;
     }
 
     ret = socket_set_fast_reuse(fd);
     if (ret < 0) {
+        error_setg_errno(errp, errno,
+                         "can't set socket option SO_REUSEADDR");
         closesocket(fd);
         return -1;
     }
     ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
+                         inet_ntoa(laddr.sin_addr));
         closesocket(fd);
         return -1;
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, &err);
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
-        error_report_err(err);
         return -1;
     }
 
@@ -692,8 +690,6 @@ static int net_socket_udp_init(NetClientState *peer,
 int net_init_socket(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
-    Error *err = NULL;
     const NetdevSocketOptions *sock;
 
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
@@ -701,22 +697,21 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     if (sock->has_listen + sock->has_connect + sock->has_mcast +
         sock->has_udp > 1) {
-        error_report("exactly one of listen=, connect=, mcast= or udp="
-                     " is required");
+        error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
+                   " is required");
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
@@ -728,15 +723,16 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->has_listen) {
-        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
+        if (net_socket_listen_init(peer, "socket", name, sock->listen, errp)
+            < 0) {
             return -1;
         }
         return 0;
     }
 
     if (sock->has_connect) {
-        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
-            -1) {
+        if (net_socket_connect_init(peer, "socket", name, sock->connect, errp)
+            < 0) {
             return -1;
         }
         return 0;
@@ -746,7 +742,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
         /* if sock->localaddr is missing, it has been initialized to "all bits
          * zero" */
         if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
-            sock->localaddr) == -1) {
+                                  sock->localaddr, errp) < 0) {
             return -1;
         }
         return 0;
@@ -754,11 +750,11 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     assert(sock->has_udp);
     if (!sock->has_localaddr) {
-        error_report("localaddr= is mandatory with udp=");
+        error_setg(errp, "localaddr= is mandatory with udp=");
         return -1;
     }
-    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
-        -1) {
+    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
+                            errp) < 0) {
         return -1;
     }
     return 0;
-- 
2.7.4
