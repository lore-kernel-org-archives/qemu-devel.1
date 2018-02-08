Received: from eggs.gnu.org ([2001:4830:134:3::10]:37069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjUy-0006bF-Nh
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjUx-0005aV-No
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejjUx-0005aL-Ib
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:11 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu,  8 Feb 2018 18:31:15 +0800
Message-Id: <20180208103132.28452-12-peterx@redhat.com>
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
References: <20180208103132.28452-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 11/28] migration: pass MigrationState to
 migrate_init()
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

Let the callers take the object, then pass it to migrate_init().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 ++-----
 migration/migration.h | 2 +-
 migration/savevm.c    | 5 ++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dbcc3f6296..37b7170c20 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1260,10 +1260,8 @@ bool migration_is_idle(void)
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
@@ -1293,7 +1291,6 @@ MigrationState *migrate_init(void)
     s->vm_was_running = false;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
-    return s;
 }
 
 static GSList *migration_blockers;
@@ -1401,7 +1398,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         migrate_set_block_incremental(s, true);
     }
 
-    s = migrate_init();
+    migrate_init(s);
 
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/migration.h b/migration/migration.h
index c39e325615..9e3ddb0b06 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -202,7 +202,7 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-MigrationState *migrate_init(void);
+void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 5b1a0a7fe1..4a75e66aab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1256,8 +1256,11 @@ void qemu_savevm_state_cleanup(void)
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
