Received: from eggs.gnu.org ([2001:4830:134:3::10]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyHAl-0004Ri-1s
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyHAg-0003rT-Tz
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:14:55 -0400
Received: from [59.151.112.132] (port=54953 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyHAg-0003p1-Hu
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:14:50 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 12 Apr 2017 20:12:07 +0800
Message-ID: <1491999127-21103-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] colo-compare: Fix old packet check bug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If colo-compare find one old packet,we can notify colo-frame
do checkpoint, no need continue find more old packet here.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..9b09cfc 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -372,10 +372,9 @@ static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
     }
 }
 
-static void colo_old_packet_check_one_conn(void *opaque,
-                                           void *user_data)
+static int colo_old_packet_check_one_conn(Connection *conn,
+                                          void *user_data)
 {
-    Connection *conn = opaque;
     GList *result = NULL;
     int64_t check_time = REGULAR_PACKET_CHECK_MS;
 
@@ -386,7 +385,10 @@ static void colo_old_packet_check_one_conn(void *opaque,
     if (result) {
         /* do checkpoint will flush old packet */
         /* TODO: colo_notify_checkpoint();*/
+        return 0;
     }
+
+    return 1;
 }
 
 /*
@@ -398,7 +400,12 @@ static void colo_old_packet_check(void *opaque)
 {
     CompareState *s = opaque;
 
-    g_queue_foreach(&s->conn_list, colo_old_packet_check_one_conn, NULL);
+    /*
+     * If we find one old packet, stop finding job and notify
+     * COLO frame do checkpoint.
+     */
+    g_queue_find_custom(&s->conn_list, NULL,
+                        (GCompareFunc)colo_old_packet_check_one_conn);
 }
 
 /*
-- 
2.7.4
