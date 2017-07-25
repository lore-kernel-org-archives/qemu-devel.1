Received: from eggs.gnu.org ([2001:4830:134:3::10]:59826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da2Cc-0000CT-3e
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da2Cb-0003Mw-CV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:56:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 25 Jul 2017 17:56:43 +0200
Message-Id: <20170725155644.20214-2-mreitz@redhat.com>
In-Reply-To: <20170725155644.20214-1-mreitz@redhat.com>
References: <20170725155644.20214-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] iotests: Fix test 156
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On one hand, the _make_test_img invocation for creating the target image
was missing a -u because its backing file is not supposed to exist at
that point.

On the other hand, nobody noticed probably because the backing file is
created later on and _cleanup failed to remove it: The quotation marks
were misplaced so bash tried to deleted a file literally called
"$TEST_IMG{,.target}..." instead of resolving the globs.  Thus, the
files stayed around after the first run and qemu-img create did not
complain about a missing backing file on any run but the first.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/156 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 2c4a06e..e75dc4d 100755
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
2.9.4
