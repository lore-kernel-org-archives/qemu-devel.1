Received: from eggs.gnu.org ([2001:4830:134:3::10]:34465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4Ym-0001Ht-Ux
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4Ym-0000R8-1h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 18:09:30 +0200
Message-Id: <20170403160936.28293-11-mreitz@redhat.com>
In-Reply-To: <20170403160936.28293-1-mreitz@redhat.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 10/16] block/qcow2: Lock s->lock in
 preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

preallocate() is and will be called only from places that do not lock
s->lock: Currently that is qcow2_create2(), as of a future patch it will
be called from qcow2_truncate(), too.

It therefore makes sense to move locking that mutex into preallocate()
itself.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 163d51ec65..f665cd21dc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2043,12 +2043,15 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
  */
 static int preallocate(BlockDriverState *bs, int64_t offset, int64_t new_length)
 {
+    BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
 
+    qemu_co_mutex_lock(&s->lock);
+
     assert(offset <= new_length);
     bytes = new_length - offset;
 
@@ -2057,7 +2060,7 @@ static int preallocate(BlockDriverState *bs, int64_t offset, int64_t new_length)
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
-            return ret;
+            goto done;
         }
 
         while (meta) {
@@ -2067,7 +2070,7 @@ static int preallocate(BlockDriverState *bs, int64_t offset, int64_t new_length)
             if (ret < 0) {
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
-                return ret;
+                goto done;
             }
 
             /* There are no dependent requests, but we need to remove our
@@ -2094,11 +2097,15 @@ static int preallocate(BlockDriverState *bs, int64_t offset, int64_t new_length)
         ret = bdrv_pwrite(bs->file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
-            return ret;
+            goto done;
         }
     }
 
-    return 0;
+    ret = 0;
+
+done:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
 }
 
 static int qcow2_create2(const char *filename, int64_t total_size,
@@ -2318,10 +2325,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 
     /* And if we're supposed to preallocate metadata, do that now */
     if (prealloc != PREALLOC_MODE_OFF) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
-        qemu_co_mutex_lock(&s->lock);
         ret = preallocate(blk_bs(blk), 0, total_size);
-        qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not preallocate metadata");
             goto out;
-- 
2.12.1
