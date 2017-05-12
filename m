Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdN-0000PA-JW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdM-0003wr-Mo
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:45 -0400
Received: from [59.151.112.132] (port=35788 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdL-0003rG-LQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:44 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:24 +0800
Message-ID: <1494553288-30764-9-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 08/12] net/colo-compare.c: Make colo-compare
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
 net/colo-compare.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 87a9529..cb0b04e 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -98,9 +98,10 @@ enum {
     SECONDARY_IN,
 };
 
-static int compare_chr_send(CharBackend *out,
+static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
-                            uint32_t size);
+                            uint32_t size,
+                            uint32_t vnet_hdr_len);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -473,7 +474,10 @@ static void colo_compare_connection(void *opaque, void *user_data)
         }
 
         if (result) {
-            ret = compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+            ret = compare_chr_send(s,
+                                   pkt->data,
+                                   pkt->size,
+                                   pkt->vnet_hdr_len);
             if (ret < 0) {
                 error_report("colo_send_primary_packet failed");
             }
@@ -494,9 +498,10 @@ static void colo_compare_connection(void *opaque, void *user_data)
     }
 }
 
-static int compare_chr_send(CharBackend *out,
+static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
-                            uint32_t size)
+                            uint32_t size,
+                            uint32_t vnet_hdr_len)
 {
     int ret = 0;
     uint32_t len = htonl(size);
@@ -505,12 +510,24 @@ static int compare_chr_send(CharBackend *out,
         return 0;
     }
 
-    ret = qemu_chr_fe_write_all(out, (uint8_t *)&len, sizeof(len));
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
     if (ret != sizeof(len)) {
         goto err;
     }
 
-    ret = qemu_chr_fe_write_all(out, (uint8_t *)buf, size);
+    if (s->vnet_hdr) {
+        /*
+         * We send vnet header len make other module(like filter-redirector)
+         * know how to parse net packet correctly.
+         */
+        len = htonl(vnet_hdr_len);
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+        if (ret != sizeof(len)) {
+            goto err;
+        }
+    }
+
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
     if (ret != size) {
         goto err;
     }
@@ -535,7 +552,7 @@ static void compare_pri_chr_in(void *opaque, const uint8_t *buf, int size)
     CompareState *s = COLO_COMPARE(opaque);
     int ret;
 
-    ret = net_fill_rstate(&s->pri_rs, buf, size, false);
+    ret = net_fill_rstate(&s->pri_rs, buf, size, s->vnet_hdr);
     if (ret == -1) {
         qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
                                  NULL, NULL, true);
@@ -552,7 +569,7 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
     CompareState *s = COLO_COMPARE(opaque);
     int ret;
 
-    ret = net_fill_rstate(&s->sec_rs, buf, size, false);
+    ret = net_fill_rstate(&s->sec_rs, buf, size, s->vnet_hdr);
     if (ret == -1) {
         qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
                                  NULL, NULL, true);
@@ -675,7 +692,10 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 
     if (packet_enqueue(s, PRIMARY_IN)) {
         trace_colo_compare_main("primary: unsupported packet in");
-        compare_chr_send(&s->chr_out, pri_rs->buf, pri_rs->packet_len);
+        compare_chr_send(s,
+                         pri_rs->buf,
+                         pri_rs->packet_len,
+                         pri_rs->vnet_hdr_len);
     } else {
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
@@ -783,7 +803,10 @@ static void colo_flush_packets(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list)) {
         pkt = g_queue_pop_head(&conn->primary_list);
-        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+        compare_chr_send(s,
+                         pkt->data,
+                         pkt->size,
+                         pkt->vnet_hdr_len);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
-- 
2.7.4
