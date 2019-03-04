Received: from eggs.gnu.org ([209.51.188.92]:50074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h0kWi-0005k2-EK
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h0kWg-0005q2-Pd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:08:52 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  4 Mar 2019 13:08:40 +0300
Message-Id: <1551694120-768127-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/3] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Some test cases require specific formats. The method decorator
skip_if_unsupported() checks if requested formats are whitelisted.
The test #139 was selected for a sample output:

137 3s ...
138 0s ...
139 2s ...
    [case not run] testBlkVerify (__main__.TestBlockdevDel): formats ['blkverify'] are not whitelisted
    [case not run] testQuorum (__main__.TestBlockdevDel): formats ['quorum'] are not whitelisted
140 0s ...
Not run: 131 135 136
Some cases not run in: 139
Passed all 137 tests

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/139 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 62402c1..cb97029 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -333,6 +333,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.delBlockDriverState('debug0')
         self.checkBlockDriverState('node0', False)
 
+    @iotests.skip_if_unsupported(['blkverify'])
     def testBlkVerify(self):
         self.addBlkVerify('verify0', 'node0', 'node1')
         # We cannot remove the children of a blkverify device
@@ -343,6 +344,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState('node0', False)
         self.checkBlockDriverState('node1', False)
 
+    @iotests.skip_if_unsupported(['quorum'])
     def testQuorum(self):
         if not iotests.supports_quorum():
             return
-- 
1.8.3.1
