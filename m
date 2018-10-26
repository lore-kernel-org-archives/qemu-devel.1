Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gFxsm-0002KM-7P
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gFxsh-0004ek-J5
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:54:16 -0400
Received: from mx22.baidu.com ([220.181.50.185]:38255 helo=baidu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gFxsh-0004bv-6T
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:54:11 -0400
From: Jia Lina <jialina01@baidu.com>
Date: Fri, 26 Oct 2018 16:36:20 +0800
Message-ID: <20181026083620.10172-1-jialina01@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] migration: avoid segmentfault when take a
 snapshot of a VM which being migrated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Jia Lina <jialina01@baidu.com>, Chai Wen <chaiwen@baidu.com>, Zhang Yu <zhangyu31@baidu.com>

During an active background migration, snapshot will trigger a
segmentfault. As snapshot clears the "current_migration" struct
and updates "to_dst_file" before it finds out that there is a
migration task, Migration accesses the null pointer in
"current_migration" struct and qemu crashes eventually.

Signed-off-by: Jia Lina <jialina01@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 migration/migration.c |  2 +-
 migration/migration.h |  2 ++
 migration/savevm.c    | 19 +++++++++++--------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d6ae879dc8..b5e71c7bfc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -711,7 +711,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
  */
-static bool migration_is_setup_or_active(int state)
+bool migration_is_setup_or_active(int state)
 {
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
diff --git a/migration/migration.h b/migration/migration.h
index f7813f8261..e413d4d8b6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -241,6 +241,8 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
+bool migration_is_setup_or_active(int state);
+
 void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
diff --git a/migration/savevm.c b/migration/savevm.c
index 2d10e45582..eeade8cb92 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1319,21 +1319,25 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationState *ms = migrate_get_current();
     MigrationStatus status;
 
-    migrate_init(ms);
-
-    ms->to_dst_file = f;
+    if (migration_is_setup_or_active(ms->state) ||
+        ms->state == MIGRATION_STATUS_CANCELLING ||
+        ms->state == MIGRATION_STATUS_COLO) {
+        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        return -EINVAL;
+    }
 
     if (migration_is_blocked(errp)) {
-        ret = -EINVAL;
-        goto done;
+        return -EINVAL;
     }
 
     if (migrate_use_block()) {
         error_setg(errp, "Block migration and snapshots are incompatible");
-        ret = -EINVAL;
-        goto done;
+        return -EINVAL;
     }
 
+    migrate_init(ms);
+    ms->to_dst_file = f;
+
     qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
@@ -1355,7 +1359,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
 
-done:
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
     } else {
-- 
2.13.2.windows.1
