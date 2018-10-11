Received: from eggs.gnu.org ([2001:4830:134:3::10]:59612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006ak-Vb
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchV-0006il-Na
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:23 +0300
Message-Id: <20181011151623.25702-9-vsementsov@virtuozzo.com>
In-Reply-To: <20181011151623.25702-1-vsementsov@virtuozzo.com>
References: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 8/8] block/qcow2-refcount: fix out-of-file
 L2 entries
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

Rewrite corrupted L2 table entry, which reference space out of
underlying file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 5ebe292fc1..2e2ba806ed 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1629,11 +1629,37 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                               int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_table;
+    uint64_t *l2_table, zero_fix_entry;
     uint64_t next_contiguous_offset = 0;
     int i, l2_size, ret;
     bool fix_er = fix & BDRV_FIX_ERRORS;
     RepTableType type = active ? REP_ACTIVE_L2 : REP_INACTIVE_L2;
+    const char *zero_fix_desc = "";
+    int64_t file_len = bdrv_getlength(bs->file->bs);
+
+    if (file_len < 0) {
+        return file_len;
+    }
+
+    if (fix_er) {
+        /* prepare options for fixing corrupted l2 entries to be marked as zero
+         * or unallocated
+         */
+        if (s->qcow_version >= 3) {
+            zero_fix_entry = QCOW_OFLAG_ZERO;
+            zero_fix_desc = ": mark cluster as zero";
+        } else {
+            /* v2 doesn't support ZERO flag, so we just mark it unallocated.
+             * It's a bit unsafe, as backing file may become available through
+             * the hole. However, discard for v2 do the same, so we don't care
+             * too.
+             */
+            zero_fix_entry = 0;
+            zero_fix_desc = ": mark cluster as unallocated (warning: "
+                            "underlying backing file may become available "
+                            "through the hole)";
+        }
+    }
 
     /* Read L2 table from disk */
     l2_size = s->l2_size * sizeof(uint64_t);
@@ -1670,6 +1696,34 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             offset = l2_entry & s->cluster_offset_mask & ~511;
             size = (((l2_entry >> s->csize_shift) & s->csize_mask) + 1) * 512;
+
+            if (offset + size > QEMU_ALIGN_UP(file_len, 512)) {
+                /* The compressed data does not necessarily occupy
+                 * all of the bytes in the final 512-bytes sector
+                 */
+                const char *fix_desc = "";
+                uint64_t orig_size = size;
+                fatal = true;
+
+                if (fix_er) {
+                    if (offset < file_len) {
+                        size = QEMU_ALIGN_UP(file_len, 512) - offset;
+                        l2_entry_fix &=
+                                ~((uint64_t)s->csize_mask << s->csize_shift);
+                        l2_entry_fix |= (size / 512 - 1) << s->csize_shift;
+                        fix_desc = ": try to fix cluster size";
+                    } else {
+                        l2_entry_fix = zero_fix_entry;
+                        fix_desc = zero_fix_desc;
+                    }
+                } else {
+                    res->corruptions++;
+                }
+                fprintf(stderr, "%s: compressed cluster out of file: "
+                        "offset 0x%" PRIx64 " size 0x%" PRIx64 "%s\n",
+                        fix_er ? "Repairing" : "ERROR",
+                        offset, orig_size, fix_desc);
+            }
             break;
 
         case QCOW2_CLUSTER_ZERO_ALLOC:
@@ -1677,6 +1731,16 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             offset = l2_entry & L2E_OFFSET_MASK;
             size = s->cluster_size;
 
+            if (offset >= file_len) {
+                fatal = true; /* for sure, there is no allocation after EOF */
+                fprintf(stderr,
+                        "%s: cluster out of file: offset 0x%" PRIx64 "%s\n",
+                        fix_er ? "Repairing" : "ERROR", offset,
+                        fix_er ? zero_fix_desc : "");
+                l2_entry_fix = zero_fix_entry;
+                break;
+            }
+
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
                 fatal = true; /* misaligned cluster leads to
-- 
2.18.0
