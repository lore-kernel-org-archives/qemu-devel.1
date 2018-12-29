Received: from eggs.gnu.org ([208.118.235.92]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDv0-0002vb-9Z
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDcG-00083h-GF
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:21:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Dec 2018 15:20:26 +0300
Message-Id: <20181229122027.42245-11-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-1-vsementsov@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 10/11] block/backup: tiny refactor
 backup_job_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

Move copy-bitmap find/create code. It's needed for the following
commit, as we'll need copy_bitmap before actual block job creation. Do
it in a separate commit to simplify review.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 69 +++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 0b3fddeb6c..88c0242b4e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -561,6 +561,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
     int ret;
+    int64_t cluster_size;
+    HBitmap *copy_bitmap = NULL;
 
     assert(bs);
     assert(target);
@@ -615,6 +617,35 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    /*
+     * If there is no backing file on the target, we cannot rely on COW if our
+     * backup cluster size is smaller than the target cluster size. Even for
+     * targets with a backing file, try to avoid COW if possible.
+     */
+    ret = bdrv_get_info(target, &bdi);
+    if (ret == -ENOTSUP && !target->backing) {
+        /* Cluster size is not defined */
+        warn_report("The target block device doesn't provide "
+                    "information about the block size and it doesn't have a "
+                    "backing file. The default block size of %u bytes is "
+                    "used. If the actual block size of the target exceeds "
+                    "this default, the backup may be unusable",
+                    BACKUP_CLUSTER_SIZE_DEFAULT);
+        cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else if (ret < 0 && !target->backing) {
+        error_setg_errno(errp, -ret,
+            "Couldn't determine the cluster size of the target image, "
+            "which has no backing file");
+        error_append_hint(errp,
+            "Aborting, since this may create an unusable destination image\n");
+        return NULL;
+    } else if (ret < 0 && target->backing) {
+        /* Not fatal; just trudge on ahead. */
+        cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else {
+        cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+    }
+
     len = bdrv_getlength(bs);
     if (len < 0) {
         error_setg_errno(errp, -len, "unable to get length for '%s'",
@@ -622,6 +653,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
+    copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
+
     /* job->len is fixed, so we can't allow resize */
     job = block_job_create(job_id, &backup_job_driver, txn, bs,
                            BLK_PERM_CONSISTENT_READ,
@@ -650,35 +683,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     /* Detect image-fleecing (and similar) schemes */
     job->serialize_target_writes = bdrv_chain_contains(target, bs);
-
-    /* If there is no backing file on the target, we cannot rely on COW if our
-     * backup cluster size is smaller than the target cluster size. Even for
-     * targets with a backing file, try to avoid COW if possible. */
-    ret = bdrv_get_info(target, &bdi);
-    if (ret == -ENOTSUP && !target->backing) {
-        /* Cluster size is not defined */
-        warn_report("The target block device doesn't provide "
-                    "information about the block size and it doesn't have a "
-                    "backing file. The default block size of %u bytes is "
-                    "used. If the actual block size of the target exceeds "
-                    "this default, the backup may be unusable",
-                    BACKUP_CLUSTER_SIZE_DEFAULT);
-        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
-        error_setg_errno(errp, -ret,
-            "Couldn't determine the cluster size of the target image, "
-            "which has no backing file");
-        error_append_hint(errp,
-            "Aborting, since this may create an unusable destination image\n");
-        goto error;
-    } else if (ret < 0 && target->backing) {
-        /* Not fatal; just trudge on ahead. */
-        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else {
-        job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
-    }
-
-    job->copy_bitmap = hbitmap_alloc(len, ctz32(job->cluster_size));
+    job->cluster_size = cluster_size;
+    job->copy_bitmap = copy_bitmap;
+    copy_bitmap = NULL;
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
@@ -694,6 +701,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     return &job->common;
 
  error:
+    if (copy_bitmap) {
+        assert(!job || !job->copy_bitmap);
+        hbitmap_free(copy_bitmap);
+    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
-- 
2.18.0
