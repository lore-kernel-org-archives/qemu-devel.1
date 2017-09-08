Received: from eggs.gnu.org ([2001:4830:134:3::10]:32895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gn-0003hM-6J
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gi-0002aF-7g
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gi-0002Z9-1V
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:32 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:20 +0800
Message-Id: <1504836324-4871-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] net/colo-compare.c: Adjust net queue pop
 order for performance
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

The packet_enqueue() use g_queue_push_tail() to
enqueue net packet, so it is more efficent way use
g_queue_pop_head() to get packet for compare.
That will improve the success rate of comparison.
In my test the performance of ftp put 1000M file
will increase 10%

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 612fbac..f480315 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -484,7 +484,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
-        pkt = g_queue_pop_tail(&conn->primary_list);
+        pkt = g_queue_pop_head(&conn->primary_list);
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -522,7 +522,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
              * until next comparison.
              */
             trace_colo_compare_main("packet different");
-            g_queue_push_tail(&conn->primary_list, pkt);
+            g_queue_push_head(&conn->primary_list, pkt);
             /* TODO: colo_notify_checkpoint();*/
             break;
         }
-- 
2.7.4
