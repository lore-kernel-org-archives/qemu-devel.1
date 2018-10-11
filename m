Received: from eggs.gnu.org ([2001:4830:134:3::10]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006al-Vf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchU-0006hf-VG
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:22 +0300
Message-Id: <20181011151623.25702-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181011151623.25702-1-vsementsov@virtuozzo.com>
References: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 7/8] block/qcow2-refcount: fix out-of-file
 L1 entries to be zero
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

Zero out corrupted L1 table entry, which reference L2 table out of
underlying file.
Zero L1 table entry means that "the L2 table and all clusters described
by this L2 table are unallocated."

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 65e0fd2de3..5ebe292fc1 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1803,6 +1803,13 @@ static int check_refcounts_l1(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l1_table = NULL, l2_offset, l1_size2;
     int i, ret;
+    bool fix_er = fix & BDRV_FIX_ERRORS;
+    RepTableType type = active ? REP_ACTIVE_L1 : REP_INACTIVE_L1;
+    int64_t file_len = bdrv_getlength(bs->file->bs);
+
+    if (file_len < 0) {
+        return file_len;
+    }
 
     l1_size2 = l1_size * sizeof(uint64_t);
 
@@ -1837,6 +1844,25 @@ static int check_refcounts_l1(BlockDriverState *bs,
         if (l2_offset) {
             /* Mark L2 table as used */
             l2_offset &= L1E_OFFSET_MASK;
+            if (l2_offset >= file_len) {
+                fprintf(stderr,
+                        "%s: l2 table offset out of file: offset 0x%" PRIx64
+                        "\n", fix_er ? "Repairing" : "ERROR", l2_offset);
+                if (fix_er) {
+                    ret = repair_table_entry(bs, res, type,
+                                             l1_table_offset, i, 0);
+                    if (ret < 0) {
+                        /* Something is seriously wrong, so abort checking
+                         * this L1 table */
+                        goto fail;
+                    }
+                } else {
+                    res->corruptions++;
+                }
+
+                continue;
+            }
+
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
                                            l2_offset, s->cluster_size);
-- 
2.18.0
