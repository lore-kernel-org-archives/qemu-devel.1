Received: from eggs.gnu.org ([2001:4830:134:3::10]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxn-0000OF-52
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxm-0002y1-1M
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:45 +0200
Message-Id: <20171006155422.10135-18-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/54] qcow2: Switch qcow2_measure() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

This is new code, but it is easier to read if it makes passes over
the image using bytes rather than sectors (and will get easier in
the future when bdrv_get_block_status is converted to byte-based).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 970006fc1d..b8da8ca105 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3673,20 +3673,19 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
@@ -3699,12 +3698,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
2.13.6
