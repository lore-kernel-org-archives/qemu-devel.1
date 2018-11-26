Received: from eggs.gnu.org ([2001:4830:134:3::10]:58128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRJOH-0005Oy-Nc
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRJOF-0004Mw-E7
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Nov 2018 17:05:13 +0100
Message-Id: <20181126160513.26369-3-kwolf@redhat.com>
In-Reply-To: <20181126160513.26369-1-kwolf@redhat.com>
References: <20181126160513.26369-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 v3 2/2] iotests: Test migration with
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Check that block node activation and inactivation works with a block
graph that is built with individually created nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/234     | 121 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/234.out |  30 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 152 insertions(+)
 create mode 100755 tests/qemu-iotests/234
 create mode 100644 tests/qemu-iotests/234.out

diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
new file mode 100755
index 0000000000..a8185b4360
--- /dev/null
+++ b/tests/qemu-iotests/234
@@ -0,0 +1,121 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2018 Red Hat, Inc.
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
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
+# Check that block node activation and inactivation works with a block g=
raph
+# that is built with individually created nodes
+
+import iotests
+import os
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_platform(['linux'])
+
+with iotests.FilePath('img') as img_path, \
+     iotests.FilePath('backing') as backing_path, \
+     iotests.FilePath('mig_fifo_a') as fifo_a, \
+     iotests.FilePath('mig_fifo_b') as fifo_b, \
+     iotests.VM(path_suffix=3D'a') as vm_a, \
+     iotests.VM(path_suffix=3D'b') as vm_b:
+
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, backing_path, =
'64M')
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M=
')
+
+    os.mkfifo(fifo_a)
+    os.mkfifo(fifo_b)
+
+    iotests.log('Launching source VM...')
+    (vm_a.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
+         .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (iot=
ests.imgfmt))
+         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-fi=
le' % (backing_path))
+         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
+         .launch())
+
+    iotests.log('Launching destination VM...')
+    (vm_b.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
+         .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (iot=
ests.imgfmt))
+         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-fi=
le' % (backing_path))
+         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
+         .add_incoming("exec: cat '%s'" % (fifo_a))
+         .launch())
+
+    # Add a child node that was created after the parent node. The rever=
se case
+    # is covered by the -blockdev options above.
+    iotests.log(vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing',
+                         overlay=3D'drive0'))
+    iotests.log(vm_b.qmp('blockdev-snapshot', node=3D'drive0-backing',
+                         overlay=3D'drive0'))
+
+    iotests.log('Enabling migration QMP events on A...')
+    iotests.log(vm_a.qmp('migrate-set-capabilities', capabilities=3D[
+        {
+            'capability': 'events',
+            'state': True
+        }
+    ]))
+
+    iotests.log('Starting migration to B...')
+    iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_a)))
+    with iotests.Timeout(3, 'Migration does not complete'):
+        while True:
+            event =3D vm_a.event_wait('MIGRATION')
+            iotests.log(event, filters=3D[iotests.filter_qmp_event])
+            if event['data']['status'] =3D=3D 'completed':
+                break
+
+    iotests.log(vm_a.qmp('query-migrate')['return']['status'])
+    iotests.log(vm_b.qmp('query-migrate')['return']['status'])
+
+    iotests.log(vm_a.qmp('query-status'))
+    iotests.log(vm_b.qmp('query-status'))
+
+    iotests.log('Add a second parent to drive0-file...')
+    iotests.log(vm_b.qmp('blockdev-add', driver=3D'raw', file=3D'drive0-=
file',
+                         node_name=3D'drive0-raw'))
+
+    iotests.log('Restart A with -incoming and second parent...')
+    vm_a.shutdown()
+    (vm_a.add_blockdev('raw,file=3Ddrive0-file,node-name=3Ddrive0-raw')
+         .add_incoming("exec: cat '%s'" % (fifo_b))
+         .launch())
+
+    iotests.log(vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing',
+                         overlay=3D'drive0'))
+
+    iotests.log('Enabling migration QMP events on B...')
+    iotests.log(vm_b.qmp('migrate-set-capabilities', capabilities=3D[
+        {
+            'capability': 'events',
+            'state': True
+        }
+    ]))
+
+    iotests.log('Starting migration back to A...')
+    iotests.log(vm_b.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_b)))
+    with iotests.Timeout(3, 'Migration does not complete'):
+        while True:
+            event =3D vm_b.event_wait('MIGRATION')
+            iotests.log(event, filters=3D[iotests.filter_qmp_event])
+            if event['data']['status'] =3D=3D 'completed':
+                break
+
+    iotests.log(vm_a.qmp('query-migrate')['return']['status'])
+    iotests.log(vm_b.qmp('query-migrate')['return']['status'])
+
+    iotests.log(vm_a.qmp('query-status'))
+    iotests.log(vm_b.qmp('query-status'))
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
new file mode 100644
index 0000000000..b9ed910b1a
--- /dev/null
+++ b/tests/qemu-iotests/234.out
@@ -0,0 +1,30 @@
+Launching source VM...
+Launching destination VM...
+{"return": {}}
+{"return": {}}
+Enabling migration QMP events on A...
+{"return": {}}
+Starting migration to B...
+{"return": {}}
+{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+completed
+completed
+{"return": {"running": false, "singlestep": false, "status": "postmigrat=
e"}}
+{"return": {"running": true, "singlestep": false, "status": "running"}}
+Add a second parent to drive0-file...
+{"return": {}}
+Restart A with -incoming and second parent...
+{"return": {}}
+Enabling migration QMP events on B...
+{"return": {}}
+Starting migration back to A...
+{"return": {}}
+{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+completed
+completed
+{"return": {"running": true, "singlestep": false, "status": "running"}}
+{"return": {"running": false, "singlestep": false, "status": "postmigrat=
e"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ddf1a5b549..8c56a0ad11 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -231,3 +231,4 @@
 231 auto quick
 232 auto quick
 233 auto quick
+234 auto quick migration
--=20
2.19.1
