Received: from eggs.gnu.org ([2001:4830:134:3::10]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTu-0001Vz-2H
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTp-0004G3-8X
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:33 +0300
Message-Id: <20180731173033.75467-11-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 10/10] iotests: test nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add test, which starts backup to nbd target and restarts nbd server
during backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/220        | 67 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out    |  7 +++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py |  4 +++
 4 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
new file mode 100755
index 0000000000..c9702a7dad
--- /dev/null
+++ b/tests/qemu-iotests/220
@@ -0,0 +1,67 @@
+#!/usr/bin/env python
+#
+# Test nbd reconnect
+#
+# Copyright (c) 2018 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import time
+
+import iotests
+from iotests import qemu_img_create, file_path, qemu_nbd_popen
+
+disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
+nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
+
+qemu_img_create('-f', iotests.imgfmt, disk_a, '5M')
+qemu_img_create('-f', iotests.imgfmt, disk_b, '5M')
+srv = qemu_nbd_popen('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk_b)
+time.sleep(1)
+
+vm = iotests.VM().add_drive(disk_a)
+vm.launch()
+vm.hmp_qemu_io('drive0', 'write 0 5M')
+
+print 'blockdev-add:', vm.qmp('blockdev-add', node_name='backup0', driver='raw',
+                              file={'driver':'nbd',
+                                    'export': 'exp',
+                                    'server': {'type': 'unix',
+                                               'path': nbd_sock}})
+print 'blockdev-backup:', vm.qmp('blockdev-backup', device='drive0',
+                                 sync='full', target='backup0')
+
+time.sleep(1)
+print 'Kill NBD server'
+srv.kill()
+
+jobs = vm.qmp('query-block-jobs')['return']
+if jobs and jobs[0]['offset'] < jobs[0]['len']:
+    print 'Backup job is still in progress'
+
+time.sleep(1)
+
+print 'Start NBD server'
+srv = qemu_nbd_popen('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk_b)
+
+try:
+    e = vm.event_wait('BLOCK_JOB_COMPLETED')
+    print e['event'], ':', e['data']
+except:
+    pass
+
+print 'blockdev-del:', vm.qmp('blockdev-del', node_name='backup0')
+srv.kill()
+vm.shutdown()
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
new file mode 100644
index 0000000000..dae1a49d9f
--- /dev/null
+++ b/tests/qemu-iotests/220.out
@@ -0,0 +1,7 @@
+blockdev-add: {u'return': {}}
+blockdev-backup: {u'return': {}}
+Kill NBD server
+Backup job is still in progress
+Start NBD server
+BLOCK_JOB_COMPLETED : {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 5242880, u'offset': 5242880}
+blockdev-del: {u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b973dc842d..ee2473c6a3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -219,6 +219,7 @@
 217 rw auto quick
 218 rw auto quick
 219 rw auto
+220 rw auto quick
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4e67fbbe96..17bc8c8e32 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -185,6 +185,10 @@ def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
 
+def qemu_nbd_popen(*args):
+    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
+    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+
 def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
     '''Return True if two image files are identical'''
     return qemu_img('compare', '-f', fmt1,
-- 
2.11.1
