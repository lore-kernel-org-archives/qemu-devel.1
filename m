Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etJWQ-0000oT-U0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etJWP-0005ax-Np
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:49:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  6 Mar 2018 20:48:19 +0000
Message-Id: <20180306204819.11266-3-stefanha@redhat.com>
In-Reply-To: <20180306204819.11266-1-stefanha@redhat.com>
References: <20180306204819.11266-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: add 208 nbd-server +
 blockdev-snapshot-sync test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This test case adds an NBD server export and then invokes
blockdev-snapshot-sync, which changes the BlockDriverState node that the
NBD server's BlockBackend points to.  This is an interesting scenario to
test and exercises the code path fixed by the previous commit.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/208.out |  9 ++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
new file mode 100755
index 0000000000..4e82b96c82
--- /dev/null
+++ b/tests/qemu-iotests/208
@@ -0,0 +1,55 @@
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
+# Creator/Owner: Stefan Hajnoczi <stefanha@redhat.com>
+#
+# Check that the runtime NBD server does not crash when stopped after
+# blockdev-snapshot-sync.
+
+import iotests
+
+with iotests.FilePath('disk.img') as disk_img_path, \
+     iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
+     iotests.FilePath('nbd.sock') as nbd_sock_path, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk_img_path, img_size)
+
+    iotests.log('Launching VM...')
+    (vm.add_drive(disk_img_path, 'node-name=drive0-node', interface='none')
+       .launch())
+
+    iotests.log('Starting NBD server...')
+    iotests.log(vm.qmp('nbd-server-start', addr={
+            "type": "unix",
+            "data": {
+                "path": nbd_sock_path,
+            }
+        }))
+
+    iotests.log('Adding NBD export...')
+    iotests.log(vm.qmp('nbd-server-add', device='drive0-node', writable=True))
+
+    iotests.log('Creating external snapshot...')
+    iotests.log(vm.qmp('blockdev-snapshot-sync',
+        node_name='drive0-node',
+        snapshot_node_name='drive0-snapshot-node',
+        snapshot_file=disk_snapshot_img_path))
+
+    iotests.log('Stopping NBD server...')
+    iotests.log(vm.qmp('nbd-server-stop'))
diff --git a/tests/qemu-iotests/208.out b/tests/qemu-iotests/208.out
new file mode 100644
index 0000000000..3687e9d0dd
--- /dev/null
+++ b/tests/qemu-iotests/208.out
@@ -0,0 +1,9 @@
+Launching VM...
+Starting NBD server...
+{u'return': {}}
+Adding NBD export...
+{u'return': {}}
+Creating external snapshot...
+{u'return': {}}
+Stopping NBD server...
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a2dfe79d86..01c03019dd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -202,3 +202,4 @@
 203 rw auto
 204 rw auto quick
 205 rw auto quick
+208 rw auto quick
-- 
2.14.3
