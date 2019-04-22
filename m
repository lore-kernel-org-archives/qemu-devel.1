Received: from eggs.gnu.org ([209.51.188.92]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIamv-0005Ld-Ke
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIamu-0006GQ-3F
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:23:21 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 18:23:15 +0300
Message-Id: <20190422152315.74361-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190422152315.74361-1-vsementsov@virtuozzo.com>
References: <20190422152315.74361-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 3/3] iotests: test big qcow2 shrink
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, eblake@redhat.com

This test checks bug in qcow2_process_discards, fixed by previous
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/250     | 72 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 21 +++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 94 insertions(+)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
new file mode 100755
index 0000000000..315054f765
--- /dev/null
+++ b/tests/qemu-iotests/250
@@ -0,0 +1,72 @@
+#!/usr/bin/env bash
+#
+# Test big discard in qcow2 shrink
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
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
+owner=vsementsov@virtuozzo.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
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
+# This test checks that qcow2_process_discards does not truncate a discard
+# request > 2G.
+# To reproduce bug we need to overflow int by one sequential discard, so we
+# need size > 2G, bigger cluster size (as with default 64k we may have maximum
+# of 512M sequential data, corresponding to one L1 entry), and we need some
+# data of the beginning of the disk mapped to the end of file to prevent
+# bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
+# anyway.
+
+size=2100M
+IMGOPTS="cluster_size=1M,preallocation=metadata"
+
+_make_test_img $size
+$QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
+         -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_qemu_io
+
+# Check that our trick with swapping first and last 10M chunks succeeded.
+# Otherwise test may pass even if bdrv_pdiscard() fails in
+# qcow2_process_discards()
+$QEMU_IMG map "$TEST_IMG" | _filter_testdir
+$QEMU_IMG info "$TEST_IMG" | grep size |  _filter_testdir
+
+$QEMU_IMG resize --shrink "$TEST_IMG" 5M
+
+$QEMU_IMG info "$TEST_IMG" | grep size | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
new file mode 100644
index 0000000000..a7076efc0c
--- /dev/null
+++ b/tests/qemu-iotests/250.out
@@ -0,0 +1,21 @@
+QA output created by 250
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 preallocation=metadata
+discard 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 10485760/10485760 bytes at offset 2191523840
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 2191523840
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          Mapped to       File
+0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
+0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
+virtual size: 2.05 GiB (2202009600 bytes)
+disk size: 24 MiB
+cluster_size: 1048576
+Image resized.
+virtual size: 5 MiB (5242880 bytes)
+disk size: 9 MiB
+cluster_size: 1048576
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..588ae8b8b1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+250 rw auto quick
-- 
2.18.0
