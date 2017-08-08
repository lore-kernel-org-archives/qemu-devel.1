Received: from eggs.gnu.org ([2001:4830:134:3::10]:35338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBPN-00068D-UQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBPK-0006BJ-4Q
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfBPJ-00068M-RH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4585F6146C
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:31 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Tue,  8 Aug 2017 22:38:57 +0200
Message-Id: <20170808203900.7661-3-jfreimann@redhat.com>
In-Reply-To: <20170808203900.7661-1-jfreimann@redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] net: fix -netdev socket,
 fd= for UDP sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

This patch fixes -netdev socket,fd= for UDP sockets
Currently -netdev socket,fd=<...> results in

  qemu: error: specified mcastaddr "127.0.0.1" (0x7f000001) does not
    contain a multicast address
  qemu-system-x86_64: -netdev
    socket,id=n1,fd=3: Device 'socket' could not be initialized

To fix these we need to allow specifying multicast and fd arguments
for the same netdev. With this the user can specify "-netdev
fd=3,mcast=<IP:port>"

Cc: Jason Wang <jasowang@redhat.com>
Fixes: 3d830459b1eccdb61b75e2712fd364012ce5a115
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/socket.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index f85ef7d61b..18af2ab5f3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -320,11 +320,11 @@ static NetClientInfo net_dgram_socket_info = {
 static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
-                                                int fd, int is_connected)
+                                                int fd, int is_connected,
+                                                const char *mcast)
 {
     struct sockaddr_in saddr;
     int newfd;
-    socklen_t saddr_len = sizeof(saddr);
     NetClientState *nc;
     NetSocketState *s;
 
@@ -333,8 +333,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
      * by ONLY ONE process: we must "clone" this dgram socket --jjo
      */
 
-    if (is_connected) {
-        if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
+    if (is_connected && mcast != NULL) {
+            if (parse_host_port(&saddr, mcast) < 0) {
+                fprintf(stderr,
+                        "qemu: error: init_dgram: fd=%d failed parse_host_port()\n",
+                        fd);
+                goto err;
+            }
             /* must be bound */
             if (saddr.sin_addr.s_addr == 0) {
                 fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
@@ -351,12 +356,6 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
             dup2(newfd, fd);
             close(newfd);
 
-        } else {
-            fprintf(stderr,
-                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
-                    fd, strerror(errno));
-            goto err;
-        }
     }
 
     nc = qemu_new_net_client(&net_dgram_socket_info, peer, model, name);
@@ -432,7 +431,7 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
 static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
-                                          int fd, int is_connected)
+                                          int fd, int is_connected, const char *mc)
 {
     int so_type = -1, optlen=sizeof(so_type);
 
@@ -445,7 +444,7 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
     }
     switch(so_type) {
     case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected, mc);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
@@ -567,7 +566,7 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected);
+    s = net_socket_fd_init(peer, model, name, fd, connected, NULL);
     if (!s)
         return -1;
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
@@ -602,7 +601,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     if (fd < 0)
         return -1;
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL);
     if (!s)
         return -1;
 
@@ -652,7 +651,7 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init(peer, model, name, fd, 0, NULL);
     if (!s) {
         return -1;
     }
@@ -675,9 +674,9 @@ int net_init_socket(const Netdev *netdev, const char *name,
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
     sock = &netdev->u.socket;
 
-    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
-        sock->has_udp != 1) {
-        error_report("exactly one of fd=, listen=, connect=, mcast= or udp="
+    if (sock->has_listen + sock->has_connect + sock->has_mcast +
+        sock->has_udp > 1) {
+        error_report("exactly one of listen=, connect=, mcast= or udp="
                      " is required");
         return -1;
     }
@@ -696,7 +695,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast)) {
             return -1;
         }
         return 0;
-- 
2.13.3
