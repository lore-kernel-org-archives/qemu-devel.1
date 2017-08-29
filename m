Received: from eggs.gnu.org ([2001:4830:134:3::10]:48241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCZ-0001PX-9o
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCW-0005cX-0Z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCV-0005ZP-LV
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0FxG6009445
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:14 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjejkke-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:14 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:13 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:20 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-46-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/79] block: Guarantee that *file is set on
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
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

We document that *file is valid if the return is not an error and
includes BDRV_BLOCK_OFFSET_VALID, but forgot to obey this contract
when a driver (such as blkdebug) lacks a callback.  Messed up in
commit 67a0fd2 (v2.6), when we added the file parameter.

Enhance qemu-iotest 177 to cover this, using a sequence that would
print garbage or even SEGV, because it was dererefencing through
uninitialized memory.  [The resulting test output shows that we
have less-than-ideal block status from the blkdebug driver, but
that's a separate fix coming up soon.]

Setting *file on all paths that return BDRV_BLOCK_OFFSET_VALID is
enough to fix the crash, but we can go one step further: always
setting *file, even on error, means that a broken caller that
blindly dereferences file without checking for error is now more
likely to get a reliable SEGV instead of randomly acting on garbage,
making it easier to diagnose such buggy callers.  Adding an
assertion that file is set where expected doesn't hurt either.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 81c219ac6ce0d6182e35f3976f2caa4cefcaf9f0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c                 | 5 +++--
 tests/qemu-iotests/177     | 3 +++
 tests/qemu-iotests/177.out | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index fe0c867..a8589ee 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1757,6 +1757,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     int64_t n;
     int64_t ret, ret2;
 
+    *file = NULL;
     total_sectors = bdrv_nb_sectors(bs);
     if (total_sectors < 0) {
         return total_sectors;
@@ -1777,11 +1778,11 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (bs->drv->protocol_name) {
             ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+            *file = bs;
         }
         return ret;
     }
 
-    *file = NULL;
     bdrv_inc_in_flight(bs);
     ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
                                             file);
@@ -1791,7 +1792,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
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
index e887542..fcfbfa3 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -45,5 +45,7 @@ read 30408704/30408704 bytes at offset 80740352
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 23068672/23068672 bytes at offset 111149056
 22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x8000000       json:{"image": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}, "driver": "blkdebug", "align": "4k"}
 No errors were found on the image.
 *** done
-- 
2.7.4
