Received: from eggs.gnu.org ([2001:4830:134:3::10]:37324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdM-0005Vi-Ru
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdJ-0002jl-Qo
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18989
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdJ-0002hR-G5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:17 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Mon, 4 Sep 2017 14:14:47 +0800
Message-ID: <1504505688-32455-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1504505688-32455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1504505688-32455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V5 2/3] net/colo-compare.c: Adjust net queue
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

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
index 18a9ebf..8dd76e4 100644
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
