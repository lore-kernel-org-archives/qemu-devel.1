Received: from eggs.gnu.org ([2001:4830:134:3::10]:38608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1ehA7c-0003PV-JD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1ehA7X-0000Bu-Kr
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:21:28 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1ehA7X-0000Bd-Dd
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:21:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id g1so4034176wmg.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 00:21:23 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  1 Feb 2018 16:20:28 +0800
Message-Id: <1517473228-8402-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH] net/socket: change net_socket_listen_init to
 use qemu-socket functions
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

net_socket_listen_init directly uses parse_host_port, bind and listen,
change it to use functions in include/qemu/sockets.h

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 net/socket.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6917fbc..e4b1f47 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -494,36 +494,24 @@ static int net_socket_listen_init(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
-    struct sockaddr_in saddr;
-    int fd, ret;
+    SocketAddress *saddr;
+    Error *local_err = NULL;
+    int fd;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    saddr = socket_parse(host_str, &local_err);
+    if (NULL != local_err) {
+        error_setg_errno(errp, errno, "socket_parse failed");
         return -1;
     }
 
-    fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
+    fd = socket_listen(saddr, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "can't create stream socket");
+        error_setg_errno(errp, errno, "can't listen on address");
+        qapi_free_SocketAddress(saddr);
         return -1;
     }
     qemu_set_nonblock(fd);
 
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
-        return -1;
-    }
-
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
     s = DO_UPCAST(NetSocketState, nc, nc);
     s->fd = -1;
-- 
2.7.4
