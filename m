Received: from eggs.gnu.org ([2001:4830:134:3::10]:57958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fPLEb-0000Yq-I7
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fPLEa-00016I-GN
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:17 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:46814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fPLEa-00015Y-AX
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:16 -0400
Received: by mail-pl0-x235.google.com with SMTP id 30-v6so17638887pld.13
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 22:07:16 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun,  3 Jun 2018 13:05:44 +0800
Message-Id: <20180603050546.6827-16-zhangckid@gmail.com>
In-Reply-To: <20180603050546.6827-1-zhangckid@gmail.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V8 15/17] filter-rewriter: handle checkpoint
 and failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

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
index 442471e088..0bff21d9e5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/cpus.h"
+#include "net/filter.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -82,6 +83,11 @@ static void secondary_vm_do_failover(void)
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
@@ -800,6 +806,13 @@ void *colo_process_incoming_thread(void *opaque)
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
index 0909a9a8af..f3c306cc89 100644
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
2.17.GIT
