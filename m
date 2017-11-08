Received: from eggs.gnu.org ([2001:4830:134:3::10]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZk-0006wn-1L
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00016K-3K
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZi-00014u-Sn
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:29 +0800
Message-Id: <20171108060130.3772-32-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 31/32] migration,
 qmp: new command "migrate-pause"
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

It is used to manually trigger the postcopy pause state.  It works just
like when we found the migration stream failed during postcopy, but
provide an explicit way for user in case of misterious socket hangs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 ++++++++++++++++++
 qapi/migration.json   | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 536a771803..30348a5e27 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1485,6 +1485,24 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
     once = false;
 }
 
+void qmp_migrate_pause(Error **errp)
+{
+    int ret;
+    MigrationState *ms = migrate_get_current();
+
+    if (ms->state != MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        error_setg(errp, "Migration pause is currently only allowed during"
+                   " an active postcopy phase.");
+        return;
+    }
+
+    ret = qemu_file_shutdown(ms->to_dst_file);
+
+    if (ret) {
+        error_setg(errp, "Failed to pause migration stream.");
+    }
+}
+
 bool migration_is_blocked(Error **errp)
 {
     if (qemu_savevm_state_blocked(errp)) {
diff --git a/qapi/migration.json b/qapi/migration.json
index 4a3eff62f1..52901f7e2e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1074,6 +1074,28 @@
 { 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
 
 ##
+# @migrate-pause:
+#
+# Pause an migration.  Currently it can only pause a postcopy
+# migration.  Pausing a precopy migration is not supported yet.
+#
+# It is mostly used as a manual way to trigger the postcopy paused
+# state when the network sockets hang due to some reason, so that we
+# can try a recovery afterward.
+#
+# Returns: nothing on success
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "migrate-pause" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'migrate-pause' }
+
+##
 # @xen-save-devices-state:
 #
 # Save the state of all devices to file. The RAM and the block devices
-- 
2.13.6
