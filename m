Received: from eggs.gnu.org ([2001:4830:134:3::10]:45462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX7-0004I0-5H
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX3-0004CO-TG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX3-0003so-KC
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:21 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:10 +0800
Message-Id: <1539593186-32183-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 10/26] qmp event: Add COLO_EXIT event to notify
 users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

If some errors happen during VM's COLO FT stage, it's important to
notify the users of this event. Together with 'x-colo-lost-heartbeat',
Users can intervene in COLO's failover work immediately.
If users don't want to get involved in COLO's failover verdict,
it is still necessary to notify users that we exited COLO mode.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 migration/colo.c    | 31 +++++++++++++++++++++++++++++++
 qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index d3163b5..bd7390d 100644
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
+                                  COLO_EXIT_REASON_ERROR);
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
+                                  COLO_EXIT_REASON_REQUEST);
+        break;
+    default:
+        abort();
+    }
+
     /* Hope this not to be too long to wait here */
     qemu_sem_wait(&s->colo_exit_sem);
     qemu_sem_destroy(&s->colo_exit_sem);
@@ -746,6 +764,19 @@ out:
         error_report_err(local_err);
     }
 
+    switch (failover_get_state()) {
+    case FAILOVER_STATUS_NONE:
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_ERROR);
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
+                                  COLO_EXIT_REASON_REQUEST);
+        break;
+    default:
+        abort();
+    }
+
     if (fb) {
         qemu_fclose(fb);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 6e8c212..4a18209 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -957,6 +957,44 @@
   'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
 
 ##
+# @COLO_EXIT:
+#
+# Emitted when VM finishes COLO mode due to some errors happening or
+# at the request of users.
+#
+# @mode: report COLO mode when COLO exited.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 3.1
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
+# Since: 3.1
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'none', 'request', 'error' ] }
+
+##
 # @x-colo-lost-heartbeat:
 #
 # Tell qemu that heartbeat is lost, request it to do takeover procedures.
-- 
2.5.0
