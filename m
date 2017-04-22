Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXR-0001H6-Jp
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXQ-00041C-I9
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3848
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXP-0003z7-Uj
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:04 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:13 +0800
Message-ID: <1492850128-17472-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 03/18] colo-compare: use notifier to
 notify packets comparing result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

It's a good idea to use notifier to notify COLO frame of
inconsistent packets comparing.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 32 ++++++++++++++++++++++++++++----
 net/colo-compare.h |  2 ++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3adccfb..bb234dd 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -30,6 +30,7 @@
 #include "qapi-visit.h"
 #include "net/colo.h"
 #include "net/colo-compare.h"
+#include "migration/migration.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
@@ -38,6 +39,9 @@
 static QTAILQ_HEAD(, CompareState) net_compares =
        QTAILQ_HEAD_INITIALIZER(net_compares);
 
+static NotifierList colo_compare_notifiers =
+    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
+
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
@@ -384,6 +388,22 @@ static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
     }
 }
 
+static void colo_compare_inconsistent_notify(void)
+{
+    notifier_list_notify(&colo_compare_notifiers,
+                migrate_get_current());
+}
+
+void colo_compare_register_notifier(Notifier *notify)
+{
+    notifier_list_add(&colo_compare_notifiers, notify);
+}
+
+void colo_compare_unregister_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
 static void colo_old_packet_check_one_conn(void *opaque,
                                            void *user_data)
 {
@@ -397,7 +417,7 @@ static void colo_old_packet_check_one_conn(void *opaque,
 
     if (result) {
         /* do checkpoint will flush old packet */
-        /* TODO: colo_notify_checkpoint();*/
+        colo_compare_inconsistent_notify();
     }
 }
 
@@ -415,7 +435,10 @@ static void colo_old_packet_check(void *opaque)
 
 /*
  * Called from the compare thread on the primary
- * for compare connection
+ * for compare connection.
+ * TODO: Reconstruct this function, we should hold the max handled sequence
+ * of the connect, Don't trigger a checkpoint request if we only get packets
+ * from one side (primary or secondary).
  */
 static void colo_compare_connection(void *opaque, void *user_data)
 {
@@ -464,11 +487,12 @@ static void colo_compare_connection(void *opaque, void *user_data)
             /*
              * If one packet arrive late, the secondary_list or
              * primary_list will be empty, so we can't compare it
-             * until next comparison.
+             * until next comparison. If the packets in the list are
+             * timeout, it will trigger a checkpoint request.
              */
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
-            /* TODO: colo_notify_checkpoint();*/
+            colo_compare_inconsistent_notify();
             break;
         }
     }
diff --git a/net/colo-compare.h b/net/colo-compare.h
index c9c62f5..a0b573e 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -2,5 +2,7 @@
 #define QEMU_COLO_COMPARE_H
 
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
+void colo_compare_register_notifier(Notifier *notify);
+void colo_compare_unregister_notifier(Notifier *notify);
 
 #endif /* QEMU_COLO_COMPARE_H */
-- 
1.8.3.1
