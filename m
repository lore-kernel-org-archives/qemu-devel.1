Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3v-0007O4-Ew
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3u-0006Ig-Kj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:19 -0400
Received: from [59.151.112.132] (port=25092 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3u-0006C3-8Q
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:18 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 13 Jul 2017 13:52:52 +0800
Message-ID: <1499925175-21218-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 1/4] net/colo-compare.c: Add checkpoint min
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If colo-compare find out the first different packet that means
the following packet almost is different. we needn't do a lot
of checkpoint in this time, so we set the no-need-checkpoint
peroid, default just set 3 second.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6d500e1..0f8e198 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -40,6 +40,9 @@
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 
+/* TODO: Should be configurable */
+#define CHECKPOINT_MIN_TIME 3000
+
 /*
   + CompareState ++
   |               |
@@ -455,6 +458,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
     Packet *pkt = NULL;
     GList *result = NULL;
     int ret;
+    static int64_t checkpoint_time_ms;
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
@@ -494,7 +498,14 @@ static void colo_compare_connection(void *opaque, void *user_data)
              */
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
-            /* TODO: colo_notify_checkpoint();*/
+
+            if (pkt->creation_ms - checkpoint_time_ms > CHECKPOINT_MIN_TIME) {
+                /*
+                 * TODO: Notify colo frame to do checkpoint.
+                 * colo_compare_inconsistent_notify();
+                 */
+                checkpoint_time_ms = pkt->creation_ms;
+            }
             break;
         }
     }
-- 
2.7.4
