Received: from eggs.gnu.org ([2001:4830:134:3::10]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4TXa-00021E-9n
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4TXW-0007YF-6G
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:12:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 17 Oct 2017 17:11:49 +0200
Message-Id: <20171017151149.28062-1-kwolf@redhat.com>
In-Reply-To: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
Subject: [Qemu-devel] [PATCH 2/1] qemu-iotests: Test backing_fmt with
 backing node reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

This changes test case 191 to include a backing image that has
backing_fmt set in the image file, but is referenced by node name in the
qemu command line.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/191     | 5 +++--
 tests/qemu-iotests/191.out | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ac2b88fd78..00202efd47 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -56,9 +56,10 @@ echo === Preparing and starting VM ===
 echo
 
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
-TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
+IMGOPTS=$(_optstr_add "$IMGOPTS" "backing_fmt=$IMGFMT") \
+    TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base" $size
 _make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
+TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" $size
 
 $QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io
 
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 7bfcd2d5d8..6157fa520f 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -3,7 +3,7 @@ QA output created by 191
 === Preparing and starting VM ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
 Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
 wrote 65536/65536 bytes at offset 1048576
-- 
2.13.6
