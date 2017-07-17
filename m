Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52H-0000YO-5Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52G-0007tB-1F
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52F-0007pU-NH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:21:59 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:33 +0800
Message-Id: <1500294105-13713-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] net/net.c: Add vnet_hdr support in
 SocketReadState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

We add a flag to decide whether net_fill_rstate() need read
the vnet_hdr_len or not.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h   |  9 +++++++--
 net/colo-compare.c  |  4 ++--
 net/filter-mirror.c |  2 +-
 net/net.c           | 36 ++++++++++++++++++++++++++++++++----
 net/socket.c        |  8 ++++----
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 9a92c70..1c55a93 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -112,9 +112,13 @@ typedef struct NICState {
 } NICState;
 
 struct SocketReadState {
-    int state; /* 0 = getting length, 1 = getting data */
+    /* 0 = getting length, 1 = getting vnet header length, 2 = getting data */
+    int state;
+    /* This flag decide whether to read the vnet_hdr_len field */
+    bool vnet_hdr;
     uint32_t index;
     uint32_t packet_len;
+    uint32_t vnet_hdr_len;
     uint8_t buf[NET_BUFSIZE];
     SocketReadStateFinalize *finalize;
 };
@@ -177,7 +181,8 @@ ssize_t qemu_deliver_packet_iov(NetClientState *sender,
 void print_net_client(Monitor *mon, NetClientState *nc);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
 void net_socket_rs_init(SocketReadState *rs,
-                        SocketReadStateFinalize *finalize);
+                        SocketReadStateFinalize *finalize,
+                        bool vnet_hdr);
 
 /* NIC info */
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index abfc23c..ea9bccc 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -743,8 +743,8 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize);
-    net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
+    net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, false);
+    net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, false);
 
     g_queue_init(&s->conn_list);
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 6043549..1b6211b 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -229,7 +229,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         }
     }
 
-    net_socket_rs_init(&s->rs, redirector_rs_finalize);
+    net_socket_rs_init(&s->rs, redirector_rs_finalize, false);
 
     if (s->indev) {
         chr = qemu_chr_find(s->indev);
diff --git a/net/net.c b/net/net.c
index b62ce10..0e28099 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1616,11 +1616,14 @@ QemuOptsList qemu_net_opts = {
 };
 
 void net_socket_rs_init(SocketReadState *rs,
-                        SocketReadStateFinalize *finalize)
+                        SocketReadStateFinalize *finalize,
+                        bool vnet_hdr)
 {
     rs->state = 0;
+    rs->vnet_hdr = vnet_hdr;
     rs->index = 0;
     rs->packet_len = 0;
+    rs->vnet_hdr_len = 0;
     memset(rs->buf, 0, sizeof(rs->buf));
     rs->finalize = finalize;
 }
@@ -1635,8 +1638,12 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
     unsigned int l;
 
     while (size > 0) {
-        /* reassemble a packet from the network */
-        switch (rs->state) { /* 0 = getting length, 1 = getting data */
+        /* Reassemble a packet from the network.
+         * 0 = getting length.
+         * 1 = getting vnet header length.
+         * 2 = getting data.
+         */
+        switch (rs->state) {
         case 0:
             l = 4 - rs->index;
             if (l > size) {
@@ -1650,10 +1657,31 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
                 /* got length */
                 rs->packet_len = ntohl(*(uint32_t *)rs->buf);
                 rs->index = 0;
-                rs->state = 1;
+                if (rs->vnet_hdr) {
+                    rs->state = 1;
+                } else {
+                    rs->state = 2;
+                    rs->vnet_hdr_len = 0;
+                }
             }
             break;
         case 1:
+            l = 4 - rs->index;
+            if (l > size) {
+                l = size;
+            }
+            memcpy(rs->buf + rs->index, buf, l);
+            buf += l;
+            size -= l;
+            rs->index += l;
+            if (rs->index == 4) {
+                /* got vnet header length */
+                rs->vnet_hdr_len = ntohl(*(uint32_t *)rs->buf);
+                rs->index = 0;
+                rs->state = 2;
+            }
+            break;
+        case 2:
             l = rs->packet_len - rs->index;
             if (l > size) {
                 l = size;
diff --git a/net/socket.c b/net/socket.c
index dcae1ae..f85ef7d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -174,7 +174,7 @@ static void net_socket_send(void *opaque)
         closesocket(s->fd);
 
         s->fd = -1;
-        net_socket_rs_init(&s->rs, net_socket_rs_finalize);
+        net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
         s->nc.link_down = true;
         memset(s->nc.info_str, 0, sizeof(s->nc.info_str));
 
@@ -366,7 +366,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
     s->fd = fd;
     s->listen_fd = -1;
     s->send_fn = net_socket_send_dgram;
-    net_socket_rs_init(&s->rs, net_socket_rs_finalize);
+    net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
     net_socket_read_poll(s, true);
 
     /* mcast: save bound address as dst */
@@ -417,7 +417,7 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
     s->fd = fd;
     s->listen_fd = -1;
-    net_socket_rs_init(&s->rs, net_socket_rs_finalize);
+    net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
 
     /* Disable Nagle algorithm on TCP sockets to reduce latency */
     socket_set_nodelay(fd);
@@ -522,7 +522,7 @@ static int net_socket_listen_init(NetClientState *peer,
     s->fd = -1;
     s->listen_fd = fd;
     s->nc.link_down = true;
-    net_socket_rs_init(&s->rs, net_socket_rs_finalize);
+    net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
     return 0;
-- 
2.7.4
