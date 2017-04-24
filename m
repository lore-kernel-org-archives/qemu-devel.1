Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2eT1-0000Do-Pr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2eSz-0006Bi-7R
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:55:51 -0400
From: jemmy858585@gmail.com
Date: Mon, 24 Apr 2017 21:55:40 +0800
Message-Id: <1493042140-25551-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH] migration/block: optimize the performance by
 coalescing the same write type
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

This patch optimizes the performance by coalescing the same write type.
When the zero/non-zero state changes, perform the write for the accumulated
cluster count.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
    Thanks Fam Zheng and Stefan's advice.
---
 migration/block.c | 66 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 060087f..e9c5e21 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -40,6 +40,8 @@
 
 #define MAX_INFLIGHT_IO 512
 
+#define MIN_CLUSTER_SIZE 8192
+
 //#define DEBUG_BLK_MIGRATION
 
 #ifdef DEBUG_BLK_MIGRATION
@@ -923,10 +925,11 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                 }
 
                 ret = bdrv_get_info(blk_bs(blk), &bdi);
-                if (ret == 0 && bdi.cluster_size > 0 &&
-                    bdi.cluster_size <= BLOCK_SIZE &&
-                    BLOCK_SIZE % bdi.cluster_size == 0) {
+                if (ret == 0 && bdi.cluster_size > 0) {
                     cluster_size = bdi.cluster_size;
+                    while (cluster_size < MIN_CLUSTER_SIZE) {
+                        cluster_size *= 2;
+                    }
                 } else {
                     cluster_size = BLOCK_SIZE;
                 }
@@ -943,29 +946,58 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                                         nr_sectors * BDRV_SECTOR_SIZE,
                                         BDRV_REQ_MAY_UNMAP);
             } else {
-                int i;
-                int64_t cur_addr;
-                uint8_t *cur_buf;
+                int64_t cur_addr = addr * BDRV_SECTOR_SIZE;
+                uint8_t *cur_buf = NULL;
+                int64_t last_addr = addr * BDRV_SECTOR_SIZE;
+                uint8_t *last_buf = NULL;
+                int64_t end_addr = addr * BDRV_SECTOR_SIZE + BLOCK_SIZE;
 
                 buf = g_malloc(BLOCK_SIZE);
                 qemu_get_buffer(f, buf, BLOCK_SIZE);
-                for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
-                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
-                    cur_buf = buf + i * cluster_size;
-
-                    if ((!block_mig_state.zero_blocks ||
-                        cluster_size < BLOCK_SIZE) &&
-                        buffer_is_zero(cur_buf, cluster_size)) {
-                        ret = blk_pwrite_zeroes(blk, cur_addr,
-                                                cluster_size,
+                cur_buf = buf;
+                last_buf = buf;
+
+                while (last_addr < end_addr) {
+                    int is_zero = 0;
+                    int buf_size = MIN(end_addr - cur_addr, cluster_size);
+
+                    /* If the "zero blocks" migration capability is enabled
+                     * and the buf_size == BLOCK_SIZE, then the source QEMU
+                     * process has already scanned for zeroes. CPU is wasted
+                     * scanning for zeroes in the destination QEMU process.
+                     */
+                    if (block_mig_state.zero_blocks &&
+                        buf_size == BLOCK_SIZE) {
+                        is_zero = 0;
+                    } else {
+                        is_zero = buffer_is_zero(cur_buf, buf_size);
+                    }
+
+                    cur_addr += buf_size;
+                    cur_buf += buf_size;
+                    while (cur_addr < end_addr) {
+                        buf_size = MIN(end_addr - cur_addr, cluster_size);
+                        if (is_zero != buffer_is_zero(cur_buf, buf_size)) {
+                            break;
+                        }
+                        cur_addr += buf_size;
+                        cur_buf += buf_size;
+                    }
+
+                    if (is_zero) {
+                        ret = blk_pwrite_zeroes(blk, last_addr,
+                                                cur_addr - last_addr,
                                                 BDRV_REQ_MAY_UNMAP);
                     } else {
-                        ret = blk_pwrite(blk, cur_addr, cur_buf,
-                                         cluster_size, 0);
+                        ret = blk_pwrite(blk, last_addr, last_buf,
+                                         cur_addr - last_addr, 0);
                     }
                     if (ret < 0) {
                         break;
                     }
+
+                    last_addr = cur_addr;
+                    last_buf = cur_buf;
                 }
                 g_free(buf);
             }
-- 
1.8.3.1
