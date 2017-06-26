Received: from eggs.gnu.org ([2001:4830:134:3::10]:41203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPRGV-0004vM-KY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPRGT-0002i9-2s
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPRGS-0002hM-Q0
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD6DD83F42
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 10:29:03 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Jun 2017 18:28:55 +0800
Message-Id: <1498472935-14461-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: add "return-path" capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

When this capability is enabled, QEMU will use the return path even for
precopy migration. This is helpful at least in one case when destination
failed to load the image while source quited without confirmation. With
return path, source will wait for the last response from destination,
and if destination fails, it'll fail the migration on source, then the
guest can be run again on the source (rather than assuming to be good,
then the guest will be lost after source quits).

It needs to be enabled explicitly on source, otherwise disabled.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 16 +++++++++++++---
 migration/migration.h |  1 +
 qapi-schema.json      |  5 ++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f588329..66fd81e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1304,6 +1304,15 @@ bool migrate_use_block(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK];
 }
 
+bool migrate_use_return_path(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
+}
+
 bool migrate_use_block_incremental(void)
 {
     MigrationState *s;
@@ -1968,10 +1977,11 @@ void migrate_fd_connect(MigrationState *s)
     notifier_list_notify(&migration_state_notifiers, s);
 
     /*
-     * Open the return path; currently for postcopy but other things might
-     * also want it.
+     * Open the return path. For postcopy, it is used exclusively. For
+     * precopy, only if user specified "return-path" capability would
+     * QEMU uses the return path.
      */
-    if (migrate_postcopy_ram()) {
+    if (migrate_postcopy_ram() || migrate_use_return_path()) {
         if (open_return_path_on_source(s)) {
             error_report("Unable to open return-path for postcopy");
             migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/migration.h b/migration/migration.h
index d9a268a..e41fb68 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -144,6 +144,7 @@ bool migrate_colo_enabled(void);
 
 bool migrate_use_block(void);
 bool migrate_use_block_incremental(void);
+bool migrate_use_return_path(void);
 
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b65..9e34cf7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -900,12 +900,15 @@
 #          offers more flexibility.
 #          (Since 2.10)
 #
+# @return-path: If enabled, migration will use the return path even
+#               for precopy. (since 2.10)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block' ] }
+           'block', 'return-path' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.7.4
