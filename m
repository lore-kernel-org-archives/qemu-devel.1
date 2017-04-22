Received: from eggs.gnu.org ([2001:4830:134:3::10]:34319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXa-0001Rf-Lq
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXX-00045G-Ia
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3515
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXW-00042M-WA
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:11 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:20 +0800
Message-ID: <1492850128-17472-11-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 10/18] qmp event: Add COLO_EXIT event
 to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If some errors happen during VM's COLO FT stage, it's important to
notify the users of this event. Together with 'x_colo_lost_heartbeat',
Users can intervene in COLO's failover work immediately.
If users don't want to get involved in COLO's failover verdict,
it is still necessary to notify users that we exited COLO mode.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/colo.c | 19 +++++++++++++++++++
 qapi-schema.json | 14 ++++++++++++++
 qapi/event.json  | 21 +++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 9949293..e62da93 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -516,6 +516,18 @@ out:
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
@@ -757,6 +769,13 @@ out:
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
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b3e1b7..460ca53 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1233,6 +1233,20 @@
   'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
 
 ##
+# @COLOExitReason:
+#
+# The reason for a COLO exit
+#
+# @request: COLO exit is due to an external request
+#
+# @error: COLO exit is due to an internal error
+#
+# Since: 2.10
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'request', 'error' ] }
+
+##
 # @x-colo-lost-heartbeat:
 #
 # Tell qemu that heartbeat is lost, request it to do takeover procedures.
diff --git a/qapi/event.json b/qapi/event.json
index e80f3f4..924bc6f 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -441,6 +441,27 @@
   'data': { 'pass': 'int' } }
 
 ##
+# @COLO_EXIT:
+#
+# Emitted when VM finishes COLO mode due to some errors happening or
+# at the request of users.
+#
+# @mode: which COLO mode the VM was in when it exited.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 2.10
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
 # @ACPI_DEVICE_OST:
 #
 # Emitted when guest executes ACPI _OST method.
-- 
1.8.3.1
