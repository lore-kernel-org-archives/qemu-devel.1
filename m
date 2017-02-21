Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvU-0001R2-V8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvP-0008To-7u
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:43 +0100
Message-Id: <1487689130-30373-48-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 47/54] migration/block: Use real permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Request BLK_PERM_CONSISTENT_READ for the source of block migration, and
handle potential permission errors as good as we can in this place
(which is not very good, but it matches the other failure cases).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/block.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index d259936..958d0fc 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -379,7 +379,7 @@ static void unset_dirty_tracking(void)
     }
 }
 
-static void init_blk_migration(QEMUFile *f)
+static int init_blk_migration(QEMUFile *f)
 {
     BlockDriverState *bs;
     BlkMigDevState *bmds;
@@ -390,6 +390,8 @@ static void init_blk_migration(QEMUFile *f)
         BlkMigDevState *bmds;
         BlockDriverState *bs;
     } *bmds_bs;
+    Error *local_err = NULL;
+    int ret;
 
     block_mig_state.submitted = 0;
     block_mig_state.read_done = 0;
@@ -411,12 +413,12 @@ static void init_blk_migration(QEMUFile *f)
 
         sectors = bdrv_nb_sectors(bs);
         if (sectors <= 0) {
+            ret = sectors;
             goto out;
         }
 
         bmds = g_new0(BlkMigDevState, 1);
-        /* FIXME Use real permissions */
-        bmds->blk = blk_new(0, BLK_PERM_ALL);
+        bmds->blk = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
         bmds->blk_name = g_strdup(bdrv_get_device_name(bs));
         bmds->bulk_completed = 0;
         bmds->total_sectors = sectors;
@@ -446,7 +448,11 @@ static void init_blk_migration(QEMUFile *f)
         BlockDriverState *bs = bmds_bs[i].bs;
 
         if (bmds) {
-            blk_insert_bs(bmds->blk, bs, &error_abort);
+            ret = blk_insert_bs(bmds->blk, bs, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+                goto out;
+            }
 
             alloc_aio_bitmap(bmds);
             error_setg(&bmds->blocker, "block device is in use by migration");
@@ -454,8 +460,10 @@ static void init_blk_migration(QEMUFile *f)
         }
     }
 
+    ret = 0;
 out:
     g_free(bmds_bs);
+    return ret;
 }
 
 /* Called with no lock taken.  */
@@ -706,7 +714,10 @@ static int block_save_setup(QEMUFile *f, void *opaque)
             block_mig_state.submitted, block_mig_state.transferred);
 
     qemu_mutex_lock_iothread();
-    init_blk_migration(f);
+    ret = init_blk_migration(f);
+    if (ret < 0) {
+        return ret;
+    }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
-- 
1.8.3.1
