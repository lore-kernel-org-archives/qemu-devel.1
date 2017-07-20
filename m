Received: from eggs.gnu.org ([2001:4830:134:3::10]:54115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsV-0007JG-VN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsU-0007p2-I0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:51 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42625
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsU-0007oL-8Q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:50 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:28 +0100
Message-Id: <20170720191228.12342-6-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH v2 5/5] Migrate Datagram operation in socket
 transport to UDST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Migrate datagram operation to UDST if UDST is available.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 net/socket.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index f85ef7d61b..0523fe9ac1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -33,6 +33,9 @@
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#ifdef CONFIG_UDST
+#include "udst.h"
+#endif
 
 typedef struct NetSocketState {
     NetClientState nc;
@@ -49,6 +52,14 @@ typedef struct NetSocketState {
 static void net_socket_accept(void *opaque);
 static void net_socket_writable(void *opaque);
 
+#ifdef CONFIG_UDST
+static int noop(void *us, uint8_t *buf)
+{
+    return 0;
+}
+#endif
+
+
 static void net_socket_update_fd_handler(NetSocketState *s)
 {
     qemu_set_fd_handler(s->fd,
@@ -113,6 +124,8 @@ static ssize_t net_socket_receive(NetClientState *nc, const uint8_t *buf, size_t
     return size;
 }
 
+#ifndef CONFIG_UDST
+
 static ssize_t net_socket_receive_dgram(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     NetSocketState *s = DO_UPCAST(NetSocketState, nc, nc);
@@ -130,6 +143,7 @@ static ssize_t net_socket_receive_dgram(NetClientState *nc, const uint8_t *buf,
     }
     return ret;
 }
+#endif
 
 static void net_socket_send_completed(NetClientState *nc, ssize_t len)
 {
@@ -189,6 +203,8 @@ static void net_socket_send(void *opaque)
     }
 }
 
+#ifndef CONFIG_UDST
+
 static void net_socket_send_dgram(void *opaque)
 {
     NetSocketState *s = opaque;
@@ -208,6 +224,7 @@ static void net_socket_send_dgram(void *opaque)
         net_socket_read_poll(s, false);
     }
 }
+#endif
 
 static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr *localaddr)
 {
@@ -309,7 +326,85 @@ static void net_socket_cleanup(NetClientState *nc)
         s->listen_fd = -1;
     }
 }
+#ifdef CONFIG_UDST
+static NetUdstState *net_socket_fd_init_dgram(NetClientState *peer,
+                                                const char *model,
+                                                const char *name,
+                                                int fd, int is_connected)
+{
+    struct sockaddr_in saddr;
+    int newfd;
+    socklen_t saddr_len = sizeof(saddr);
+    NetClientState *nc;
+    NetUdstState *s;
 
+    /* fd passed: multicast: "learn" dgram_dst address from bound address and save it
+     * Because this may be "shared" socket from a "master" process, datagrams would be recv()
+     * by ONLY ONE process: we must "clone" this dgram socket --jjo
+     */
+
+    if (is_connected) {
+        if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
+            /* must be bound */
+            if (saddr.sin_addr.s_addr == 0) {
+                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
+                        "cannot setup multicast dst addr\n", fd);
+                goto err;
+            }
+            /* clone dgram socket */
+            newfd = net_socket_mcast_create(&saddr, NULL);
+            if (newfd < 0) {
+                /* error already reported by net_socket_mcast_create() */
+                goto err;
+            }
+            /* clone newfd to fd, close newfd */
+            dup2(newfd, fd);
+            close(newfd);
+
+        } else {
+            fprintf(stderr,
+                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
+                    fd, strerror(errno));
+            goto err;
+        }
+    }
+
+    fprintf(stderr,
+            "qemu: init udst for fd=%d\n",
+            fd);
+    nc = qemu_new_udst_net_client(name, peer);
+
+    s = DO_UPCAST(NetUdstState, nc, nc);
+
+    s->offset = 0;
+
+    qemu_net_finalize_udst_init(s,
+        &noop,
+        NULL,
+        fd);
+
+    /* mcast: save bound address as dst */
+    if (is_connected) {
+        s->dgram_dst = g_memdup(&saddr, sizeof(struct sockaddr_in));
+        s->dst_size = sizeof(struct sockaddr_in);
+        snprintf(nc->info_str, sizeof(nc->info_str),
+                 "socket: fd=%d (cloned mcast=%s:%d)",
+                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
+    } else {
+        /* This will be overwritten later if we have a dst */
+        s->dgram_dst = NULL;
+        s->dst_size = 0;
+        snprintf(nc->info_str, sizeof(nc->info_str),
+                 "socket: fd=%d", fd);
+    }
+
+    return s;
+
+err:
+    closesocket(fd);
+    return NULL;
+}
+#else
 static NetClientInfo net_dgram_socket_info = {
     .type = NET_CLIENT_DRIVER_SOCKET,
     .size = sizeof(NetSocketState),
@@ -386,6 +481,7 @@ err:
     closesocket(fd);
     return NULL;
 }
+#endif
 
 static void net_socket_connect(void *opaque)
 {
@@ -430,7 +526,7 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
     return s;
 }
 
-static NetSocketState *net_socket_fd_init(NetClientState *peer,
+static void *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
                                           int fd, int is_connected)
 {
@@ -567,7 +663,7 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected);
+    s = net_socket_fd_init_stream(peer, model, name, fd, connected);
     if (!s)
         return -1;
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
@@ -582,7 +678,11 @@ static int net_socket_mcast_init(NetClientState *peer,
                                  const char *host_str,
                                  const char *localaddr_str)
 {
+#ifdef CONFIG_UDST
+    NetUdstState *s;
+#else
     NetSocketState *s;
+#endif
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
@@ -602,11 +702,15 @@ static int net_socket_mcast_init(NetClientState *peer,
     if (fd < 0)
         return -1;
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0);
     if (!s)
         return -1;
-
+#ifdef CONFIG_UDST
+    s->dgram_dst = g_memdup(&saddr, sizeof(struct sockaddr_in));
+    s->dst_size = sizeof(struct sockaddr_in);
+#else
     s->dgram_dst = saddr;
+#endif
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: mcast=%s:%d",
@@ -621,7 +725,11 @@ static int net_socket_udp_init(NetClientState *peer,
                                  const char *rhost,
                                  const char *lhost)
 {
+#ifdef CONFIG_UDST
+    NetUdstState *s;
+#else
     NetSocketState *s;
+#endif
     int fd, ret;
     struct sockaddr_in laddr, raddr;
 
@@ -652,12 +760,17 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0);
     if (!s) {
         return -1;
     }
 
+#ifdef CONFIG_UDST
+    s->dgram_dst = g_memdup(&raddr, sizeof(struct sockaddr_in));
+    s->dst_size = sizeof(struct sockaddr_in);
+#else
     s->dgram_dst = raddr;
+#endif
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: udp=%s:%d",
-- 
2.11.0
