Received: from eggs.gnu.org ([2001:4830:134:3::10]:34214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMr-00044m-FR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMq-0006Ij-Pu
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 26 Jun 2018 16:50:34 +0300
Message-Id: <20180626135035.133432-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180626135035.133432-1-vsementsov@virtuozzo.com>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/6] iotests: improve 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

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
---
 tests/qemu-iotests/169 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index df408f8367..8b7947d650 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -24,6 +24,7 @@ import time
 import itertools
 import operator
 import new
+import re
 from iotests import qemu_img
 
 
@@ -133,6 +134,14 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
         if should_migrate:
             self.vm_b.shutdown()
+
+            # catch 'Could not reopen qcow2 layer: Bitmap already exists'
+            # possible error
+            log = self.vm_b.get_log()
+            log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+            log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+            self.assertEqual(log, '')
+
             # recreate vm_b, as we don't want -incoming option (this will lead
             # to "cat" process left alive after test finish)
             self.vm_b = iotests.VM(path_suffix='b')
-- 
2.11.1
