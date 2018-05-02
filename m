Received: from eggs.gnu.org ([2001:4830:134:3::10]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJs-00077a-PI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJp-000397-Ko
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJp-00038l-GG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:05 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:36 +0800
Message-Id: <20180502104740.12123-21-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 20/24] qmp/migration: new command
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The first allow-oob=true command.  It's used on destination side when
the postcopy migration is paused and ready for a recovery.  After
execution, a new migration channel will be established for postcopy to
continue.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   | 20 ++++++++++++++++++++
 migration/migration.h |  1 +
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/savevm.c    |  3 +++
 4 files changed, 48 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 25a6776af6..a1c2c238ab 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1191,3 +1191,23 @@
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
diff --git a/migration/migration.h b/migration/migration.h
index 2f0dc34ae9..012bcd352b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -77,6 +77,7 @@ struct MigrationIncomingState {
     struct PostcopyBlocktimeContext *blocktime_ctx;
 
     /* notify PAUSED postcopy incoming migrations to try to continue */
+    bool postcopy_recover_triggered;
     QemuSemaphore postcopy_pause_sem_dst;
     QemuSemaphore postcopy_pause_sem_fault;
 };
diff --git a/migration/migration.c b/migration/migration.c
index c059579fee..03d1fc7bc3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1470,6 +1470,30 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
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
+    if (atomic_cmpxchg(&mis->postcopy_recover_triggered,
+                       false, true) == true) {
+        error_setg(errp, "Migrate recovery is triggered already");
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
diff --git a/migration/savevm.c b/migration/savevm.c
index 8e7653badc..4251125831 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2190,6 +2190,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 {
     trace_postcopy_pause_incoming();
 
+    /* Clear the triggered bit to allow one recovery */
+    mis->postcopy_recover_triggered = false;
+
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                       MIGRATION_STATUS_POSTCOPY_PAUSED);
 
-- 
2.14.3
