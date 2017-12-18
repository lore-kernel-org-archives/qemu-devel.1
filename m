Received: from eggs.gnu.org ([2001:4830:134:3::10]:46230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXf-0007Nm-CK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXe-0007wJ-4Q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwXd-0007uf-5I
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:30 +0000
Message-Id: <20171218143530.12082-24-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 23/23] qemu-iotests: add 203 savevm with
 IOThreads test
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

This test case will prevent future regressions with savevm and
IOThreads.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171207201320.19284-7-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/203     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/203.out |  6 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 66 insertions(+)
 create mode 100755 tests/qemu-iotests/203
 create mode 100644 tests/qemu-iotests/203.out

diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
new file mode 100755
index 0000000000..2c811917d8
--- /dev/null
+++ b/tests/qemu-iotests/203
@@ -0,0 +1,59 @@
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
+# Check that QMP 'migrate' with multiple drives on a single IOThread completes
+# successfully.  This particular command triggered a hang in the source QEMU
+# process due to recursive AioContext locking in bdrv_invalidate_all() and
+# BDRV_POLL_WHILE().
+
+import iotests
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+iotests.verify_platform(['linux'])
+
+with iotests.FilePath('disk0.img') as disk0_img_path, \
+     iotests.FilePath('disk1.img') as disk1_img_path, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk0_img_path, img_size)
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk1_img_path, img_size)
+
+    iotests.log('Launching VM...')
+    (vm.add_object('iothread,id=iothread0')
+       .add_drive(disk0_img_path, 'node-name=drive0-node', interface='none')
+       .add_drive(disk1_img_path, 'node-name=drive1-node', interface='none')
+       .launch())
+
+    iotests.log('Setting IOThreads...')
+    iotests.log(vm.qmp('x-blockdev-set-iothread',
+                       node_name='drive0-node', iothread='iothread0',
+                       force=True))
+    iotests.log(vm.qmp('x-blockdev-set-iothread',
+                       node_name='drive1-node', iothread='iothread0',
+                       force=True))
+
+    iotests.log('Starting migration...')
+    iotests.log(vm.qmp('migrate', uri='exec:cat >/dev/null'))
+    while True:
+        vm.get_qmp_event(wait=60.0)
+        result = vm.qmp('query-migrate')
+        status = result.get('return', {}).get('status', None)
+        if status == 'completed':
+            break
diff --git a/tests/qemu-iotests/203.out b/tests/qemu-iotests/203.out
new file mode 100644
index 0000000000..3f1ff900e4
--- /dev/null
+++ b/tests/qemu-iotests/203.out
@@ -0,0 +1,6 @@
+Launching VM...
+Setting IOThreads...
+{u'return': {}}
+{u'return': {}}
+Starting migration...
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d0ee1e2e55..93d96fb22f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -198,3 +198,4 @@
 198 rw auto
 200 rw auto
 202 rw auto quick
+203 rw auto
-- 
2.14.3
