Received: from eggs.gnu.org ([2001:4830:134:3::10]:39027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIz2-00020b-U3
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIz0-0001zU-JO
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22715
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIyz-0001ra-N2
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:18 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 25 Dec 2017 10:54:12 +0800
Message-ID: <13419a5985e00c236467916d3b26af89bc2daacd.1514169758.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/2] colo: compare the packet based on the
 tcp sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

Packet size some time different or when network is busy.
Based on same payload size, but TCP protocol can not
guarantee send the same one packet in the same way,

like that:
We send this payload:
------------------------------
| header |1|2|3|4|5|6|7|8|9|0|
------------------------------

primary:
ppkt1:
----------------
| header |1|2|3|
----------------
ppkt2:
------------------------
| header |4|5|6|7|8|9|0|
------------------------

secondary:
spkt1:
------------------------------
| header |1|2|3|4|5|6|7|8|9|0|
------------------------------

In the original method, ppkt1 and ppkt2 are different in size and
spkt1, so they can't compare and trigger the checkpoint.

I have tested FTP get 200M and 1G file many times, I found that
the performance was less than 1% of the native.

Now I reconstructed the comparison of TCP packets based on the
TCP sequence number. first of all, ppkt1 and spkt1 have the same
starting sequence number, so they can compare, even though their
length is different. And then ppkt1 with a smaller payload length
is used as the comparison length, if the payload is same, send
out the ppkt1 and record the offset(the length of ppkt1 payload)
in spkt1. The next comparison, ppkt2 and spkt1 can be compared
from the recorded position of spkt1.

like that:
----------------
| header |1|2|3| ppkt1
---------|-----|
         |     |
---------v-----v--------------
| header |1|2|3|4|5|6|7|8|9|0| spkt1
---------------|\------------|
               | \offset     |
      ---------v-------------v
      | header |4|5|6|7|8|9|0| ppkt2
      ------------------------

In this way, the performance can reach native 20% in my multiple
tests.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Tested-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 343 +++++++++++++++++++++++++++++++++++------------------
 net/colo.c         |   9 ++
 net/colo.h         |  15 +++
 net/trace-events   |   2 +-
 4 files changed, 250 insertions(+), 119 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index f39ca02..8622b0b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -37,6 +37,9 @@
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
+#define COLO_COMPARE_FREE_PRIMARY     0x01
+#define COLO_COMPARE_FREE_SECONDARY   0x02
+
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 
@@ -111,14 +114,32 @@ static gint seq_sorter(Packet *a, Packet *b, gpointer data)
     return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
 }
 
+static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
+{
+    Packet *pkt = data;
+    struct tcphdr *tcphd;
+
+    tcphd = (struct tcphdr *)pkt->transport_header;
+
+    pkt->tcp_seq = ntohl(tcphd->th_seq);
+    pkt->tcp_ack = ntohl(tcphd->th_ack);
+    *max_ack = *max_ack > pkt->tcp_ack ? *max_ack : pkt->tcp_ack;
+    pkt->header_size = pkt->transport_header - (uint8_t *)pkt->data
+                       + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
+    pkt->payload_size = pkt->size - pkt->header_size;
+    pkt->seq_end = pkt->tcp_seq + pkt->payload_size;
+    pkt->flags = tcphd->th_flags;
+}
+
 /*
  * Return 1 on success, if return 0 means the
  * packet will be dropped
  */
-static int colo_insert_packet(GQueue *queue, Packet *pkt)
+static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)
 {
     if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
         if (pkt->ip->ip_p == IPPROTO_TCP) {
+            fill_pkt_tcp_info(pkt, max_ack);
             g_queue_insert_sorted(queue,
                                   pkt,
                                   (GCompareDataFunc)seq_sorter,
@@ -168,12 +189,12 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     }
 
     if (mode == PRIMARY_IN) {
-        if (!colo_insert_packet(&conn->primary_list, pkt)) {
+        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
             error_report("colo compare primary queue size too big,"
                          "drop packet");
         }
     } else {
-        if (!colo_insert_packet(&conn->secondary_list, pkt)) {
+        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
             error_report("colo compare secondary queue size too big,"
                          "drop packet");
         }
@@ -183,6 +204,25 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     return 0;
 }
 
+static inline bool after(uint32_t seq1, uint32_t seq2)
+{
+        return (int32_t)(seq1 - seq2) > 0;
+}
+
+static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
+{
+    int ret;
+    ret = compare_chr_send(s,
+                           pkt->data,
+                           pkt->size,
+                           pkt->vnet_hdr_len);
+    if (ret < 0) {
+        error_report("colo send primary packet failed");
+    }
+    trace_colo_compare_main("packet same and release packet");
+    packet_destroy(pkt, NULL);
+}
+
 /*
  * The IP packets sent by primary and secondary
  * will be compared in here
@@ -214,104 +254,175 @@ static int colo_compare_packet_payload(Packet *ppkt,
 }
 
 /*
- * Called from the compare thread on the primary
- * for compare tcp packet
- * compare_tcp copied from Dr. David Alan Gilbert's branch
- */
-static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
+ * return true means that the payload is consist and
+ * need to make the next comparison, false means do
+ * the checkpoint
+*/
+static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
+                              int8_t *mark, uint32_t max_ack)
 {
-    struct tcphdr *ptcp, *stcp;
-    int res;
+    *mark = 0;
+
+    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
+        if (colo_compare_packet_payload(ppkt, spkt,
+                                        ppkt->header_size, spkt->header_size,
+                                        ppkt->payload_size)) {
+            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
+            return true;
+        }
+    }
+    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
+        if (colo_compare_packet_payload(ppkt, spkt,
+                                        ppkt->header_size, spkt->header_size,
+                                        ppkt->payload_size)) {
+            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
+            return true;
+        }
+    }
+
+    /* one part of secondary packet payload still need to be compared */
+    if (!after(ppkt->seq_end, spkt->seq_end)) {
+        if (colo_compare_packet_payload(ppkt, spkt,
+                                        ppkt->header_size + ppkt->offset,
+                                        spkt->header_size + spkt->offset,
+                                        ppkt->payload_size - ppkt->offset)) {
+            if (!after(ppkt->tcp_ack, max_ack)) {
+                *mark = COLO_COMPARE_FREE_PRIMARY;
+                spkt->offset += ppkt->payload_size - ppkt->offset;
+                return true;
+            } else {
+                /* secondary guest hasn't ack the data, don't send
+                 * out this packet
+                 */
+                return false;
+            }
+        }
+    } else {
+        /* primary packet is longer than secondary packet, compare
+         * the same part and mark the primary packet offset
+         */
+        if (colo_compare_packet_payload(ppkt, spkt,
+                                        ppkt->header_size + ppkt->offset,
+                                        spkt->header_size + spkt->offset,
+                                        spkt->payload_size - spkt->offset)) {
+            *mark = COLO_COMPARE_FREE_SECONDARY;
+            ppkt->offset += spkt->payload_size - spkt->offset;
+            return true;
+        }
+    }
 
-    trace_colo_compare_main("compare tcp");
+    return false;
+}
 
-    ptcp = (struct tcphdr *)ppkt->transport_header;
-    stcp = (struct tcphdr *)spkt->transport_header;
+static void colo_compare_tcp(CompareState *s, Connection *conn)
+{
+    Packet *ppkt = NULL, *spkt = NULL;
+    int8_t mark;
 
     /*
-     * The 'identification' field in the IP header is *very* random
-     * it almost never matches.  Fudge this by ignoring differences in
-     * unfragmented packets; they'll normally sort themselves out if different
-     * anyway, and it should recover at the TCP level.
-     * An alternative would be to get both the primary and secondary to rewrite
-     * somehow; but that would need some sync traffic to sync the state
-     */
-    if (ntohs(ppkt->ip->ip_off) & IP_DF) {
-        spkt->ip->ip_id = ppkt->ip->ip_id;
-        /* and the sum will be different if the IDs were different */
-        spkt->ip->ip_sum = ppkt->ip->ip_sum;
+     * If ppkt and spkt have the same payload, but ppkt's ACK
+     * is greater than spkt's ACK, in this case we can not
+     * send the ppkt because it will cause the secondary guest
+     * to miss sending some data in the next. Therefore, we
+     * record the maximum ACK in the current queue at both
+     * primary side and secondary side. Only when the ack is
+     * less than the smaller of the two maximum ack, then we
+     * can ensure that the packet's payload is acknowledged by
+     * primary and secondary.
+    */
+    uint32_t min_ack = conn->pack > conn->sack ? conn->sack : conn->pack;
+
+pri:
+    if (g_queue_is_empty(&conn->primary_list)) {
+        return;
     }
+    ppkt = g_queue_pop_head(&conn->primary_list);
+sec:
+    if (g_queue_is_empty(&conn->secondary_list)) {
+        g_queue_push_head(&conn->primary_list, ppkt);
+        return;
+    }
+    spkt = g_queue_pop_head(&conn->secondary_list);
 
-    /*
-     * Check tcp header length for tcp option field.
-     * th_off > 5 means this tcp packet have options field.
-     * The tcp options maybe always different.
-     * for example:
-     * From RFC 7323.
-     * TCP Timestamps option (TSopt):
-     * Kind: 8
-     *
-     * Length: 10 bytes
-     *
-     *    +-------+-------+---------------------+---------------------+
-     *    |Kind=8 |  10   |   TS Value (TSval)  |TS Echo Reply (TSecr)|
-     *    +-------+-------+---------------------+---------------------+
-     *       1       1              4                     4
-     *
-     * In this case the primary guest's timestamp always different with
-     * the secondary guest's timestamp. COLO just focus on payload,
-     * so we just need skip this field.
-     */
+    if (ppkt->tcp_seq == ppkt->seq_end) {
+        colo_release_primary_pkt(s, ppkt);
+        ppkt = NULL;
+    }
 
-    ptrdiff_t ptcp_offset, stcp_offset;
+    if (ppkt && conn->compare_seq && !after(ppkt->seq_end, conn->compare_seq)) {
+        trace_colo_compare_main("pri: this packet has compared");
+        colo_release_primary_pkt(s, ppkt);
+        ppkt = NULL;
+    }
 
-    ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
-                  + (ptcp->th_off << 2) - ppkt->vnet_hdr_len;
-    stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
-                  + (stcp->th_off << 2) - spkt->vnet_hdr_len;
-    if (ppkt->size - ptcp_offset == spkt->size - stcp_offset) {
-        res = colo_compare_packet_payload(ppkt, spkt,
-                                          ptcp_offset, stcp_offset,
-                                          ppkt->size - ptcp_offset);
+    if (spkt->tcp_seq == spkt->seq_end) {
+        packet_destroy(spkt, NULL);
+        if (!ppkt) {
+            goto pri;
+        } else {
+            goto sec;
+        }
     } else {
-        trace_colo_compare_main("TCP: payload size of packets are different");
-        res = -1;
+        if (conn->compare_seq && !after(spkt->seq_end, conn->compare_seq)) {
+            trace_colo_compare_main("sec: this packet has compared");
+            packet_destroy(spkt, NULL);
+            if (!ppkt) {
+                goto pri;
+            } else {
+                goto sec;
+            }
+        }
+        if (!ppkt) {
+            g_queue_push_head(&conn->secondary_list, spkt);
+            goto pri;
+        }
     }
 
-    if (res != 0 &&
-        trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
-
-        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
-        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
-        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
-        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
-
-        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
-                                   pri_ip_dst, spkt->size,
-                                   sec_ip_src, sec_ip_dst);
-
-        trace_colo_compare_tcp_info("pri tcp packet",
-                                    ntohl(ptcp->th_seq),
-                                    ntohl(ptcp->th_ack),
-                                    res, ptcp->th_flags,
-                                    ppkt->size);
-
-        trace_colo_compare_tcp_info("sec tcp packet",
-                                    ntohl(stcp->th_seq),
-                                    ntohl(stcp->th_ack),
-                                    res, stcp->th_flags,
-                                    spkt->size);
+    if (colo_mark_tcp_pkt(ppkt, spkt, &mark, min_ack)) {
+        trace_colo_compare_tcp_info("pri",
+                                    ppkt->tcp_seq, ppkt->tcp_ack,
+                                    ppkt->header_size, ppkt->payload_size,
+                                    ppkt->offset, ppkt->flags);
+
+        trace_colo_compare_tcp_info("sec",
+                                    spkt->tcp_seq, spkt->tcp_ack,
+                                    spkt->header_size, spkt->payload_size,
+                                    spkt->offset, spkt->flags);
+
+        if (mark == COLO_COMPARE_FREE_PRIMARY) {
+            conn->compare_seq = ppkt->seq_end;
+            colo_release_primary_pkt(s, ppkt);
+            g_queue_push_head(&conn->secondary_list, spkt);
+            goto pri;
+        }
+        if (mark == COLO_COMPARE_FREE_SECONDARY) {
+            conn->compare_seq = spkt->seq_end;
+            packet_destroy(spkt, NULL);
+            goto sec;
+        }
+        if (mark == (COLO_COMPARE_FREE_PRIMARY | COLO_COMPARE_FREE_SECONDARY)) {
+            conn->compare_seq = ppkt->seq_end;
+            colo_release_primary_pkt(s, ppkt);
+            packet_destroy(spkt, NULL);
+            goto pri;
+        }
+    } else {
+        g_queue_push_head(&conn->primary_list, ppkt);
+        g_queue_push_head(&conn->secondary_list, spkt);
 
         qemu_hexdump((char *)ppkt->data, stderr,
                      "colo-compare ppkt", ppkt->size);
         qemu_hexdump((char *)spkt->data, stderr,
                      "colo-compare spkt", spkt->size);
-    }
 
-    return res;
+        /*
+         * colo_compare_inconsistent_notify();
+         * TODO: notice to checkpoint();
+         */
+    }
 }
 
+
 /*
  * Called from the compare thread on the primary
  * for compare udp packet
@@ -477,53 +588,22 @@ static void colo_old_packet_check(void *opaque)
                         (GCompareFunc)colo_old_packet_check_one_conn);
 }
 
-/*
- * Called from the compare thread on the primary
- * for compare packet with secondary list of the
- * specified connection when a new packet was
- * queued to it.
- */
-static void colo_compare_connection(void *opaque, void *user_data)
+static void colo_compare_packet(CompareState *s, Connection *conn,
+                                int (*HandlePacket)(Packet *spkt,
+                                Packet *ppkt))
 {
-    CompareState *s = user_data;
-    Connection *conn = opaque;
     Packet *pkt = NULL;
     GList *result = NULL;
-    int ret;
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
         pkt = g_queue_pop_head(&conn->primary_list);
-        switch (conn->ip_proto) {
-        case IPPROTO_TCP:
-            result = g_queue_find_custom(&conn->secondary_list,
-                     pkt, (GCompareFunc)colo_packet_compare_tcp);
-            break;
-        case IPPROTO_UDP:
-            result = g_queue_find_custom(&conn->secondary_list,
-                     pkt, (GCompareFunc)colo_packet_compare_udp);
-            break;
-        case IPPROTO_ICMP:
-            result = g_queue_find_custom(&conn->secondary_list,
-                     pkt, (GCompareFunc)colo_packet_compare_icmp);
-            break;
-        default:
-            result = g_queue_find_custom(&conn->secondary_list,
-                     pkt, (GCompareFunc)colo_packet_compare_other);
-            break;
-        }
+        result = g_queue_find_custom(&conn->secondary_list,
+                 pkt, (GCompareFunc)HandlePacket);
 
         if (result) {
-            ret = compare_chr_send(s,
-                                   pkt->data,
-                                   pkt->size,
-                                   pkt->vnet_hdr_len);
-            if (ret < 0) {
-                error_report("colo_send_primary_packet failed");
-            }
-            trace_colo_compare_main("packet same and release packet");
+            colo_release_primary_pkt(s, pkt);
             g_queue_remove(&conn->secondary_list, result->data);
-            packet_destroy(pkt, NULL);
         } else {
             /*
              * If one packet arrive late, the secondary_list or
@@ -538,6 +618,33 @@ static void colo_compare_connection(void *opaque, void *user_data)
     }
 }
 
+/*
+ * Called from the compare thread on the primary
+ * for compare packet with secondary list of the
+ * specified connection when a new packet was
+ * queued to it.
+ */
+static void colo_compare_connection(void *opaque, void *user_data)
+{
+    CompareState *s = user_data;
+    Connection *conn = opaque;
+
+    switch (conn->ip_proto) {
+    case IPPROTO_TCP:
+        colo_compare_tcp(s, conn);
+        break;
+    case IPPROTO_UDP:
+        colo_compare_packet(s, conn, colo_packet_compare_udp);
+        break;
+    case IPPROTO_ICMP:
+        colo_compare_packet(s, conn, colo_packet_compare_icmp);
+        break;
+    default:
+        colo_compare_packet(s, conn, colo_packet_compare_other);
+        break;
+    }
+}
+
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
diff --git a/net/colo.c b/net/colo.c
index a39d600..8426265 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -138,6 +138,8 @@ Connection *connection_new(ConnectionKey *key)
     conn->processing = false;
     conn->offset = 0;
     conn->syn_flag = 0;
+    conn->pack = 0;
+    conn->sack = 0;
     g_queue_init(&conn->primary_list);
     g_queue_init(&conn->secondary_list);
 
@@ -163,6 +165,13 @@ Packet *packet_new(const void *data, int size, int vnet_hdr_len)
     pkt->size = size;
     pkt->creation_ms = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     pkt->vnet_hdr_len = vnet_hdr_len;
+    pkt->tcp_seq = 0;
+    pkt->tcp_ack = 0;
+    pkt->seq_end = 0;
+    pkt->header_size = 0;
+    pkt->payload_size = 0;
+    pkt->offset = 0;
+    pkt->flags = 0;
 
     return pkt;
 }
diff --git a/net/colo.h b/net/colo.h
index 0658e86..da6c36d 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -45,6 +45,15 @@ typedef struct Packet {
     int64_t creation_ms;
     /* Get vnet_hdr_len from filter */
     uint32_t vnet_hdr_len;
+    uint32_t tcp_seq; /* sequence number */
+    uint32_t tcp_ack; /* acknowledgement number */
+    /* the sequence number of the last byte of the packet */
+    uint32_t seq_end;
+    uint8_t header_size;  /* the header length */
+    uint16_t payload_size; /* the payload length */
+    /* record the payload offset(the length that has been compared) */
+    uint16_t offset;
+    uint8_t flags; /* Flags(aka Control bits) */
 } Packet;
 
 typedef struct ConnectionKey {
@@ -64,6 +73,12 @@ typedef struct Connection {
     /* flag to enqueue unprocessed_connections */
     bool processing;
     uint8_t ip_proto;
+    /* record the sequence number that has been compared */
+    uint32_t compare_seq;
+    /* the maximum of acknowledgement number in primary_list queue */
+    uint32_t pack;
+    /* the maximum of acknowledgement number in secondary_list queue */
+    uint32_t sack;
     /* offset = secondary_seq - primary_seq */
     tcp_seq  offset;
     /*
diff --git a/net/trace-events b/net/trace-events
index 938263d..7b594cf 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,7 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
-colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= 0x%x pkt_size: %d\n"
+colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d\n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-- 
2.9.4
