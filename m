Received: from eggs.gnu.org ([2001:4830:134:3::10]:51113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM774-0008H1-OH
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM773-0003cm-T2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:53:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM773-0003c7-NO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:53:53 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 14:52:50 +0800
Message-Id: <20171205065307.21853-12-peterx@redhat.com>
In-Reply-To: <20171205065307.21853-1-peterx@redhat.com>
References: <20171205065307.21853-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/28] migration: pass MigrationState to
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let the callers take the object, then pass it to migrate_init().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 ++-----
 migration/migration.h | 2 +-
 migration/savevm.c    | 5 ++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ad4cbfc820..96b3c25505 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1265,10 +1265,8 @@ bool migration_is_idle(void)
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
@@ -1294,7 +1292,6 @@ MigrationState *migrate_init(void)
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
     s->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    return s;
 }
 
 static GSList *migration_blockers;
@@ -1402,7 +1399,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
index ee03fb5c32..0dda7ca2b4 100644
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
