Received: from eggs.gnu.org ([2001:4830:134:3::10]:51765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM786-0000nT-Cy
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM783-00044C-9y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:54:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM783-00043o-4O
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:54:55 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 14:53:06 +0800
Message-Id: <20171205065307.21853-28-peterx@redhat.com>
In-Reply-To: <20171205065307.21853-1-peterx@redhat.com>
References: <20171205065307.21853-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 27/28] qmp/migration: new command
 migrate-recover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The first allow-oob=true command.  It's used on destination side when
the postcopy migration is paused and ready for a recovery.  After
execution, a new migration channel will be established for postcopy to
continue.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 ++++++++++++++++++
 qapi/migration.json   | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 0c1a783df2..b37c4ef669 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1423,6 +1423,24 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
     once = false;
 }
 
+void qmp_migrate_recover(const char *uri, Error **errp)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        error_setg(errp, "Migrate recover can only be run "
+                   "when postcopy is paused.");
+        return;
+    }
+
+    /*
+     * Note that this call will never start a real migration; it will
+     * only re-setup the migration stream and poke existing migration
+     * to continue using that newly established channel.
+     */
+    qemu_start_incoming_migration(uri, errp);
+}
+
 bool migration_is_blocked(Error **errp)
 {
     if (qemu_savevm_state_blocked(errp)) {
diff --git a/qapi/migration.json b/qapi/migration.json
index e15bb516cd..9fcf980750 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1173,3 +1173,23 @@
 # Since: 2.9
 ##
 { 'command': 'xen-colo-do-checkpoint' }
+
+##
+# @migrate-recover:
+#
+# Provide a recovery migration stream URI.
+#
+# @uri: the URI to be used for the recovery of migration stream.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "migrate-recover",
+#      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
+# <- { "return": {} }
+#
+# Since: 2.12
+##
+{ 'command': 'migrate-recover', 'data': { 'uri': 'str' },
+  'allow-oob': true }
-- 
2.14.3
