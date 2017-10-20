Received: from eggs.gnu.org ([2001:4830:134:3::10]:50824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TFt-0005ei-CK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TFs-0004C2-Do
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e5TFs-0004Bt-7k
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:12 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 20 Oct 2017 10:05:53 +0100
Message-Id: <20171020090556.18631-5-dgilbert@redhat.com>
In-Reply-To: <20171020090556.18631-1-dgilbert@redhat.com>
References: <20171020090556.18631-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/7] migration: migrate-continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A new qmp command allows the caller to continue from a given
paused state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 11 +++++++++++
 qapi/migration.json   | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 6c6d5e2c75..c9a3ee9efd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1368,6 +1368,17 @@ void qmp_migrate_cancel(Error **errp)
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
