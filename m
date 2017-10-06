Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uye-0001RS-74
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyd-0004Ps-AK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:19 +0200
Message-Id: <20171006155422.10135-52-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 51/54] iotests: Fix 195 if IMGFMT is part of
 TEST_DIR
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
Message-id: 20170927211334.3988-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.13.6
