Received: from eggs.gnu.org ([2001:4830:134:3::10]:35224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpK1-0007GC-Rb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpK0-0003Fo-Uc
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpK0-0003FI-Mn
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:39 +0800
Message-Id: <20180502104740.12123-24-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 23/24] migration/qmp: add command
 migrate-pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It pauses an ongoing migration.  Currently it only supports postcopy.
Note that this command will work on either side of the migration.
Basically when we trigger this on one side, it'll interrupt the other
side as well since the other side will get notified on the disconnect
event.

However, it's still possible that the other side is not notified, for
example, when the network is totally broken, or due to some firewall
configuration changes.  In that case, we will also need to run the same
command on the other side so both sides will go into the paused state.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   | 16 ++++++++++++++++
 migration/migration.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index a1c2c238ab..bf403d2dd2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1211,3 +1211,19 @@
 ##
 { 'command': 'migrate-recover', 'data': { 'uri': 'str' },
   'allow-oob': true }
+
+##
+# @migrate-pause:
+#
+# Pause a migration.  Currently it only supports postcopy.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "migrate-pause" }
+# <- { "return": {} }
+#
+# Since: 2.12
+##
+{ 'command': 'migrate-pause', 'allow-oob': true }
diff --git a/migration/migration.c b/migration/migration.c
index 25f26052d2..03e4950976 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1502,6 +1502,35 @@ void qmp_migrate_recover(const char *uri, Error **errp)
     qemu_start_incoming_migration(uri, errp);
 }
 
+void qmp_migrate_pause(Error **errp)
+{
+    MigrationState *ms = migrate_get_current();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    int ret;
+
+    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        /* Source side, during postcopy */
+        qemu_mutex_lock(&ms->qemu_file_lock);
+        ret = qemu_file_shutdown(ms->to_dst_file);
+        qemu_mutex_unlock(&ms->qemu_file_lock);
+        if (ret) {
+            error_setg(errp, "Failed to pause source migration");
+        }
+        return;
+    }
+
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        ret = qemu_file_shutdown(mis->from_src_file);
+        if (ret) {
+            error_setg(errp, "Failed to pause destination migration");
+        }
+        return;
+    }
+
+    error_setg(errp, "migrate-pause is currently only supported "
+               "during postcopy-active state");
+}
+
 bool migration_is_blocked(Error **errp)
 {
     if (qemu_savevm_state_blocked(errp)) {
-- 
2.14.3
