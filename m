Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXig-0001mP-Q0
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXif-0002TH-SU
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:46 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 18 May 2017 21:32:31 -0500
Message-Id: <20170519023233.24461-3-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-1-eblake@redhat.com>
References: <20170519023233.24461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block: Guarantee that *file is set on
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We document that *file is valid if the return is not an error and
includes BDRV_BLOCK_OFFSET_VALID, but forgot to obey this contract
when a driver (such as blkdebug) lacks a callback.  Broken in
commit 67a0fd2 (v2.6), when we added the file parameter.

Enhance qemu-iotest 177 to cover this, using a sequence that would
print garbage or even SEGV, because it was dererefencing through
uninitialized memory.  [The resulting test output shows that we
have less-than-ideal block status from the blkdebug driver, but
that's a separate fix coming up soon.]

Setting *file only when setting BDRV_BLOCK_OFFSET_VALID is enough
to fix the crash, but we can go one step further: always setting
*file, even on error, means that a caller is no longer dereferencing
uninitialized memory, so that we are more likely to get a reliable
SEGV instead of randomly acting on garbage.  Adding an assertion
doesn't hurt either.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c                 | 4 +++-
 tests/qemu-iotests/177     | 3 +++
 tests/qemu-iotests/177.out | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index fdd7485..164a82b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1749,6 +1749,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     int64_t n;
     int64_t ret, ret2;

+    *file = NULL;
     total_sectors = bdrv_nb_sectors(bs);
     if (total_sectors < 0) {
         return total_sectors;
@@ -1769,6 +1770,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (bs->drv->protocol_name) {
             ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+            *file = bs;
         }
         return ret;
     }
@@ -1783,7 +1785,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     }

     if (ret & BDRV_BLOCK_RAW) {
-        assert(ret & BDRV_BLOCK_OFFSET_VALID);
+        assert(ret & BDRV_BLOCK_OFFSET_VALID && *file);
         ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
                                        *pnum, pnum, file);
         goto out;
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 2005c17..f8ed8fb 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -43,6 +43,7 @@ _supported_proto file
 CLUSTER_SIZE=1M
 size=128M
 options=driver=blkdebug,image.driver=qcow2
+nested_opts=image.file.driver=file,image.file.filename=$TEST_IMG

 echo
 echo "== setting up files =="
@@ -106,6 +107,8 @@ function verify_io()
 }

 verify_io | $QEMU_IO -r "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --image-opts "$options,$nested_opts,align=4k" \
+    | _filter_qemu_img_map

 _check_test_img

diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index e887542..b754ed4 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -45,5 +45,7 @@ read 30408704/30408704 bytes at offset 80740352
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 23068672/23068672 bytes at offset 111149056
 22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x8000000       blkdebug::TEST_DIR/t.IMGFMT
 No errors were found on the image.
 *** done
-- 
2.9.4
