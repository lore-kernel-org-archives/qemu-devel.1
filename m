Received: from eggs.gnu.org ([2001:4830:134:3::10]:58287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmztQ-0005mk-8B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmztM-00045V-H2
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:06:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 30 Aug 2017 18:06:05 +0800
Message-Id: <20170830100605.22694-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This fixes the assertion due to op blockers added by BMDS:

block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.

Reproducer: simply start block migration and quit QEMU before it ends.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                 | 2 ++
 migration/block.c       | 2 +-
 migration/block.h       | 1 +
 stubs/Makefile.objs     | 1 +
 stubs/block-migration.c | 6 ++++++
 5 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 stubs/block-migration.c

diff --git a/block.c b/block.c
index 3308814bba..508a57274d 100644
--- a/block.c
+++ b/block.c
@@ -43,6 +43,7 @@
 #include "qemu/cutils.h"
 #include "qemu/id.h"
 #include "qapi/util.h"
+#include "migration/block.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
@@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
 
 void bdrv_close_all(void)
 {
+    block_migration_cleanup_bmds();
     block_job_cancel_sync_all();
     nbd_export_close_all();
 
diff --git a/migration/block.c b/migration/block.c
index 9171f60028..c059e48484 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -673,7 +673,7 @@ static int64_t get_remaining_dirty(void)
 
 
 /* Called with iothread lock taken.  */
-static void block_migration_cleanup_bmds(void)
+void block_migration_cleanup_bmds(void)
 {
     BlkMigDevState *bmds;
     AioContext *ctx;
diff --git a/migration/block.h b/migration/block.h
index 22ebe94259..8bae1cf55a 100644
--- a/migration/block.h
+++ b/migration/block.h
@@ -42,4 +42,5 @@ static inline uint64_t blk_mig_bytes_total(void)
 #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
 
 void migrate_set_block_enabled(bool value, Error **errp);
+void block_migration_cleanup_bmds(void);
 #endif /* MIGRATION_BLOCK_H */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217aff..7540913767 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,6 +19,7 @@ stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
+stub-obj-y += block-migration.o
 stub-obj-y += change-state-handler.o
 stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
diff --git a/stubs/block-migration.c b/stubs/block-migration.c
new file mode 100644
index 0000000000..855f15c757
--- /dev/null
+++ b/stubs/block-migration.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "migration/block.h"
+
+void block_migration_cleanup_bmds(void)
+{
+}
-- 
2.13.5
