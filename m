Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tE7-0003K9-3k
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tE3-0002bk-4V
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 10 Apr 2018 08:21:58 -0500
Message-Id: <20180410132200.187832-2-eblake@redhat.com>
In-Reply-To: <20180410132200.187832-1-eblake@redhat.com>
References: <20180410132200.187832-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Peter Xu <peterx@redhat.com>

If there are more than one events, wait_until_completed() might return
the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
will continue to run even if completed is set to True.

It never happened before, but it can be triggered when OOB is enabled
due to the RESUME startup message. Fix that up.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180408030542.17855-1-peterx@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b5d7945af88..119c8e270a5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -470,18 +470,15 @@ class QMPTestCase(unittest.TestCase):

     def wait_until_completed(self, drive='drive0', check_offset=True):
         '''Wait for a block job to finish, returning the event'''
-        completed = False
-        while not completed:
+        while True:
             for event in self.vm.get_qmp_events(wait=True):
                 if event['event'] == 'BLOCK_JOB_COMPLETED':
                     self.assert_qmp(event, 'data/device', drive)
                     self.assert_qmp_absent(event, 'data/error')
                     if check_offset:
                         self.assert_qmp(event, 'data/offset', event['data']['len'])
-                    completed = True
-
-        self.assert_no_active_block_jobs()
-        return event
+                    self.assert_no_active_block_jobs()
+                    return event

     def wait_ready(self, drive='drive0'):
         '''Wait until a block job BLOCK_JOB_READY event'''
-- 
2.14.3
