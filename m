Received: from eggs.gnu.org ([2001:4830:134:3::10]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0X-0004Ql-3Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0V-00076a-Or
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0V-00076A-Io
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33318401EF05
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 04:22:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:54 +0200
Message-Id: <20180604042156.13812-4-quintela@redhat.com>
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] migration: Don't activate block devices if
 using -S
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

Activating the block devices causes the locks to be taken on
the backing file.  If we're running with -S and the destination libvirt
hasn't started the destination with 'cont', it's expecting the locks are
still untaken.

Don't activate the block devices if we're not going to autostart the VM;
'cont' already will do that anyway.   This change is tied to the new
migration capability 'late-block-activate' that defaults to off, keeping
the old behaviour by default.

bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 34 +++++++++++++++++++++++++++-------
 qapi/migration.json   |  6 +++++-
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a5384865ff..1e99ec9b7e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -202,6 +202,16 @@ static void migrate_generate_event(int new_state)
     }
 }
 
+static bool migrate_late_block_activate(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[
+        MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE];
+}
+
 /*
  * Called on -incoming with a defer: uri.
  * The migration can be started later after any parameters have been
@@ -311,13 +321,23 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    /* Make sure all file formats flush their mutable metadata.
-     * If we get an error here, just don't restart the VM yet. */
-    bdrv_invalidate_cache_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        local_err = NULL;
-        autostart = false;
+    /* If capability late_block_activate is set:
+     * Only fire up the block code now if we're going to restart the
+     * VM, else 'cont' will do it.
+     * This causes file locking to happen; so we don't want it to happen
+     * unless we really are starting the VM.
+     */
+    if (!migrate_late_block_activate() ||
+         (autostart && (!global_state_received() ||
+            global_state_get_runstate() == RUN_STATE_RUNNING))) {
+        /* Make sure all file formats flush their mutable metadata.
+         * If we get an error here, just don't restart the VM yet. */
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+            autostart = false;
+        }
     }
 
     /*
diff --git a/qapi/migration.json b/qapi/migration.json
index dc9cc85545..f7e10ee90f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -376,13 +376,17 @@
 # @postcopy-blocktime: Calculate downtime for postcopy live migration
 #                     (since 3.0)
 #
+# @late-block-activate: If enabled, the destination will not activate block
+#           devices (and thus take locks) immediately at the end of migration.
+#           (since 3.0)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
            'block', 'return-path', 'pause-before-switchover', 'x-multifd',
-           'dirty-bitmaps', 'postcopy-blocktime' ] }
+           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.17.0
