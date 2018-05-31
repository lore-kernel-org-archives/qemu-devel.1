Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxE-0004q0-Uz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxE-0008D3-1N
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:52 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 1 Jun 2018 00:17:22 +0300
Message-ID: <1527801443-30620-4-git-send-email-ari@tuxera.com>
In-Reply-To: <1527801443-30620-3-git-send-email-ari@tuxera.com>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<1527801443-30620-2-git-send-email-ari@tuxera.com>
	<1527801443-30620-3-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] block/blklogwrites: Use block limits from
 the backend block configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Ari Sundholm <ari@tuxera.com>

This is to ensure that writes are aligned properly for logging writes
to the virtual block device. This is important because the
dm-log-writes log format has a granularity of one sector for both the
offset and the size of each write. By using the logical sector size
for alignment, the log records the writes more faithfully for those
devices that have a non-512 logical sector size.

Note that even with this patch, blklogwrites still uses
BDRV_SECTOR_SIZE for logging. This will change in a subsequent patch
which will introduce support for non-512 sector sizes.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 78835bf..6cdad2c 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -229,6 +229,22 @@ static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
+static void blk_log_writes_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
+{
+    assert(bs && conf && conf->blk);
+
+    bs->bl.request_alignment = conf->logical_block_size;
+    if (conf->discard_granularity != (uint32_t)-1)
+        bs->bl.pdiscard_alignment = conf->discard_granularity;
+
+    if (bs->bl.pdiscard_alignment &&
+            bs->bl.pdiscard_alignment < bs->bl.request_alignment)
+        bs->bl.pdiscard_alignment = bs->bl.request_alignment;
+    if (bs->bl.pwrite_zeroes_alignment &&
+            bs->bl.pwrite_zeroes_alignment < bs->bl.request_alignment)
+        bs->bl.pwrite_zeroes_alignment = bs->bl.request_alignment;
+}
+
 static int coroutine_fn
 blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                          QEMUIOVector *qiov, int flags)
@@ -424,6 +440,7 @@ static BlockDriver bdrv_blk_log_writes = {
     .bdrv_refresh_filename  = blk_log_writes_refresh_filename,
     .bdrv_child_perm        = blk_log_writes_child_perm,
     .bdrv_refresh_limits    = blk_log_writes_refresh_limits,
+    .bdrv_apply_blkconf     = blk_log_writes_apply_blkconf,
 
     .bdrv_co_preadv         = blk_log_writes_co_preadv,
     .bdrv_co_pwritev        = blk_log_writes_co_pwritev,
-- 
2.7.4
