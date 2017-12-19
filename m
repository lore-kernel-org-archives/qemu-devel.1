Received: from eggs.gnu.org ([2001:4830:134:3::10]:57921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZs-0004wQ-A2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZr-0007Bn-28
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJZq-0007B4-PJ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:36 +0000
Message-Id: <20171219151144.11120-16-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 15/23] qemu-iotests: add 202 external
 snapshots IOThread test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

QMP 'transaction' blockdev-snapshot-sync with multiple disks in an
IOThread is an untested code path.  Several bugs have been found in
connection with this command.  This patch adds a test case to prevent
future regressions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-10-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/202     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/202.out | 11 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 107 insertions(+)
 create mode 100755 tests/qemu-iotests/202
 create mode 100644 tests/qemu-iotests/202.out

diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
new file mode 100755
index 0000000000..581ca34d79
--- /dev/null
+++ b/tests/qemu-iotests/202
@@ -0,0 +1,95 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+# Check that QMP 'transaction' blockdev-snapshot-sync with multiple drives on a
+# single IOThread completes successfully.  This particular command triggered a
+# hang due to recursive AioContext locking and BDRV_POLL_WHILE().  Protect
+# against regressions.
+
+import iotests
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+iotests.verify_platform(['linux'])
+
+with iotests.FilePath('disk0.img') as disk0_img_path, \
+     iotests.FilePath('disk1.img') as disk1_img_path, \
+     iotests.FilePath('disk0-snap.img') as disk0_snap_img_path, \
+     iotests.FilePath('disk1-snap.img') as disk1_snap_img_path, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk0_img_path, img_size)
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk1_img_path, img_size)
+
+    iotests.log('Launching VM...')
+    vm.launch()
+
+    iotests.log('Adding IOThread...')
+    iotests.log(vm.qmp('object-add',
+                       qom_type='iothread',
+                       id='iothread0'))
+
+    iotests.log('Adding blockdevs...')
+    iotests.log(vm.qmp('blockdev-add',
+                       driver=iotests.imgfmt,
+                       node_name='disk0',
+                       file={
+                           'driver': 'file',
+                           'filename': disk0_img_path,
+                       }))
+    iotests.log(vm.qmp('blockdev-add',
+                       driver=iotests.imgfmt,
+                       node_name='disk1',
+                       file={
+                           'driver': 'file',
+                           'filename': disk1_img_path,
+                       }))
+
+    iotests.log('Setting iothread...')
+    iotests.log(vm.qmp('x-blockdev-set-iothread',
+                       node_name='disk0',
+                       iothread='iothread0'))
+    iotests.log(vm.qmp('x-blockdev-set-iothread',
+                       node_name='disk1',
+                       iothread='iothread0'))
+
+    iotests.log('Creating external snapshots...')
+    iotests.log(vm.qmp(
+                  'transaction',
+                  actions=[
+                      {
+                          'data': {
+                              'node-name': 'disk0',
+                              'snapshot-file': disk0_snap_img_path,
+                              'snapshot-node-name': 'disk0-snap',
+                              'mode': 'absolute-paths',
+                              'format': iotests.imgfmt,
+                          },
+                          'type': 'blockdev-snapshot-sync'
+                      }, {
+                          'data': {
+                              'node-name': 'disk1',
+                              'snapshot-file': disk1_snap_img_path,
+                              'snapshot-node-name': 'disk1-snap',
+                              'mode': 'absolute-paths',
+                              'format': iotests.imgfmt
+                          },
+                          'type': 'blockdev-snapshot-sync'
+                      }
+                  ]))
diff --git a/tests/qemu-iotests/202.out b/tests/qemu-iotests/202.out
new file mode 100644
index 0000000000..d5ea374e17
--- /dev/null
+++ b/tests/qemu-iotests/202.out
@@ -0,0 +1,11 @@
+Launching VM...
+Adding IOThread...
+{u'return': {}}
+Adding blockdevs...
+{u'return': {}}
+{u'return': {}}
+Setting iothread...
+{u'return': {}}
+{u'return': {}}
+Creating external snapshots...
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 3e688678dd..d0ee1e2e55 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -197,3 +197,4 @@
 197 rw auto quick
 198 rw auto
 200 rw auto
+202 rw auto quick
-- 
2.14.3
