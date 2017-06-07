Received: from eggs.gnu.org ([2001:4830:134:3::10]:53620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6G-0001u1-7k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6F-0005uz-DV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Jun 2017 19:50:14 +0200
Message-Id: <1496857819-12466-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] migration/block: Clean up BBs in
 block_save_complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

We need to release any block migrations BlockBackends on the source
before successfully completing the migration because otherwise
inactivating the images will fail (inactivation only tolerates device
BBs).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 migration/block.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 4d8c2e9..114cedb 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -674,16 +674,14 @@ static int64_t get_remaining_dirty(void)
     return dirty << BDRV_SECTOR_BITS;
 }
 
-/* Called with iothread lock taken.  */
 
-static void block_migration_cleanup(void *opaque)
+
+/* Called with iothread lock taken.  */
+static void block_migration_cleanup_bmds(void)
 {
     BlkMigDevState *bmds;
-    BlkMigBlock *blk;
     AioContext *ctx;
 
-    bdrv_drain_all();
-
     unset_dirty_tracking();
 
     while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
@@ -701,6 +699,16 @@ static void block_migration_cleanup(void *opaque)
         g_free(bmds->aio_bitmap);
         g_free(bmds);
     }
+}
+
+/* Called with iothread lock taken.  */
+static void block_migration_cleanup(void *opaque)
+{
+    BlkMigBlock *blk;
+
+    bdrv_drain_all();
+
+    block_migration_cleanup_bmds();
 
     blk_mig_lock();
     while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
@@ -844,6 +852,10 @@ static int block_save_complete(QEMUFile *f, void *opaque)
 
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
 
+    /* Make sure that our BlockBackends are gone, so that the block driver
+     * nodes can be inactivated. */
+    block_migration_cleanup_bmds();
+
     return 0;
 }
 
-- 
1.8.3.1
