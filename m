Received: from eggs.gnu.org ([2001:4830:134:3::10]:60745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCJ-0008GQ-LM
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCH-0006nG-By
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:55 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:07 +0300
Message-Id: <1509551048-129830-15-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 14/15] iotest 198: test BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/qemu-iotests/198     | 146 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/198.out |  50 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 197 insertions(+)
 create mode 100755 tests/qemu-iotests/198
 create mode 100644 tests/qemu-iotests/198.out

diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
new file mode 100755
index 0000000..ad7162a
--- /dev/null
+++ b/tests/qemu-iotests/198
@@ -0,0 +1,146 @@
+#!/bin/env bash
+#
+# Test qcow2 BDRV_REQ_ALLOCATE requests
+#
+# Copyright (c) 2017 Parallels International GmbH
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
+##
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
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
+function do_io()
+{
+    $QEMU_IO "$@" | _filter_qemu_io |\
+        sed -e 's/bytes at offset [0-9]*/bytes at offset XXX/g'
+}
+
+CLUSTER_SIZE=64k
+size=128M
+
+_make_test_img 1G
+
+echo
+echo "== Test discarded cluster reuse =="
+
+# allocate first two clusters
+do_io -c "writev -P 1 0x8000 0x10000" "$TEST_IMG"
+len=$(stat -c "%s" $TEST_IMG)
+
+# discard the 1st cluster on qcow2 level only
+do_io -c "open -o pass-discard-request=off $TEST_IMG" -c "discard 0 0x10000"
+
+# new write will reuse the dirty host cluster and has to overwrite that
+#  with zeroes
+do_io -c "writev -P 2 0x24000 0x8000" "$TEST_IMG"
+if [ $len -ne $(stat -c "%s" $TEST_IMG) ] ; then
+    >&2 echo "Failed to reuse cluster"
+    exit 1
+fi
+
+echo
+echo "== Test preallocation =="
+
+function io_commands()
+{
+    echo "open -o prealloc-size=$((1024*1024)) blkdebug::$TEST_IMG"
+
+    # Verify that intersections of a running preallocation and new requests
+    #  is handled properly.
+    #
+    # 1. send a write #1 which triggers preallocation, suspend it in action
+    # 2. send a write #2 which intersects with the area being preallocated
+    # 3. using break/wait_break/resume, wait until write #2 is at least
+    #    at WRITE_AIO tracepoint.
+    #    Then it is supposed to enter pwrite(bs->child) and start waiting
+    #    for #1 to finish
+    # 4. resume #1
+
+cat <<EOF
+break pwritev_zero A
+aio_write -P 3 0x30000 0x1000
+wait_break A
+
+break write_aio B
+aio_write -P 4 0x40000 0x1000
+wait_break B
+resume B
+
+resume A
+aio_flush
+EOF
+
+    # Verify that new cluster in the preallocated area triggers
+    #  neither new preallocation nor COW read
+    #
+    # TODO: this test will not fail but hang. Better ideas?
+    #       wait and kill by timeout?
+
+cat <<EOF
+break pwritev_zero A
+break cow_read B
+writev -P 5 0x51000 0x1000
+EOF
+}
+
+io_commands | do_io
+
+echo
+echo "== Verify image content =="
+
+function verify_io()
+{
+cat <<EOF
+read -P 0 0 0x10000
+read -P 1 0x10000 0x8000
+read -P 0 0x18000 0xc000
+read -P 2 0x24000 0x8000
+read -P 0 0x2c000 0x4000
+
+read -P 3 0x30000 0x1000
+read -P 0 0x31000 0xf000
+read -P 4 0x40000 0x1000
+read -P 0 0x41000 0xf000
+
+read -P 0 0x50000 0x1000
+read -P 5 0x51000 0x1000
+read -P 0 0x52000 0xe000
+EOF
+}
+
+verify_io | do_io $TEST_IMG
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
new file mode 100644
index 0000000..b4eb27f
--- /dev/null
+++ b/tests/qemu-iotests/198.out
@@ -0,0 +1,50 @@
+QA output created by 198
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+
+== Test discarded cluster reuse ==
+wrote 65536/65536 bytes at offset XXX
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 65536/65536 bytes at offset XXX
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset XXX
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== Test preallocation ==
+blkdebug: Suspended request 'A'
+blkdebug: Suspended request 'B'
+blkdebug: Resuming request 'B'
+blkdebug: Resuming request 'A'
+wrote 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== Verify image content ==
+read 65536/65536 bytes at offset XXX
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset XXX
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 49152/49152 bytes at offset XXX
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset XXX
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 16384/16384 bytes at offset XXX
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 61440/61440 bytes at offset XXX
+60 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 61440/61440 bytes at offset XXX
+60 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset XXX
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 57344/57344 bytes at offset XXX
+56 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 24e5ad1..6263608 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -194,3 +194,4 @@
 194 rw auto migration quick
 195 rw auto quick
 197 rw auto quick
+198 rw auto quick
-- 
2.7.4
