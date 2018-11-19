Received: from eggs.gnu.org ([2001:4830:134:3::10]:46977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZL-0001a9-OE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZF-0007FL-Ep
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:41 +0100
Message-Id: <20181119142944.29061-7-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] iotests: Add new test 220 for max
 compressed cluster offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/220     | 96 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out | 54 +++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 151 insertions(+)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
new file mode 100755
index 0000000000..0c5682bda0
--- /dev/null
+++ b/tests/qemu-iotests/220
@@ -0,0 +1,96 @@
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
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1    # failure is the default!
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
+echo "=3D=3D Creating huge file =3D=3D"
+
+# Sanity check: We require a file system that permits the creation
+# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
+if ! truncate --size=3D513T "$TEST_IMG"; then
+    _notrun "file system on $TEST_DIR does not support large enough file=
s"
+fi
+rm "$TEST_IMG"
+IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
+
+echo "=3D=3D Populating refcounts =3D=3D"
+# We want an image with 256M refcounts * 2M clusters =3D 512T referenced=
.
+# Each 2M cluster holds 16M refcounts; the refcount table initially uses
+# 1 refblock, so we need to add 15 more.  The refcount table lives at 2M=
,
+# first refblock at 4M, L2 at 6M, so our remaining additions start at 8M=
.
+# Then, for each refblock, mark it as fully populated.
+to_hex() {
+    printf %016x\\n $1 | sed 's/\(..\)/\\x\1/g'
+}
+truncate --size=3D38m "$TEST_IMG"
+entry=3D$((0x200000))
+$QEMU_IO_PROG -f raw -c "w -P 0xff 4m 2m" "$TEST_IMG" | _filter_qemu_io
+for i in {1..15}; do
+    offs=3D$((0x600000 + i*0x200000))
+    poke_file "$TEST_IMG" $((i*8 + entry)) $(to_hex $offs)
+    $QEMU_IO_PROG -f raw -c "w -P 0xff $offs 2m" "$TEST_IMG" | _filter_q=
emu_io
+done
+
+echo "=3D=3D Checking file before =3D=3D"
+# FIXME: 'qemu-img check' doesn't diagnose refcounts beyond the end of
+# the file as leaked clusters
+_check_test_img 2>&1 | sed '/^Leaked cluster/d'
+stat -c 'image size %s' "$TEST_IMG"
+
+echo "=3D=3D Trying to write compressed cluster =3D=3D"
+# Given our file size, the next available cluster at 512T lies beyond th=
e
+# maximum offset that a compressed 2M cluster can reside in
+$QEMU_IO_PROG -c 'w -c 0 2m' "$TEST_IMG" | _filter_qemu_io
+# The attempt failed, but ended up allocating a new refblock
+stat -c 'image size %s' "$TEST_IMG"
+
+echo "=3D=3D Writing normal cluster =3D=3D"
+# The failed write should not corrupt the image, so a normal write succe=
eds
+$QEMU_IO_PROG -c 'w 0 2m' "$TEST_IMG" | _filter_qemu_io
+
+echo "=3D=3D Checking file after =3D=3D"
+# qemu-img now sees the millions of leaked clusters, thanks to the alloc=
ations
+# at 512T.  Undo many of our faked references to speed up the check.
+$QEMU_IO_PROG -f raw -c "w -z 5m 1m" -c "w -z 8m 30m" "$TEST_IMG" |
+    _filter_qemu_io
+_check_test_img 2>&1 | sed '/^Leaked cluster/d'
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
new file mode 100644
index 0000000000..af3021fd88
--- /dev/null
+++ b/tests/qemu-iotests/220.out
@@ -0,0 +1,54 @@
+QA output created by 220
+=3D=3D Creating huge file =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D564049465049088
+=3D=3D Populating refcounts =3D=3D
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
+=3D=3D Checking file before =3D=3D
+No errors were found on the image.
+image size 39845888
+=3D=3D Trying to write compressed cluster =3D=3D
+write failed: Input/output error
+image size 562949957615616
+=3D=3D Writing normal cluster =3D=3D
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+=3D=3D Checking file after =3D=3D
+wrote 1048576/1048576 bytes at offset 5242880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 31457280/31457280 bytes at offset 8388608
+30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+8388589 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ebe4fe78bc..4d194716f2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -219,6 +219,7 @@
 217 rw auto quick
 218 rw auto quick
 219 rw auto
+220 rw auto
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
--=20
2.19.1
