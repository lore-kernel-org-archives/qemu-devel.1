Received: from eggs.gnu.org ([2001:4830:134:3::10]:42937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Ti-5u
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00021d-A5
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:06 +0300
Message-Id: <20180807174311.32454-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/7] qcow2: bdrv_co_pwritev: move encryption
 code out of lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

We don't need locking for encryption code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 41def07c67..65e3ca00e2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2039,6 +2039,15 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
         assert((cluster_offset & 511) == 0);
 
+        ret = qcow2_pre_write_overlap_check(bs, 0,
+                                            cluster_offset + offset_in_cluster,
+                                            cur_bytes);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
@@ -2072,30 +2081,25 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
+                qemu_co_mutex_lock(&s->lock);
                 goto fail;
             }
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         ret = qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
             goto fail;
-- 
2.11.1
