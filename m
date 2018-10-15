Received: from eggs.gnu.org ([2001:4830:134:3::10]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByWS-0003sD-9K
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByWM-0003aY-RV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByWI-0003Wz-TL
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:36 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:01 +0800
Message-Id: <1539593186-32183-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 01/26] filter-rewriter: Add TCP state machine
 and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangckid@gmail.com>

We add almost full TCP state machine in filter-rewriter, except
TCPS_LISTEN and some simplify in VM active close FIN states.
The reason for this simplify job is because guest kernel will track
the TCP status and wait 2MSL time too, if client resend the FIN packet,
guest will resend the last ACK, so we needn't wait 2MSL time in filter-rewriter.

After a net connection is closed, we didn't clear its related resources
in connection_track_table, which will lead to memory leak.

Let's track the state of net connection, if it is closed, its related
resources will be cleared up.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo.c            |   2 +-
 net/colo.h            |   9 ++---
 net/filter-rewriter.c | 109 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/net/colo.c b/net/colo.c
index 6dda4ed..97c8fc9 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -137,7 +137,7 @@ Connection *connection_new(ConnectionKey *key)
     conn->ip_proto = key->ip_proto;
     conn->processing = false;
     conn->offset = 0;
-    conn->syn_flag = 0;
+    conn->tcp_state = TCPS_CLOSED;
     conn->pack = 0;
     conn->sack = 0;
     g_queue_init(&conn->primary_list);
diff --git a/net/colo.h b/net/colo.h
index da6c36d..0277e0e 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -18,6 +18,7 @@
 #include "slirp/slirp.h"
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
+#include "slirp/tcp.h"
 
 #define HASHTABLE_MAX_SIZE 16384
 
@@ -81,11 +82,9 @@ typedef struct Connection {
     uint32_t sack;
     /* offset = secondary_seq - primary_seq */
     tcp_seq  offset;
-    /*
-     * we use this flag update offset func
-     * run once in independent tcp connection
-     */
-    int syn_flag;
+
+    int tcp_state; /* TCP FSM state */
+    tcp_seq fin_ack_seq; /* the seq of 'fin=1,ack=1' */
 } Connection;
 
 uint32_t connection_key_hash(const void *opaque);
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index f584e4e..dd323fa 100644
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
 
@@ -74,23 +74,28 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
         trace_colo_filter_rewriter_conn_offset(conn->offset);
     }
 
+    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == (TH_ACK | TH_SYN)) &&
+        conn->tcp_state == TCPS_SYN_SENT) {
+        conn->tcp_state = TCPS_ESTABLISHED;
+    }
+
     if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_SYN)) {
         /*
          * we use this flag update offset func
          * run once in independent tcp connection
          */
-        conn->syn_flag = 1;
+        conn->tcp_state = TCPS_SYN_RECEIVED;
     }
 
     if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_ACK)) {
-        if (conn->syn_flag) {
+        if (conn->tcp_state == TCPS_SYN_RECEIVED) {
             /*
              * offset = secondary_seq - primary seq
              * ack packet sent by guest from primary node,
              * so we use th_ack - 1 get primary_seq
              */
             conn->offset -= (ntohl(tcp_pkt->th_ack) - 1);
-            conn->syn_flag = 0;
+            conn->tcp_state = TCPS_ESTABLISHED;
         }
         if (conn->offset) {
             /* handle packets to the secondary from the primary */
@@ -99,15 +104,66 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
             net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
                                    pkt->size - pkt->vnet_hdr_len);
         }
+
+        /*
+         * Passive close step 3
+         */
+        if ((conn->tcp_state == TCPS_LAST_ACK) &&
+            (ntohl(tcp_pkt->th_ack) == (conn->fin_ack_seq + 1))) {
+            conn->tcp_state = TCPS_CLOSED;
+            g_hash_table_remove(rf->connection_track_table, key);
+        }
+    }
+
+    if ((tcp_pkt->th_flags & TH_FIN) == TH_FIN) {
+        /*
+         * Passive close.
+         * Step 1:
+         * The *server* side of this connect is VM, *client* tries to close
+         * the connection. We will into CLOSE_WAIT status.
+         *
+         * Step 2:
+         * In this step we will into LAST_ACK status.
+         *
+         * We got 'fin=1, ack=1' packet from server side, we need to
+         * record the seq of 'fin=1, ack=1' packet.
+         *
+         * Step 3:
+         * We got 'ack=1' packets from client side, it acks 'fin=1, ack=1'
+         * packet from server side. From this point, we can ensure that there
+         * will be no packets in the connection, except that, some errors
+         * happen between the path of 'filter object' and vNIC, if this rare
+         * case really happen, we can still create a new connection,
+         * So it is safe to remove the connection from connection_track_table.
+         *
+         */
+        if (conn->tcp_state == TCPS_ESTABLISHED) {
+            conn->tcp_state = TCPS_CLOSE_WAIT;
+        }
+
+        /*
+         * Active close step 2.
+         */
+        if (conn->tcp_state == TCPS_FIN_WAIT_1) {
+            conn->tcp_state = TCPS_TIME_WAIT;
+            /*
+             * For simplify implementation, we needn't wait 2MSL time
+             * in filter rewriter. Because guest kernel will track the
+             * TCP status and wait 2MSL time, if client resend the FIN
+             * packet, guest will apply the last ACK too.
+             */
+            conn->tcp_state = TCPS_CLOSED;
+            g_hash_table_remove(rf->connection_track_table, key);
+        }
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
 
@@ -121,7 +177,8 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
         trace_colo_filter_rewriter_conn_offset(conn->offset);
     }
 
-    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == (TH_ACK | TH_SYN))) {
+    if (conn->tcp_state == TCPS_SYN_RECEIVED &&
+        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == (TH_ACK | TH_SYN))) {
         /*
          * save offset = secondary_seq and then
          * in handle_primary_tcp_pkt make offset
@@ -130,6 +187,12 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
         conn->offset = ntohl(tcp_pkt->th_seq);
     }
 
+    /* VM active connect */
+    if (conn->tcp_state == TCPS_CLOSED &&
+        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_SYN)) {
+        conn->tcp_state = TCPS_SYN_SENT;
+    }
+
     if ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_ACK) {
         /* Only need to adjust seq while offset is Non-zero */
         if (conn->offset) {
@@ -141,6 +204,32 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
         }
     }
 
+    /*
+     * Passive close step 2:
+     */
+    if (conn->tcp_state == TCPS_CLOSE_WAIT &&
+        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) == (TH_ACK | TH_FIN)) {
+        conn->fin_ack_seq = ntohl(tcp_pkt->th_seq);
+        conn->tcp_state = TCPS_LAST_ACK;
+    }
+
+    /*
+     * Active close
+     *
+     * Step 1:
+     * The *server* side of this connect is VM, *server* tries to close
+     * the connection.
+     *
+     * Step 2:
+     * We will into CLOSE_WAIT status.
+     * We simplify the TCPS_FIN_WAIT_2, TCPS_TIME_WAIT and
+     * CLOSING status.
+     */
+    if (conn->tcp_state == TCPS_ESTABLISHED &&
+        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) == TH_FIN) {
+        conn->tcp_state = TCPS_FIN_WAIT_1;
+    }
+
     return 0;
 }
 
@@ -190,7 +279,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
 
         if (sender == nf->netdev) {
             /* NET_FILTER_DIRECTION_TX */
-            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
+            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
                 qemu_net_queue_send(s->incoming_queue, sender, 0,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
@@ -203,7 +292,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
             }
         } else {
             /* NET_FILTER_DIRECTION_RX */
-            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
+            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
                 qemu_net_queue_send(s->incoming_queue, sender, 0,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
-- 
2.5.0
