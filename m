Received: from eggs.gnu.org ([2001:4830:134:3::10]:43926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003hc-0m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhe-00073n-OU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=16463 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhe-0006zC-Bp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:54 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:50 +0800
Message-ID: <1499151236-14671-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 06/12] net/colo.c: Make vnet_hdr_len as
 packet property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We can use this property flush and send packet with vnet_hdr_len.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c    | 8 ++++++--
 net/colo.c            | 3 ++-
 net/colo.h            | 4 +++-
 net/filter-rewriter.c | 2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 45b1584..3f914f6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -121,9 +121,13 @@ static int packet_enqueue(CompareState *s, int mode)
     Connection *conn;
 
     if (mode == PRIMARY_IN) {
-        pkt = packet_new(s->pri_rs.buf, s->pri_rs.packet_len);
+        pkt = packet_new(s->pri_rs.buf,
+                         s->pri_rs.packet_len,
+                         s->pri_rs.vnet_hdr_len);
     } else {
-        pkt = packet_new(s->sec_rs.buf, s->sec_rs.packet_len);
+        pkt = packet_new(s->sec_rs.buf,
+                         s->sec_rs.packet_len,
+                         s->sec_rs.vnet_hdr_len);
     }
 
     if (parse_packet_early(pkt)) {
diff --git a/net/colo.c b/net/colo.c
index 8cc166b..180eaed 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -153,13 +153,14 @@ void connection_destroy(void *opaque)
     g_slice_free(Connection, conn);
 }
 
-Packet *packet_new(const void *data, int size)
+Packet *packet_new(const void *data, int size, int vnet_hdr_len)
 {
     Packet *pkt = g_slice_new(Packet);
 
     pkt->data = g_memdup(data, size);
     pkt->size = size;
     pkt->creation_ms = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    pkt->vnet_hdr_len = vnet_hdr_len;
 
     return pkt;
 }
diff --git a/net/colo.h b/net/colo.h
index 7c524f3..caedb0d 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -43,6 +43,8 @@ typedef struct Packet {
     int size;
     /* Time of packet creation, in wall clock ms */
     int64_t creation_ms;
+    /* Get vnet_hdr_len from filter */
+    uint32_t vnet_hdr_len;
 } Packet;
 
 typedef struct ConnectionKey {
@@ -82,7 +84,7 @@ Connection *connection_get(GHashTable *connection_track_table,
                            ConnectionKey *key,
                            GQueue *conn_list);
 void connection_hashtable_reset(GHashTable *connection_track_table);
-Packet *packet_new(const void *data, int size);
+Packet *packet_new(const void *data, int size, int vnet_hdr_len);
 void packet_destroy(void *opaque, void *user_data);
 
 #endif /* QEMU_COLO_PROXY_H */
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index afa06e8..63256c7 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -158,7 +158,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
     char *buf = g_malloc0(size);
 
     iov_to_buf(iov, iovcnt, 0, buf, size);
-    pkt = packet_new(buf, size);
+    pkt = packet_new(buf, size, 0);
     g_free(buf);
 
     /*
-- 
2.7.4
