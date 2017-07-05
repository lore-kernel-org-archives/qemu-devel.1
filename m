Received: from eggs.gnu.org ([2001:4830:134:3::10]:40258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4l-0003Z1-FW
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4j-0000Fb-Rf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:31 -0400
Received: from [59.151.112.132] (port=56355 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4j-0000EX-Eo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:29 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 5 Jul 2017 19:01:56 +0800
Message-ID: <d6cba505174f8cd7208faac323184528de37e1f3.1499250206.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1499250206.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1499250206.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 3/4] net/net: Convert parse_host_port() to
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
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com, eblake@redhat.com

Cc: berrange@redhat.com
Cc: kraxel@redhat.com
Cc: pbonzini@redhat.com
Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: eblake@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/sockets.h |  3 ++-
 net/net.c              | 22 +++++++++++++++++-----
 net/socket.c           | 19 ++++++++++++++-----
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5c326db..78e2b30 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -53,7 +53,8 @@ void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
-int parse_host_port(struct sockaddr_in *saddr, const char *str);
+int parse_host_port(struct sockaddr_in *saddr, const char *str,
+                    Error **errp);
 int socket_init(void);
 
 /**
diff --git a/net/net.c b/net/net.c
index 6235aab..77b6deb 100644
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
index 3dd4459..1d4c515 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -497,9 +497,12 @@ static int net_socket_listen_init(NetClientState *peer,
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
@@ -544,8 +547,10 @@ static int net_socket_connect_init(NetClientState *peer,
     struct sockaddr_in saddr;
     Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &err) < 0) {
+        error_report_err(err);
         return -1;
+    }
 
     fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -597,8 +602,10 @@ static int net_socket_mcast_init(NetClientState *peer,
     struct in_addr localaddr, *param_localaddr;
     Error *err = NULL;
 
-    if (parse_host_port(&saddr, host_str) < 0)
+    if (parse_host_port(&saddr, host_str, &err) < 0) {
+        error_report_err(err);
         return -1;
+    }
 
     if (localaddr_str != NULL) {
         if (inet_aton(localaddr_str, &localaddr) == 0)
@@ -640,11 +647,13 @@ static int net_socket_udp_init(NetClientState *peer,
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
2.9.4
