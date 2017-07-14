Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVa-0003y8-FX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVZ-00044I-C9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:46 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:49 -0500
Message-Id: <20170714121457.10322-13-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/20] qed: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qed driver accordingly.  There is no intent
to optimize based on the mapping flag for this format.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping flag, fix mask in qed_is_allocated_cb
---
 block/qed.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 86cad21..a80195c 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -677,7 +677,7 @@ typedef struct {
     Coroutine *co;
     uint64_t pos;
     int64_t status;
-    int *pnum;
+    int64_t *pnum;
     BlockDriverState **file;
 } QEDIsAllocatedCB;

@@ -685,10 +685,10 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
 {
     QEDIsAllocatedCB *cb = opaque;
     BDRVQEDState *s = cb->bs->opaque;
-    *cb->pnum = len / BDRV_SECTOR_SIZE;
+    *cb->pnum = len;
     switch (ret) {
     case QED_CLUSTER_FOUND:
-        offset |= qed_offset_into_cluster(s, cb->pos);
+        offset |= qed_offset_into_cluster(s, cb->pos) & BDRV_BLOCK_OFFSET_MASK;
         cb->status = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | offset;
         *cb->file = cb->bs->file->bs;
         break;
@@ -710,16 +710,18 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
     }
 }

-static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
-                                                 int64_t sector_num,
-                                                 int nb_sectors, int *pnum,
-                                                 BlockDriverState **file)
+static int64_t coroutine_fn bdrv_qed_co_block_status(BlockDriverState *bs,
+                                                     bool mapping,
+                                                     int64_t pos,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     BlockDriverState **file)
 {
     BDRVQEDState *s = bs->opaque;
-    size_t len = (size_t)nb_sectors * BDRV_SECTOR_SIZE;
+    size_t len;
     QEDIsAllocatedCB cb = {
         .bs = bs,
-        .pos = (uint64_t)sector_num * BDRV_SECTOR_SIZE,
+        .pos = pos,
         .status = BDRV_BLOCK_OFFSET_MASK,
         .pnum = pnum,
         .file = file,
@@ -1541,7 +1543,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
+    .bdrv_co_block_status     = bdrv_qed_co_block_status,
     .bdrv_co_readv            = bdrv_qed_co_readv,
     .bdrv_co_writev           = bdrv_qed_co_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-- 
2.9.4
