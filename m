Received: from eggs.gnu.org ([2001:4830:134:3::10]:37262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaQ-0005FG-GF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaP-0001t9-Gb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:51 -0500
Message-Id: <20170713010555.6769-15-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

This is new code, but it is easier to read if it makes passes over
the image using bytes rather than sectors (and will get easier in
the future when bdrv_get_block_status is converted to byte-based).

While at it, fix a bug in the computation of nb_sectors using MAX
rather than MIN and thus always passing INT_MAX (thankfully, the
bug was harmless, as bdrv_get_block_status_above() clamps its
answers according to image size).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: new patch
---
 block/qcow2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c144ea5..85ee9b2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3662,20 +3662,19 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
              */
             required = virtual_size;
         } else {
-            int cluster_sectors = cluster_size / BDRV_SECTOR_SIZE;
-            int64_t sector_num;
+            int64_t offset;
             int pnum = 0;

-            for (sector_num = 0;
-                 sector_num < ssize / BDRV_SECTOR_SIZE;
-                 sector_num += pnum) {
-                int nb_sectors = MAX(ssize / BDRV_SECTOR_SIZE - sector_num,
-                                     INT_MAX);
+            for (offset = 0; offset < ssize;
+                 offset += pnum * BDRV_SECTOR_SIZE) {
+                int nb_sectors = MIN(ssize - offset,
+                                     INT_MAX) / BDRV_SECTOR_SIZE;
                 BlockDriverState *file;
                 int64_t ret;

                 ret = bdrv_get_block_status_above(in_bs, NULL,
-                                                  sector_num, nb_sectors,
+                                                  offset >> BDRV_SECTOR_BITS,
+                                                  nb_sectors,
                                                   &pnum, &file);
                 if (ret < 0) {
                     error_setg_errno(&local_err, -ret,
@@ -3688,12 +3687,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                 } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
                            (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
                     /* Extend pnum to end of cluster for next iteration */
-                    pnum = ROUND_UP(sector_num + pnum, cluster_sectors) -
-                           sector_num;
+                    pnum = (ROUND_UP(offset + pnum * BDRV_SECTOR_SIZE,
+                                 cluster_size) - offset) >> BDRV_SECTOR_BITS;

                     /* Count clusters we've seen */
-                    required += (sector_num % cluster_sectors + pnum) *
-                                BDRV_SECTOR_SIZE;
+                    required += offset % cluster_size + pnum * BDRV_SECTOR_SIZE;
                 }
             }
         }
-- 
2.9.4
