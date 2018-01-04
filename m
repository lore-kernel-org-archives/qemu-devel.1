Received: from eggs.gnu.org ([2001:4830:134:3::10]:36998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybc-0003rI-8r
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybZ-0004IX-5c
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:20 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:33498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybY-0004I4-WF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:17 -0500
Received: by mail-pg0-x22c.google.com with SMTP id i196so344207pgd.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:16 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:09 +0800
Message-Id: <1515045675-6993-11-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 10/16] qmp event: Add COLO_EXIT event
 to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

If some errors happen during VM's COLO FT stage, it's important to
notify the users of this event. Together with 'x_colo_lost_heartbeat',
Users can intervene in COLO's failover work immediately.
If users don't want to get involved in COLO's failover verdict,
it is still necessary to notify users that we exited COLO mode.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/colo.c    | 19 +++++++++++++++++++
 qapi-schema.json    | 21 +++++++++++++++++++++
 qapi/migration.json | 13 +++++++++++++
 3 files changed, 53 insertions(+)

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
diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745..4ff6d2c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2921,6 +2921,27 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
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
+# Since: 2.11
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
diff --git a/qapi/migration.json b/qapi/migration.json
index 03f57c9..f7b2cc6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -854,6 +854,19 @@
 ##
 { 'enum': 'FailoverStatus',
   'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
+##
+# @COLOExitReason:
+#
+# The reason for a COLO exit
+#
+# @request: COLO exit is due to an external request
+#
+# @error: COLO exit is due to an internal error
+#
+# Since: 2.11
+##
+{ 'enum': 'COLOExitReason',
+  'data': [ 'request', 'error' ] }
 
 ##
 # @x-colo-lost-heartbeat:
-- 
2.7.4
