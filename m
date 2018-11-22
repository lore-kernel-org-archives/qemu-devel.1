Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1S-0003O8-Kt
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1P-00073v-M9
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:18 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 22 Nov 2018 21:48:05 +0300
Message-Id: <1542912487-279165-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] iotests: allow resume_drive by node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

After node graph changes, we may not be able to resume_drive by device
name (backing files are not recursively searched). So, lets allow to
resume by node-name. Set constant name for breakpoints, to avoid
introducing extra parameters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 27bb2b6..78a96f0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -407,11 +407,11 @@ class VM(qtest.QEMUQtestMachine):
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
@@ -535,13 +535,14 @@ class QMPTestCase(unittest.TestCase):
         self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
                          self.vm.flatten_qmp_object(reference))
 
-    def cancel_and_wait(self, drive='drive0', force=False, resume=False):
+    def cancel_and_wait(self, drive='drive0', force=False,
+                        resume=False,resume_node=None):
         '''Cancel a block job and wait for it to finish, returning the event'''
         result = self.vm.qmp('block-job-cancel', device=drive, force=force)
         self.assert_qmp(result, 'return', {})
 
         if resume:
-            self.vm.resume_drive(drive)
+            self.vm.resume_drive(resume_node or drive)
 
         cancelled = False
         result = None
-- 
1.8.3.1
