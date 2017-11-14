Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhh-0004d3-F2
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhg-0000mg-En
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEQhg-0000mH-7t
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:56 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:33 +0800
Message-Id: <1510625498-4821-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] colo-compare: compare the packet in a
 specified Connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

A package from pri_indev or sec_indev only belongs to a particular
Connection, so we only need to compare the package in the specified
Connection's primary_list and secondary_list, rather than for each
the whole Connection list to compare. This is time-consuming and
unnecessary.

Less checkpoint more efficiency.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54b6347..5d2429b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -136,7 +136,7 @@ static int colo_insert_packet(GQueue *queue, Packet *pkt)
  * Return 0 on success, if return -1 means the pkt
  * is unsupported(arp and ipv6) and will be sent later
  */
-static int packet_enqueue(CompareState *s, int mode)
+static int packet_enqueue(CompareState *s, int mode, Connection **con)
 {
     ConnectionKey key;
     Packet *pkt = NULL;
@@ -179,6 +179,7 @@ static int packet_enqueue(CompareState *s, int mode)
                          "drop packet");
         }
     }
+    con = &conn;
 
     return 0;
 }
@@ -728,8 +729,9 @@ static void compare_set_vnet_hdr(Object *obj,
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
+    Connection *conn = NULL;
 
-    if (packet_enqueue(s, PRIMARY_IN)) {
+    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
         trace_colo_compare_main("primary: unsupported packet in");
         compare_chr_send(s,
                          pri_rs->buf,
@@ -737,19 +739,20 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
                          pri_rs->vnet_hdr_len);
     } else {
         /* compare connection */
-        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        colo_compare_connection(conn, s);
     }
 }
 
 static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 {
     CompareState *s = container_of(sec_rs, CompareState, sec_rs);
+    Connection *conn = NULL;
 
-    if (packet_enqueue(s, SECONDARY_IN)) {
+    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
         trace_colo_compare_main("secondary: unsupported packet in");
     } else {
         /* compare connection */
-        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        colo_compare_connection(conn, s);
     }
 }
 
-- 
2.7.4
