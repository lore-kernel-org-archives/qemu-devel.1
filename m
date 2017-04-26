Received: from eggs.gnu.org ([2001:4830:134:3::10]:45440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxH-0006du-Ur
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxD-0002xJ-CE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:43 -0400
Received: from [59.151.112.132] (port=36150 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxC-0002wU-DV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:39 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Apr 2017 16:04:17 +0800
Message-ID: <2bc05de0edd61cdcdd3d2b894378a874d1e12327.1493191677.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/4] net/socket: Convert error report
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
Cc: jasowang@redhat.com, armbru@redhat.com

Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
net_socket_fd_init() use the function such as fprintf(), perror() to
report an error message.

Now, convert these functions to Error.

CC: jasowang@redhat.com, armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 66 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b0decbe..559e09a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -210,7 +210,9 @@ static void net_socket_send_dgram(void *opaque)
     }
 }
 
-static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr *localaddr)
+static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
+                                   struct in_addr *localaddr,
+                                   Error **errp)
 {
     struct ip_mreq imr;
     int fd;
@@ -222,8 +224,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
 #endif
 
     if (!IN_MULTICAST(ntohl(mcastaddr->sin_addr.s_addr))) {
-        fprintf(stderr, "qemu: error: specified mcastaddr \"%s\" (0x%08x) "
-                "does not contain a multicast address\n",
+        error_setg(errp, "qemu: error: specified mcastaddr %s (0x%08x) "
+                "does not contain a multicast address",
                 inet_ntoa(mcastaddr->sin_addr),
                 (int)ntohl(mcastaddr->sin_addr.s_addr));
         return -1;
@@ -231,7 +233,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     }
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "socket(PF_INET, SOCK_DGRAM)");
         return -1;
     }
 
@@ -243,13 +245,13 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     val = 1;
     ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
     if (ret < 0) {
-        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
+        error_setg_errno(errp, errno, "setsockopt(SOL_SOCKET, SO_REUSEADDR)");
         goto fail;
     }
 
     ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "bind");
         goto fail;
     }
 
@@ -264,7 +266,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                           &imr, sizeof(struct ip_mreq));
     if (ret < 0) {
-        perror("setsockopt(IP_ADD_MEMBERSHIP)");
+        error_setg_errno(errp, errno, "setsockopt(IP_ADD_MEMBERSHIP)");
         goto fail;
     }
 
@@ -273,7 +275,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
                           &loop, sizeof(loop));
     if (ret < 0) {
-        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
+        error_setg_errno(errp, errno, "setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
         goto fail;
     }
 
@@ -282,7 +284,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
         ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
                               localaddr, sizeof(*localaddr));
         if (ret < 0) {
-            perror("setsockopt(IP_MULTICAST_IF)");
+            error_setg_errno(errp, errno, "setsockopt(IP_MULTICAST_IF)");
             goto fail;
         }
     }
@@ -321,13 +323,15 @@ static NetClientInfo net_dgram_socket_info = {
 static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
-                                                int fd, int is_connected)
+                                                int fd, int is_connected,
+                                                Error **errp)
 {
     struct sockaddr_in saddr;
     int newfd;
     socklen_t saddr_len = sizeof(saddr);
     NetClientState *nc;
     NetSocketState *s;
+    Error *local_error = NULL;
 
     /* fd passed: multicast: "learn" dgram_dst address from bound address and save it
      * Because this may be "shared" socket from a "master" process, datagrams would be recv()
@@ -338,14 +342,14 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
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
+            newfd = net_socket_mcast_create(&saddr, NULL, &local_error);
             if (newfd < 0) {
-                /* error already reported by net_socket_mcast_create() */
+                error_propagate(errp, local_error);
                 goto err;
             }
             /* clone newfd to fd, close newfd */
@@ -433,25 +437,27 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
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
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected, errp);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
         /* who knows ... this could be a eg. a pty, do warn and continue as stream */
-        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
+        error_setg(errp, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM"
+                   " or SOCK_STREAM", so_type, fd);
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     }
     return NULL;
@@ -546,6 +552,7 @@ static void net_socket_connected(QIOTask *task, void *opaque)
     socket_connect_data *c = opaque;
     NetSocketState *s;
     char *addr_str = NULL;
+    Error *local_error = NULL;
 
     addr_str = socket_address_to_string(c->saddr);
     if (addr_str == NULL) {
@@ -553,9 +560,10 @@ static void net_socket_connected(QIOTask *task, void *opaque)
         goto end;
     }
 
-    s = net_socket_fd_init(c->peer, c->model, c->name, sioc->fd, true);
+    s = net_socket_fd_init(c->peer, c->model, c->name, sioc->fd, true, &local_error);
     if (!s) {
         closesocket(sioc->fd);
+        error_report_err(local_error);
         goto end;
     }
 
@@ -610,6 +618,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
+    Error *local_error = NULL;
 
     if (parse_host_port(&saddr, host_str) < 0)
         return -1;
@@ -625,13 +634,17 @@ static int net_socket_mcast_init(NetClientState *peer,
         param_localaddr = NULL;
     }
 
-    fd = net_socket_mcast_create(&saddr, param_localaddr);
-    if (fd < 0)
+    fd = net_socket_mcast_create(&saddr, param_localaddr, &local_error);
+    if (fd < 0) {
+        error_propagate(errp, local_error);
         return -1;
+    }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
-    if (!s)
+    s = net_socket_fd_init(peer, model, name, fd, 0, &local_error);
+    if (!s) {
+        error_propagate(errp, local_error);
         return -1;
+    }
 
     s->dgram_dst = saddr;
 
@@ -652,6 +665,7 @@ static int net_socket_udp_init(NetClientState *peer,
     NetSocketState *s;
     int fd, ret;
     struct sockaddr_in laddr, raddr;
+    Error *local_error = NULL;
 
     if (parse_host_port(&laddr, lhost) < 0) {
         return -1;
@@ -680,8 +694,9 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, &local_error);
     if (!s) {
+        error_propagate(errp, local_error);
         return -1;
     }
 
@@ -723,7 +738,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, 1, &err)) {
+            error_propagate(errp, err);
             return -1;
         }
         return 0;
-- 
2.9.3
