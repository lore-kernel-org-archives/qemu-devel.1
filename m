Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJeJ-0001y3-KI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJeI-00058R-N2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:13:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 27 Sep 2017 23:13:34 +0200
Message-Id: <20170927211334.3988-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Fix 195 if IMGFMT is part of TEST_DIR
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

do_run_qemu() in iotest 195 first applies _filter_imgfmt when printing
qemu's command line and _filter_testdir only afterwards.  Therefore, if
the image format is part of the test directory path, _filter_testdir
will no longer apply and the actual output will differ from the
reference output even in case of success.

For example, TEST_DIR might be "/tmp/test-qcow2", in which case
_filter_imgfmt first transforms this to "/tmp/test-IMGFMT" which is no
longer recognized as the TEST_DIR by _filter_testdir.

Fix this by not applying _filter_imgfmt in do_run_qemu() but in
run_qemu() instead, and only after _filter_testdir.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/195 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 05a239cbf5..e7a403ded2 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -44,15 +44,16 @@ _supported_os Linux
 
 function do_run_qemu()
 {
-    echo Testing: "$@" | _filter_imgfmt
+    echo Testing: "$@"
     $QEMU -nographic -qmp-pretty stdio -serial none "$@"
     echo
 }
 
 function run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp \
-                          | _filter_qemu_io | _filter_generated_node_ids
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_imgfmt | _filter_qemu \
+                          | _filter_qmp | _filter_qemu_io \
+                          | _filter_generated_node_ids
 }
 
 size=64M
-- 
2.13.5
