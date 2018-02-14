Received: from eggs.gnu.org ([2001:4830:134:3::10]:54010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA7-0008Nh-Ql
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA5-00079h-F6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elzA5-000795-2E
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:57 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:38 +0000
Message-Id: <20180214153938.5410-11-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] migration: pass MigrationState to
 migrate_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: Peter Xu <peterx@redhat.com>

Let the callers take the object, then pass it to migrate_init().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180208103132.28452-12-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 7 ++-----
 migration/migration.h | 2 +-
 migration/savevm.c    | 5 ++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 913f658c3e..0aa596f867 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1258,10 +1258,8 @@ bool migration_is_idle(void)
     return false;
 }
 
-MigrationState *migrate_init(void)
+void migrate_init(MigrationState *s)
 {
-    MigrationState *s = migrate_get_current();
-
     /*
      * Reinitialise all migration state, except
      * parameters/capabilities that the user set, and
@@ -1291,7 +1289,6 @@ MigrationState *migrate_init(void)
     s->vm_was_running = false;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
-    return s;
 }
 
 static GSList *migration_blockers;
@@ -1399,7 +1396,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         migrate_set_block_incremental(s, true);
     }
 
-    s = migrate_init();
+    migrate_init(s);
 
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/migration.h b/migration/migration.h
index f515b8994f..82cf926b17 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -193,7 +193,7 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-MigrationState *migrate_init(void);
+void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 967c3bca0d..8e6d872452 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1257,8 +1257,11 @@ void qemu_savevm_state_cleanup(void)
 static int qemu_savevm_state(QEMUFile *f, Error **errp)
 {
     int ret;
-    MigrationState *ms = migrate_init();
+    MigrationState *ms = migrate_get_current();
     MigrationStatus status;
+
+    migrate_init(ms);
+
     ms->to_dst_file = f;
 
     if (migration_is_blocked(errp)) {
-- 
2.14.3
