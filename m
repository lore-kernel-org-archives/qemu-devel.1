Received: from eggs.gnu.org ([2001:4830:134:3::10]:59105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfm-00061c-ST
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfl-0000XA-An
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:38 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvfl-0000Vp-36
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:37 -0400
Received: by mail-pf0-x243.google.com with SMTP id j2so3036300pff.10
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:45:36 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:44:58 +0800
Message-Id: <1520754314-5969-3-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V6 01/17] filter-rewriter: fix memory leak for
 connection in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

After a net connection is closed, we didn't clear its releated resources
in connection_track_table, which will lead to memory leak.

Let't track the state of net connection, if it is closed, its related
resources will be cleared up.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo.h            |  4 +++
 net/filter-rewriter.c | 69 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/net/colo.h b/net/colo.h
index da6c36d..cd11851 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -18,6 +18,7 @@
 #include "slirp/slirp.h"
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
+#include "slirp/tcp.h"
 
 #define HASHTABLE_MAX_SIZE 16384
 
@@ -86,6 +87,9 @@ typedef struct Connection {
      * run once in independent tcp connection
      */
     int syn_flag;
+
+    int tcp_state; /* TCP FSM state */
+    tcp_seq fin_ack_seq; /* the seq of 'fin=1,ack=1' */
 } Connection;
 
 uint32_t connection_key_hash(const void *opaque);
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 62dad2d..0909a9a 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -59,9 +59,9 @@ static int is_tcp_packet(Packet *pkt)
 }
 
 /* handle tcp packet from primary guest */
-static int handle_primary_tcp_pkt(NetFilterState *nf,
+static int handle_primary_tcp_pkt(RewriterState *rf,
                                   Connection *conn,
-                                  Packet *pkt)
+                                  Packet *pkt, ConnectionKey *key)
 {
     struct tcphdr *tcp_pkt;
 
@@ -99,15 +99,44 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
             net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
                                    pkt->size - pkt->vnet_hdr_len);
         }
+        /*
+         * Case 1:
+         * The *server* side of this connect is VM, *client* tries to close
+         * the connection.
+         *
+         * We got 'ack=1' packets from client side, it acks 'fin=1, ack=1'
+         * packet from server side. From this point, we can ensure that there
+         * will be no packets in the connection, except that, some errors
+         * happen between the path of 'filter object' and vNIC, if this rare
+         * case really happen, we can still create a new connection,
+         * So it is safe to remove the connection from connection_track_table.
+         *
+         */
+        if ((conn->tcp_state == TCPS_LAST_ACK) &&
+            (ntohl(tcp_pkt->th_ack) == (conn->fin_ack_seq + 1))) {
+            g_hash_table_remove(rf->connection_track_table, key);
+        }
+    }
+    /*
+     * Case 2:
+     * The *server* side of this connect is VM, *server* tries to close
+     * the connection.
+     *
+     * We got 'fin=1, ack=1' packet from client side, we need to
+     * record the seq of 'fin=1, ack=1' packet.
+     */
+    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) == (TH_ACK | TH_FIN)) {
+        conn->fin_ack_seq = htonl(tcp_pkt->th_seq);
+        conn->tcp_state = TCPS_LAST_ACK;
     }
 
     return 0;
 }
 
 /* handle tcp packet from secondary guest */
-static int handle_secondary_tcp_pkt(NetFilterState *nf,
+static int handle_secondary_tcp_pkt(RewriterState *rf,
                                     Connection *conn,
-                                    Packet *pkt)
+                                    Packet *pkt, ConnectionKey *key)
 {
     struct tcphdr *tcp_pkt;
 
@@ -139,8 +168,34 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
             net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
                                    pkt->size - pkt->vnet_hdr_len);
         }
+        /*
+         * Case 2:
+         * The *server* side of this connect is VM, *server* tries to close
+         * the connection.
+         *
+         * We got 'ack=1' packets from server side, it acks 'fin=1, ack=1'
+         * packet from client side. Like Case 1, there should be no packets
+         * in the connection from now know, But the difference here is
+         * if the packet is lost, We will get the resent 'fin=1,ack=1' packet.
+         * TODO: Fix above case.
+         */
+        if ((conn->tcp_state == TCPS_LAST_ACK) &&
+            (ntohl(tcp_pkt->th_ack) == (conn->fin_ack_seq + 1))) {
+            g_hash_table_remove(rf->connection_track_table, key);
+        }
+    }
+    /*
+     * Case 1:
+     * The *server* side of this connect is VM, *client* tries to close
+     * the connection.
+     *
+     * We got 'fin=1, ack=1' packet from server side, we need to
+     * record the seq of 'fin=1, ack=1' packet.
+     */
+    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) == (TH_ACK | TH_FIN)) {
+        conn->fin_ack_seq = ntohl(tcp_pkt->th_seq);
+        conn->tcp_state = TCPS_LAST_ACK;
     }
-
     return 0;
 }
 
@@ -190,7 +245,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
 
         if (sender == nf->netdev) {
             /* NET_FILTER_DIRECTION_TX */
-            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
+            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
                 qemu_net_queue_send(s->incoming_queue, sender, 0,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
@@ -203,7 +258,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
             }
         } else {
             /* NET_FILTER_DIRECTION_RX */
-            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
+            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
                 qemu_net_queue_send(s->incoming_queue, sender, 0,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
-- 
2.7.4
