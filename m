Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDctz-0003iG-Hs
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDcty-00062V-9E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:29:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 24 May 2017 15:28:42 -0500
Message-Id: <20170524202842.26724-6-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-1-eblake@redhat.com>
References: <20170524202842.26724-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] blkdebug: Support
 .bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

Without a passthrough status of BDRV_BLOCK_RAW, anything wrapped by
blkdebug appears 100% allocated as data.  Better is treating it the
same as the underlying file being wrapped.

Update iotest 177 for the new expected output.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: tweak commit message
---
 block/blkdebug.c           | 11 +++++++++++
 tests/qemu-iotests/177.out |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e8..1ad8d65 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -642,6 +642,16 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, count);
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
@@ -912,6 +922,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
+    .bdrv_co_get_block_status = blkdebug_co_get_block_status,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index b754ed4..43a7778 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -46,6 +46,9 @@ read 30408704/30408704 bytes at offset 80740352
 read 23068672/23068672 bytes at offset 111149056
 22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x8000000       blkdebug::TEST_DIR/t.IMGFMT
+0               0x800000        TEST_DIR/t.IMGFMT
+0x900000        0x2400000       TEST_DIR/t.IMGFMT
+0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
+0x6a00000       0x1600000       TEST_DIR/t.IMGFMT
 No errors were found on the image.
 *** done
-- 
2.9.4
