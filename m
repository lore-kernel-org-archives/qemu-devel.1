Received: from eggs.gnu.org ([2001:4830:134:3::10]:47370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI6WX-0006dK-OR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI46i-0000Uc-NS
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:05 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:45501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fI46i-0000Te-Hm
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:04 -0400
Received: by mail-pg0-x22a.google.com with SMTP id w3-v6so4844595pgv.12
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 20:25:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 14 May 2018 11:23:42 +0800
Message-Id: <1526268228-27951-12-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 11/17] qapi: Add new command to query colo
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

Libvirt or other high level software can use this command query colo status.
You can test this command like that:
{'execute':'query-colo-status'}

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 migration/colo.c    | 34 ++++++++++++++++++++++++++++++++++
 qapi/migration.json | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8ca6381..314344c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -29,6 +29,7 @@
 #include "net/colo.h"
 #include "block/block.h"
 #include "qapi/qapi-events-migration.h"
+#include "qapi/qmp/qerror.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -237,6 +238,39 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
 #endif
 }
 
+COLOStatus *qmp_query_colo_status(Error **errp)
+{
+    int state;
+    COLOStatus *s = g_new0(COLOStatus, 1);
+
+    if (get_colo_mode() == COLO_MODE_UNKNOWN) {
+        error_setg(errp, QERR_FEATURE_DISABLED, "colo");
+        s->colo_running = false;
+        goto out;
+    } else if (get_colo_mode() == COLO_MODE_PRIMARY) {
+         state = migrate_get_current()->state;
+    } else {
+         state = migration_incoming_get_current()->state;
+    }
+    s->colo_running = state == MIGRATION_STATUS_COLO;
+
+out:
+    s->mode = get_colo_mode();
+
+    switch (failover_get_state()) {
+    case FAILOVER_STATUS_NONE:
+        s->reason = COLO_EXIT_REASON_NONE;
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        s->reason = COLO_EXIT_REASON_REQUEST;
+        break;
+    default:
+        s->reason = COLO_EXIT_REASON_ERROR;
+    }
+
+    return s;
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi/migration.json b/qapi/migration.json
index 55dae48..13589ba 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1220,3 +1220,36 @@
 # Since: 2.9
 ##
 { 'command': 'xen-colo-do-checkpoint' }
+
+##
+# @COLOStatus:
+#
+# The result format for 'query-colo-status'.
+#
+# @mode: which COLO mode the VM was in when it exited.
+#
+# @colo-running: true if COLO is running.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 2.13
+##
+{ 'struct': 'COLOStatus',
+  'data': { 'mode': 'COLOMode', 'colo-running': 'bool', 'reason': 'COLOExitReason' } }
+
+##
+# @query-colo-status:
+#
+# Query COLO status while the vm is running.
+#
+# Returns: A @COLOStatus object showing the status.
+#
+# Example:
+#
+# -> { "execute": "query-colo-status" }
+# <- { "return": { "mode": "primary", "colo-running": true, "reason": "request" } }
+#
+# Since: 2.13
+##
+{ 'command': 'query-colo-status',
+  'returns': 'COLOStatus' }
-- 
2.7.4
