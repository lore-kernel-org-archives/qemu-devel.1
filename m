Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlT-0007Ke-6w
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlR-0002aY-Rd
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:35 -0400
Received: from [59.151.112.132] (port=57873 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlR-0002K7-73
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:33 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 18:01:47 +0800
Message-ID: <7819d8ffa4c7ad794ae20b8ea3c77826d2306984.1496924675.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/4] net/socket: Convert error report
 message to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com

Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
net_socket_fd_init() use the function such as fprintf(), perror() to
report an error message.

Now, convert these functions to Error.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 62 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index d711f51..4a63eb8 100644
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
+        error_setg(errp, "qemu: error: specified mcastaddr %s (0x%08x) "
+                "does not contain a multicast address",
                 inet_ntoa(mcastaddr->sin_addr),
                 (int)ntohl(mcastaddr->sin_addr.s_addr));
         return -1;
@@ -230,7 +232,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     }
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "Create socket(PF_INET, SOCK_DGRAM)"
+                         " failed");
         return -1;
     }
 
@@ -242,13 +245,15 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     val = 1;
     ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
     if (ret < 0) {
-        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
+        error_setg_errno(errp, errno, "Set the socket fd=%d attribute"
+                         " SO_REUSEADDR failed", fd);
         goto fail;
     }
 
     ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "Bind ip=%s to fd=%d failed",
+                         inet_ntoa(mcastaddr->sin_addr), fd);
         goto fail;
     }
 
@@ -263,7 +268,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                           &imr, sizeof(struct ip_mreq));
     if (ret < 0) {
-        perror("setsockopt(IP_ADD_MEMBERSHIP)");
+        error_setg_errno(errp, errno, "Add socket fd=%d to multicast group %s"
+                " failed", fd, inet_ntoa(imr.imr_multiaddr));
         goto fail;
     }
 
@@ -272,7 +278,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
                           &loop, sizeof(loop));
     if (ret < 0) {
-        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
+        error_setg_errno(errp, errno, "Force multicast message to loopback"
+                         " failed");
         goto fail;
     }
 
@@ -281,7 +288,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
         ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
                               localaddr, sizeof(*localaddr));
         if (ret < 0) {
-            perror("setsockopt(IP_MULTICAST_IF)");
+            error_setg_errno(errp, errno, "Set the default network send "
+                             "interfaec failed");
             goto fail;
         }
     }
@@ -320,7 +328,8 @@ static NetClientInfo net_dgram_socket_info = {
 static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
-                                                int fd, int is_connected)
+                                                int fd, int is_connected,
+                                                Error **errp)
 {
     struct sockaddr_in saddr;
     int newfd;
@@ -337,14 +346,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
         if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
             /* must be bound */
             if (saddr.sin_addr.s_addr == 0) {
-                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
-                        "cannot setup multicast dst addr\n", fd);
+                error_setg(errp, "qemu: error: init_dgram: fd=%d unbound, "
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
@@ -352,8 +360,8 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
             close(newfd);
 
         } else {
-            fprintf(stderr,
-                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
+            error_setg(errp,
+                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s",
                     fd, strerror(errno));
             goto err;
         }
@@ -432,25 +440,27 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
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
+        error_setg(errp, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed",
                 fd);
         closesocket(fd);
         return NULL;
     }
     switch(so_type) {
     case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
+            errp);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        fprintf(stderr, "qemu: error: socket type=%d for fd=%d is not"
-                " SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
+        error_setg(errp, "qemu: error: socket type=%d for fd=%d is not"
+                " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
         closesocket(fd);
     }
     return NULL;
@@ -571,7 +581,7 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected);
+    s = net_socket_fd_init(peer, model, name, fd, connected, errp);
     if (!s)
         return -1;
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
@@ -603,11 +613,11 @@ static int net_socket_mcast_init(NetClientState *peer,
         param_localaddr = NULL;
     }
 
-    fd = net_socket_mcast_create(&saddr, param_localaddr);
+    fd = net_socket_mcast_create(&saddr, param_localaddr, errp);
     if (fd < 0)
         return -1;
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
     if (!s)
         return -1;
 
@@ -658,7 +668,7 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
     if (!s) {
         return -1;
     }
@@ -702,7 +712,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, 1, errp)) {
             return -1;
         }
         return 0;
-- 
2.9.3
