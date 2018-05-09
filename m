Received: from eggs.gnu.org ([2001:4830:134:3::10]:58858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDZ-00053r-Ha
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDY-0001tq-IC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDY-0001tJ-DD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 140DB8D6DA
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:25:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:24:01 +0200
Message-Id: <20180509112406.6183-37-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 36/41] migration/qmp: add command migrate-pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

It pauses an ongoing migration.  Currently it only supports postcopy.
Note that this command will work on either side of the migration.
Basically when we trigger this on one side, it'll interrupt the other
side as well since the other side will get notified on the disconnect
event.

However, it's still possible that the other side is not notified, for
example, when the network is totally broken, or due to some firewall
configuration changes.  In that case, we will also need to run the same
command on the other side so both sides will go into the paused state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-24-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 29 +++++++++++++++++++++++++++++
 qapi/migration.json   | 16 ++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 3deded90e5..05aec2c905 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1507,6 +1507,35 @@ void qmp_migrate_recover(const char *uri, Error **errp)
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
diff --git a/qapi/migration.json b/qapi/migration.json
index ec739cbd04..7e9283c613 100644
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
-- 
2.17.0
