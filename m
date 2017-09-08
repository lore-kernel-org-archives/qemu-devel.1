Received: from eggs.gnu.org ([2001:4830:134:3::10]:60951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gZ-0003Um-Cs
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gU-0002Nr-7w
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gT-0002NR-Vo
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:18 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:16 +0800
Message-Id: <1504836324-4871-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] net/net: Convert parse_host_port() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com, eblake@redhat.com

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: berrange@redhat.com
Cc: kraxel@redhat.com
Cc: pbonzini@redhat.com
Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: eblake@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/qemu/sockets.h |  3 ++-
 net/net.c              | 22 +++++++++++++++++-----
 net/socket.c           | 22 +++++++++++++++-------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 639cc07..4f7311b 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -45,7 +45,8 @@ void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
-int parse_host_port(struct sockaddr_in *saddr, const char *str);
+int parse_host_port(struct sockaddr_in *saddr, const char *str,
+                    Error **errp);
 int socket_init(void);
 
 /**
diff --git a/net/net.c b/net/net.c
index 2fa99c0..bebb042 100644
--- a/net/net.c
+++ b/net/net.c
@@ -100,7 +100,8 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     return 0;
 }
 
-int parse_host_port(struct sockaddr_in *saddr, const char *str)
+int parse_host_port(struct sockaddr_in *saddr, const char *str,
+                    Error **errp)
 {
     char buf[512];
     struct hostent *he;
@@ -108,24 +109,35 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str)
     int port;
 
     p = str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0)
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        error_setg(errp, "host address '%s' doesn't contain ':' "
+                   "separating host from port", str);
         return -1;
+    }
     saddr->sin_family = AF_INET;
     if (buf[0] == '\0') {
         saddr->sin_addr.s_addr = 0;
     } else {
         if (qemu_isdigit(buf[0])) {
-            if (!inet_aton(buf, &saddr->sin_addr))
+            if (!inet_aton(buf, &saddr->sin_addr)) {
+                error_setg(errp, "host address '%s' is not a valid "
+                           "IPv4 address", buf);
                 return -1;
+            }
         } else {
-            if ((he = gethostbyname(buf)) == NULL)
+            he = gethostbyname(buf);
+            if (he == NULL) {
+                error_setg(errp, "can't resolve host address '%s'", buf);
                 return - 1;
+            }
             saddr->sin_addr = *(struct in_addr *)he->h_addr;
         }
     }
     port = strtol(p, (char **)&r, 0);
-    if (r == p)
+    if (r == p) {
+        error_setg(errp, "port number '%s' is invalid", p);
         return -1;
+    }
     saddr->sin_port = htons(port);
     return 0;
 }
diff --git a/net/socket.c b/net/socket.c
index 00f9796..12495d1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -343,8 +343,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
      */
 
     if (is_connected && mcast != NULL) {
-            if (parse_host_port(&saddr, mcast) < 0) {
-                error_setg(errp, "fd=%d failed parse_host_port()", fd);
+            if (parse_host_port(&saddr, mcast, errp) < 0) {
                 goto err;
             }
             /* must be bound */
@@ -496,9 +495,12 @@ static int net_socket_listen_init(NetClientState *peer,
     NetSocketState *s;
     struct sockaddr_in saddr;
     int fd, ret;
+    Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &err) < 0) {
+        error_report_err(err);
         return -1;
+    }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -543,8 +545,10 @@ static int net_socket_connect_init(NetClientState *peer,
     struct sockaddr_in saddr;
     Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &err) < 0) {
+        error_report_err(err);
         return -1;
+    }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -597,8 +601,10 @@ static int net_socket_mcast_init(NetClientState *peer,
     struct in_addr localaddr, *param_localaddr;
     Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &err) < 0) {
+        error_report_err(err);
         return -1;
+    }
 
     if (localaddr_str != NULL) {
         if (inet_aton(localaddr_str, &localaddr) == 0)
@@ -640,11 +646,13 @@ static int net_socket_udp_init(NetClientState *peer,
     struct sockaddr_in laddr, raddr;
     Error *err = NULL;
 
-    if (parse_host_port(&laddr, lhost) < 0) {
+    if (parse_host_port(&laddr, lhost, &err) < 0) {
+        error_report_err(err);
         return -1;
     }
 
-    if (parse_host_port(&raddr, rhost) < 0) {
+    if (parse_host_port(&raddr, rhost, &err) < 0) {
+        error_report_err(err);
         return -1;
     }
 
-- 
2.7.4
