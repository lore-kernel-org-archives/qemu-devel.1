Received: from eggs.gnu.org ([2001:4830:134:3::10]:41326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOe-0006Mo-Pk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOd-0000fC-VM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:48 -0400
Received: from [59.151.112.132] (port=35077 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOc-0000e7-NG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:47 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 15:29:56 +0800
Message-ID: <1500449399-19107-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 1/4] net/colo-compare.c: Add checkpoint min
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

If colo-compare find out the first different packet that means
the following packet almost is different. we needn't do a lot
of checkpoint in this time, so we set the no-need-checkpoint
peroid, default just set 3 second.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ca67c68..5313e74 100644
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
@@ -75,6 +78,9 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     bool vnet_hdr;
 
+    /* Record the last checkpoint time */
+    int64_t checkpoint_time_ms;
+
     /* connection list: the connections belonged to this NIC could be found
      * in this list.
      * element type: Connection
@@ -507,7 +513,19 @@ static void colo_compare_connection(void *opaque, void *user_data)
              */
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
-            /* TODO: colo_notify_checkpoint();*/
+
+            if (pkt->creation_ms - s->checkpoint_time_ms >
+                CHECKPOINT_MIN_TIME) {
+                /*
+                 * TODO: Notify colo frame to do checkpoint.
+                 * colo_compare_inconsistent_notify();
+                 *
+                 * TODO: Reset s->checkpoint_time_ms after finish
+                 * checkpoint(when colo-compare get notify from colo-frame,
+                 * in another independent patch).
+                 */
+                s->checkpoint_time_ms = pkt->creation_ms;
+            }
             break;
         }
     }
@@ -803,6 +821,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                        colo_compare_thread, s,
                        QEMU_THREAD_JOINABLE);
     compare_id++;
+    s->checkpoint_time_ms = 0;
 
     return;
 }
-- 
2.7.4
