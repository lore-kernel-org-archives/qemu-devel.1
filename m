Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db573-0001Vs-J6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db572-0007ku-J9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Jul 2017 15:14:50 +0200
Message-Id: <20170728131452.15316-6-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
References: <20170728131452.15316-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 5/7] qemu-iotests/162: Fix leaked
 temporary files
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

qemu-iotests 162 left qemu-nbd.pid behind in the scratch directory, and
potentially a file called '42' in the current directory. Make sure to
clean it up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
