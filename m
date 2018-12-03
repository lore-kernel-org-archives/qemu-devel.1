Received: from eggs.gnu.org ([2001:4830:134:3::10]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOg-0006RW-IN
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOf-0007WI-16
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:42 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 18:52:11 +0100
Message-Id: <20181203175211.8230-7-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
References: <20181203175211.8230-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 6/6] iotests: Test qemu-img convert
 --salvage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This test converts a simple image to another, but blkdebug injects
block_status and read faults at some offsets.  The resulting image
should be the same as the input image, except that sectors that could
not be read have to be 0.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/236     | 164 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/236.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 208 insertions(+)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..02b032ebb5
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,164 @@
+#!/bin/bash
+#
+# Test qemu-img convert --salvage
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
+# creator
+owner=3Dmreitz@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+here=3D$PWD
+status=3D1	# failure is the default!
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
+. ./common.qemu
+
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+
+TEST_IMG=3D"$TEST_IMG.orig" _make_test_img 64M
+
+$QEMU_IO -c 'write -P 42 0 64M' "$TEST_IMG.orig" | _filter_qemu_io
+
+
+sector_size=3D512
+
+# Offsets on which to fail block-status.  Keep in ascending order so
+# the indexing done by _filter_offsets will appear in ascending order
+# in the output as well.
+status_fail_offsets=3D"$((16 * 1024 * 1024 + 8192))
+                     $((33 * 1024 * 1024 + 512))"
+
+# Offsets on which to fail reads.  Keep in ascending order for the
+# same reason.
+# Element 1 is shared with $status_fail_offsets on purpose.
+# Elements 2 and later test what happens when a continuous range of
+# sectors is inaccessible.
+read_fail_offsets=3D"$((32 * 1024 * 1024 - 65536))
+                   $((33 * 1024 * 1024 + 512))
+                   $(seq $((34 * 1024 * 1024)) $sector_size \
+                         $((34 * 1024 * 1024 + 4096 - $sector_size)))"
+
+
+# blkdebug must be above the format layer so it can intercept all
+# block-status events
+source_img=3D"json:{'driver': 'blkdebug',
+                  'image': {
+                      'driver': '$IMGFMT',
+                      'file': {
+                          'driver': 'file',
+                          'filename': '$TEST_IMG.orig'
+                      }
+                  },
+                  'inject-error': ["
+
+for ofs in $status_fail_offsets
+do
+    source_img+=3D"{ 'event': 'none',
+                   'iotype': 'block-status',
+                   'errno': 5,
+                   'sector': $((ofs / sector_size)) },"
+done
+
+for ofs in $read_fail_offsets
+do
+    source_img+=3D"{ 'event': 'none',
+                   'iotype': 'read',
+                   'errno': 5,
+                   'sector': $((ofs / sector_size)) },"
+done
+
+# Remove the trailing comma and terminate @inject-error and json:{}
+source_img=3D"${source_img%,} ] }"
+
+
+echo
+
+
+_filter_offsets() {
+    filters=3D
+
+    index=3D0
+    for ofs in $2
+    do
+        filters+=3D" -e s/$(printf "$1" $ofs)/status_fail_offset_$index/=
"
+        index=3D$((index + 1))
+    done
+
+    index=3D0
+    for ofs in $3
+    do
+        filters+=3D" -e s/$(printf "$1" $ofs)/read_fail_offset_$index/"
+        index=3D$((index + 1))
+    done
+
+    sed $filters
+}
+
+# While determining the number of allocated sectors in the input
+# image, we should see one block status warning per element of
+# $status_fail_offsets.
+#
+# Then, the image is read.  Since the block status is queried in
+# basically the same way, the same warnings as in the previous step
+# should reappear.  Interleaved with those we should see a read
+# warning per element of $read_fail_offsets.
+# Note that $read_fail_offsets and $status_fail_offsets share an
+# element (read_fail_offset_1 =3D=3D status_fail_offset_1), so
+# "status_fail_offset_1" in the output is the same as
+# "read_fail_offset_1".
+$QEMU_IMG convert --salvage "$source_img" "$TEST_IMG" 2>&1 \
+    | sed -e 's/json:{.*}/SOURCE_IMG/' \
+    | _filter_offsets '%#x' "$status_fail_offsets" "$read_fail_offsets"
+
+echo
+
+# The offsets where the block status could not be determined should
+# have been treated as containing data and thus should be correct in
+# the output image.
+# The offsets where reading failed altogether should be 0.  Make them
+# 0 in the input image, too, so we can compare both images.
+for ofs in $read_fail_offsets
+do
+    $QEMU_IO -c "write -z $ofs $sector_size" "$TEST_IMG.orig" \
+        | _filter_qemu_io \
+        | _filter_offsets '%i' '' "$read_fail_offsets"
+done
+
+echo
+
+# These should be equal now.
+$QEMU_IMG compare "$TEST_IMG.orig" "$TEST_IMG"
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
new file mode 100644
index 0000000000..df240685ab
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,43 @@
+QA output created by 236
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
+wrote 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+qemu-img: warning: Failed to inquire block status of SOURCE_IMG at offse=
t status_fail_offset_0: Input/output error
+qemu-img: warning: Failed to inquire block status of SOURCE_IMG at offse=
t status_fail_offset_1: Input/output error
+qemu-img: warning: Failed to inquire block status of SOURCE_IMG at offse=
t status_fail_offset_0: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_0 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to inquire block status of SOURCE_IMG at offse=
t status_fail_offset_1: Input/output error
+qemu-img: warning: Failed to read offset status_fail_offset_1 from SOURC=
E_IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_2 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_3 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_4 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_5 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_6 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_7 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_8 from SOURCE_=
IMG: Input/output error
+qemu-img: warning: Failed to read offset read_fail_offset_9 from SOURCE_=
IMG: Input/output error
+
+wrote 512/512 bytes at offset read_fail_offset_0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_1
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_2
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_3
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_4
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_5
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_6
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_7
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_8
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_9
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..f6b245917a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+236 auto quick
--=20
2.19.2
