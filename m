Received: from eggs.gnu.org ([2001:4830:134:3::10]:39794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqv-00028c-SE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqu-0006Qj-UM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 12 Sep 2017 15:31:15 -0500
Message-Id: <20170912203119.24166-17-eblake@redhat.com>
In-Reply-To: <20170912203119.24166-1-eblake@redhat.com>
References: <20170912203119.24166-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 16/20] qcow2: Switch qcow2_measure() to
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
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is new code, but it is easier to read if it makes passes over
the image using bytes rather than sectors (and will get easier in
the future when bdrv_get_block_status is converted to byte-based).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v7: tweak constant given to MIN (no semantic change, R-b kept) [Kevin]
v6: separate bug fix to earlier patch
v5: new patch
---
 block/qcow2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index bae5893327..64dcd98a91 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3647,20 +3647,19 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
-                int nb_sectors = MIN(ssize / BDRV_SECTOR_SIZE - sector_num,
-                                     BDRV_REQUEST_MAX_SECTORS);
+            for (offset = 0; offset < ssize;
+                 offset += pnum * BDRV_SECTOR_SIZE) {
+                int nb_sectors = MIN(ssize - offset,
+                                     BDRV_REQUEST_MAX_BYTES) / BDRV_SECTOR_SIZE;
                 BlockDriverState *file;
                 int64_t ret;

                 ret = bdrv_get_block_status_above(in_bs, NULL,
-                                                  sector_num, nb_sectors,
+                                                  offset >> BDRV_SECTOR_BITS,
+                                                  nb_sectors,
                                                   &pnum, &file);
                 if (ret < 0) {
                     error_setg_errno(&local_err, -ret,
@@ -3673,12 +3672,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
2.13.5
