Received: from eggs.gnu.org ([2001:4830:134:3::10]:59309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvgT-0006YW-TU
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvgQ-0000tF-Ra
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:21 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvgQ-0000so-LT
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:18 -0400
Received: by mail-pf0-x242.google.com with SMTP id h11so3039964pfn.4
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:46:18 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:45:08 +0800
Message-Id: <1520754314-5969-13-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V6 11/17] qapi: Add new command to query colo
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Libvirt or other high level software can use this command query colo status.
You can test this command like that:
{'execute':'query-colo-status'}

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 migration/colo.c    | 31 +++++++++++++++++++++++++++++++
 qapi/migration.json | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8ca6381..127db3c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -237,6 +237,37 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
 #endif
 }
 
+COLOStatus *qmp_query_colo_status(Error **errp)
+{
+    MigrationState *m;
+    MigrationIncomingState *mis;
+    COLOStatus *s = g_new0(COLOStatus, 1);
+
+    if (get_colo_mode() == COLO_MODE_PRIMARY) {
+        m = migrate_get_current();
+
+        if (m->state == MIGRATION_STATUS_COLO) {
+            s->colo_running = true;
+        } else {
+            s->colo_running = false;
+        }
+        s->mode = COLO_MODE_PRIMARY;
+    } else {
+        mis = migration_incoming_get_current();
+
+        if (mis->state == MIGRATION_STATUS_COLO) {
+            s->colo_running = true;
+        } else {
+            s->colo_running = false;
+        }
+        s->mode = COLO_MODE_SECONDARY;
+    }
+
+    s->reason = failover_get_state();
+
+    return s;
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi/migration.json b/qapi/migration.json
index 6c6c50e..8ccdd21 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1201,3 +1201,36 @@
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
+# @colo-running: if true means COLO running well, otherwise COLO have done.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 2.12
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
+# Since: 2.12
+##
+{ 'command': 'query-colo-status',
+  'returns': 'COLOStatus' }
-- 
2.7.4
