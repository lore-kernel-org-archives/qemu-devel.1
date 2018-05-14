Received: from eggs.gnu.org ([2001:4830:134:3::10]:33536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGl3-0008Bj-4o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGky-0005lz-KA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:33 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:39941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIGky-0005lJ-Dk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:28 -0400
Received: by mail-pf0-x22d.google.com with SMTP id f189-v6so6306562pfa.7
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:55:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 15 May 2018 00:54:17 +0800
Message-Id: <20180514165424.12884-11-zhangckid@gmail.com>
In-Reply-To: <20180514165424.12884-1-zhangckid@gmail.com>
References: <20180514165424.12884-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 RESEND 10/17] qmp event: Add COLO_EXIT event
 to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

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
---
 migration/colo.c    | 20 ++++++++++++++++++++
 qapi/migration.json | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index c083d3696f..8ca63813c2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -28,6 +28,7 @@
 #include "net/colo-compare.h"
 #include "net/colo.h"
 #include "block/block.h"
+#include "qapi/qapi-events-migration.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -514,6 +515,18 @@ out:
         qemu_fclose(fb);
     }
 
+    /*
+     * There are only two reasons we can go here, some error happened.
+     * Or the user triggered failover.
+     */
+    if (failover_get_state() == FAILOVER_STATUS_NONE) {
+        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
+                                  COLO_EXIT_REASON_ERROR, NULL);
+    } else {
+        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
+                                  COLO_EXIT_REASON_REQUEST, NULL);
+    }
+
     /* Hope this not to be too long to wait here */
     qemu_sem_wait(&s->colo_exit_sem);
     qemu_sem_destroy(&s->colo_exit_sem);
@@ -744,6 +757,13 @@ out:
     if (local_err) {
         error_report_err(local_err);
     }
+    if (failover_get_state() == FAILOVER_STATUS_NONE) {
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_ERROR, NULL);
+    } else {
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_REQUEST, NULL);
+    }
 
     if (fb) {
         qemu_fclose(fb);
diff --git a/qapi/migration.json b/qapi/migration.json
index f3974c6807..55dae48089 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -874,6 +874,43 @@
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
+# Since: 2.13
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
+# @none: no failover has ever happened.
+#
+# @request: COLO exit is due to an external request
+#
+# @error: COLO exit is due to an internal error
+#
+# Since: 2.13
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'none', 'request', 'error' ] }
+
 ##
 # @x-colo-lost-heartbeat:
 #
-- 
2.17.0
