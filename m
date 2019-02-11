Received: from eggs.gnu.org ([209.51.188.92]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpK-0001Fa-T3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpK-0000ry-17
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:54 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 17:44:19 +0300
Message-Id: <20190211144421.106232-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190211144421.106232-1-vsementsov@virtuozzo.com>
References: <20190211144421.106232-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 7/9] qcow2: qcow2_co_preadv: skip using
 hd_qiov when possible
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

qemu_iovec_memset has @offset parameter, so using hd_qiov for it is not
needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 29be900555..3f39ec0c05 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1888,16 +1888,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
-        offset_in_cluster = offset_into_cluster(s, offset);
-
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
-
         if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
             ret == QCOW2_CLUSTER_ZERO_ALLOC ||
             (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
         {
-            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+            qemu_iovec_memset(qiov, bytes_done, 0, cur_bytes);
 
             bytes -= cur_bytes;
             offset += cur_bytes;
@@ -1905,6 +1900,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             continue;
         }
 
+        offset_in_cluster = offset_into_cluster(s, offset);
+
+        qemu_iovec_reset(&hd_qiov);
+        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
+
         qemu_co_mutex_unlock(&s->lock);
 
         switch (ret) {
-- 
2.18.0
