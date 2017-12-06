Received: from eggs.gnu.org ([2001:4830:134:3::10]:55415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWk-0007oV-WC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWh-0004Cc-Sn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59003
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWh-00046x-F6
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:03 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 6 Dec 2017 17:57:28 +0800
Message-ID: <03fd4ff1dd212e028f605e630551bce15e5d10a9.1512552817.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/4] colo: add trace for the tcp packet
 comparison
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

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 16 ++++++++++++++++
 net/colo.c         |  1 +
 net/colo.h         |  1 +
 net/trace-events   |  1 +
 4 files changed, 19 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 683ec4e..db1f586 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -129,6 +129,7 @@ static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
                        + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
     pkt->payload_size = pkt->size - pkt->header_size;
     pkt->seq_end = pkt->tcp_seq + pkt->payload_size;
+    pkt->flags = tcphd->th_flags;
 }
 
 /*
@@ -369,6 +370,16 @@ sec:
     }
 
     if (colo_mark_tcp_pkt(ppkt, spkt, &mark, min_ack)) {
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
         if (mark == COLO_COMPARE_FREE_PRIMARY) {
             conn->compare_seq = ppkt->seq_end;
             colo_release_primary_pkt(s, ppkt);
@@ -387,6 +398,11 @@ sec:
             goto pri;
         }
     } else {
+        qemu_hexdump((char *)ppkt->data, stderr,
+                     "colo-compare ppkt", ppkt->size);
+        qemu_hexdump((char *)spkt->data, stderr,
+                     "colo-compare spkt", spkt->size);
+
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);
 
diff --git a/net/colo.c b/net/colo.c
index a7a7117..8426265 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -171,6 +171,7 @@ Packet *packet_new(const void *data, int size, int vnet_hdr_len)
     pkt->header_size = 0;
     pkt->payload_size = 0;
     pkt->offset = 0;
+    pkt->flags = 0;
 
     return pkt;
 }
diff --git a/net/colo.h b/net/colo.h
index aa08374..da6c36d 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -53,6 +53,7 @@ typedef struct Packet {
     uint16_t payload_size; /* the payload length */
     /* record the payload offset(the length that has been compared) */
     uint16_t offset;
+    uint8_t flags; /* Flags(aka Control bits) */
 } Packet;
 
 typedef struct ConnectionKey {
diff --git a/net/trace-events b/net/trace-events
index 7b7cae5..7b594cf 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,6 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
+colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d\n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-- 
2.9.4
