Received: from eggs.gnu.org ([2001:4830:134:3::10]:35849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRR-0008Gx-G3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRQ-0006bx-J1
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJRQ-0006af-Dt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:09 +0800
Message-Id: <20171108060130.3772-12-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/32] migration: pass MigrationState to
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
index b080440143..bf1bdd09da 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1269,10 +1269,8 @@ bool migration_is_idle(void)
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
@@ -1300,7 +1298,6 @@ MigrationState *migrate_init(void)
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
     s->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    return s;
 }
 
 static GSList *migration_blockers;
@@ -1408,7 +1405,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         migrate_set_block_incremental(s, true);
     }
 
-    s = migrate_init();
+    migrate_init(s);
 
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/migration.h b/migration/migration.h
index 2751b2dffc..d052669e1c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -180,7 +180,7 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
 
-MigrationState *migrate_init(void);
+void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 86ada6d0e7..6d6f8ee3e4 100644
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
2.13.6
