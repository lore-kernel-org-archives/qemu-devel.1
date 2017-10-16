Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zIF-0001yI-BF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zIC-0003bb-4O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zIB-0003Zp-To
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:28 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2017 14:52:15 +0800
Message-Id: <20171016065216.18162-32-peterx@redhat.com>
In-Reply-To: <20171016065216.18162-1-peterx@redhat.com>
References: <20171016065216.18162-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 31/32] migration,
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It is used to manually trigger the postcopy pause state.  It works just
like when we found the migration stream failed during postcopy, but
provide an explicit way for user in case of misterious socket hangs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 ++++++++++++++++++
 qapi/migration.json   | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 51e771685c..3d852d233f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1426,6 +1426,24 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
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
index f8132e683a..095aeb4dd2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1028,6 +1028,28 @@
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
+# Since: 2.10
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
2.13.5
