Received: from eggs.gnu.org ([2001:4830:134:3::10]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGv-0001ss-KZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGm-0001fl-0k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:08:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 14:07:22 -0500
Message-Id: <20180628190723.276458-6-eblake@redhat.com>
In-Reply-To: <20180628190723.276458-1-eblake@redhat.com>
References: <20180628190723.276458-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 5/6] iotests: Add new test 220 for max
 compressed cluster offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

If you have a capable file system (tmpfs is good, ext4 not so much;
run ./check with TEST_DIR pointing to a good location so as not
to skip the test), it's actually possible to create a qcow2 file
that expands to a sparse 512T image with just over 38M of content.
The test is not the world's fastest (qemu crawling through 256M
bits of refcount table to find the next cluster to allocate takes
several seconds, as does qemu-img check reporting millions of
leaked clusters); but it DOES catch the problem that the previous
patch just fixed where writing a compressed cluster to a full
image ended up overwriting the wrong cluster.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>

---
v7: s/214/220/
v6: new patch; took over 90 seconds to run on my setup, using tmpfs
---
 tests/qemu-iotests/220     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out | 54 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 152 insertions(+)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
new file mode 100755
index 00000000000..b4127facd12
--- /dev/null
+++ b/tests/qemu-iotests/220
@@ -0,0 +1,97 @@
+#!/bin/bash
+#
+# max limits on compression in huge qcow2 files
+#
+# Copyright (C) 2018 Red Hat, Inc.
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
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
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
+. ./common.pattern
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo "== Creating huge file =="
+
+# Sanity check: We require a file system that permits the creation
+# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
+if ! truncate --size=513T "$TEST_IMG"; then
+    _notrun "file system on $TEST_DIR does not support large enough files"
+fi
+rm "$TEST_IMG"
+IMGOPTS='cluster_size=2M,refcount_bits=1' _make_test_img 513T
+
+echo "== Populating refcounts =="
+# We want an image with 256M refcounts * 2M clusters = 512T referenced.
+# Each 2M cluster holds 16M refcounts; the refcount table initially uses
+# 1 refblock, so we need to add 15 more.  The refcount table lives at 2M,
+# first refblock at 4M, L2 at 6M, so our remaining additions start at 8M.
+# Then, for each refblock, mark it as fully populated.
+to_hex() {
+    printf %016x\\n $1 | sed 's/\(..\)/\\x\1/g'
+}
+truncate --size=38m "$TEST_IMG"
+entry=$((0x200000))
+$QEMU_IO_PROG -f raw -c "w -P 0xff 4m 2m" "$TEST_IMG" | _filter_qemu_io
+for i in {1..15}; do
+    offs=$((0x600000 + i*0x200000))
+    poke_file "$TEST_IMG" $((i*8 + entry)) $(to_hex $offs)
+    $QEMU_IO_PROG -f raw -c "w -P 0xff $offs 2m" "$TEST_IMG" | _filter_qemu_io
+done
+
+echo "== Checking file before =="
+# FIXME: 'qemu-img check' doesn't diagnose refcounts beyond the end of
+# the file as leaked clusters
+_check_test_img 2>&1 | sed '/^Leaked cluster/d'
+stat -c 'image size %s' "$TEST_IMG"
+
+echo "== Trying to write compressed cluster =="
+# Given our file size, the next available cluster at 512T lies beyond the
+# maximum offset that a compressed 2M cluster can reside in
+$QEMU_IO_PROG -c 'w -c 0 2m' "$TEST_IMG" | _filter_qemu_io
+# The attempt failed, but ended up allocating a new refblock
+stat -c 'image size %s' "$TEST_IMG"
+
+echo "== Writing normal cluster =="
+# The failed write should not corrupt the image, so a normal write succeeds
+$QEMU_IO_PROG -c 'w 0 2m' "$TEST_IMG" | _filter_qemu_io
+
+echo "== Checking file after =="
+# qemu-img now sees the millions of leaked clusters, thanks to the allocations
+# at 512T.  Undo many of our faked references to speed up the check.
+$QEMU_IO_PROG -f raw -c "w -z 5m 1m" -c "w -z 8m 30m" "$TEST_IMG" |
+    _filter_qemu_io
+_check_test_img 2>&1 | sed '/^Leaked cluster/d'
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
new file mode 100644
index 00000000000..af3021fd883
--- /dev/null
+++ b/tests/qemu-iotests/220.out
@@ -0,0 +1,54 @@
+QA output created by 220
+== Creating huge file ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=564049465049088
+== Populating refcounts ==
+wrote 2097152/2097152 bytes at offset 4194304
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 8388608
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 10485760
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 12582912
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 14680064
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 16777216
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 18874368
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 20971520
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 23068672
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 25165824
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 27262976
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 29360128
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 31457280
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 33554432
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 35651584
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 37748736
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== Checking file before ==
+No errors were found on the image.
+image size 39845888
+== Trying to write compressed cluster ==
+write failed: Input/output error
+image size 562949957615616
+== Writing normal cluster ==
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== Checking file after ==
+wrote 1048576/1048576 bytes at offset 5242880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 31457280/31457280 bytes at offset 8388608
+30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+8388589 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index eea75819d2a..6eed45ff572 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -219,4 +219,5 @@
 217 rw auto quick
 218 rw auto quick
 219 rw auto
+220 rw auto
 221 rw auto quick
-- 
2.14.4
