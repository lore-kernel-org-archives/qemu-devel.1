Received: from eggs.gnu.org ([2001:4830:134:3::10]:53340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmg-0004rV-64
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmc-0001vc-2p
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:03 +0200
Message-Id: <20180611142611.6609-22-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] iotests: Test post-backing convert target
 behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This adds a test case to 122 for what happens when you convert to a
target with a backing file that is shorter than the target, and the
image format does not support efficient zero writes (as is the case with
qcow2 v2).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180501165750.19242-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122     | 42 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 18 ++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c2ba..d8c8ad722d 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -76,6 +76,48 @@ $QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _filter_testdir
 
 
+echo
+echo "=== Converting to an overlay larger than its backing file ==="
+echo
+
+TEST_IMG="$TEST_IMG".base _make_test_img 256M
+# Needs to be at least how much an L2 table covers
+# (64 kB/entry * 64 kB / 8 B/entry = 512 MB)
+# That way, qcow2 will yield at least two status request responses.
+# With just a single response, it would always say "Allocated in the
+# backing file", so the optimization qemu-img convert tries to do is
+# done automatically.  Once it has to be queried twice, however (and
+# one of the queries is completely after the end of the backing file),
+# the block layer will automatically add a ZERO flag that qemu-img
+# convert used to follow up with a zero write to the target.
+# We do not want such a zero write, however, because we are past the
+# end of the backing file on the target as well, so we do not need to
+# write anything there.
+_make_test_img -b "$TEST_IMG".base 768M
+
+# Use compat=0.10 as the output so there is no zero cluster support
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=0.10 \
+    "$TEST_IMG" "$TEST_IMG".orig
+# See that nothing has been allocated past 64M
+$QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
+
+echo
+
+# Just before the end of the backing file
+$QEMU_IO -c 'write -P 0x11 255M 1M' "$TEST_IMG".base 2>&1 | _filter_qemu_io
+# Somewhere in the second L2 table
+$QEMU_IO -c 'write -P 0x22 600M 1M' "$TEST_IMG" 2>&1 | _filter_qemu_io
+
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=0.10 \
+    "$TEST_IMG" "$TEST_IMG".orig
+
+$QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
+$QEMU_IO -c 'read -P 0x11 255M 1M' \
+         -c 'read -P 0x22 600M 1M' \
+         "$TEST_IMG".orig \
+    | _filter_qemu_io
+
+
 echo
 echo "=== Concatenate multiple source images ==="
 echo
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 47d8656db8..6c7ee1da6c 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -28,6 +28,24 @@ read 3145728/3145728 bytes at offset 0
 read 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Converting to an overlay larger than its backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=268435456
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=805306368 backing_file=TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+
+wrote 1048576/1048576 bytes at offset 267386880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 629145600
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0xff00000       0x100000        TEST_DIR/t.IMGFMT.base
+0x25800000      0x100000        TEST_DIR/t.IMGFMT.orig
+read 1048576/1048576 bytes at offset 267386880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 629145600
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 === Concatenate multiple source images ===
 
 Formatting 'TEST_DIR/t.IMGFMT.1', fmt=IMGFMT size=4194304
-- 
2.17.1
