Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRd-0000Cy-FC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRc-0005Q6-Jt
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:19 +0200
Message-Id: <20170801144632.3831-3-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] iotests: Fix test 156
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

From: Max Reitz <mreitz@redhat.com>

On one hand, the _make_test_img invocation for creating the target image
was missing a -u because its backing file is not supposed to exist at
that point.

On the other hand, nobody noticed probably because the backing file is
created later on and _cleanup failed to remove it: The quotation marks
were misplaced so bash tried to delete a file literally called
"$TEST_IMG{,.target}..." instead of performing brace expansion. Thus, the
files stayed around after the first run and qemu-img create did not
complain about a missing backing file on any run but the first.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/156 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 2c4a06e2d8..e75dc4d743 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -38,7 +38,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "$TEST_IMG{,.target}{,.backing,.overlay}"
+    rm -f "$TEST_IMG"{,.target}{,.backing,.overlay}
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -83,7 +83,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 # Create target image
-TEST_IMG="$TEST_IMG.target.overlay" _make_test_img -b "$TEST_IMG.target" 1M
+TEST_IMG="$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.target" 1M
 
 # Mirror snapshot
 _send_qemu_cmd $QEMU_HANDLE \
-- 
2.13.3
