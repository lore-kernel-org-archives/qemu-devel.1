Received: from eggs.gnu.org ([2001:4830:134:3::10]:42061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl85-0001u9-Da
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl81-0004HV-VU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 19:43:16 +0300
Message-Id: <20181211164317.32893-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 7/8] qcow2: bdrv_co_pwritev: move encryption
 code out of the lock
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

Encryption will be done in threads, to take benefit of it, we should
move it out of the lock first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4e217ee918..941ccfa51a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2078,11 +2078,20 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &cluster_offset, &l2meta);
         if (ret < 0) {
-            goto fail;
+            goto out_locked;
         }
 
         assert((cluster_offset & 511) == 0);
 
+        ret = qcow2_pre_write_overlap_check(bs, 0,
+                                            cluster_offset + offset_in_cluster,
+                                            cur_bytes);
+        if (ret < 0) {
+            goto out_locked;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
@@ -2094,7 +2103,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                                    * s->cluster_size);
                 if (cluster_data == NULL) {
                     ret = -ENOMEM;
-                    goto fail;
+                    goto out_unlocked;
                 }
             }
 
@@ -2109,40 +2118,34 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                       cluster_data,
                                       cur_bytes, NULL) < 0) {
                 ret = -EIO;
-                goto fail;
+                goto out_unlocked;
             }
 
             qemu_iovec_reset(&hd_qiov);
             qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
         }
 
-        ret = qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes);
-        if (ret < 0) {
-            goto fail;
-        }
-
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regions.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret = bdrv_co_pwritev(bs->file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
-                goto fail;
+                goto out_unlocked;
             }
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         ret = qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
-            goto fail;
+            goto out_locked;
         }
 
         bytes -= cur_bytes;
@@ -2151,8 +2154,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
     ret = 0;
+    goto out_locked;
 
-fail:
+out_unlocked:
+    qemu_co_mutex_lock(&s->lock);
+
+out_locked:
     qcow2_handle_l2meta(bs, &l2meta, false);
 
     qemu_co_mutex_unlock(&s->lock);
-- 
2.18.0
