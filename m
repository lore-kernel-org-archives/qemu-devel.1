Received: from eggs.gnu.org ([2001:4830:134:3::10]:34701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0LMa-0004jG-1p
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0LMW-00052m-2G
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:12:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0LMV-00052X-V0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E60A6401DE65
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:12:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:11:57 +0800
Message-Id: <20180326061157.24865-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com

If there are more than one events, wait_until_completed() might return
the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
will continue to run even if completed is set to True.

It never happened before, but it can be triggered when OOB is enabled
due to the RESUME startup message. Fix that up by removing the boolean
and make sure we return the correct event.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qemu-iotests/iotests.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b5d7945af8..11704e6583 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -470,18 +470,14 @@ class QMPTestCase(unittest.TestCase):
 
     def wait_until_completed(self, drive='drive0', check_offset=True):
         '''Wait for a block job to finish, returning the event'''
-        completed = False
-        while not completed:
-            for event in self.vm.get_qmp_events(wait=True):
-                if event['event'] == 'BLOCK_JOB_COMPLETED':
-                    self.assert_qmp(event, 'data/device', drive)
-                    self.assert_qmp_absent(event, 'data/error')
-                    if check_offset:
-                        self.assert_qmp(event, 'data/offset', event['data']['len'])
-                    completed = True
-
-        self.assert_no_active_block_jobs()
-        return event
+        for event in self.vm.get_qmp_events(wait=True):
+            if event['event'] == 'BLOCK_JOB_COMPLETED':
+                self.assert_qmp(event, 'data/device', drive)
+                self.assert_qmp_absent(event, 'data/error')
+                if check_offset:
+                    self.assert_qmp(event, 'data/offset', event['data']['len'])
+                self.assert_no_active_block_jobs()
+                return event
 
     def wait_ready(self, drive='drive0'):
         '''Wait until a block job BLOCK_JOB_READY event'''
-- 
2.14.3
