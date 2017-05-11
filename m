Received: from eggs.gnu.org ([2001:4830:134:3::10]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pB0-0002to-Ux
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAw-00088G-Vy
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:48 +0200
Message-Id: <1494513181-7900-46-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 45/58] tests: Add coverage for recent block
 geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Use blkdebug's new geometry constraints to emulate setups that
have needed past regression fixes: write zeroes asserting
when running through a loopback block device with max-transfer
smaller than cluster size, and discard rounding away portions
of requests not aligned to preferred boundaries.  Also, add
coverage that the block layer is honoring max transfer limits.

For now, a single iotest performs all actions, with the idea
that we can add future blkdebug constraint test cases in the
same file; but it can be split into multiple iotests if we find
reason to run one portion of the test in more setups than what
are possible in the other.

For reference, the final portion of the test (checking whether
discard passes as much as possible to the lowest layers of the
stack) works as follows:

qemu-io: discard 30M at 80000001, passed to blkdebug
  blkdebug: discard 511 bytes at 80000001, -ENOTSUP (smaller than
blkdebug's 512 align)
  blkdebug: discard 14371328 bytes at 80000512, passed to qcow2
    qcow2: discard 739840 bytes at 80000512, -ENOTSUP (smaller than
qcow2's 1M align)
    qcow2: discard 13M bytes at 77M, succeeds
  blkdebug: discard 15M bytes at 90M, passed to qcow2
    qcow2: discard 15M bytes at 90M, succeeds
  blkdebug: discard 1356800 bytes at 105M, passed to qcow2
    qcow2: discard 1M at 105M, succeeds
    qcow2: discard 308224 bytes at 106M, -ENOTSUP (smaller than qcow2's
1M align)
  blkdebug: discard 1 byte at 111457280, -ENOTSUP (smaller than
blkdebug's 512 align)

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170429191419.30051-10-eblake@redhat.com
[mreitz: For cooperation with image locking, add -r to the qemu-io
         invocation which verifies the image content]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/177     | 114 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/177.out |  49 +++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 164 insertions(+)
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out

diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
new file mode 100755
index 0000000..2005c17
--- /dev/null
+++ b/tests/qemu-iotests/177
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# Test corner cases with unusual block geometries
+#
+# Copyright (C) 2016-2017 Red Hat, Inc.
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
+owner=eblake@redhat.com
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
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+
+CLUSTER_SIZE=1M
+size=128M
+options=driver=blkdebug,image.driver=qcow2
+
+echo
+echo "== setting up files =="
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+$QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
+_make_test_img -b "$TEST_IMG.base"
+$QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io
+
+# Limited to 64k max-transfer
+echo
+echo "== constrained alignment and max-transfer =="
+limits=align=4k,max-transfer=64k
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -P 33 1000 128k" -c "read -P 33 1000 128k" | _filter_qemu_io
+
+echo
+echo "== write zero with constrained max-transfer =="
+limits=align=512,max-transfer=64k,opt-write-zero=$CLUSTER_SIZE
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -z 8003584 2093056" | _filter_qemu_io
+
+# non-power-of-2 write-zero/discard alignments
+echo
+echo "== non-power-of-2 write zeroes limits =="
+
+limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -z 32M 32M" | _filter_qemu_io
+
+echo
+echo "== non-power-of-2 discard limits =="
+
+limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "discard 80000001 30M" | _filter_qemu_io
+
+echo
+echo "== verify image content =="
+
+function verify_io()
+{
+    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
+	    grep "compat: 0.10" > /dev/null); then
+        # For v2 images, discarded clusters are read from the backing file
+        discarded=11
+    else
+        # Discarded clusters are zeroed for v3 or later
+        discarded=0
+    fi
+
+    echo read -P 22 0 1000
+    echo read -P 33 1000 128k
+    echo read -P 22 132072 7871512
+    echo read -P 0 8003584 2093056
+    echo read -P 22 10096640 23457792
+    echo read -P 0 32M 32M
+    echo read -P 22 64M 13M
+    echo read -P $discarded 77M 29M
+    echo read -P 22 106M 22M
+}
+
+verify_io | $QEMU_IO -r "$TEST_IMG" | _filter_qemu_io
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+status=0
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
new file mode 100644
index 0000000..e887542
--- /dev/null
+++ b/tests/qemu-iotests/177.out
@@ -0,0 +1,49 @@
+QA output created by 177
+
+== setting up files ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== constrained alignment and max-transfer ==
+wrote 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== write zero with constrained max-transfer ==
+wrote 2093056/2093056 bytes at offset 8003584
+1.996 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== non-power-of-2 write zeroes limits ==
+wrote 33554432/33554432 bytes at offset 33554432
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== non-power-of-2 discard limits ==
+discard 31457280/31457280 bytes at offset 80000001
+30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify image content ==
+read 1000/1000 bytes at offset 0
+1000 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 7871512/7871512 bytes at offset 132072
+7.507 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2093056/2093056 bytes at offset 8003584
+1.996 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 23457792/23457792 bytes at offset 10096640
+22.371 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 33554432/33554432 bytes at offset 33554432
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 13631488/13631488 bytes at offset 67108864
+13 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 30408704/30408704 bytes at offset 80740352
+29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 23068672/23068672 bytes at offset 111149056
+22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a4549d8..bb6df8f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -170,5 +170,6 @@
 174 auto
 175 auto quick
 176 rw auto backing
+177 rw auto quick
 181 rw auto migration
 182 rw auto quick
-- 
1.8.3.1
