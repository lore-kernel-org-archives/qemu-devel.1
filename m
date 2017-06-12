Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ94-0007uu-89
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ92-0001mr-VW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:42 -0400
Received: from [59.151.112.132] (port=41787 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ92-0001le-1m
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:40 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 22:15:03 +0800
Message-ID: <debfee582acd0e32a08a812c710abbdeb11e90d1.1497276062.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/4] net/net: Convert parse_host_port() to
 Error
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

Cc: berrange@redhat.com
Cc: kraxel@redhat.com
Cc: pbonzini@redhat.com
Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 include/qemu/sockets.h |  2 +-
 net/net.c              | 21 ++++++++++++++++-----
 net/socket.c           | 37 ++++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5c326db..7abffc4 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -53,7 +53,7 @@ void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
-int parse_host_port(struct sockaddr_in *saddr, const char *str);
+int parse_host_port(struct sockaddr_in *saddr, const char *str, Error **errp);
 int socket_init(void);
 
 /**
diff --git a/net/net.c b/net/net.c
index 6235aab..e55869a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -100,7 +100,7 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     return 0;
 }
 
-int parse_host_port(struct sockaddr_in *saddr, const char *str)
+int parse_host_port(struct sockaddr_in *saddr, const char *str, Error **errp)
 {
     char buf[512];
     struct hostent *he;
@@ -108,24 +108,35 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str)
     int port;
 
     p = str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0)
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        error_setg(errp, "The address should contain ':', for example: "
+                   "xxxx=230.0.0.1:1234");
         return -1;
+    }
     saddr->sin_family = AF_INET;
     if (buf[0] == '\0') {
         saddr->sin_addr.s_addr = 0;
     } else {
         if (qemu_isdigit(buf[0])) {
-            if (!inet_aton(buf, &saddr->sin_addr))
+            if (!inet_aton(buf, &saddr->sin_addr)) {
+                error_setg(errp, "Host address '%s' is not a valid "
+                           "IPv4 address", buf);
                 return -1;
+            }
         } else {
-            if ((he = gethostbyname(buf)) == NULL)
+            he = gethostbyname(buf);
+            if (he == NULL) {
+                error_setg(errp, "Specified hostname is error.");
                 return - 1;
+            }
             saddr->sin_addr = *(struct in_addr *)he->h_addr;
         }
     }
     port = strtol(p, (char **)&r, 0);
-    if (r == p)
+    if (r == p) {
+        error_setg(errp, "The port number is illegal");
         return -1;
+    }
     saddr->sin_port = htons(port);
     return 0;
 }
diff --git a/net/socket.c b/net/socket.c
index 53765bd..66016c8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -485,15 +485,17 @@ static void net_socket_accept(void *opaque)
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
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
+    }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -531,14 +533,16 @@ static int net_socket_listen_init(NetClientState *peer,
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
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
+    }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -580,14 +584,15 @@ static int net_socket_mcast_init(NetClientState *peer,
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
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, errp) < 0)
         return -1;
 
     if (localaddr_str != NULL) {
@@ -619,17 +624,18 @@ static int net_socket_udp_init(NetClientState *peer,
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
 
-    if (parse_host_port(&laddr, lhost) < 0) {
+    if (parse_host_port(&laddr, lhost, errp) < 0) {
         return -1;
     }
 
-    if (parse_host_port(&raddr, rhost) < 0) {
+    if (parse_host_port(&raddr, rhost, errp) < 0) {
         return -1;
     }
 
@@ -703,15 +709,16 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->has_listen) {
-        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
+        if (net_socket_listen_init(peer, "socket", name, sock->listen,
+            errp) == -1) {
             return -1;
         }
         return 0;
     }
 
     if (sock->has_connect) {
-        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
-            -1) {
+        if (net_socket_connect_init(peer, "socket", name, sock->connect,
+            errp) == -1) {
             return -1;
         }
         return 0;
@@ -721,7 +728,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
         /* if sock->localaddr is missing, it has been initialized to "all bits
          * zero" */
         if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
-            sock->localaddr) == -1) {
+            sock->localaddr, errp) == -1) {
             return -1;
         }
         return 0;
@@ -732,8 +739,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
         error_report("localaddr= is mandatory with udp=");
         return -1;
     }
-    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
-        -1) {
+    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
+        errp) == -1) {
         return -1;
     }
     return 0;
-- 
2.9.3
