Received: from eggs.gnu.org ([2001:4830:134:3::10]:45342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2a-0004VH-C9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2V-0002Sf-Te
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2T-0002L1-TS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:35 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:25:00 -0400
Message-Id: <20181029212501.5897-19-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 18/19] iotests: improve 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
2.14.5
