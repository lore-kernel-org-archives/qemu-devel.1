Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjj-00083N-O0
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002CU-KM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:08 +0300
Message-Id: <20181123165511.416480-9-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 08/11] qcow2: bdrv_co_preadv: improve locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Background: decryption will be done in threads, to take benefit of it,
we should move it out of the lock first.

But let's go further: it turns out, that for locking around switch
cases we have only two variants: when we just do memset(0) not
releasing the lock (it is useless) and when we actually can handle the
whole case out of the lock. So, refactor the whole thing to reduce
locked code region and make it clean.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1e28f17373..5467089cfe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1924,6 +1924,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 
         ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
         if (ret < 0) {
+            qemu_co_mutex_unlock(&s->lock);
             goto fail;
         }
 
@@ -1932,39 +1933,38 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
+        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
+            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
+            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        {
+            /* No sense in releasing the lock */
+
+            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+
+            bytes -= cur_bytes;
+            offset += cur_bytes;
+            bytes_done += cur_bytes;
+            continue;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
-
-            if (bs->backing) {
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                qemu_co_mutex_unlock(&s->lock);
-                ret = bdrv_co_preadv(bs->backing, offset, cur_bytes,
-                                     &hd_qiov, 0);
-                qemu_co_mutex_lock(&s->lock);
-                if (ret < 0) {
-                    goto fail;
-                }
-            } else {
-                /* Note: in this case, no need to wait */
-                qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+            BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+            ret = bdrv_co_preadv(bs->backing, offset, cur_bytes, &hd_qiov, 0);
+            if (ret < 0) {
+                goto fail;
             }
             break;
 
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_ZERO_ALLOC:
-            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
-            break;
-
         case QCOW2_CLUSTER_COMPRESSED:
-            qemu_co_mutex_unlock(&s->lock);
             ret = qcow2_co_preadv_compressed(bs, cluster_offset,
                                              offset, cur_bytes,
                                              &hd_qiov);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
-
             break;
 
         case QCOW2_CLUSTER_NORMAL:
@@ -1997,11 +1997,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
 
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            qemu_co_mutex_unlock(&s->lock);
             ret = bdrv_co_preadv(bs->file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -2032,12 +2030,14 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         bytes -= cur_bytes;
         offset += cur_bytes;
         bytes_done += cur_bytes;
+
+        qemu_co_mutex_lock(&s->lock);
     }
     ret = 0;
 
-fail:
     qemu_co_mutex_unlock(&s->lock);
 
+fail:
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
 
-- 
2.18.0
