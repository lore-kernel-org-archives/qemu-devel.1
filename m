Received: from eggs.gnu.org ([2001:4830:134:3::10]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHD-0005cm-Te
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHC-000053-V8
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHC-0008VT-P4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E04404A700
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:48 +0200
Message-Id: <20171023160800.20540-10-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/21] migration: migrate-continue
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A new qmp command allows the caller to continue from a given
paused state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 11 +++++++++++
 qapi/migration.json   | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index ef84d2c1fb..90bfdc3a7c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1374,6 +1374,17 @@ void qmp_migrate_cancel(Error **errp)
     migrate_fd_cancel(migrate_get_current());
 }
 
+void qmp_migrate_continue(MigrationStatus state, Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    if (s->state != state) {
+        error_setg(errp,  "Migration not in expected state: %s",
+                   MigrationStatus_str(s->state));
+        return;
+    }
+    qemu_sem_post(&s->pause_sem);
+}
+
 void qmp_migrate_set_cache_size(int64_t value, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/qapi/migration.json b/qapi/migration.json
index b56f95db64..272f191551 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -877,6 +877,23 @@
 { 'command': 'migrate_cancel' }
 
 ##
+# @migrate-continue:
+#
+# Continue migration when it's in a paused state.
+#
+# @state: The state the migration is currently expected to be in
+#
+# Returns: nothing on success
+# Since: 2.11
+# Example:
+#
+# -> { "execute": "migrate-continue" , "arguments":
+#      { "state": "pre-switchover" } }
+# <- { "return": {} }
+##
+{ 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
+
+##
 # @migrate_set_downtime:
 #
 # Set maximum tolerated downtime for migration.
-- 
2.13.6
