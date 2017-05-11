Received: from eggs.gnu.org ([2001:4830:134:3::10]:55220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8r14-00062a-56
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8r12-0006dp-OP
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d8r12-0006dQ-En
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:32:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59DFDC05973F
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 16:32:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 11 May 2017 18:32:26 +0200
Message-Id: <20170511163228.6666-2-quintela@redhat.com>
In-Reply-To: <20170511163228.6666-1-quintela@redhat.com>
References: <20170511163228.6666-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities for
 shared and enable
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

Those two capabilities were added through the command line.  Notice that
we just created them.  This is just the boilerplate.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

--

Make migrate_set_block_* take a boolean argument.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/block.h     |  3 +++
 include/migration/migration.h |  3 +++
 migration/migration.c         | 36 ++++++++++++++++++++++++++++++++++++
 qapi-schema.json              |  7 ++++++-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/migration/block.h b/include/migration/block.h
index 41a1ac8..5b3f1a5 100644
--- a/include/migration/block.h
+++ b/include/migration/block.h
@@ -20,4 +20,7 @@ uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
+void migrate_set_block_shared(MigrationState *s, bool value);
+void migrate_set_block_enabled(MigrationState *s, bool value);
+
 #endif /* MIGRATION_BLOCK_H */
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 0c9b6af..30c2913 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -305,6 +305,9 @@ bool migrate_colo_enabled(void);
 
 int64_t xbzrle_cache_resize(int64_t new_size);
 
+bool migrate_use_block_enabled(void);
+bool migrate_use_block_shared(void);
+
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
diff --git a/migration/migration.c b/migration/migration.c
index fe62f15..2f981aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1195,6 +1195,16 @@ bool migration_is_blocked(Error **errp)
     return false;
 }
 
+void migrate_set_block_shared(MigrationState *s, bool value)
+{
+    s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
+}
+
+void migrate_set_block_enabled(MigrationState *s, bool value)
+{
+    s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = value;
+}
+
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  Error **errp)
@@ -1224,6 +1234,14 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 
     s = migrate_init(&params);
 
+    if (has_blk && blk) {
+        migrate_set_block_enabled(s, true);
+    }
+
+    if (has_inc && inc) {
+        migrate_set_block_shared(s, true);
+    }
+
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -1419,6 +1437,24 @@ int64_t migrate_xbzrle_cache_size(void)
     return s->xbzrle_cache_size;
 }
 
+bool migrate_use_block_enabled(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED];
+}
+
+bool migrate_use_block_shared(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED];
+}
+
 /* migration thread support */
 /*
  * Something bad happened to the RP stream, mark an error
diff --git a/qapi-schema.json b/qapi-schema.json
index 5728b7f..109852e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -894,11 +894,16 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
 #        during postcopy-ram migration. (since 2.9)
 #
+# @block-enabled: enable block migration (Since 2.10)
+#
+# @block-shared: enable block shared migration (Since 2.10)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
+           'block-enabled', 'block-shared' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.9.3
