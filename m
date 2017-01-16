Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v5-0006Yg-Ai
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v4-0001QR-9n
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:07 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 17:13:54 +0100
Message-Id: <20170116161354.8011-3-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 9/9] iotests: Test changed Quorum filename
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

After drive-mirror replacing a Quorum child, the filename of the Quorum
BDS should reflect the change. This patch replaces the existing test for
whether the operation did actually exchange the BDS (which simply tested
whether the new BDS existed) by a test which examines the children list
contained in the Quorum BDS's filename as returned by query-block.

As a nice side effect of confirming that the new BDS actually belongs to
the Quorum BDS, this checks whether the filename was properly updated.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index bc6cf782fe..aa6efa5b5b 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+import json
 import time
 import os
 import iotests
@@ -961,9 +962,18 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait('job0')
-        self.assert_has_block_node("repair0", quorum_repair_img)
-        # TODO: a better test requiring some QEMU infrastructure will be added
-        #       to check that this file is really driven by quorum
+
+        result = self.vm.qmp('query-block')
+        for blockdev in result['return']:
+            if blockdev['device'] == 'quorum0':
+                filename = blockdev['inserted']['image']['filename']
+                self.assertEquals(filename[:5], 'json:')
+                children = json.loads(filename[5:])['children']
+                self.assertEquals(children[0]['file']['filename'], quorum_img1)
+                self.assertEquals(children[1]['file']['filename'],
+                                  quorum_repair_img)
+                self.assertEquals(children[2]['file']['filename'], quorum_img3)
+
         self.vm.shutdown()
 
 if __name__ == '__main__':
-- 
2.11.0
