Received: from eggs.gnu.org ([2001:4830:134:3::10]:42944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Tn-88
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00022I-JI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:10 +0300
Message-Id: <20180807174311.32454-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/7] qcow2: refactor qcow2_co_pwritev locals
 scope
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

Move local variables related to individual loop iteration into while
block.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4d669432d1..88b3fb8080 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2294,10 +2294,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    int offset_in_cluster;
     int ret;
-    unsigned int cur_bytes; /* number of sectors in current iteration */
-    uint64_t cluster_offset;
     QEMUIOVector hd_qiov;
     uint64_t bytes_done = 0;
     uint8_t *cluster_data = NULL;
@@ -2312,12 +2309,14 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     qemu_co_mutex_lock(&s->lock);
 
     while (bytes != 0) {
+        int offset_in_cluster = offset_into_cluster(s, offset);
+        unsigned int cur_bytes = MIN(bytes, INT_MAX); /* number of sectors in
+                                                         current iteration */
+        uint64_t cluster_offset;
 
         l2meta = NULL;
 
         trace_qcow2_writev_start_part(qemu_coroutine_self());
-        offset_in_cluster = offset_into_cluster(s, offset);
-        cur_bytes = MIN(bytes, INT_MAX);
         if (bs->encrypted) {
             cur_bytes = MIN(cur_bytes,
                             QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size
-- 
2.11.1
