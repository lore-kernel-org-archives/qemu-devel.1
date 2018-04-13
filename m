Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74L1-0005CC-DG
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74L0-0001zG-32
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:23 -0400
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 13 Apr 2018 22:26:05 +0300
Message-Id: <20180413192605.2145-4-nirsof@gmail.com>
In-Reply-To: <20180413192605.2145-1-nirsof@gmail.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test new qemu-nbd --nolist
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

Add new test module for tesing the --nolist option.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/214     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 49 insertions(+)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
new file mode 100755
index 0000000000..779e382070
--- /dev/null
+++ b/tests/qemu-iotests/214
@@ -0,0 +1,46 @@
+#!/usr/bin/env python
+#
+# Test qemu-nbd compatibility with other tools.
+#
+# Copyright (C) 2018 Nir Soffer <nirsof@gmail.com>
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
+
+iotests.verify_image_format(supported_fmts=['raw'])
+
+iotests.log('Check that listing exports is allowed by default')
+disk, nbd_sock = iotests.file_path('disk1', 'nbd-sock1')
+iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
+iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'export', disk)
+out = iotests.run('nbd-client', '-l', '--unix', nbd_sock)
+
+assert 'export' in out.splitlines(), 'Export not in %r' % out
+
+iotests.log('Check that listing exports is forbidden with --nolist')
+disk, nbd_sock = iotests.file_path('disk2', 'nbd-sock2')
+iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
+iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'secret',
+                 '--nolist', disk)
+
+# nbd-client fails when listing is not allowed, but lets not depend on 3rd
+# party tool behavior here.
+try:
+    out = iotests.run('nbd-client', '-l', '--unix', nbd_sock)
+    assert 'secret' not in out, 'Export in %r' % out
+except iotests.CommandFailed as e:
+    # This text comes from qemu-nbd.
+    assert 'Listing exports is forbidden' in e.err, 'Unexpected error: %s' % e
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
new file mode 100644
index 0000000000..dae61b5a57
--- /dev/null
+++ b/tests/qemu-iotests/214.out
@@ -0,0 +1,2 @@
+Check that listing exports is allowed by default
+Check that listing exports is forbidden with --nolist
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 52a80f3f9e..a820dcb91f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -212,3 +212,4 @@
 211 rw auto quick
 212 rw auto quick
 213 rw auto quick
+214 rw auto quick
-- 
2.14.3
