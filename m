Received: from eggs.gnu.org ([2001:4830:134:3::10]:52960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiY-00046p-Mg
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiX-0005di-4P
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:14 -0400
Received: from [59.151.112.132] (port=30009 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiW-0005aI-DP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:13 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 28 Jun 2017 21:08:48 +0800
Message-ID: <4e5b562c22cfcfe7732857d6470fa56ecdd23146.1498654240.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 2/4] net/socket: Convert several helper
 functions to Error
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

Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
net_socket_fd_init() use the function such as fprintf(), perror() to
report an error message.

Now, convert these functions to Error.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 75 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 53765bd..b6bacf4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -209,7 +209,9 @@ static void net_socket_send_dgram(void *opaque)
     }
 }
 
-static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr *localaddr)
+static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
+                                   struct in_addr *localaddr,
+                                   Error **errp)
 {
     struct ip_mreq imr;
     int fd;
@@ -221,8 +223,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
 #endif
 
     if (!IN_MULTICAST(ntohl(mcastaddr->sin_addr.s_addr))) {
-        fprintf(stderr, "qemu: error: specified mcastaddr \"%s\" (0x%08x) "
-                "does not contain a multicast address\n",
+        error_setg(errp, "specified mcastaddr %s (0x%08x) "
+                "does not contain a multicast address",
                 inet_ntoa(mcastaddr->sin_addr),
                 (int)ntohl(mcastaddr->sin_addr.s_addr));
         return -1;
@@ -230,7 +232,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     }
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "failed to create datagram socket");
         return -1;
     }
 
@@ -242,13 +244,15 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     val = 1;
     ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
     if (ret < 0) {
-        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
+        error_setg_errno(errp, errno, "set the socket 'SO_REUSEADDR'"
+                         " attribute failed");
         goto fail;
     }
 
     ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "bind ip=%s to socket failed",
+                         inet_ntoa(mcastaddr->sin_addr));
         goto fail;
     }
 
@@ -263,7 +267,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                           &imr, sizeof(struct ip_mreq));
     if (ret < 0) {
-        perror("setsockopt(IP_ADD_MEMBERSHIP)");
+        error_setg_errno(errp, errno, "add socket to multicast group %s"
+                         " failed", inet_ntoa(imr.imr_multiaddr));
         goto fail;
     }
 
@@ -272,7 +277,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
                           &loop, sizeof(loop));
     if (ret < 0) {
-        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
+        error_setg_errno(errp, errno, "force multicast message to loopback"
+                         " failed");
         goto fail;
     }
 
@@ -281,7 +287,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
         ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
                               localaddr, sizeof(*localaddr));
         if (ret < 0) {
-            perror("setsockopt(IP_MULTICAST_IF)");
+            error_setg_errno(errp, errno, "set the default network send "
+                             "interface failed");
             goto fail;
         }
     }
@@ -320,7 +327,8 @@ static NetClientInfo net_dgram_socket_info = {
 static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
-                                                int fd, int is_connected)
+                                                int fd, int is_connected,
+                                                Error **errp)
 {
     struct sockaddr_in saddr;
     int newfd;
@@ -337,14 +345,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
         if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
             /* must be bound */
             if (saddr.sin_addr.s_addr == 0) {
-                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
-                        "cannot setup multicast dst addr\n", fd);
+                error_setg(errp, "init_dgram: fd=%d unbound, "
+                        "cannot setup multicast dst addr", fd);
                 goto err;
             }
             /* clone dgram socket */
-            newfd = net_socket_mcast_create(&saddr, NULL);
+            newfd = net_socket_mcast_create(&saddr, NULL, errp);
             if (newfd < 0) {
-                /* error already reported by net_socket_mcast_create() */
                 goto err;
             }
             /* clone newfd to fd, close newfd */
@@ -352,8 +359,8 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
             close(newfd);
 
         } else {
-            fprintf(stderr,
-                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
+            error_setg(errp,
+                    "init_dgram: fd=%d failed getsockname(): %s",
                     fd, strerror(errno));
             goto err;
         }
@@ -432,24 +439,26 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
 static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
-                                          int fd, int is_connected)
+                                          int fd, int is_connected,
+                                          Error **errp)
 {
     int so_type = -1, optlen=sizeof(so_type);
 
     if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
         (socklen_t *)&optlen)< 0) {
-        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed\n",
+        error_setg(errp, "getsockopt(SO_TYPE) for fd=%d failed",
                 fd);
         closesocket(fd);
         return NULL;
     }
     switch(so_type) {
     case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
+                                        errp);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        error_report("qemu: error: socket type=%d for fd=%d is not"
+        error_setg(errp, "socket type=%d for fd=%d is not"
                 " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
         closesocket(fd);
     }
@@ -536,6 +545,7 @@ static int net_socket_connect_init(NetClientState *peer,
     NetSocketState *s;
     int fd, connected, ret;
     struct sockaddr_in saddr;
+    Error *err = NULL;
 
     if (parse_host_port(&saddr, host_str) < 0)
         return -1;
@@ -567,9 +577,11 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected);
-    if (!s)
+    s = net_socket_fd_init(peer, model, name, fd, connected, &err);
+    if (!s) {
+        error_report_err(err);
         return -1;
+    }
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: connect to %s:%d",
              inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
@@ -586,6 +598,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
+    Error *err = NULL;
 
     if (parse_host_port(&saddr, host_str) < 0)
         return -1;
@@ -598,13 +611,17 @@ static int net_socket_mcast_init(NetClientState *peer,
         param_localaddr = NULL;
     }
 
-    fd = net_socket_mcast_create(&saddr, param_localaddr);
-    if (fd < 0)
+    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
+    if (fd < 0) {
+        error_report_err(err);
         return -1;
+    }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
-    if (!s)
+    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
+    if (!s) {
+        error_report_err(err);
         return -1;
+    }
 
     s->dgram_dst = saddr;
 
@@ -624,6 +641,7 @@ static int net_socket_udp_init(NetClientState *peer,
     NetSocketState *s;
     int fd, ret;
     struct sockaddr_in laddr, raddr;
+    Error *err = NULL;
 
     if (parse_host_port(&laddr, lhost) < 0) {
         return -1;
@@ -652,8 +670,9 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
     if (!s) {
+        error_report_err(err);
         return -1;
     }
 
@@ -696,7 +715,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, 1, errp)) {
             return -1;
         }
         return 0;
-- 
2.9.4
