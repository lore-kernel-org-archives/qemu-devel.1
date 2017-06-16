Received: from eggs.gnu.org ([2001:4830:134:3::10]:32891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLrm5-0007Pp-4H
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLrm4-0007xp-3u
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:58:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 16 Jun 2017 15:58:47 +0200
Message-Id: <20170616135847.17726-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
In order to pass, this depends on "fix: avoid an infinite loop or a
dangling pointer problem in img_commit"
(http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00443.html)
and on the "block: Don't compare strings in bdrv_reopen_prepare()"
series
(http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html).
---
 tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
 tests/qemu-iotests/020.out | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 7a11110..83d5ef0 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -110,6 +110,33 @@ for offset in $TEST_OFFSETS; do
     io_zero readv $(( offset + 64 * 1024 + 65536 * 4 )) 65536 65536 1
 done
 _check_test_img
+_cleanup
+TEST_IMG=$TEST_IMG_SAVE
+
+echo
+echo 'Testing failing commit'
+echo
+
+# Create an image with a null backing file to which committing will fail (with
+# ENOSPC so we can distinguish the result from some generic EIO which may be
+# generated anywhere in the block layer)
+_make_test_img -b "json:{'driver': 'raw',
+                         'file': {
+                             'driver': 'blkdebug',
+                             'inject-error': [{
+                                 'event': 'write_aio',
+                                 'errno': 28,
+                                 'once': true
+                             }],
+                             'image': {
+                                 'driver': 'null-co'
+                             }}}"
+
+# Just write anything so comitting will not be a no-op
+$QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG commit "$TEST_IMG"
+_cleanup_test_img
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 42f6c1b..165b70a 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1075,4 +1075,21 @@ read 65536/65536 bytes at offset 4295098368
 read 65536/65536 bytes at offset 4295294976
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+Testing failing commit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=json:{'driver': 'raw',,
+                         'file': {
+                             'driver': 'blkdebug',,
+                             'inject-error': [{
+                                 'event': 'write_aio',,
+                                 'errno': 28,,
+                                 'once': true
+                             }],,
+                             'image': {
+                                 'driver': 'null-co'
+                             }}}
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Block job failed: No space left on device
 *** done
-- 
2.9.4
