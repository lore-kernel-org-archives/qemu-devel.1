Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUu-0007MY-GY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUs-0000vA-Hs
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:37 -0500
Message-Id: <20180313171345.659672-10-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 09/17] iotests: add 208 nbd-server +
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

This test case adds an NBD server export and then invokes
blockdev-snapshot-sync, which changes the BlockDriverState node that the
NBD server's BlockBackend points to.  This is an interesting scenario to
test and exercises the code path fixed by the previous commit.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180306204819.11266-3-stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/208.out |  9 ++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
new file mode 100755
index 00000000000..4e82b96c829
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
index 00000000000..3687e9d0dd4
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
index c401791fcdb..890fe91f2b1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -204,3 +204,4 @@
 205 rw auto quick
 206 rw auto
 207 rw auto
+208 rw auto quick
-- 
2.14.3
