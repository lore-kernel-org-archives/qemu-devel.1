Received: from eggs.gnu.org ([2001:4830:134:3::10]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawh-0003Fg-GE
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawg-0000MB-5y
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:45 -0600
Message-Id: <20180105225753.30509-13-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 12/20] qed: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qed driver accordingly, taking the opportunity
to inline qed_is_allocated_cb() into its lone caller (the callback
used to be important, until we switched qed to coroutines).  There is
no intent to optimize based on the want_zero flag for this format.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: initialize len before qed_find_cluster() [Vladimir]
v4: rebase to interface change, inline pointless callback
v3: no change
v2: rebase to mapping flag, fix mask in qed_is_allocated_cb
---
 block/qed.c | 84 +++++++++++++++++++++----------------------------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 821dcaa055..13fbc3e2f1 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -688,74 +688,46 @@ finish:
     return ret;
 }

-typedef struct {
-    BlockDriverState *bs;
-    Coroutine *co;
-    uint64_t pos;
-    int64_t status;
-    int *pnum;
-    BlockDriverState **file;
-} QEDIsAllocatedCB;
-
-/* Called with table_lock held.  */
-static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t len)
-{
-    QEDIsAllocatedCB *cb = opaque;
-    BDRVQEDState *s = cb->bs->opaque;
-    *cb->pnum = len / BDRV_SECTOR_SIZE;
-    switch (ret) {
-    case QED_CLUSTER_FOUND:
-        offset |= qed_offset_into_cluster(s, cb->pos);
-        cb->status = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | offset;
-        *cb->file = cb->bs->file->bs;
-        break;
-    case QED_CLUSTER_ZERO:
-        cb->status = BDRV_BLOCK_ZERO;
-        break;
-    case QED_CLUSTER_L2:
-    case QED_CLUSTER_L1:
-        cb->status = 0;
-        break;
-    default:
-        assert(ret < 0);
-        cb->status = ret;
-        break;
-    }
-
-    if (cb->co) {
-        aio_co_wake(cb->co);
-    }
-}
-
-static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
-                                                 int64_t sector_num,
-                                                 int nb_sectors, int *pnum,
+static int coroutine_fn bdrv_qed_co_block_status(BlockDriverState *bs,
+                                                 bool want_zero,
+                                                 int64_t pos, int64_t bytes,
+                                                 int64_t *pnum, int64_t *map,
                                                  BlockDriverState **file)
 {
     BDRVQEDState *s = bs->opaque;
-    size_t len = (size_t)nb_sectors * BDRV_SECTOR_SIZE;
-    QEDIsAllocatedCB cb = {
-        .bs = bs,
-        .pos = (uint64_t)sector_num * BDRV_SECTOR_SIZE,
-        .status = BDRV_BLOCK_OFFSET_MASK,
-        .pnum = pnum,
-        .file = file,
-    };
+    size_t len = MIN(bytes, SIZE_MAX);
+    int status;
     QEDRequest request = { .l2_table = NULL };
     uint64_t offset;
     int ret;

     qemu_co_mutex_lock(&s->table_lock);
-    ret = qed_find_cluster(s, &request, cb.pos, &len, &offset);
-    qed_is_allocated_cb(&cb, ret, offset, len);
+    ret = qed_find_cluster(s, &request, pos, &len, &offset);

-    /* The callback was invoked immediately */
-    assert(cb.status != BDRV_BLOCK_OFFSET_MASK);
+    *pnum = len;
+    switch (ret) {
+    case QED_CLUSTER_FOUND:
+        *map = offset | qed_offset_into_cluster(s, pos);
+        status = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+        *file = bs->file->bs;
+        break;
+    case QED_CLUSTER_ZERO:
+        status = BDRV_BLOCK_ZERO;
+        break;
+    case QED_CLUSTER_L2:
+    case QED_CLUSTER_L1:
+        status = 0;
+        break;
+    default:
+        assert(ret < 0);
+        status = ret;
+        break;
+    }

     qed_unref_l2_cache_entry(request.l2_table);
     qemu_co_mutex_unlock(&s->table_lock);

-    return cb.status;
+    return status;
 }

 static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
@@ -1595,7 +1567,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
+    .bdrv_co_block_status     = bdrv_qed_co_block_status,
     .bdrv_co_readv            = bdrv_qed_co_readv,
     .bdrv_co_writev           = bdrv_qed_co_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-- 
2.14.3
