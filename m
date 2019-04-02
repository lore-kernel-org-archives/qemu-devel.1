Received: from eggs.gnu.org ([209.51.188.92]:59605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIr1-0002M3-AG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIr0-0003ED-8J
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:06 +0200
Message-Id: <20190402124907.24421-9-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] block: test block-stream with a base node
 that is used by block-commit
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

From: Alberto Garcia <berto@igalia.com>

The base node of a block-stream operation indicates the first image
from the backing chain starting from which no data is copied to the
top node.

The block-stream job allows others to use that base image, so a second
block-stream job could be writing to it at the same time. An important
restriction is that the base image must not disappear while the stream
job is ongoing. stream_start() freezes the backing chain from top to
base with that purpose but it does it too late in the code so there is
a race condition there.

This bug was fixed in the previous commit, and this patch contains an
iotest for this scenario.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030     | 17 +++++++++++++++++
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 276e06b5ba..c6311d1825 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -314,6 +314,23 @@ class TestParallelOps(iotests.QMPTestCase):
=20
         self.wait_until_completed(drive=3D'commit-drive0')
=20
+    # In this case the base node of the stream job is the same as the
+    # top node of commit job. Since block-commit removes the top node
+    # when it finishes, this is not allowed.
+    def test_overlapping_4(self):
+        self.assert_no_active_block_jobs()
+
+        # Commit from node2 into node0
+        result =3D self.vm.qmp('block-commit', device=3D'drive0', top=3D=
self.imgs[2], base=3Dself.imgs[0])
+        self.assert_qmp(result, 'return', {})
+
+        # Stream from node2 into node4
+        result =3D self.vm.qmp('block-stream', device=3D'node4', base_no=
de=3D'node2', job_id=3D'node4')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+        self.wait_until_completed()
+        self.assert_no_active_block_jobs()
+
     # Test a block-stream and a block-commit job in parallel
     # Here the stream job is supposed to finish quickly in order to repr=
oduce
     # the scenario that triggers the bug fixed in 3d5d319e1221 and 1a63a=
907507
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 42314e9c00..4fd1c2dcd2 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-........................
+.........................
 ----------------------------------------------------------------------
-Ran 24 tests
+Ran 25 tests
=20
 OK
--=20
2.20.1
