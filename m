Received: from eggs.gnu.org ([2001:4830:134:3::10]:58417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2m-00005H-1H
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2l-0001Xz-1H
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:17:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:08 +0200
Message-Id: <20171026131741.5059-3-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/35] qemu-iotests: Test backing_fmt with
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This changes test case 191 to include a backing image that has
backing_fmt set in the image file, but is referenced by node name in the
qemu command line.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/191     | 3 ++-
 tests/qemu-iotests/191.out | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ac2b88fd78..28bdea8f98 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -56,7 +56,8 @@ echo === Preparing and starting VM ===
 echo
 
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
-TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
+IMGOPTS=$(_optstr_add "$IMGOPTS" "backing_fmt=$IMGFMT") \
+    TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
 _make_test_img -b "${TEST_IMG}.mid"
 TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
 
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
