Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSi-0005BT-7V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSd-0002w8-VI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:17 +0300
Message-Id: <20181001102928.20533-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 07/18] block/backup: allow use existent
 copy-bitmap
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

Allow use existent copy-bitmap to make it possible to synchronize with
externally created fleecing-hook filter which will be introduced soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ad143ea735..11aa31a323 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -53,6 +53,7 @@ typedef struct BackupBlockJob {
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
     BdrvDirtyBitmap *copy_bitmap;
+    bool copy_bitmap_created;
     bool use_copy_range;
     int64_t copy_range_size;
 
@@ -307,7 +308,7 @@ static void backup_clean(Job *job)
     blk_unref(s->target);
     s->target = NULL;
 
-    if (s->copy_bitmap) {
+    if (s->copy_bitmap_created) {
         bdrv_release_dirty_bitmap(blk_bs(s->common.blk), s->copy_bitmap);
         s->copy_bitmap = NULL;
     }
@@ -686,11 +687,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
 
-    if (!x_copy_bitmap) {
+    if (x_copy_bitmap) {
+        job->copy_bitmap = bdrv_find_dirty_bitmap(bs, x_copy_bitmap);
+    } else {
         x_copy_bitmap = gen_bitmap_name = id_generate(ID_BLOCK_BITMAP);
     }
-    job->copy_bitmap = bdrv_create_dirty_bitmap(bs, job->cluster_size,
-                                                x_copy_bitmap, errp);
+    if (!job->copy_bitmap) {
+        job->copy_bitmap = bdrv_create_dirty_bitmap(bs, job->cluster_size,
+                                                    x_copy_bitmap, errp);
+        job->copy_bitmap_created = !!job->copy_bitmap;
+    }
     g_free(gen_bitmap_name);
     if (!job->copy_bitmap) {
         goto error;
-- 
2.18.0
