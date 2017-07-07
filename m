Received: from eggs.gnu.org ([2001:4830:134:3::10]:41184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWko-0004Wl-0j
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkm-0007XN-S3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:17 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:19 +0200
Message-Id: <1499447335-6125-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 004/100] blkdebug: Support
 .bdrv_co_get_block_status
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

Without a passthrough status of BDRV_BLOCK_RAW, anything wrapped by
blkdebug appears 100% allocated as data.  Better is treating it the
same as the underlying file being wrapped.

Update iotest 177 for the new expected output.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkdebug.c           | 11 +++++++++++
 tests/qemu-iotests/177.out |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a1b24b9..b25856c 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -641,6 +641,16 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
+static int64_t coroutine_fn blkdebug_co_get_block_status(
+    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
+    BlockDriverState **file)
+{
+    *pnum = nb_sectors;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+        (sector_num << BDRV_SECTOR_BITS);
+}
+
 static void blkdebug_close(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -915,6 +925,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
+    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
 
     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index fcfbfa3..43a7778 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -46,6 +46,9 @@ read 30408704/30408704 bytes at offset 80740352
 read 23068672/23068672 bytes at offset 111149056
 22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x8000000       json:{"image": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}, "driver": "blkdebug", "align": "4k"}
+0               0x800000        TEST_DIR/t.IMGFMT
+0x900000        0x2400000       TEST_DIR/t.IMGFMT
+0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
+0x6a00000       0x1600000       TEST_DIR/t.IMGFMT
 No errors were found on the image.
 *** done
-- 
1.8.3.1
