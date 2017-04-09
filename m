Received: from eggs.gnu.org ([2001:4830:134:3::10]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxC6V-0004Ze-Fo
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 08:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxC6S-0006U5-CS
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 08:38:03 -0400
From: jemmy858585@gmail.com
Date: Sun,  9 Apr 2017 20:37:40 +0800
Message-Id: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v3] migration/block: use blk_pwrite_zeroes for
 each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
this maybe cause the qcow2 file size is bigger after migration.
This patch check each cluster, use blk_pwrite_zeroes for each
zero cluster.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/block.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..fe613db 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     int64_t total_sectors = 0;
     int nr_sectors;
     int ret;
+    BlockDriverInfo bdi;
+    int cluster_size;
 
     do {
         addr = qemu_get_be64(f);
@@ -934,8 +936,40 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
             } else {
                 buf = g_malloc(BLOCK_SIZE);
                 qemu_get_buffer(f, buf, BLOCK_SIZE);
-                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
-                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
+
+                ret = bdrv_get_info(blk_bs(blk), &bdi);
+                cluster_size = bdi.cluster_size;
+
+                if (ret == 0 && cluster_size > 0 &&
+                    cluster_size <= BLOCK_SIZE &&
+                    BLOCK_SIZE % cluster_size == 0) {
+                    int i;
+                    int64_t cur_addr;
+                    uint8_t *cur_buf;
+
+                    for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
+                        cur_addr = addr * BDRV_SECTOR_SIZE
+                                        + i * cluster_size;
+                        cur_buf = buf + i * cluster_size;
+
+                        if (buffer_is_zero(cur_buf, cluster_size)) {
+                            ret = blk_pwrite_zeroes(blk, cur_addr,
+                                                    cluster_size,
+                                                    BDRV_REQ_MAY_UNMAP);
+                        } else {
+                             ret = blk_pwrite(blk, cur_addr, cur_buf,
+                                              cluster_size, 0);
+                        }
+
+                        if (ret < 0) {
+                            g_free(buf);
+                            return ret;
+                        }
+                    }
+                } else {
+                    ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
+                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
+                }
                 g_free(buf);
             }
 
-- 
1.8.3.1
