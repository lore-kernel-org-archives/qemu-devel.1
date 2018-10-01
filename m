Received: from eggs.gnu.org ([2001:4830:134:3::10]:40628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSi-0005BR-6A
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSd-0002wD-Vd
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:27 +0300
Message-Id: <20181001102928.20533-18-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 17/18] block/backup: tiny refactor
 backup_job_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Move copy-bitmap find/create code. It's needed for the following
commit, as we'll need copy_bitmap before actual block job creation. Do
it in a separate commit to simplify review.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 95 +++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 11aa31a323..6cab54dea4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -570,6 +570,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     BackupBlockJob *job = NULL;
     int ret;
     char *gen_bitmap_name = NULL;
+    int64_t cluster_size;
+    BdrvDirtyBitmap *copy_bitmap = NULL;
+    bool copy_bitmap_created = false;
 
     assert(bs);
     assert(target);
@@ -624,6 +627,48 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    /* If there is no backing file on the target, we cannot rely on COW if our
+     * backup cluster size is smaller than the target cluster size. Even for
+     * targets with a backing file, try to avoid COW if possible. */
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
+    if (x_copy_bitmap) {
+        copy_bitmap = bdrv_find_dirty_bitmap(bs, x_copy_bitmap);
+    } else {
+        x_copy_bitmap = gen_bitmap_name = id_generate(ID_BLOCK_BITMAP);
+    }
+    if (!copy_bitmap) {
+        copy_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size,
+                                               x_copy_bitmap, errp);
+        copy_bitmap_created = !!copy_bitmap;
+    }
+    g_free(gen_bitmap_name);
+    if (!copy_bitmap) {
+        return NULL;
+    }
+
     len = bdrv_getlength(bs);
     if (len < 0) {
         error_setg_errno(errp, -len, "unable to get length for '%s'",
@@ -659,49 +704,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
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
-    if (x_copy_bitmap) {
-        job->copy_bitmap = bdrv_find_dirty_bitmap(bs, x_copy_bitmap);
-    } else {
-        x_copy_bitmap = gen_bitmap_name = id_generate(ID_BLOCK_BITMAP);
-    }
-    if (!job->copy_bitmap) {
-        job->copy_bitmap = bdrv_create_dirty_bitmap(bs, job->cluster_size,
-                                                    x_copy_bitmap, errp);
-        job->copy_bitmap_created = !!job->copy_bitmap;
-    }
-    g_free(gen_bitmap_name);
-    if (!job->copy_bitmap) {
-        goto error;
-    }
-
+    job->cluster_size = cluster_size;
+    job->copy_bitmap = copy_bitmap;
+    job->copy_bitmap_created = copy_bitmap_created;
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
@@ -717,6 +722,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     return &job->common;
 
  error:
+    if (copy_bitmap_created) {
+        assert(!job || !job->copy_bitmap_created);
+        bdrv_release_dirty_bitmap(bs, copy_bitmap);
+    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
-- 
2.18.0
