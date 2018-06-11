Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmV-0004gT-3U
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmU-0001oV-03
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:59 +0200
Message-Id: <20180611142611.6609-18-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 17/29] iotests: Let 216 make use of qemu-io's
 exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

As a showcase of how you can use qemu-io's exit code to determine
success or failure (same for qemu-img), this test is changed to use
qemu_io_silent() instead of qemu_io(), and to assert the exit code
instead of logging the filtered result.

One real advantage of this is that in case of an error, you get a
backtrace that helps you locate the issue in the test file quickly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509194302.21585-6-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/216     | 23 ++++++++++++-----------
 tests/qemu-iotests/216.out | 17 ++---------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index ca9b47a7fd..3c0ae54b44 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -20,7 +20,7 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
 
 import iotests
-from iotests import log, qemu_img_pipe, qemu_io, filter_qemu_io
+from iotests import log, qemu_img, qemu_io_silent
 
 # Need backing file support
 iotests.verify_image_format(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk'])
@@ -50,14 +50,13 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Setting up images ---')
     log('')
 
-    qemu_img_pipe('create', '-f', iotests.imgfmt, base_img_path, '64M')
+    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
+    assert qemu_io_silent(base_img_path, '-c', 'write -P 1 0M 1M') == 0
+    assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
+                    top_img_path) == 0
+    assert qemu_io_silent(top_img_path,  '-c', 'write -P 2 1M 1M') == 0
 
-    log(filter_qemu_io(qemu_io(base_img_path, '-c', 'write -P 1 0M 1M')))
-
-    qemu_img_pipe('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                  top_img_path)
-
-    log(filter_qemu_io(qemu_io(top_img_path,  '-c', 'write -P 2 1M 1M')))
+    log('Done')
 
     log('')
     log('--- Doing COR ---')
@@ -110,6 +109,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Checking COR result ---')
     log('')
 
-    log(filter_qemu_io(qemu_io(base_img_path, '-c', 'discard 0 64M')))
-    log(filter_qemu_io(qemu_io(top_img_path,  '-c', 'read -P 1 0M 1M')))
-    log(filter_qemu_io(qemu_io(top_img_path,  '-c', 'read -P 2 1M 1M')))
+    assert qemu_io_silent(base_img_path, '-c', 'discard 0 64M') == 0
+    assert qemu_io_silent(top_img_path,  '-c', 'read -P 1 0M 1M') == 0
+    assert qemu_io_silent(top_img_path,  '-c', 'read -P 2 1M 1M') == 0
+
+    log('Done')
diff --git a/tests/qemu-iotests/216.out b/tests/qemu-iotests/216.out
index d3fc590d29..45ea857ee1 100644
--- a/tests/qemu-iotests/216.out
+++ b/tests/qemu-iotests/216.out
@@ -3,12 +3,7 @@
 
 --- Setting up images ---
 
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-wrote 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
+Done
 
 --- Doing COR ---
 
@@ -17,12 +12,4 @@ wrote 1048576/1048576 bytes at offset 1048576
 
 --- Checking COR result ---
 
-discard 67108864/67108864 bytes at offset 0
-64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-read 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-read 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
+Done
-- 
2.17.1
