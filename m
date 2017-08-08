Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52c-0000Yd-Nl
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52X-0002Kc-Oh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:37 +0200
Message-Id: <20170808135838.11525-18-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/18] qemu-iotests: Test reopen between
 read-only and read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

This serves as a regression test for the bugs that were just fixed for
bdrv_reopen() between read-only and read-write mode.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/187     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/187.out | 18 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/qemu-iotests/187
 create mode 100644 tests/qemu-iotests/187.out

diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
new file mode 100755
index 0000000000..7bb783363c
--- /dev/null
+++ b/tests/qemu-iotests/187
@@ -0,0 +1,69 @@
+#!/bin/bash
+#
+# Test switching between read-only and read-write
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
+
+# creator
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+    rm -f "$TEST_IMG.2"
+    rm -f "$TEST_IMG.3"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=64M
+_make_test_img $size
+
+echo
+echo "Start from read-only"
+echo
+
+$QEMU_IO -r -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+$QEMU_IO -r -c 'reopen -w' -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+$QEMU_IO -r -c 'reopen -w' -c 'reopen -r' -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+
+echo
+echo "Start from read-write"
+echo
+
+$QEMU_IO -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+$QEMU_IO -c 'reopen -r' -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+$QEMU_IO -c 'reopen -r' -c 'reopen -w' -c 'write 0 64k' $TEST_IMG | _filter_qemu_io
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
new file mode 100644
index 0000000000..68fb944cd5
--- /dev/null
+++ b/tests/qemu-iotests/187.out
@@ -0,0 +1,18 @@
+QA output created by 187
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+Start from read-only
+
+Block node is read-only
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Block node is read-only
+
+Start from read-write
+
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Operation not permitted
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 823811076d..1848077932 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -182,6 +182,7 @@
 183 rw auto migration
 185 rw auto
 186 rw auto
+187 rw auto
 188 rw auto quick
 189 rw auto
 190 rw auto quick
-- 
2.13.4
