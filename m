Received: from eggs.gnu.org ([2001:4830:134:3::10]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OD-0008JC-Vk
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-00052z-JV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:28 +0300
Message-Id: <20181015160633.63130-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 06/11] iotests: allow resume_drive by node
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

After node graph changes, we may not be able to resume_drive by device
name (backing files are not recursively searched). So, lets allow to
resume by node-name. Set constant name for breakpoints, to avoid
introducing extra parameters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index bc0b8851bd..5cc47c85de 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -404,11 +404,11 @@ class VM(qtest.QEMUQtestMachine):
             self.pause_drive(drive, "write_aio")
             return
         self.qmp('human-monitor-command',
-                    command_line='qemu-io %s "break %s bp_%s"' % (drive, event, drive))
+                    command_line='qemu-io %s "break %s bp_0"' % (drive, event))
 
     def resume_drive(self, drive):
         self.qmp('human-monitor-command',
-                    command_line='qemu-io %s "remove_break bp_%s"' % (drive, drive))
+                    command_line='qemu-io %s "remove_break bp_0"' % (drive))
 
     def hmp_qemu_io(self, drive, cmd):
         '''Write to a given drive using an HMP command'''
@@ -531,13 +531,14 @@ class QMPTestCase(unittest.TestCase):
         self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
                          self.vm.flatten_qmp_object(reference))
 
-    def cancel_and_wait(self, drive='drive0', force=False, resume=False):
+    def cancel_and_wait(self, drive='drive0', force=False, resume=False,
+                        resume_node=None):
         '''Cancel a block job and wait for it to finish, returning the event'''
         result = self.vm.qmp('block-job-cancel', device=drive, force=force)
         self.assert_qmp(result, 'return', {})
 
         if resume:
-            self.vm.resume_drive(drive)
+            self.vm.resume_drive(resume_node or drive)
 
         cancelled = False
         result = None
-- 
2.18.0
