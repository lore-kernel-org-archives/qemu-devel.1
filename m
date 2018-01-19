Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX0J-0003xh-Dc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX0F-0003La-2E
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:47 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1ecX0E-0003LK-TC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:42 -0500
Received: by mail-pg0-x244.google.com with SMTP id q67so1458676pga.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:46:42 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 19 Jan 2018 21:44:39 +0800
Message-Id: <1516369485-5374-11-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V4 10/16] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
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
 migration/colo.c    | 19 +++++++++++++++++++
 qapi/migration.json | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8d2e3f8..790b122 100644
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
@@ -746,6 +758,13 @@ out:
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
index 70e7b67..6fc95b7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -869,6 +869,41 @@
   'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
 
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
+# Since: 2.12
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
+# @request: COLO exit is due to an external request
+#
+# @error: COLO exit is due to an internal error
+#
+# Since: 2.12
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'request', 'error' ] }
+
+##
 # @x-colo-lost-heartbeat:
 #
 # Tell qemu that heartbeat is lost, request it to do takeover procedures.
-- 
2.7.4
