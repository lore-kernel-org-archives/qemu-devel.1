Received: from eggs.gnu.org ([2001:4830:134:3::10]:36589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2ybq-0006Qq-Tf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2ybq-00022D-0w
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:26:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2ybp-00021T-Rs
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:26:17 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Apr 2017 19:26:01 +0800
Message-Id: <1493119568-15218-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 1/8] colo-compare: Fix old packet check bug.
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

If colo-compare find one old packet,we can notify colo-frame
do checkpoint, no need continue find more old packet here.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
