Received: from eggs.gnu.org ([209.51.188.92]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5Y-0008EH-Em
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5U-0005u2-FL
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:00 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:56 +0100
Message-Id: <20190308125823.32535-7-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/33] iotests: check whitelisted formats
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Some test cases require specific formats. The method decorator
skip_if_unsupported() checks if requested formats are whitelisted.
The test #139 was selected for a sample output, after running
$ ./check -qcow2 131-140

137 3s ...
138 0s ...
139 2s ...
    [case not run] testBlkDebug (__main__.TestBlockdevDel): formats ['blk=
debug'] are not whitelisted
    [case not run] testBlkVerify (__main__.TestBlockdevDel): formats ['bl=
kverify'] are not whitelisted
    [case not run] testQuorum (__main__.TestBlockdevDel): formats ['quoru=
m'] are not whitelisted
140 0s ...
Not run: 131 135 136
Some cases not run in: 139
Passed all 7 tests

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/139 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 62402c1c35..933b45121a 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -325,6 +325,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         # FIXME mirror0 disappears, drive-mirror doesn't take a referenc=
e
         #self.delBlockDriverState('mirror0')
=20
+    @iotests.skip_if_unsupported(['blkdebug'])
     def testBlkDebug(self):
         self.addBlkDebug('debug0', 'node0')
         # 'node0' is used by the blkdebug node
@@ -333,6 +334,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.delBlockDriverState('debug0')
         self.checkBlockDriverState('node0', False)
=20
+    @iotests.skip_if_unsupported(['blkverify'])
     def testBlkVerify(self):
         self.addBlkVerify('verify0', 'node0', 'node1')
         # We cannot remove the children of a blkverify device
@@ -343,6 +345,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState('node0', False)
         self.checkBlockDriverState('node1', False)
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def testQuorum(self):
         if not iotests.supports_quorum():
             return
--=20
2.20.1
