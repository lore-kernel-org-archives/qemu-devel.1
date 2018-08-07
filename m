Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Tg-5B
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60q-000216-Vq
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:05 +0300
Message-Id: <20180807174311.32454-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/7] qcow2: move qemu_co_mutex_lock below
 decryption procedure
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

From: "Denis V. Lunev" <den@openvz.org>

We are not working with a shared state data in the decruption code and
thus this operation is safe. On the other hand this significantly
reduces the scope of the lock.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..41def07c67 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1880,9 +1880,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             break;
 
         case QCOW2_CLUSTER_NORMAL:
+            qemu_co_mutex_unlock(&s->lock);
+
             if ((cluster_offset & 511) != 0) {
                 ret = -EIO;
-                goto fail;
+                goto fail_nolock;
             }
 
             if (bs->encrypted) {
@@ -1899,7 +1901,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                             * s->cluster_size);
                     if (cluster_data == NULL) {
                         ret = -ENOMEM;
-                        goto fail;
+                        goto fail_nolock;
                     }
                 }
 
@@ -1909,13 +1911,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
 
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            qemu_co_mutex_unlock(&s->lock);
             ret = bdrv_co_preadv(bs->file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
-                goto fail;
+                goto fail_nolock;
             }
             if (bs->encrypted) {
                 assert(s->crypto);
@@ -1929,10 +1929,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                           cur_bytes,
                                           NULL) < 0) {
                     ret = -EIO;
-                    goto fail;
+                    goto fail_nolock;
                 }
                 qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_bytes);
             }
+            qemu_co_mutex_lock(&s->lock);
             break;
 
         default:
@@ -1950,6 +1951,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 fail:
     qemu_co_mutex_unlock(&s->lock);
 
+fail_nolock:
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
 
-- 
2.11.1
