Received: from eggs.gnu.org ([2001:4830:134:3::10]:33567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxuYA-0005KC-PU
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxuY5-0001KV-UB
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:05:34 -0400
From: jemmy858585@gmail.com
Date: Tue, 11 Apr 2017 20:05:12 +0800
Message-Id: <1491912312-23393-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v4] migration/block: use blk_pwrite_zeroes for
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
 migration/block.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..5d0635a 100644
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
@@ -919,6 +921,15 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                     error_report_err(local_err);
                     return -EINVAL;
                 }
+
+                ret = bdrv_get_info(blk_bs(blk), &bdi);
+                if (ret == 0 && bdi.cluster_size > 0 &&
+                    bdi.cluster_size <= BLOCK_SIZE &&
+                    BLOCK_SIZE % bdi.cluster_size == 0) {
+                    cluster_size = bdi.cluster_size;
+                } else {
+                    cluster_size = BLOCK_SIZE;
+                }
             }
 
             if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
@@ -932,10 +943,28 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                                         nr_sectors * BDRV_SECTOR_SIZE,
                                         BDRV_REQ_MAY_UNMAP);
             } else {
+                int i;
+                int64_t cur_addr;
+                uint8_t *cur_buf;
+
                 buf = g_malloc(BLOCK_SIZE);
                 qemu_get_buffer(f, buf, BLOCK_SIZE);
-                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
-                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
+                for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
+                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
+                    cur_buf = buf + i * cluster_size;
+
+                    if (buffer_is_zero(cur_buf, cluster_size)) {
+                        ret = blk_pwrite_zeroes(blk, cur_addr,
+                                                cluster_size,
+                                                BDRV_REQ_MAY_UNMAP);
+                    } else {
+                        ret = blk_pwrite(blk, cur_addr, cur_buf,
+                                         cluster_size, 0);
+                    }
+                    if (ret < 0) {
+                        break;
+                    }
+                }
                 g_free(buf);
             }
 
-- 
1.8.3.1
