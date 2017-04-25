Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xkJ-0000wh-4C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xkH-0004xQ-0m
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xkG-0004wx-Nc
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5AF47CFAD
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:30:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:30:48 +0200
Message-Id: <20170425103049.4073-3-quintela@redhat.com>
In-Reply-To: <20170425103049.4073-1-quintela@redhat.com>
References: <20170425103049.4073-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
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

We have change in the previous patch to use migration capabilities for
it.  Notice that we continue using the old command line flags from
migrate command from the time being.  Remove the set_params method as
now it is empty.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  3 +--
 migration/block.c             | 17 ++---------------
 migration/colo.c              |  3 ---
 migration/migration.c         |  8 +++++---
 migration/savevm.c            |  2 --
 5 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 618ab0e..2917baa 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -42,8 +42,7 @@
 extern int only_migratable;
 
 struct MigrationParams {
-    bool blk;
-    bool shared;
+    bool unused; /* C don't allow empty structs */
 };
 
 /* Messages sent on the return path from destination to source */
diff --git a/migration/block.c b/migration/block.c
index 060087f..fcfa823 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -94,9 +94,6 @@ typedef struct BlkMigBlock {
 } BlkMigBlock;
 
 typedef struct BlkMigState {
-    /* Written during setup phase.  Can be read without a lock.  */
-    int blk_enable;
-    int shared_base;
     QSIMPLEQ_HEAD(bmds_list, BlkMigDevState) bmds_list;
     int64_t total_sector_sum;
     bool zero_blocks;
@@ -425,7 +422,7 @@ static int init_blk_migration(QEMUFile *f)
         bmds->bulk_completed = 0;
         bmds->total_sectors = sectors;
         bmds->completed_sectors = 0;
-        bmds->shared_base = block_mig_state.shared_base;
+        bmds->shared_base = migrate_use_block_shared();
 
         assert(i < num_bs);
         bmds_bs[i].bmds = bmds;
@@ -994,22 +991,12 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
-static void block_set_params(const MigrationParams *params, void *opaque)
-{
-    block_mig_state.blk_enable = params->blk;
-    block_mig_state.shared_base = params->shared;
-
-    /* shared base means that blk_enable = 1 */
-    block_mig_state.blk_enable |= params->shared;
-}
-
 static bool block_is_active(void *opaque)
 {
-    return block_mig_state.blk_enable == 1;
+    return migrate_use_block_enabled();
 }
 
 static SaveVMHandlers savevm_block_handlers = {
-    .set_params = block_set_params,
     .save_live_setup = block_save_setup,
     .save_live_iterate = block_save_iterate,
     .save_live_complete_precopy = block_save_complete,
diff --git a/migration/colo.c b/migration/colo.c
index c19eb3f..5c6c2f0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -332,9 +332,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
-    /* Disable block migration */
-    s->params.blk = 0;
-    s->params.shared = 0;
     qemu_savevm_state_header(fb);
     qemu_savevm_state_begin(fb, &s->params);
     qemu_mutex_lock_iothread();
diff --git a/migration/migration.c b/migration/migration.c
index 775b24c..9b96f1a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -787,6 +787,10 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
         s->enabled_capabilities[cap->value->capability] = cap->value->state;
     }
 
+    if (s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED]) {
+        s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = true;
+    }
+
     if (migrate_postcopy_ram()) {
         if (migrate_use_compression()) {
             /* The decompression threads asynchronously write into RAM
@@ -1214,9 +1218,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationParams params;
     const char *p;
 
-    params.blk = has_blk && blk;
-    params.shared = has_inc && inc;
-
     if (migration_is_setup_or_active(s->state) ||
         s->state == MIGRATION_STATUS_CANCELLING ||
         s->state == MIGRATION_STATUS_COLO) {
@@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 
     if (has_inc && inc) {
+        migrate_set_block_enabled(s);
         migrate_set_block_shared(s);
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 0c01988..102b11d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1233,8 +1233,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 {
     int ret;
     MigrationParams params = {
-        .blk = 0,
-        .shared = 0
     };
     MigrationState *ms = migrate_init(&params);
     MigrationStatus status;
-- 
2.9.3
