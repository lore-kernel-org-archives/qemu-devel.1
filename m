Received: from eggs.gnu.org ([2001:4830:134:3::10]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxg-00037N-3b
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxf-0003Sj-4z
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:28 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulxe-0003SZ-V3
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:27 -0500
Received: by mail-pl0-x241.google.com with SMTP id w12-v6so7169350plp.4
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:23:26 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:22:05 +0800
Message-Id: <1520716927-17068-16-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 15/17] filter-rewriter: handle checkpoint
 and failover event
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

After one round of checkpoint, the states between PVM and SVM
become consistent, so it is unnecessary to adjust the sequence
of net packets for old connections, besides, while failover
happens, filter-rewriter needs to check if it still needs to
adjust sequence of net packets.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 migration/colo.c      | 13 +++++++++++++
 net/filter-rewriter.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 1633aed..6834f3d 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -30,6 +30,7 @@
 #include "block/block.h"
 #include "qapi/qapi-events-migration.h"
 #include "sysemu/cpus.h"
+#include "net/filter.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -81,6 +82,11 @@ static void secondary_vm_do_failover(void)
     if (local_err) {
         error_report_err(local_err);
     }
+    /* Notify all filters of all NIC to do checkpoint */
+    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 
     if (!autostart) {
         error_report("\"-S\" qemu option will be ignored in secondary side");
@@ -787,6 +793,13 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        /* Notify all filters of all NIC to do checkpoint */
+        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+
         vmstate_loading = false;
         vm_start();
         trace_colo_vm_state_change("stop", "run");
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 0909a9a..f3c306c 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -20,6 +20,8 @@
 #include "qemu/main-loop.h"
 #include "qemu/iov.h"
 #include "net/checksum.h"
+#include "net/colo.h"
+#include "migration/colo.h"
 
 #define FILTER_COLO_REWRITER(obj) \
     OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
@@ -277,6 +279,43 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
     return 0;
 }
 
+static void reset_seq_offset(gpointer key, gpointer value, gpointer user_data)
+{
+    Connection *conn = (Connection *)value;
+
+    conn->offset = 0;
+}
+
+static gboolean offset_is_nonzero(gpointer key,
+                                  gpointer value,
+                                  gpointer user_data)
+{
+    Connection *conn = (Connection *)value;
+
+    return conn->offset ? true : false;
+}
+
+static void colo_rewriter_handle_event(NetFilterState *nf, int event,
+                                       Error **errp)
+{
+    RewriterState *rs = FILTER_COLO_REWRITER(nf);
+
+    switch (event) {
+    case COLO_EVENT_CHECKPOINT:
+        g_hash_table_foreach(rs->connection_track_table,
+                            reset_seq_offset, NULL);
+        break;
+    case COLO_EVENT_FAILOVER:
+        if (!g_hash_table_find(rs->connection_track_table,
+                              offset_is_nonzero, NULL)) {
+            object_property_set_str(OBJECT(nf), "off", "status", errp);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 static void colo_rewriter_cleanup(NetFilterState *nf)
 {
     RewriterState *s = FILTER_COLO_REWRITER(nf);
@@ -332,6 +371,7 @@ static void colo_rewriter_class_init(ObjectClass *oc, void *data)
     nfc->setup = colo_rewriter_setup;
     nfc->cleanup = colo_rewriter_cleanup;
     nfc->receive_iov = colo_rewriter_receive_iov;
+    nfc->handle_event = colo_rewriter_handle_event;
 }
 
 static const TypeInfo colo_rewriter_info = {
-- 
2.7.4
