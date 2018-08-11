Received: from eggs.gnu.org ([2001:4830:134:3::10]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1foazJ-0004NX-Pk
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 16:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1foazI-000155-T5
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 16:59:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:35824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1foazI-00014j-Mp
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 16:59:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id w10-v6so5872207pgv.2
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 13:59:52 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 12 Aug 2018 04:59:07 +0800
Message-Id: <20180811205924.4113-4-zhangckid@gmail.com>
In-Reply-To: <20180811205924.4113-1-zhangckid@gmail.com>
References: <20180811205924.4113-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V11 03/20] colo-compare: use notifier to notify
 packets comparing result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

It's a good idea to use notifier to notify COLO frame of
inconsistent packets comparing.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 37 ++++++++++++++++++++++++++-----------
 net/colo-compare.h |  2 ++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 80e6532e8b..426eab5973 100644
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
 
@@ -427,10 +431,7 @@ sec:
         qemu_hexdump((char *)spkt->data, stderr,
                      "colo-compare spkt", spkt->size);
 
-        /*
-         * colo_compare_inconsistent_notify();
-         * TODO: notice to checkpoint();
-         */
+        colo_compare_inconsistency_notify();
     }
 }
 
@@ -561,8 +562,24 @@ static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
     }
 }
 
+static void colo_compare_inconsistency_notify(void)
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
@@ -573,10 +590,7 @@ static int colo_old_packet_check_one_conn(Connection *conn,
 
     if (result) {
         /* Do checkpoint will flush old packet */
-        /*
-         * TODO: Notify colo frame to do checkpoint.
-         * colo_compare_inconsistent_notify();
-         */
+        colo_compare_inconsistency_notify();
         return 0;
     }
 
@@ -620,11 +634,12 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
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
+            colo_compare_inconsistency_notify();
             break;
         }
     }
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 1b1ce76aea..22ddd512e2 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -18,5 +18,7 @@
 #define QEMU_COLO_COMPARE_H
 
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
+void colo_compare_register_notifier(Notifier *notify);
+void colo_compare_unregister_notifier(Notifier *notify);
 
 #endif /* QEMU_COLO_COMPARE_H */
-- 
2.17.GIT
