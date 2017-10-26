Received: from eggs.gnu.org ([2001:4830:134:3::10]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3k-0000wX-Lw
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3h-0002Pv-Hp
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:32 +0200
Message-Id: <20171026131741.5059-27-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/35] qemu-io: Relax 'alloc' now that
 block-status doesn't assert
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

Previously, the alloc command required that input parameters be
sector-aligned and clamped to 32 bits, because the underlying
bdrv_is_allocated used a 32-bit parameter and asserted aligned
inputs.  But now that we have fixed block status to report a
64-bit bytes value, and to properly round requests on behalf of
guests, we can pass any values, and can use qemu-io to add
coverage that our rounding is correct regardless of the guest
alignment constraints.

Update iotest 177 to intentionally probe block status at
unaligned boundaries as well as with a bytes value that does not
map to 32-bit sectors, which also required tweaking the image
prep to leave an unallocated portion to the image under test.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c             | 13 -------------
 tests/qemu-iotests/177     | 12 ++++++++++--
 tests/qemu-iotests/177.out | 19 ++++++++++++++-----
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 3727fb43f3..de8e3de726 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1769,10 +1769,6 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return 0;
-    } else if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
-        printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
-               offset);
-        return 0;
     }
 
     if (argc == 3) {
@@ -1780,19 +1776,10 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
         if (count < 0) {
             print_cvtnum_err(count, argv[2]);
             return 0;
-        } else if (count > INT_MAX * BDRV_SECTOR_SIZE) {
-            printf("length argument cannot exceed %llu, given %s\n",
-                   INT_MAX * BDRV_SECTOR_SIZE, argv[2]);
-            return 0;
         }
     } else {
         count = BDRV_SECTOR_SIZE;
     }
-    if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
-        printf("%" PRId64 " is not a sector-aligned value for 'count'\n",
-               count);
-        return 0;
-    }
 
     remaining = count;
     sum_alloc = 0;
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index f8ed8fb86b..28990977f1 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -51,7 +51,7 @@ echo "== setting up files =="
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
 _make_test_img -b "$TEST_IMG.base"
-$QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 22 0 110M" "$TEST_IMG" | _filter_qemu_io
 
 # Limited to 64k max-transfer
 echo
@@ -82,6 +82,13 @@ $QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
          -c "discard 80000001 30M" | _filter_qemu_io
 
 echo
+echo "== block status smaller than alignment =="
+limits=align=4k
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+	 -c "alloc 1 1" -c "alloc 0x6dffff0 1000" -c "alloc 127m 5P" \
+	 -c map | _filter_qemu_io
+
+echo
 echo "== verify image content =="
 
 function verify_io()
@@ -103,7 +110,8 @@ function verify_io()
     echo read -P 0 32M 32M
     echo read -P 22 64M 13M
     echo read -P $discarded 77M 29M
-    echo read -P 22 106M 22M
+    echo read -P 22 106M 4M
+    echo read -P 11 110M 18M
 }
 
 verify_io | $QEMU_IO -r "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index 43a777836c..f788b55e20 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -5,8 +5,8 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
-wrote 134217728/134217728 bytes at offset 0
-128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 115343360/115343360 bytes at offset 0
+110 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == constrained alignment and max-transfer ==
 wrote 131072/131072 bytes at offset 1000
@@ -26,6 +26,13 @@ wrote 33554432/33554432 bytes at offset 33554432
 discard 31457280/31457280 bytes at offset 80000001
 30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+== block status smaller than alignment ==
+1/1 bytes allocated at offset 1 bytes
+16/1000 bytes allocated at offset 110 MiB
+0/1048576 bytes allocated at offset 127 MiB
+110 MiB (0x6e00000) bytes     allocated at offset 0 bytes (0x0)
+18 MiB (0x1200000) bytes not allocated at offset 110 MiB (0x6e00000)
+
 == verify image content ==
 read 1000/1000 bytes at offset 0
 1000 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -43,12 +50,14 @@ read 13631488/13631488 bytes at offset 67108864
 13 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 30408704/30408704 bytes at offset 80740352
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 23068672/23068672 bytes at offset 111149056
-22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 111149056
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 18874368/18874368 bytes at offset 115343360
+18 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0               0x800000        TEST_DIR/t.IMGFMT
 0x900000        0x2400000       TEST_DIR/t.IMGFMT
 0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
-0x6a00000       0x1600000       TEST_DIR/t.IMGFMT
+0x6a00000       0x400000        TEST_DIR/t.IMGFMT
 No errors were found on the image.
 *** done
-- 
2.13.6
