Received: from eggs.gnu.org ([2001:4830:134:3::10]:52212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGY-0000sb-LQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGV-0006cj-0b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 12 Mar 2018 18:21:26 +0300
Message-Id: <20180312152126.286890-9-vsementsov@virtuozzo.com>
In-Reply-To: <20180312152126.286890-1-vsementsov@virtuozzo.com>
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 8/8] iotests: new test 209 for NBD
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: mv 206 209, make test file executable


 tests/qemu-iotests/209     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/209.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 37 insertions(+)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out

diff --git a/tests/qemu-iotests/209 b/tests/qemu-iotests/209
new file mode 100755
index 0000000000..259e991ec6
--- /dev/null
+++ b/tests/qemu-iotests/209
@@ -0,0 +1,34 @@
+#!/usr/bin/env python
+#
+# Tests for NBD BLOCK_STATUS extension
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
+import iotests
+from iotests import qemu_img_create, qemu_io, qemu_img_verbose, qemu_nbd, \
+                    file_path
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+disk, nbd_sock = file_path('disk', 'nbd-sock')
+nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+qemu_io('-f', iotests.imgfmt, '-c', 'write 0 512K', disk)
+
+qemu_nbd('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk)
+qemu_img_verbose('map', '-f', 'raw', '--output=json', nbd_uri)
diff --git a/tests/qemu-iotests/209.out b/tests/qemu-iotests/209.out
new file mode 100644
index 0000000000..0d29724e84
--- /dev/null
+++ b/tests/qemu-iotests/209.out
@@ -0,0 +1,2 @@
+[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true},
+{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data": false}]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a2dfe79d86..c16343016c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -202,3 +202,4 @@
 203 rw auto
 204 rw auto quick
 205 rw auto quick
+209 rw auto quick
-- 
2.11.1
