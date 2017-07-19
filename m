Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOe-0006Mc-EM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOd-0000f2-Hr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:48 -0400
Received: from [59.151.112.132] (port=20158 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOd-0000bK-59
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:47 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 15:29:58 +0800
Message-ID: <1500449399-19107-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 3/4] net/colo-compare.c: Adjust net queue
 pop order for performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The packet_enqueue() use g_queue_push_tail() to
enqueue net packet, so it is more efficent way use
g_queue_pop_head() to get packet for compare.
That will improve the success rate of comparison.
In my test the performance of ftp put 1000M file
will increase 10%

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6aa5ea6..58c3250 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -489,7 +489,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
-        pkt = g_queue_pop_tail(&conn->primary_list);
+        pkt = g_queue_pop_head(&conn->primary_list);
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -527,7 +527,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
              * until next comparison.
              */
             trace_colo_compare_main("packet different");
-            g_queue_push_tail(&conn->primary_list, pkt);
+            g_queue_push_head(&conn->primary_list, pkt);
 
             if (pkt->creation_ms - s->checkpoint_time_ms >
                 CHECKPOINT_MIN_TIME) {
-- 
2.7.4
