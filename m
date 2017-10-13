Received: from eggs.gnu.org ([2001:4830:134:3::10]:35398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZf-00080i-2b
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZc-0004vi-W1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34094
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZc-0004qA-KZ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:56 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 13 Oct 2017 14:32:07 +0800
Message-ID: <20171013063209.15617-3-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
References: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] colo-compare: compare the packet in a
 specified Connection
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
2.9.4
