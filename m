Received: from eggs.gnu.org ([2001:4830:134:3::10]:51220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxZ-0001tq-0x
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxU-00012u-Pk
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:47 +0300
Message-Id: <1518702707-7077-10-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 9/9] iotests: new test 206 for NBD BLOCK_STATUS
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
 tests/qemu-iotests/206     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/206.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 37 insertions(+)
 create mode 100644 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
new file mode 100644
index 0000000000..259e991ec6
--- /dev/null
+++ b/tests/qemu-iotests/206
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
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
new file mode 100644
index 0000000000..0d29724e84
--- /dev/null
+++ b/tests/qemu-iotests/206.out
@@ -0,0 +1,2 @@
+[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true},
+{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data": false}]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a2dfe79d86..2c3925566a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -202,3 +202,4 @@
 203 rw auto
 204 rw auto quick
 205 rw auto quick
+206 rw auto quick
-- 
2.11.1
