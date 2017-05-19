Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXik-0001pl-6J
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXij-0002Z9-E7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 18 May 2017 21:32:33 -0500
Message-Id: <20170519023233.24461-5-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-1-eblake@redhat.com>
References: <20170519023233.24461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] blkdebug: Support .bdrv_co_get_block_status
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

For a quick manual test, compare this sequence, pre- and post-patch:
$ qemu-img create -f qcow2 file 10M
$ qemu-io -f qcow2 -c 'w 1m' file
$ qemu-img map -f qcow2 file
$ qemu-img map --image-opts driver=blkdebug,image.driver=qcow2,\
image.file.driver=file,image.file.filename=file

Update iotest 177 for the new expected output.

Signed-off-by: Eric Blake <eblake@redhat.com>
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
