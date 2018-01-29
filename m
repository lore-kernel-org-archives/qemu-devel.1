Received: from eggs.gnu.org ([2001:4830:134:3::10]:46428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt7-000623-N9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt6-0000B6-Ky
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:41 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1egEt6-0000Ap-F4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:40 -0500
Received: by mail-pf0-x244.google.com with SMTP id 17so4786063pfw.11
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:14:40 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 30 Jan 2018 03:13:44 +0800
Message-Id: <1517253224-14361-5-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 4/4] net/socket: change net_socket_connect_init
 to use functions in sockets.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, Jason Wang <jasowang@redhat.com>

net_socket_connect_init still uses parse_host_port() and connect()
directly. Convert it into functions in include/qemu/sockets.h

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 net/socket.c | 52 +++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 7b07223..312b638 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -543,48 +543,42 @@ static int net_socket_connect_init(NetClientState *peer,
                                    Error **errp)
 {
     NetSocketState *s;
-    int fd, connected, ret;
-    struct sockaddr_in saddr;
+    int fd, connected;
+    SocketAddress *saddr;
+    QemuSocketConfig *sconf;
+    Error *local_err = NULL;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    saddr = socket_parse(host_str, &local_err);
+    if(NULL != local_err) {
+        error_setg_errno(errp, errno, "socket_parse failed");
         return -1;
     }
 
-    fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
-    if (fd < 0) {
-        error_setg_errno(errp, errno, "can't create stream socket");
-        return -1;
-    }
-    qemu_set_nonblock(fd);
+    sconf = g_new0(QemuSocketConfig, 1);
+    sconf->nonblocking = true;
+    sconf->options = NULL;
 
     connected = 0;
-    for(;;) {
-        ret = connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
-        if (ret < 0) {
-            if (errno == EINTR || errno == EWOULDBLOCK) {
-                /* continue */
-            } else if (errno == EINPROGRESS ||
-                       errno == EALREADY ||
-                       errno == EINVAL) {
-                break;
-            } else {
-                error_setg_errno(errp, errno, "can't connect socket");
-                closesocket(fd);
-                return -1;
-            }
-        } else {
-            connected = 1;
-            break;
-        }
+    fd = socket_connect(saddr, errp, sconf);
+    if(fd < 0) {
+        error_setg_errno(errp, errno, "socket_connect failed");
+        g_free(sconf);
+        qapi_free_SocketAddress(saddr);
+        return -1;
+    } else if(errno != EINPROGRESS && errno != EALREADY && errno != EINVAL) {
+        connected = 1;
     }
+    g_free(sconf);
+
     s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
     if (!s) {
         return -1;
     }
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connect to %s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
+             "socket: connect to %s:%s",
+             saddr->u.inet.host, saddr->u.inet.port);
+    qapi_free_SocketAddress(saddr);
     return 0;
 }
 
-- 
2.7.4
