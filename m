Received: from eggs.gnu.org ([2001:4830:134:3::10]:45720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDf-00026T-SF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDe-0007vh-Nv
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:09 -0400
Message-Id: <20180723222210.11077-7-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 6/7] iotests: improve 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Before previous patch, iotest 169 was actually broken for the case
test_persistent__not_migbitmap__offline_shared, while formally
passing.

After migration log of vm_b had message:

    qemu-system-x86_64: Could not reopen qcow2 layer: Bitmap already
    exists: bitmap0

which means that invalidation failed and bs->drv = NULL.

It was because we've loaded bitmap twice: on open and on invalidation.

Add code to 169, to catch such fails.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/169 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 87edc85f43..24027da8e1 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -24,6 +24,7 @@ import time
 import itertools
 import operator
 import new
+import re
 from iotests import qemu_img
 
 
@@ -136,6 +137,16 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
         if should_migrate:
             self.vm_b.shutdown()
+
+            # catch 'Could not reopen qcow2 layer: Bitmap already exists'
+            # possible error
+            log = self.vm_b.get_log()
+            log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+            log = re.sub(r'Receiving block device images\n', '', log)
+            log = re.sub(r'Completed \d+ %\r?\n?', '', log)
+            log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+            self.assertEqual(log, '')
+
             # recreate vm_b, as we don't want -incoming option (this will lead
             # to "cat" process left alive after test finish)
             self.vm_b = iotests.VM(path_suffix='b')
-- 
2.14.4
