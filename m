Received: from eggs.gnu.org ([2001:4830:134:3::10]:43314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V6J-00083K-Uj
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V6I-0000YK-JS
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1V6I-0000YA-AO
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:43:14 +0100
Message-Id: <20170421094316.19361-5-stefanha@redhat.com>
In-Reply-To: <20170421094316.19361-1-stefanha@redhat.com>
References: <20170421094316.19361-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 4/6] migration/block: use
 blk_pwrite_zeroes for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Lidong Chen <lidongchen@tencent.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Lidong Chen <lidongchen@tencent.com>

BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
this may cause the qcow2 file size to be bigger after migration.
This patch checks each cluster, using blk_pwrite_zeroes for each
zero cluster.

[Initialize cluster_size to BLOCK_SIZE to prevent a gcc uninitialized
variable compiler warning.  In reality we always initialize cluster_size
in a conditional but gcc doesn't know that.
--Stefan]

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Message-id: 1492050868-16200-1-git-send-email-lidongchen@tencent.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/block.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..060087f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     int64_t total_sectors = 0;
     int nr_sectors;
     int ret;
+    BlockDriverInfo bdi;
+    int cluster_size = BLOCK_SIZE;
 
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
@@ -932,10 +943,30 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
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
+                    if ((!block_mig_state.zero_blocks ||
+                        cluster_size < BLOCK_SIZE) &&
+                        buffer_is_zero(cur_buf, cluster_size)) {
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
2.9.3
