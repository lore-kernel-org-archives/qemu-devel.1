Received: from eggs.gnu.org ([2001:4830:134:3::10]:47847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSJOp-0007Pw-Pr
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSJOo-00059j-UX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 29 Nov 2018 13:18:01 +0300
Message-Id: <20181129101801.6421-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181129101801.6421-1-vsementsov@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with kvm on
 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, vsementsov@virtuozzo.com, qemu-stable@nongnu.org

This test is broken without previous commit fixing dead-lock in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/235.out |  1 +
 tests/qemu-iotests/group   |  1 +
 3 files changed, 61 insertions(+)
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
new file mode 100755
index 0000000000..e5d1ae6593
--- /dev/null
+++ b/tests/qemu-iotests/235
@@ -0,0 +1,59 @@
+#!/usr/bin/env python
+#
+# Simple mirror test
+#
+# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
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
+import sys
+import os
+import iotests
+from iotests import qemu_img_create, qemu_io, file_path
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
+
+from qemu import QEMUMachine
+
+# Note:
+# This test was added to check that mirror dead-lock was fixed (see previous
+# commit before this test addition).
+# And it didn't reproduce if at least one of the following:
+# 1. use small image size
+# 2. use raw format (not qcow2)
+# 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however, it still
+#    reproduces, if just drop kvm, but gdb failed to produce full backtraces
+#    for me)
+# 4. add iothread
+
+size = '1G'
+
+iotests.verify_image_format(supported_fmts=['raw', 'qcow2'])
+
+disk, target = file_path('disk', 'target')
+
+# prepare source image
+qemu_img_create('-f', iotests.imgfmt, disk, size)
+qemu_io('-f', iotests.imgfmt, '-c', 'write 0 ' + size, disk)
+
+vm = QEMUMachine(iotests.qemu_prog)
+vm.add_args('-machine', 'pc,accel=kvm')
+vm.add_args('-drive', 'id=src,file=' + disk)
+vm.launch()
+
+print(vm.qmp('drive-mirror', device='src', target=target, sync='full'))
+vm.event_wait('BLOCK_JOB_READY')
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
new file mode 100644
index 0000000000..d6ccbad8fa
--- /dev/null
+++ b/tests/qemu-iotests/235.out
@@ -0,0 +1 @@
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 8c56a0ad11..61a6d98ebd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -232,3 +232,4 @@
 232 auto quick
 233 auto quick
 234 auto quick migration
+235 auto quick
-- 
2.18.0
