Received: from eggs.gnu.org ([209.51.188.92]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTm-0001eT-0k
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTk-0000VF-MC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:37 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Apr 2019 18:37:27 +0300
Message-Id: <20190402153730.54145-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

Background: decryption will be done in threads, to take benefit of it,
we should move it out of the lock first.

But let's go further: it turns out, that for locking around switch
cases we have only two variants: when we just do memset(0) not
releasing the lock (it is useless) and when we actually can handle the
whole case out of the lock. So, refactor the whole thing to reduce
locked code region and make it clean.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 46e8e39da5..fcf92a7eb6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 
         ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
         if (ret < 0) {
+            qemu_co_mutex_unlock(&s->lock);
             goto fail;
         }
 
@@ -1991,39 +1992,36 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
+        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
+            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
+            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        {
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
@@ -2056,11 +2054,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
 
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            qemu_co_mutex_unlock(&s->lock);
             ret = bdrv_co_preadv(s->data_file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -2091,12 +2087,14 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
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
