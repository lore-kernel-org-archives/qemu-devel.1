Received: from eggs.gnu.org ([2001:4830:134:3::10]:38153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsK1-0006Tu-4u
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJz-0001du-TF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:53 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:21:01 +0200
Message-Id: <20170613202107.10125-11-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/16] block/qcow2: Lock s->lock in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

preallocate() is and will be called only from places that do not
otherwise need to lock s->lock: Currently that is qcow2_create2(), as of
a future patch it will be called from qcow2_truncate(), too.

It therefore makes sense to move locking that mutex into preallocate()
itself.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7d201bb..c1aec07 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2045,12 +2045,17 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
 static int preallocate(BlockDriverState *bs,
                        uint64_t offset, uint64_t new_length)
 {
+    BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
 
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->lock);
+    }
+
     assert(offset <= new_length);
     bytes = new_length - offset;
 
@@ -2059,7 +2064,7 @@ static int preallocate(BlockDriverState *bs,
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
-            return ret;
+            goto done;
         }
 
         while (meta) {
@@ -2069,7 +2074,7 @@ static int preallocate(BlockDriverState *bs,
             if (ret < 0) {
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
-                return ret;
+                goto done;
             }
 
             /* There are no dependent requests, but we need to remove our
@@ -2096,11 +2101,17 @@ static int preallocate(BlockDriverState *bs,
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
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->lock);
+    }
+    return ret;
 }
 
 /* qcow2_refcount_metadata_size:
@@ -2389,10 +2400,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 
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
2.9.4
