Received: from eggs.gnu.org ([2001:4830:134:3::10]:43140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCf-0001Pa-8d
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCe-0002Wa-7y
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:44 +0100
Message-Id: <20171117181653.20651-17-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/25] iotests: Add test for failing qemu-img
 commit
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170616135847.17726-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
 tests/qemu-iotests/020.out | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 7a111100ec..cefe3a830e 100755
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
+# Just write anything so committing will not be a no-op
+$QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG commit "$TEST_IMG"
+_cleanup_test_img
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 42f6c1b151..165b70aa49 100644
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
2.13.6
