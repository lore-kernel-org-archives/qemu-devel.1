Received: from eggs.gnu.org ([2001:4830:134:3::10]:54337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIoQE-00087c-GC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIoQA-0006ee-IV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:47:46 -0400
Received: from [59.151.112.132] (port=36612 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIoQ9-0006eT-Cg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:47:42 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 8 Jun 2017 11:47:52 +0800
Message-ID: <1496893672-8313-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/colo-compare.c: Add no-need-checkpoint
 period to optimize performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

If colo-compare find out the first different packet that means
the following packet almost is different. we needn't do a lot
of checkpoint in one second, so we set the no-need-checkpoint
period, default just set 3 second.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6d500e1..8fb1c9c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -39,6 +39,8 @@
 
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
+/* TODO: Should be configurable */
+#define CHECKPOINT_MIN_TIME 3000
 
 /*
   + CompareState ++
@@ -455,6 +457,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
     Packet *pkt = NULL;
     GList *result = NULL;
     int ret;
+    static int64_t checkpoint_time_ms;
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
@@ -494,7 +497,11 @@ static void colo_compare_connection(void *opaque, void *user_data)
              */
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
-            /* TODO: colo_notify_checkpoint();*/
+
+            if (pkt->creation_ms - checkpoint_time_ms > CHECKPOINT_MIN_TIME) {
+                /* TODO: colo_notify_checkpoint();*/
+                checkpoint_time_ms = pkt->creation_ms;
+            }
             break;
         }
     }
-- 
2.7.4
