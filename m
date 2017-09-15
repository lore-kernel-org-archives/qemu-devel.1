Received: from eggs.gnu.org ([2001:4830:134:3::10]:50397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQJ-0000Zn-V7
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQJ-0007O9-24
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 13:44:03 +0800
Message-Id: <20170915054404.19914-3-famz@redhat.com>
In-Reply-To: <20170915054404.19914-1-famz@redhat.com>
References: <20170915054404.19914-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: Cancel migration at exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com

bdrv_close_all() would abort() due to op blockers added by BMDS, clean
up migration states when main loop quits to avoid that.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 ++++++-
 vl.c                     | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c079b7771b..b9a26b0898 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,5 +54,6 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
+void migrate_cancel(void);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 959e8ec88e..2c844945c7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1274,11 +1274,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 }
 
-void qmp_migrate_cancel(Error **errp)
+void migrate_cancel(void)
 {
     migrate_fd_cancel(migrate_get_current());
 }
 
+void qmp_migrate_cancel(Error **errp)
+{
+    migrate_cancel();
+}
+
 void qmp_migrate_set_cache_size(int64_t value, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/vl.c b/vl.c
index fb1f05b937..abbe61f40b 100644
--- a/vl.c
+++ b/vl.c
@@ -87,6 +87,7 @@ int main(int argc, char **argv)
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "migration/misc.h"
+#include "migration/savevm.h"
 #include "migration/snapshot.h"
 #include "migration/global_state.h"
 #include "sysemu/tpm.h"
@@ -4799,6 +4800,8 @@ int main(int argc, char **argv, char **envp)
     iothread_stop_all();
 
     pause_all_vcpus();
+    migrate_cancel();
+    qemu_savevm_state_cleanup();
     bdrv_close_all();
     res_free();
 
-- 
2.13.5
