Received: from eggs.gnu.org ([209.51.188.92]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9w-0002LR-P3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9v-0003LJ-U8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:04 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu,  7 Mar 2019 16:34:00 +0300
Message-Id: <1551965640-164939-5-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/4] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Some test cases require specific formats. The method decorator
skip_if_unsupported() checks if requested formats are whitelisted.
The test #139 was selected for a sample output, after running
$ ./check -qcow2 131-140

137 3s ...
138 0s ...
139 2s ...
    [case not run] testBlkDebug (__main__.TestBlockdevDel): formats ['blkdebug'] are not whitelisted
    [case not run] testBlkVerify (__main__.TestBlockdevDel): formats ['blkverify'] are not whitelisted
    [case not run] testQuorum (__main__.TestBlockdevDel): formats ['quorum'] are not whitelisted
140 0s ...
Not run: 131 135 136
Some cases not run in: 139
Passed all 7 tests

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/139 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 62402c1..933b451 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -325,6 +325,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         # FIXME mirror0 disappears, drive-mirror doesn't take a reference
         #self.delBlockDriverState('mirror0')
 
+    @iotests.skip_if_unsupported(['blkdebug'])
     def testBlkDebug(self):
         self.addBlkDebug('debug0', 'node0')
         # 'node0' is used by the blkdebug node
@@ -333,6 +334,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.delBlockDriverState('debug0')
         self.checkBlockDriverState('node0', False)
 
+    @iotests.skip_if_unsupported(['blkverify'])
     def testBlkVerify(self):
         self.addBlkVerify('verify0', 'node0', 'node1')
         # We cannot remove the children of a blkverify device
@@ -343,6 +345,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState('node0', False)
         self.checkBlockDriverState('node1', False)
 
+    @iotests.skip_if_unsupported(['quorum'])
     def testQuorum(self):
         if not iotests.supports_quorum():
             return
-- 
1.8.3.1
