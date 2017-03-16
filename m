Received: from eggs.gnu.org ([2001:4830:134:3::10]:60988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5a-0000jH-Ri
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5Z-0005d7-Pt
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:58 -0400
Received: from [59.151.112.132] (port=35717 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5W-0005aT-Fh
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:57 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 17:52:06 +0800
Message-ID: <1489657928-14919-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] COLO-proxy: Add virtio-net packet parse
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Change parse_packet_early(Packet *pkt) to parse_packet_early(Packet *pkt, int offset)
that we can skip virtio-net header.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c    | 11 +++++++----
 net/colo.c            |  8 ++++----
 net/colo.h            |  5 ++++-
 net/filter-rewriter.c | 15 ++++++++++-----
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..ce0cd12 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -126,10 +126,13 @@ static int packet_enqueue(CompareState *s, int mode)
         pkt = packet_new(s->sec_rs.buf, s->sec_rs.packet_len);
     }
 
-    if (parse_packet_early(pkt)) {
-        packet_destroy(pkt, NULL);
-        pkt = NULL;
-        return -1;
+    /* Try to parse the virtio-net-pci packet */
+    if (parse_packet_early(pkt, VIRTIO_NET_HEADER)) {
+        if (parse_packet_early(pkt, 0)) {
+            packet_destroy(pkt, NULL);
+            pkt = NULL;
+            return -1;
+        }
     }
     fill_connection_key(pkt, &key);
 
diff --git a/net/colo.c b/net/colo.c
index 8cc166b..060e822 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -39,15 +39,15 @@ int connection_key_equal(const void *key1, const void *key2)
     return memcmp(key1, key2, sizeof(ConnectionKey)) == 0;
 }
 
-int parse_packet_early(Packet *pkt)
+int parse_packet_early(Packet *pkt, int offset)
 {
     int network_length;
     static const uint8_t vlan[] = {0x81, 0x00};
-    uint8_t *data = pkt->data;
+    uint8_t *data = pkt->data + offset;
     uint16_t l3_proto;
     ssize_t l2hdr_len = eth_get_l2_hdr_length(data);
 
-    if (pkt->size < ETH_HLEN) {
+    if (pkt->size < ETH_HLEN + offset) {
         trace_colo_proxy_main("pkt->size < ETH_HLEN");
         return 1;
     }
@@ -73,7 +73,7 @@ int parse_packet_early(Packet *pkt)
     }
 
     network_length = pkt->ip->ip_hl * 4;
-    if (pkt->size < l2hdr_len + network_length) {
+    if (pkt->size < l2hdr_len + network_length + offset) {
         trace_colo_proxy_main("pkt->size < network_header + network_length");
         return 1;
     }
diff --git a/net/colo.h b/net/colo.h
index 7c524f3..b713f87 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -33,6 +33,9 @@
 #define IPPROTO_UDPLITE 136
 #endif
 
+/* virtio-net header length */
+#define VIRTIO_NET_HEADER 12
+
 typedef struct Packet {
     void *data;
     union {
@@ -73,7 +76,7 @@ typedef struct Connection {
 
 uint32_t connection_key_hash(const void *opaque);
 int connection_key_equal(const void *opaque1, const void *opaque2);
-int parse_packet_early(Packet *pkt);
+int parse_packet_early(Packet *pkt, int offset);
 void fill_connection_key(Packet *pkt, ConnectionKey *key);
 void reverse_connection_key(ConnectionKey *key);
 Connection *connection_new(ConnectionKey *key);
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index afa06e8..c3f0261 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -51,12 +51,17 @@ static void filter_rewriter_flush(NetFilterState *nf)
  */
 static int is_tcp_packet(Packet *pkt)
 {
-    if (!parse_packet_early(pkt) &&
-        pkt->ip->ip_p == IPPROTO_TCP) {
-        return 1;
-    } else {
-        return 0;
+    if (!parse_packet_early(pkt, VIRTIO_NET_HEADER) ||
+        !parse_packet_early(pkt, 0)) {
+        if (pkt->ip->ip_p == IPPROTO_TCP) {
+            return 1;
+        } else {
+            goto out;
+        }
     }
+
+out:
+    return 0;
 }
 
 /* handle tcp packet from primary guest */
-- 
2.7.4
