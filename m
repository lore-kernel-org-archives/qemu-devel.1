Received: from eggs.gnu.org ([2001:4830:134:3::10]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9z-0003h3-CA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9y-00060D-Ct
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:51 +0100
Message-Id: <20180123140201.31163-20-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/29] iotests: Fix 020 for vmdk
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

From: Max Reitz <mreitz@redhat.com>

vmdk cannot work with anything but vmdk backing files, so make the
backing file be the same format as the overlay.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-11-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020     | 9 ++++++---
 tests/qemu-iotests/020.out | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index d22ab81414..eac5080f83 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -111,10 +111,12 @@ echo
 echo 'Testing failing commit'
 echo
 
+TEST_IMG="$TEST_IMG.base" _make_test_img 1M
+
 # Create an image with a null backing file to which committing will fail (with
 # ENOSPC so we can distinguish the result from some generic EIO which may be
 # generated anywhere in the block layer)
-_make_test_img -b "json:{'driver': 'raw',
+_make_test_img -b "json:{'driver': '$IMGFMT',
                          'file': {
                              'driver': 'blkdebug',
                              'inject-error': [{
@@ -123,14 +125,15 @@ _make_test_img -b "json:{'driver': 'raw',
                                  'once': true
                              }],
                              'image': {
-                                 'driver': 'null-co'
+                                 'driver': 'file',
+                                 'filename': '$TEST_IMG.base'
                              }}}"
 
 # Just write anything so committing will not be a no-op
 $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 $QEMU_IMG commit "$TEST_IMG"
-_cleanup_test_img
+_cleanup
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 165b70aa49..4b722b2dd0 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1078,7 +1078,8 @@ No errors were found on the image.
 
 Testing failing commit
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=json:{'driver': 'raw',,
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driver': 'IMGFMT',,
                          'file': {
                              'driver': 'blkdebug',,
                              'inject-error': [{
@@ -1087,7 +1088,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=json:{'d
                                  'once': true
                              }],,
                              'image': {
-                                 'driver': 'null-co'
+                                 'driver': 'file',,
+                                 'filename': 'TEST_DIR/t.IMGFMT.base'
                              }}}
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.13.6
