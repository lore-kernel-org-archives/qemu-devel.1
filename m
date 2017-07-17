Received: from eggs.gnu.org ([2001:4830:134:3::10]:48304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52V-0000lZ-Oa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52S-00087k-KM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52S-00087M-Bb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:12 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:38 +0800
Message-Id: <1500294105-13713-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] net/colo-compare.c: Introduce parameter
 for compare_chr_send()
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

This patch change the compare_chr_send() parameter from CharBackend to CompareState,
we can get more information like vnet_hdr(We use it to support packet with vnet_header).

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9c2b1ea..c5d01da 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -97,7 +97,7 @@ enum {
     SECONDARY_IN,
 };
 
-static int compare_chr_send(CharBackend *out,
+static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size);
 
@@ -483,7 +483,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
         }
 
         if (result) {
-            ret = compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+            ret = compare_chr_send(s, pkt->data, pkt->size);
             if (ret < 0) {
                 error_report("colo_send_primary_packet failed");
             }
@@ -504,7 +504,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
     }
 }
 
-static int compare_chr_send(CharBackend *out,
+static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size)
 {
@@ -515,12 +515,12 @@ static int compare_chr_send(CharBackend *out,
         return 0;
     }
 
-    ret = qemu_chr_fe_write_all(out, (uint8_t *)&len, sizeof(len));
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
     if (ret != sizeof(len)) {
         goto err;
     }
 
-    ret = qemu_chr_fe_write_all(out, (uint8_t *)buf, size);
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
     if (ret != size) {
         goto err;
     }
@@ -665,7 +665,7 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 
     if (packet_enqueue(s, PRIMARY_IN)) {
         trace_colo_compare_main("primary: unsupported packet in");
-        compare_chr_send(&s->chr_out, pri_rs->buf, pri_rs->packet_len);
+        compare_chr_send(s, pri_rs->buf, pri_rs->packet_len);
     } else {
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
@@ -774,7 +774,7 @@ static void colo_flush_packets(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list)) {
         pkt = g_queue_pop_head(&conn->primary_list);
-        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+        compare_chr_send(s, pkt->data, pkt->size);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
-- 
2.7.4
