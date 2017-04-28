Received: from eggs.gnu.org ([2001:4830:134:3::10]:33864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f6-6W
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uu-0001Vg-JZ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=46892 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ut-0001Qm-VJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:32 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:18 +0800
Message-ID: <1493372840-24551-9-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 08/10] net/colo-compare.c: Make colo-compare
 support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

COLO-compare can get vnet header length from filter,
Add vnet_hdr_len to struct packet and output packet with
the vnet_hdr_len.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c    | 39 ++++++++++++++++++++++++++++++++-------
 net/colo.c            |  3 ++-
 net/colo.h            |  4 +++-
 net/filter-rewriter.c |  2 +-
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..b3e933c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -99,7 +99,8 @@ enum {
 
 static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
-                            uint32_t size);
+                            uint32_t size,
+                            uint32_t vnet_hdr_len);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -121,9 +122,13 @@ static int packet_enqueue(CompareState *s, int mode)
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
@@ -436,7 +441,10 @@ static void colo_compare_connection(void *opaque, void *user_data)
         }
 
         if (result) {
-            ret = compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+            ret = compare_chr_send(&s->chr_out,
+                                   pkt->data,
+                                   pkt->size,
+                                   pkt->vnet_hdr_len);
             if (ret < 0) {
                 error_report("colo_send_primary_packet failed");
             }
@@ -459,7 +467,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
 
 static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
-                            uint32_t size)
+                            uint32_t size,
+                            uint32_t vnet_hdr_len)
 {
     int ret = 0;
     uint32_t len = htonl(size);
@@ -473,6 +482,16 @@ static int compare_chr_send(CharBackend *out,
         goto err;
     }
 
+    /*
+     * We send vnet header len make other module(like colo-compare)
+     * know how to parse net packet correctly.
+     */
+    len = htonl(vnet_hdr_len);
+    ret = qemu_chr_fe_write_all(out, (uint8_t *)&len, sizeof(len));
+    if (ret != sizeof(len)) {
+        goto err;
+    }
+
     ret = qemu_chr_fe_write_all(out, (uint8_t *)buf, size);
     if (ret != size) {
         goto err;
@@ -616,7 +635,10 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 
     if (packet_enqueue(s, PRIMARY_IN)) {
         trace_colo_compare_main("primary: unsupported packet in");
-        compare_chr_send(&s->chr_out, pri_rs->buf, pri_rs->packet_len);
+        compare_chr_send(&s->chr_out,
+                         pri_rs->buf,
+                         pri_rs->packet_len,
+                         pri_rs->vnet_hdr_len);
     } else {
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
@@ -725,7 +747,10 @@ static void colo_flush_packets(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list)) {
         pkt = g_queue_pop_head(&conn->primary_list);
-        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+        compare_chr_send(&s->chr_out,
+                         pkt->data,
+                         pkt->size,
+                         pkt->vnet_hdr_len);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
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
