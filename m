Received: from eggs.gnu.org ([2001:4830:134:3::10]:60882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gQ-0003Mp-WF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gL-0002JI-ME
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gL-0002Io-CQ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:09 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:15 +0800
Message-Id: <1504836324-4871-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 09/18] net/socket: Convert several helper
 functions to Error
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

Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
net_socket_fd_init() use the function such as fprintf(), perror() to
report an error message.

Now, convert these functions to Error.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 82 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b4c5a04..00f9796 100644
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
@@ -221,16 +223,16 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
 #endif
 
     if (!IN_MULTICAST(ntohl(mcastaddr->sin_addr.s_addr))) {
-        fprintf(stderr, "qemu: error: specified mcastaddr \"%s\" (0x%08x) "
-                "does not contain a multicast address\n",
-                inet_ntoa(mcastaddr->sin_addr),
-                (int)ntohl(mcastaddr->sin_addr.s_addr));
+        error_setg(errp, "specified mcastaddr %s (0x%08x) "
+                   "does not contain a multicast address",
+                   inet_ntoa(mcastaddr->sin_addr),
+                   (int)ntohl(mcastaddr->sin_addr.s_addr));
         return -1;
-
     }
+
     fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
     if (fd < 0) {
-        perror("socket(PF_INET, SOCK_DGRAM)");
+        error_setg_errno(errp, errno, "can't create datagram socket");
         return -1;
     }
 
@@ -242,13 +244,15 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     val = 1;
     ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
     if (ret < 0) {
-        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
+        error_setg_errno(errp, errno,
+                         "can't set socket option SO_REUSEADDR");
         goto fail;
     }
 
     ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
     if (ret < 0) {
-        perror("bind");
+        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
+                         inet_ntoa(mcastaddr->sin_addr));
         goto fail;
     }
 
@@ -263,7 +267,9 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                           &imr, sizeof(struct ip_mreq));
     if (ret < 0) {
-        perror("setsockopt(IP_ADD_MEMBERSHIP)");
+        error_setg_errno(errp, errno,
+                         "can't add socket to multicast group %s",
+                         inet_ntoa(imr.imr_multiaddr));
         goto fail;
     }
 
@@ -272,7 +278,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
                           &loop, sizeof(loop));
     if (ret < 0) {
-        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
+        error_setg_errno(errp, errno,
+                         "can't force multicast message to loopback");
         goto fail;
     }
 
@@ -281,7 +288,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
         ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
                               localaddr, sizeof(*localaddr));
         if (ret < 0) {
-            perror("setsockopt(IP_MULTICAST_IF)");
+            error_setg_errno(errp, errno,
+                             "can't set the default network send interface");
             goto fail;
         }
     }
@@ -321,7 +329,8 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
                                                 int fd, int is_connected,
-                                                const char *mcast)
+                                                const char *mcast,
+                                                Error **errp)
 {
     struct sockaddr_in saddr;
     int newfd;
@@ -335,21 +344,17 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
 
     if (is_connected && mcast != NULL) {
             if (parse_host_port(&saddr, mcast) < 0) {
-                fprintf(stderr,
-                        "qemu: error: init_dgram: fd=%d failed parse_host_port()\n",
-                        fd);
+                error_setg(errp, "fd=%d failed parse_host_port()", fd);
                 goto err;
             }
             /* must be bound */
             if (saddr.sin_addr.s_addr == 0) {
-                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
-                        "cannot setup multicast dst addr\n", fd);
+                error_setg(errp, "can't setup multicast destination address");
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
@@ -431,20 +436,21 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
 static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
-                                          int fd, int is_connected, const char *mc)
+                                          int fd, int is_connected,
+                                          const char *mc, Error **errp)
 {
     int so_type = -1, optlen=sizeof(so_type);
 
     if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
         (socklen_t *)&optlen)< 0) {
-        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed\n",
-                fd);
+        error_setg(errp, "can't get socket option SO_TYPE");
         closesocket(fd);
         return NULL;
     }
     switch(so_type) {
     case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected, mc);
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
+                                        mc, errp);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
@@ -535,6 +541,7 @@ static int net_socket_connect_init(NetClientState *peer,
     NetSocketState *s;
     int fd, connected, ret;
     struct sockaddr_in saddr;
+    Error *err = NULL;
 
     if (parse_host_port(&saddr, host_str) < 0)
         return -1;
@@ -566,9 +573,12 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, NULL);
-    if (!s)
+    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, &err);
+    if (!s) {
+        error_report_err(err);
         return -1;
+    }
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: connect to %s:%d",
              inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
@@ -585,6 +595,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
+    Error *err = NULL;
 
     if (parse_host_port(&saddr, host_str) < 0)
         return -1;
@@ -597,13 +608,17 @@ static int net_socket_mcast_init(NetClientState *peer,
         param_localaddr = NULL;
     }
 
-    fd = net_socket_mcast_create(&saddr, param_localaddr);
-    if (fd < 0)
+    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
+    if (fd < 0) {
+        error_report_err(err);
         return -1;
+    }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL);
-    if (!s)
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, &err);
+    if (!s) {
+        error_report_err(err);
         return -1;
+    }
 
     s->dgram_dst = saddr;
 
@@ -623,6 +638,7 @@ static int net_socket_udp_init(NetClientState *peer,
     NetSocketState *s;
     int fd, ret;
     struct sockaddr_in laddr, raddr;
+    Error *err = NULL;
 
     if (parse_host_port(&laddr, lhost) < 0) {
         return -1;
@@ -651,8 +667,9 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL);
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, &err);
     if (!s) {
+        error_report_err(err);
         return -1;
     }
 
@@ -695,7 +712,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
+                                errp)) {
             return -1;
         }
         return 0;
-- 
2.7.4
