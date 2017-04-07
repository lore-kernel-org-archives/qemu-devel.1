Received: from eggs.gnu.org ([2001:4830:134:3::10]:48700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwPWF-00018V-CF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwPWC-0002A3-97
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:45:23 -0400
From: jemmy858585@gmail.com
Date: Fri,  7 Apr 2017 16:44:45 +0800
Message-Id: <1491554685-1288-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2] migration/block: use blk_pwrite_zeroes for
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
 migration/block.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..c32e046 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -885,6 +885,11 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     int64_t total_sectors = 0;
     int nr_sectors;
     int ret;
+    int i;
+    int64_t addr_offset;
+    uint8_t *buf_offset;
+    BlockDriverInfo bdi;
+    int cluster_size;
 
     do {
         addr = qemu_get_be64(f);
@@ -934,8 +939,36 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
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
+                    cluster_size < BLOCK_SIZE &&
+                    BLOCK_SIZE % cluster_size == 0) {
+                    for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
+                        addr_offset = addr * BDRV_SECTOR_SIZE
+                                        + i * cluster_size;
+                        buf_offset = buf + i * cluster_size;
+
+                        if (buffer_is_zero(buf_offset, cluster_size)) {
+                            ret = blk_pwrite_zeroes(blk, addr_offset,
+                                                    cluster_size,
+                                                    BDRV_REQ_MAY_UNMAP);
+                        } else {
+                             ret = blk_pwrite(blk, addr_offset, buf_offset,
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
