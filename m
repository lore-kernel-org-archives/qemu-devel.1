Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt5-0005zV-DK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt3-000090-DH
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:39 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1egEt3-00008c-7c
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:37 -0500
Received: by mail-pf0-x242.google.com with SMTP id i66so6229677pfd.7
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:14:37 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 30 Jan 2018 03:13:43 +0800
Message-Id: <1517253224-14361-4-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 3/4] net/socket: change net_socket_listen_init to
 use functions in include/qemu/sockets.h
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

Some functions in net/socket.c still uses bind/connect/listen
directly. Change it to use functions in include/qemu/sockets.h

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 net/socket.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6917fbc..7b07223 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -494,35 +494,35 @@ static int net_socket_listen_init(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
-    struct sockaddr_in saddr;
-    int fd, ret;
+    SocketAddress *saddr;
+    QemuSocketConfig *sconf;
+    Error *local_err = NULL;
+    int fd;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    saddr = socket_parse(host_str, &local_err);
+    if(NULL != local_err) {
+        error_setg_errno(errp, errno, "socket_parse failed");
         return -1;
     }
 
-    fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
-    if (fd < 0) {
-        error_setg_errno(errp, errno, "can't create stream socket");
+    /* Manually prepare config because socket_listen
++     * will not set O_NONBLOCKING */
+    sconf = g_new0(QemuSocketConfig, 1);
+    if(NULL == sconf) {
+        qapi_free_SocketAddress(saddr);
+        error_setg_errno(errp, errno, "out of memory");
         return -1;
     }
-    qemu_set_nonblock(fd);
+    sconf->nonblocking = true;
+    sconf->options = NULL;
 
-    socket_set_fast_reuse(fd);
-
-    ret = bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
-                         inet_ntoa(saddr.sin_addr));
-        closesocket(fd);
-        return -1;
-    }
-    ret = listen(fd, 0);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "can't listen on socket");
-        closesocket(fd);
+    fd = socket_listen(saddr, errp, sconf);
+    if(fd < 0) {
+        error_setg_errno(errp, errno, "can't listen on address");
+        qapi_free_SocketAddress(saddr);
         return -1;
     }
+    g_free(sconf);
 
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
     s = DO_UPCAST(NetSocketState, nc, nc);
@@ -532,6 +532,7 @@ static int net_socket_listen_init(NetClientState *peer,
     net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
+    qapi_free_SocketAddress(saddr);
     return 0;
 }
 
-- 
2.7.4
