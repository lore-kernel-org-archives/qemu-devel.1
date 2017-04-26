Received: from eggs.gnu.org ([2001:4830:134:3::10]:45409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxF-0006ca-CH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxE-0002y0-Ck
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:41 -0400
Received: from [59.151.112.132] (port=34146 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxD-0002ww-GY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:40 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Apr 2017 16:04:18 +0800
Message-ID: <56de19530e46799cd529e0c5805a40076581c68f.1493191677.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/4] net/net: Convert parse_host_port() to
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

CC: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 include/qemu/sockets.h |  2 +-
 net/net.c              | 21 ++++++++++++++++-----
 net/socket.c           | 10 +++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 528b802..adb8d4f 100644
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
index 0ac3b9e..5054035 100644
--- a/net/net.c
+++ b/net/net.c
@@ -99,7 +99,7 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     return 0;
 }
 
-int parse_host_port(struct sockaddr_in *saddr, const char *str)
+int parse_host_port(struct sockaddr_in *saddr, const char *str, Error **errp)
 {
     char buf[512];
     struct hostent *he;
@@ -107,24 +107,35 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str)
     int port;
 
     p = str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0)
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        error_setg(errp, "The mcast address should contain ':', for example: "
+                   "mcast=230.0.0.1:1234");
         return -1;
+    }
     saddr->sin_family = AF_INET;
     if (buf[0] == '\0') {
         saddr->sin_addr.s_addr = 0;
     } else {
         if (qemu_isdigit(buf[0])) {
-            if (!inet_aton(buf, &saddr->sin_addr))
+            if (!inet_aton(buf, &saddr->sin_addr)) {
+                error_setg(errp, "Convert the mcast address to network "
+                           "byte order failed.");
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
index 559e09a..4373d9d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -620,8 +620,10 @@ static int net_socket_mcast_init(NetClientState *peer,
     struct in_addr localaddr, *param_localaddr;
     Error *local_error = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &local_error) < 0) {
+        error_propagate(errp, local_error);
         return -1;
+    }
 
     if (localaddr_str != NULL) {
         if (inet_aton(localaddr_str, &localaddr) == 0) {
@@ -667,11 +669,13 @@ static int net_socket_udp_init(NetClientState *peer,
     struct sockaddr_in laddr, raddr;
     Error *local_error = NULL;
 
-    if (parse_host_port(&laddr, lhost) < 0) {
+    if (parse_host_port(&laddr, lhost, &local_error) < 0) {
+        error_propagate(errp, local_error);
         return -1;
     }
 
-    if (parse_host_port(&raddr, rhost) < 0) {
+    if (parse_host_port(&raddr, rhost, &local_error) < 0) {
+        error_propagate(errp, local_error);
         return -1;
     }
 
-- 
2.9.3
