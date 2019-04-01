Received: from eggs.gnu.org ([209.51.188.92]:41482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45C-0001zL-HK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45A-0003p1-RB
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34802
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45A-0003iV-IW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1qYL095735
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegyhg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:53 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:52 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:47 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-74-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 73/97] iotests: simple mirror test with kvm on
 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This test is broken without previous commit fixing dead-lock in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit db5e8210adbafe9c6383d8364345a8c545d38e62)
*drop context deps from test groups not in 3.0
*modify expected QMP output to match encoding for 3.0
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/235     | 76 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/235.out |  3 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
new file mode 100755
index 0000000000..da044ed34e
--- /dev/null
+++ b/tests/qemu-iotests/235
@@ -0,0 +1,76 @@
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
+from iotests import qemu_img_create, qemu_io, file_path, log
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
+size = 1 * 1024 * 1024 * 1024
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+disk = file_path('disk')
+
+# prepare source image
+qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
+                str(size))
+
+vm = QEMUMachine(iotests.qemu_prog)
+vm.add_args('-machine', 'pc,accel=kvm')
+vm.add_args('-drive', 'id=src,file=' + disk)
+vm.launch()
+
+log(vm.qmp('object-add', qom_type='throttle-group', id='tg0',
+           props={ 'x-bps-total': size }))
+
+log(vm.qmp('blockdev-add',
+           **{ 'node-name': 'target',
+               'driver': 'throttle',
+               'throttle-group': 'tg0',
+               'file': {
+                   'driver': 'null-co',
+                   'size': size
+                } }))
+
+log(vm.qmp('blockdev-mirror', device='src', target='target', sync='full'))
+
+try:
+    vm.event_wait('BLOCK_JOB_READY', timeout=10.0)
+except:
+    vm.shutdown()
+    raise
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
new file mode 100644
index 0000000000..db7882d4cc
--- /dev/null
+++ b/tests/qemu-iotests/235.out
@@ -0,0 +1,3 @@
+{u'return': {}}
+{u'return': {}}
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 31f6e77dcb..d098120afa 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -227,3 +227,4 @@
 227 auto quick
 229 auto quick
 231 auto quick
+235 auto quick
-- 
2.17.1
