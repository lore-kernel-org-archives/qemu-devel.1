Received: from eggs.gnu.org ([2001:4830:134:3::10]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawf-0003Do-My
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawe-0000L0-J3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:44 -0600
Message-Id: <20180105225753.30509-12-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 11/20] qcow2: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qcow2 driver accordingly.

For now, we are ignoring the 'want_zero' hint.  However, it should
be relatively straightforward to honor the hint as a way to return
larger *pnum values when we have consecutive clusters with the same
data/zero status but which differ only in having non-consecutive
mappings.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v5-v7: no change
v4: update to interface tweak
v3: no change
v2: rebase to mapping flag
---
 block/qcow2.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c0c5..d0b4c38110 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1637,32 +1637,34 @@ static void qcow2_join_options(QDict *options, QDict *old_options)
     }
 }

-static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
+                                              bool want_zero,
+                                              int64_t offset, int64_t count,
+                                              int64_t *pnum, int64_t *map,
+                                              BlockDriverState **file)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t cluster_offset;
     int index_in_cluster, ret;
     unsigned int bytes;
-    int64_t status = 0;
+    int status = 0;

-    bytes = MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SIZE);
+    bytes = MIN(INT_MAX, count);
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_get_cluster_offset(bs, sector_num << BDRV_SECTOR_BITS, &bytes,
-                                   &cluster_offset);
+    ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
     }

-    *pnum = bytes >> BDRV_SECTOR_BITS;
+    *pnum = bytes;

     if (cluster_offset != 0 && ret != QCOW2_CLUSTER_COMPRESSED &&
         !s->crypto) {
-        index_in_cluster = sector_num & (s->cluster_sectors - 1);
-        cluster_offset |= (index_in_cluster << BDRV_SECTOR_BITS);
+        index_in_cluster = offset & (s->cluster_size - 1);
+        *map = cluster_offset | index_in_cluster;
         *file = bs->file->bs;
-        status |= BDRV_BLOCK_OFFSET_VALID | cluster_offset;
+        status |= BDRV_BLOCK_OFFSET_VALID;
     }
     if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
@@ -4320,7 +4322,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_child_perm      = bdrv_format_default_perms,
     .bdrv_create        = qcow2_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = qcow2_co_get_block_status,
+    .bdrv_co_block_status = qcow2_co_block_status,

     .bdrv_co_preadv         = qcow2_co_preadv,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
-- 
2.14.3
