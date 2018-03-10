Received: from eggs.gnu.org ([2001:4830:134:3::10]:48575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxQ-0002jj-2z
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxP-0003Ps-6V
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:12 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulxP-0003Pn-0b
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:11 -0500
Received: by mail-pg0-x244.google.com with SMTP id g12so4943331pgs.0
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:23:10 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:22:01 +0800
Message-Id: <1520716927-17068-12-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 11/17] qapi: Add new command to query colo
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

Libvirt or other high level sofware can use this command query colo status.
You can test this command like that:
{'execute':'query-colo-status'}

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 migration/colo.c    | 35 +++++++++++++++++++++++++++++++++++
 qapi/migration.json | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8ca6381..b4243ab 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -237,6 +237,41 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
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
+        s->mode = true;
+    } else {
+        mis = migration_incoming_get_current();
+
+        if (mis->state == MIGRATION_STATUS_COLO) {
+            s->colo_running = true;
+        } else {
+            s->colo_running = false;
+        }
+        s->mode = false;
+    }
+
+    if (failover_get_state() == FAILOVER_STATUS_NONE) {
+        s->reason = true;
+    } else {
+        s->reason = false;
+    }
+
+    return s;
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi/migration.json b/qapi/migration.json
index 6c6c50e..8f81f36 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1201,3 +1201,38 @@
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
+#        true is primary mode, false is secondary mode.
+#
+# @colo_running: if true means COLO running well, otherwise COLO have done.
+#
+# @reason: describes the reason for the COLO exit.
+#          true is error, false is user request.
+#
+# Since: 2.12
+##
+{ 'struct': 'COLOStatus',
+  'data': { 'mode': 'bool', 'colo_running': 'bool', 'reason': 'bool' } }
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
+# <- { "return": { "colo_running": "true", "mode": "true", "reason": "true" } }
+#
+# Since: 2.12
+##
+{ 'command': 'query-colo-status',
+  'returns': 'COLOStatus' }
-- 
2.7.4
