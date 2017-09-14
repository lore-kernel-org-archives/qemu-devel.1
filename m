Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKb-00065G-7q
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKW-0002mg-KF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 09:40:23 -0500
Message-Id: <20170914144032.14945-12-eblake@redhat.com>
In-Reply-To: <20170914144032.14945-1-eblake@redhat.com>
References: <20170914144032.14945-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/20] qcow2: Switch to
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qcow2 driver accordingly.

For now, we are ignoring the 'mapping' hint.  However, it should
be relatively straightforward to honor the hint as a way to return
larger *pnum values when we have consecutive clusters with the same
data/zero status but which differ only in having non-consecutive
mappings.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping flag
---
 block/qcow2.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 721cb077fe..de5f737681 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1624,8 +1624,12 @@ static void qcow2_join_options(QDict *options, QDict *old_options)
     }
 }

-static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int64_t coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
+                                                  bool mapping,
+                                                  int64_t offset,
+                                                  int64_t count,
+                                                  int64_t *pnum,
+                                                  BlockDriverState **file)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t cluster_offset;
@@ -1633,21 +1637,20 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
     unsigned int bytes;
     int64_t status = 0;

-    bytes = MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SIZE);
+    bytes = MIN(INT_MAX, count);
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
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
+        cluster_offset |= (index_in_cluster & BDRV_BLOCK_OFFSET_MASK);
         *file = bs->file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID | cluster_offset;
     }
@@ -4259,7 +4262,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_child_perm      = bdrv_format_default_perms,
     .bdrv_create        = qcow2_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = qcow2_co_get_block_status,
+    .bdrv_co_block_status = qcow2_co_block_status,

     .bdrv_co_preadv         = qcow2_co_preadv,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
-- 
2.13.5
