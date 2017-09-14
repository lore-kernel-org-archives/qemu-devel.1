Received: from eggs.gnu.org ([2001:4830:134:3::10]:46751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKb-00065B-5W
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKV-0002lj-9X
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 09:40:24 -0500
Message-Id: <20170914144032.14945-13-eblake@redhat.com>
In-Reply-To: <20170914144032.14945-1-eblake@redhat.com>
References: <20170914144032.14945-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/20] qed: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

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
index 28e2ec89e8..16752e50c0 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -693,7 +693,7 @@ typedef struct {
     Coroutine *co;
     uint64_t pos;
     int64_t status;
-    int *pnum;
+    int64_t *pnum;
     BlockDriverState **file;
 } QEDIsAllocatedCB;

@@ -702,10 +702,10 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
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
@@ -727,16 +727,18 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
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
@@ -1595,7 +1597,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
+    .bdrv_co_block_status     = bdrv_qed_co_block_status,
     .bdrv_co_readv            = bdrv_qed_co_readv,
     .bdrv_co_writev           = bdrv_qed_co_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-- 
2.13.5
