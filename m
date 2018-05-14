Received: from eggs.gnu.org ([2001:4830:134:3::10]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGl4-0008D4-G4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGl3-0005qU-O8
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:34 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIGl3-0005oh-IC
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:33 -0400
Received: by mail-pg0-x241.google.com with SMTP id p9-v6so5731580pgc.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:55:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 15 May 2018 00:54:18 +0800
Message-Id: <20180514165424.12884-12-zhangckid@gmail.com>
In-Reply-To: <20180514165424.12884-1-zhangckid@gmail.com>
References: <20180514165424.12884-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 RESEND 11/17] qapi: Add new command to query
 colo status
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
index 8ca63813c2..cdff0a2490 100644
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
+        state = migrate_get_current()->state;
+    } else {
+        state = migration_incoming_get_current()->state;
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
index 55dae48089..13589ba948 100644
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
2.17.0
