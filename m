Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8L-0002pn-VI
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8I-0000k3-Pb
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:09 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fhK8I-0000jr-Iw
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:06 -0400
Received: by mail-pl0-x242.google.com with SMTP id m16-v6so7296054pls.11
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 12:35:06 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 23 Jul 2018 03:33:40 +0800
Message-Id: <20180722193350.6028-11-zhangckid@gmail.com>
In-Reply-To: <20180722193350.6028-1-zhangckid@gmail.com>
References: <20180722193350.6028-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V10 10/20] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
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

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

If some errors happen during VM's COLO FT stage, it's important to
notify the users of this event. Together with 'x-colo-lost-heartbeat',
Users can intervene in COLO's failover work immediately.
If users don't want to get involved in COLO's failover verdict,
it is still necessary to notify users that we exited COLO mode.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 migration/colo.c    | 31 +++++++++++++++++++++++++++++++
 qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index c083d3696f..ab484ad754 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -28,6 +28,7 @@
 #include "net/colo-compare.h"
 #include "net/colo.h"
 #include "block/block.h"
+#include "qapi/qapi-events-migration.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -514,6 +515,23 @@ out:
         qemu_fclose(fb);
     }
 
+    /*
+     * There are only two reasons we can get here, some error happened
+     * or the user triggered failover.
+     */
+    switch (failover_get_state()) {
+    case FAILOVER_STATUS_NONE:
+        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
+                                  COLO_EXIT_REASON_ERROR, NULL);
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
+                                  COLO_EXIT_REASON_REQUEST, NULL);
+        break;
+    default:
+        abort();
+    }
+
     /* Hope this not to be too long to wait here */
     qemu_sem_wait(&s->colo_exit_sem);
     qemu_sem_destroy(&s->colo_exit_sem);
@@ -745,6 +763,19 @@ out:
         error_report_err(local_err);
     }
 
+    switch (failover_get_state()) {
+    case FAILOVER_STATUS_NONE:
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_ERROR, NULL);
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_REQUEST, NULL);
+        break;
+    default:
+        abort();
+    }
+
     if (fb) {
         qemu_fclose(fb);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 186e8a7303..05f65680e1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -900,6 +900,44 @@
 { 'enum': 'FailoverStatus',
   'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
 
+##
+# @COLO_EXIT:
+#
+# Emitted when VM finishes COLO mode due to some errors happening or
+# at the request of users.
+#
+# @mode: report COLO mode when COLO exited.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 3.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
+#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
+#
+##
+{ 'event': 'COLO_EXIT',
+  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
+
+##
+# @COLOExitReason:
+#
+# The reason for a COLO exit
+#
+# @none: no failover has ever happened. This can't occur in the
+# COLO_EXIT event, only in the result of query-colo-status.
+#
+# @request: COLO exit is due to an external request
+#
+# @error: COLO exit is due to an internal error
+#
+# Since: 3.0
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'none', 'request', 'error' ] }
+
 ##
 # @x-colo-lost-heartbeat:
 #
-- 
2.17.1
