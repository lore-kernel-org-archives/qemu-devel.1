Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2l-0005k3-CM
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2k-0003w4-CU
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:48 -0500
Message-Id: <20170418013356.3578-24-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 23/31] qed: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qed driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qed.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index fd76817..336dae4 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -729,7 +729,7 @@ typedef struct {
     Coroutine *co;
     uint64_t pos;
     int64_t status;
-    int *pnum;
+    int64_t *pnum;
     BlockDriverState **file;
 } QEDIsAllocatedCB;

@@ -737,10 +737,10 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
 {
     QEDIsAllocatedCB *cb = opaque;
     BDRVQEDState *s = cb->bs->opaque;
-    *cb->pnum = len / BDRV_SECTOR_SIZE;
+    *cb->pnum = len;
     switch (ret) {
     case QED_CLUSTER_FOUND:
-        offset |= qed_offset_into_cluster(s, cb->pos);
+        offset |= qed_offset_into_cluster(s, cb->pos) & BDRV_BLOCK_OFFSET_VALID;
         cb->status = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | offset;
         *cb->file = cb->bs->file->bs;
         break;
@@ -762,23 +762,23 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
     }
 }

-static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
-                                                 int64_t sector_num,
-                                                 int nb_sectors, int *pnum,
-                                                 BlockDriverState **file)
+static int64_t coroutine_fn bdrv_qed_co_block_status(BlockDriverState *bs,
+                                                     int64_t offset,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     BlockDriverState **file)
 {
     BDRVQEDState *s = bs->opaque;
-    size_t len = (size_t)nb_sectors * BDRV_SECTOR_SIZE;
     QEDIsAllocatedCB cb = {
         .bs = bs,
-        .pos = (uint64_t)sector_num * BDRV_SECTOR_SIZE,
+        .pos = offset,
         .status = BDRV_BLOCK_OFFSET_MASK,
         .pnum = pnum,
         .file = file,
     };
     QEDRequest request = { .l2_table = NULL };

-    qed_find_cluster(s, &request, cb.pos, len, qed_is_allocated_cb, &cb);
+    qed_find_cluster(s, &request, cb.pos, bytes, qed_is_allocated_cb, &cb);

     /* Now sleep if the callback wasn't invoked immediately */
     while (cb.status == BDRV_BLOCK_OFFSET_MASK) {
@@ -1710,7 +1710,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
+    .bdrv_co_block_status     = bdrv_qed_co_block_status,
     .bdrv_aio_readv           = bdrv_qed_aio_readv,
     .bdrv_aio_writev          = bdrv_qed_aio_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-- 
2.9.3
