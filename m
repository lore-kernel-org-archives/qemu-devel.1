Received: from eggs.gnu.org ([2001:4830:134:3::10]:57706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6g0n-0003pM-2O
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6g0j-0008K5-Td
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6g0j-0008Iz-KH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:23:17 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  5 May 2017 17:23:05 +0100
Message-Id: <20170505162305.15763-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use socket_*()
 functions" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This reverts commit 883e4f7624e10b98d16d9adaffb8b1795664d899.

This code changed net/socket.c from using socket()+connect(),
to using socket_connect(). In theory this is great, but in
practice this has completely broken the ability to connect
the frontend and backend:

  $ ./x86_64-softmmu/qemu-system-x86_64 \
       -device e1000,id=e0,netdev=hn0,mac=DE:AD:BE:EF:AF:05 \
       -netdev socket,id=hn0,connect=localhost:1234
  qemu-system-x86_64: -device e1000,id=e0,netdev=hn0,mac=DE:AD:BE:EF:AF:05: Property 'e1000.netdev' can't find value 'hn0'

The old code would call net_socket_fd_init() synchronously,
while letting the connect() complete in the backgorund. The
new code moved net_socket_fd_init() so that it is only called
after connect() completes in the background.

Thus at the time we initialize the NIC frontend, the backend
does not exist.

The socket_connect() conversion as done is a bad fit for the
current code, since it did not try to change the way it deals
with async connection completion. Rather than try to fix this,
just revert the socket_connect() conversion entirely.

The code is about to be converted to use QIOChannel which
will let the problem be solved in a cleaner manner. This
revert is more suitable for stable branches in the meantime.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 net/socket.c | 127 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 56 insertions(+), 71 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b8c931e..dcae1ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -489,106 +489,91 @@ static int net_socket_listen_init(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
-    SocketAddress *saddr;
-    int ret;
-    Error *local_error = NULL;
+    struct sockaddr_in saddr;
+    int fd, ret;
 
-    saddr = socket_parse(host_str, &local_error);
-    if (saddr == NULL) {
-        error_report_err(local_error);
+    if (parse_host_port(&saddr, host_str) < 0)
+        return -1;
+
+    fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("socket");
         return -1;
     }
+    qemu_set_nonblock(fd);
+
+    socket_set_fast_reuse(fd);
 
-    ret = socket_listen(saddr, &local_error);
+    ret = bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
     if (ret < 0) {
-        qapi_free_SocketAddress(saddr);
-        error_report_err(local_error);
+        perror("bind");
+        closesocket(fd);
+        return -1;
+    }
+    ret = listen(fd, 0);
+    if (ret < 0) {
+        perror("listen");
+        closesocket(fd);
         return -1;
     }
 
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
     s = DO_UPCAST(NetSocketState, nc, nc);
     s->fd = -1;
-    s->listen_fd = ret;
+    s->listen_fd = fd;
     s->nc.link_down = true;
     net_socket_rs_init(&s->rs, net_socket_rs_finalize);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
-    qapi_free_SocketAddress(saddr);
     return 0;
 }
 
-typedef struct {
-    NetClientState *peer;
-    SocketAddress *saddr;
-    char *model;
-    char *name;
-} socket_connect_data;
-
-static void socket_connect_data_free(socket_connect_data *c)
-{
-    qapi_free_SocketAddress(c->saddr);
-    g_free(c->model);
-    g_free(c->name);
-    g_free(c);
-}
-
-static void net_socket_connected(int fd, Error *err, void *opaque)
-{
-    socket_connect_data *c = opaque;
-    NetSocketState *s;
-    char *addr_str = NULL;
-    Error *local_error = NULL;
-
-    addr_str = socket_address_to_string(c->saddr, &local_error);
-    if (addr_str == NULL) {
-        error_report_err(local_error);
-        closesocket(fd);
-        goto end;
-    }
-
-    s = net_socket_fd_init(c->peer, c->model, c->name, fd, true);
-    if (!s) {
-        closesocket(fd);
-        goto end;
-    }
-
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connect to %s", addr_str);
-
-end:
-    g_free(addr_str);
-    socket_connect_data_free(c);
-}
-
 static int net_socket_connect_init(NetClientState *peer,
                                    const char *model,
                                    const char *name,
                                    const char *host_str)
 {
-    socket_connect_data *c = g_new0(socket_connect_data, 1);
-    int fd = -1;
-    Error *local_error = NULL;
+    NetSocketState *s;
+    int fd, connected, ret;
+    struct sockaddr_in saddr;
 
-    c->peer = peer;
-    c->model = g_strdup(model);
-    c->name = g_strdup(name);
-    c->saddr = socket_parse(host_str, &local_error);
-    if (c->saddr == NULL) {
-        goto err;
-    }
+    if (parse_host_port(&saddr, host_str) < 0)
+        return -1;
 
-    fd = socket_connect(c->saddr, net_socket_connected, c, &local_error);
+    fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        goto err;
+        perror("socket");
+        return -1;
     }
+    qemu_set_nonblock(fd);
 
+    connected = 0;
+    for(;;) {
+        ret = connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
+        if (ret < 0) {
+            if (errno == EINTR || errno == EWOULDBLOCK) {
+                /* continue */
+            } else if (errno == EINPROGRESS ||
+                       errno == EALREADY ||
+                       errno == EINVAL) {
+                break;
+            } else {
+                perror("connect");
+                closesocket(fd);
+                return -1;
+            }
+        } else {
+            connected = 1;
+            break;
+        }
+    }
+    s = net_socket_fd_init(peer, model, name, fd, connected);
+    if (!s)
+        return -1;
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "socket: connect to %s:%d",
+             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     return 0;
-
-err:
-    error_report_err(local_error);
-    socket_connect_data_free(c);
-    return -1;
 }
 
 static int net_socket_mcast_init(NetClientState *peer,
-- 
2.9.3
