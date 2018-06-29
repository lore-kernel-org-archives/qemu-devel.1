Received: from eggs.gnu.org ([2001:4830:134:3::10]:49780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6b-00044A-3L
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-0004Cu-Aj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:49 +0200
Message-Id: <20180629140959.6690-20-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/29] qcow2: Fix src_offset in copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Not updating src_offset will result in wrong data being written to dst
image.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              |  1 +
 tests/qemu-iotests/063     |  9 +++++++++
 tests/qemu-iotests/063.out | 12 ++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 286640c0e3..2f9e58e0c4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3387,6 +3387,7 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
         }
 
         bytes -= cur_bytes;
+        src_offset += cur_bytes;
         dst_offset += cur_bytes;
     }
     ret = 0;
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index e4f6ea9385..adc037c1f5 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -91,6 +91,15 @@ if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG" >/dev
     exit 1
 fi
 
+echo "== Regression testing for copy offloading bug =="
+
+_make_test_img 1M
+TEST_IMG="$TEST_IMG.target" _make_test_img 1M
+$QEMU_IO -c 'write -P 1 0 512k' -c 'write -P 2 512k 512k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'write -P 4 512k 512k' -c 'write -P 3 0 512k' "$TEST_IMG.target" | _filter_qemu_io
+$QEMU_IMG convert -n -O $IMGFMT "$TEST_IMG" "$TEST_IMG.target"
+$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.target"
+
 echo "*** done"
 rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/063.out b/tests/qemu-iotests/063.out
index de1c99afd8..7b691b2c9e 100644
--- a/tests/qemu-iotests/063.out
+++ b/tests/qemu-iotests/063.out
@@ -7,4 +7,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 No errors were found on the image.
 == Testing conversion to a smaller file fails ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+== Regression testing for copy offloading bug ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.target', fmt=IMGFMT size=1048576
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
 *** done
-- 
2.13.6
