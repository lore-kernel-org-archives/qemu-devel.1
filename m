Received: from eggs.gnu.org ([2001:4830:134:3::10]:58617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjL-0000jw-UM
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjK-0001NM-9H
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 20:43:47 -0500
Message-Id: <20171004014347.25099-6-eblake@redhat.com>
In-Reply-To: <20171004014347.25099-1-eblake@redhat.com>
References: <20171004014347.25099-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] iotests: Add test 197 for covering
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Add a test for qcow2 copy-on-read behavior, including exposure
for the just-fixed bugs.

The copy-on-read behavior is always to a qcow2 image, but the
test is careful to allow running with most image protocol/format
combos as the backing file being copied from (luks being the
exception, as it is harder to pass the right secret to all the
right places).  In fact, for './check nbd', this appears to be
the first time we've had a qcow2 image wrapping NBD, requiring
an additional line in _filter_img_create to match the similar
line in _filter_img_info.

Invoking blkdebug to prove we don't write too much took some
effort to get working; and it requires that $TEST_WRAP (based
on $TEST_DIR) not be subject to word splitting.  We may decide
later to have the entire iotests suite use relative rather than
absolute names, to avoid problems inherited by the absolute
name of $PWD or $TEST_DIR, at which point the sanity check in
this commit could be simplified.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: test 0-length query [Kevin], sanity check TEST_DIR [Jeff]

I only tested with -raw, -qcow2, -qed, and -nbd. I won't be
surprised if the test fails in some other setup...
---
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/197           | 102 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out       |  26 ++++++++++
 tests/qemu-iotests/group         |   1 +
 4 files changed, 130 insertions(+)
 create mode 100755 tests/qemu-iotests/197
 create mode 100644 tests/qemu-iotests/197.out

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 9d5442ecd9..227b37e941 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -111,6 +111,7 @@ _filter_img_create()
     sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
+        -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
         -e "s# encryption=off##g" \
         -e "s# cluster_size=[0-9]\\+##g" \
         -e "s# table_size=[0-9]\\+##g" \
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
new file mode 100755
index 0000000000..cc85388039
--- /dev/null
+++ b/tests/qemu-iotests/197
@@ -0,0 +1,102 @@
+#!/bin/bash
+#
+# Test case for copy-on-read into qcow2
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
+owner=eblake@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1 # failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+TEST_WRAP="$TEST_DIR/t.wrap.qcow2"
+BLKDBG_CONF="$TEST_DIR/blkdebug.conf"
+
+# Sanity check: our use of blkdebug fails if $TEST_DIR contains spaces
+# or other problems
+case "$TEST_DIR" in
+    *[^-_a-zA-Z0-9/]*)
+        _notrun "Suspicious TEST_DIR='$TEST_DIR', cowardly refusing to run" ;;
+esac
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$BLKDBG_CONF"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# Test is supported for any backing file; but we force qcow2 for our wrapper.
+_supported_fmt generic
+_supported_proto generic
+_supported_os Linux
+# LUKS support may be possible, but it complicates things.
+_unsupported_fmt luks
+
+echo
+echo '=== Copy-on-read ==='
+echo
+
+# Prep the images
+_make_test_img 4G
+$QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
+IMGPROTO=file IMGFMT=qcow2 IMGOPTS= TEST_IMG_FILE="$TEST_WRAP" \
+    _make_test_img -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
+$QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
+
+# Ensure that a read of two clusters, but where one is already allocated,
+# does not re-write the allocated cluster
+cat > "$BLKDBG_CONF" <<EOF
+[inject-error]
+event = "cor_write"
+sector = "2048"
+EOF
+$QEMU_IO -c "open -C \
+ -o driver=blkdebug,config=$BLKDBG_CONF,image.driver=qcow2 $TEST_WRAP" \
+ -c "read -P 0 1M 128k" | _filter_qemu_io
+
+# Read the areas we want copied. A zero-length read should still be a
+# no-op.  The next read is under 2G, but aligned so that rounding to
+# clusters copies more than 2G of zeroes. The final read will pick up
+# the non-zero data in the same cluster
+$QEMU_IO -f qcow2 -C -c "read 0 0" "$TEST_WRAP" | _filter_qemu_io
+$QEMU_IO -f qcow2 -C -c "read -P 0 1k $((2*1024*1024*1024 - 512))" \
+    "$TEST_WRAP" | _filter_qemu_io
+$QEMU_IO -f qcow2 -C -c "read -P 0 $((3*1024*1024*1024 + 1024)) 1k" \
+    "$TEST_WRAP" | _filter_qemu_io
+
+# Copy-on-read is incompatible with read-only
+$QEMU_IO -f qcow2 -C -r "$TEST_WRAP" 2>&1 | _filter_testdir
+
+# Break the backing chain, and show that images are identical, and that
+# we properly copied over explicit zeros.
+$QEMU_IMG rebase -u -b "" -f qcow2 "$TEST_WRAP"
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"
+_check_test_img
+$QEMU_IMG compare -f $IMGFMT -F qcow2 "$TEST_IMG" "$TEST_WRAP"
+
+# success, all done
+echo '*** done'
+status=0
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
new file mode 100644
index 0000000000..52b4137d7b
--- /dev/null
+++ b/tests/qemu-iotests/197.out
@@ -0,0 +1,26 @@
+QA output created by 197
+
+=== Copy-on-read ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296
+wrote 1024/1024 bytes at offset 3221225472
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 1048576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 0/0 bytes at offset 0
+0 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2147483136/2147483136 bytes at offset 1024
+2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 3221226496
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on-read on read-only device
+2 GiB (0x80010000) bytes     allocated at offset 0 bytes (0x0)
+1023.938 MiB (0x3fff0000) bytes not allocated at offset 2 GiB (0x80010000)
+64 KiB (0x10000) bytes     allocated at offset 3 GiB (0xc0000000)
+1023.938 MiB (0x3fff0000) bytes not allocated at offset 3 GiB (0xc0010000)
+No errors were found on the image.
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index cdccee319e..7a302a67cf 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -191,3 +191,4 @@
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
+197 rw auto quick
-- 
2.13.6
