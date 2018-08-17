Received: from eggs.gnu.org ([2001:4830:134:3::10]:34933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdm0-0004MG-3t
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlz-0004a4-Dc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:19 +0300
Message-Id: <20180817122219.16206-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file
 L2 entries to be read-as-zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Rewrite corrupted L2 table entry, which reference space out of
underlying file.

Make this L2 table entry read-as-all-zeros without any allocation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c004e5bfe..3de3768a3c 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1720,8 +1720,30 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             /* Mark cluster as used */
             csize = (((l2_entry >> s->csize_shift) & s->csize_mask) + 1) *
                     BDRV_SECTOR_SIZE;
+            if (csize > s->cluster_size) {
+                ret = fix_l2_entry_to_zero(
+                        bs, res, fix, l2_offset, i, active,
+                        "compressed cluster larger than cluster: size 0x%"
+                        PRIx64, csize);
+                if (ret < 0) {
+                    goto fail;
+                }
+                continue;
+            }
+
             coffset = l2_entry & s->cluster_offset_mask &
                       ~(BDRV_SECTOR_SIZE - 1);
+            if (coffset >= bdrv_getlength(bs->file->bs)) {
+                ret = fix_l2_entry_to_zero(
+                        bs, res, fix, l2_offset, i, active,
+                        "compressed cluster out of file: offset 0x%" PRIx64,
+                        coffset);
+                if (ret < 0) {
+                    goto fail;
+                }
+                continue;
+            }
+
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
                                            coffset, csize);
@@ -1748,6 +1770,16 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
         {
             uint64_t offset = l2_entry & L2E_OFFSET_MASK;
 
+            if (offset >= bdrv_getlength(bs->file->bs)) {
+                ret = fix_l2_entry_to_zero(
+                        bs, res, fix, l2_offset, i, active,
+                        "cluster out of file: offset 0x%" PRIx64, offset);
+                if (ret < 0) {
+                    goto fail;
+                }
+                continue;
+            }
+
             if (flags & CHECK_FRAG_INFO) {
                 res->bfi.allocated_clusters++;
                 if (next_contiguous_offset &&
-- 
2.11.1
