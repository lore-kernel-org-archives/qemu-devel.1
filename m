Received: from eggs.gnu.org ([2001:4830:134:3::10]:54884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRu-0000Wo-7x
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRp-0005cT-Ut
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:29 +0200
Message-Id: <20170801144632.3831-13-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] qemu-iotests/162: Fix leaked temporary
 files
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

qemu-iotests 162 left qemu-nbd.pid behind in the scratch directory, and
potentially a file called '42' in the current directory. Make sure to
clean it up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/162 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index cad2bd70ab..477a806360 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -28,6 +28,13 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+_cleanup()
+{
+    rm -f "${TEST_DIR}/qemu-nbd.pid"
+    rm -f 42
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
-- 
2.13.3
