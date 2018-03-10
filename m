Received: from eggs.gnu.org ([2001:4830:134:3::10]:48398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulwt-0002EN-D8
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulwr-0003K2-T9
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:39 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulwr-0003Jc-Mp
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:37 -0500
Received: by mail-pf0-x243.google.com with SMTP id a16so2716640pfn.9
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:22:37 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:21:53 +0800
Message-Id: <1520716927-17068-4-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 03/17] colo-compare: use notifier to notify
 packets comparing result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

It's a good idea to use notifier to notify COLO frame of
inconsistent packets comparing.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 32 +++++++++++++++++++++++++-------
 net/colo-compare.h |  2 ++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ff3ae8..05061cd 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,6 +29,7 @@
 #include "sysemu/iothread.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
+#include "migration/migration.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
@@ -37,6 +38,9 @@
 static QTAILQ_HEAD(, CompareState) net_compares =
        QTAILQ_HEAD_INITIALIZER(net_compares);
 
+static NotifierList colo_compare_notifiers =
+    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
+
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
@@ -561,8 +565,24 @@ static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
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
 static int colo_old_packet_check_one_conn(Connection *conn,
-                                          void *user_data)
+                                           void *user_data)
 {
     GList *result = NULL;
     int64_t check_time = REGULAR_PACKET_CHECK_MS;
@@ -573,10 +593,7 @@ static int colo_old_packet_check_one_conn(Connection *conn,
 
     if (result) {
         /* Do checkpoint will flush old packet */
-        /*
-         * TODO: Notify colo frame to do checkpoint.
-         * colo_compare_inconsistent_notify();
-         */
+        colo_compare_inconsistent_notify();
         return 0;
     }
 
@@ -620,11 +637,12 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
             /*
              * If one packet arrive late, the secondary_list or
              * primary_list will be empty, so we can't compare it
-             * until next comparison.
+             * until next comparison. If the packets in the list are
+             * timeout, it will trigger a checkpoint request.
              */
             trace_colo_compare_main("packet different");
             g_queue_push_head(&conn->primary_list, pkt);
-            /* TODO: colo_notify_checkpoint();*/
+            colo_compare_inconsistent_notify();
             break;
         }
     }
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 1b1ce76..22ddd51 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -18,5 +18,7 @@
 #define QEMU_COLO_COMPARE_H
 
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
+void colo_compare_register_notifier(Notifier *notify);
+void colo_compare_unregister_notifier(Notifier *notify);
 
 #endif /* QEMU_COLO_COMPARE_H */
-- 
2.7.4
