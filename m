Received: from eggs.gnu.org ([2001:4830:134:3::10]:43043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCZ-0001Jk-SA
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCX-0002PT-CO
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:37 +0100
Message-Id: <20171117181653.20651-10-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/25] qcow2: fix image corruption on commit
 with persistent bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

If an image contains persistent bitmaps, we cannot use the
fast path of bdrv_make_empty() to clear the image during
qemu-img commit, because that will lose the clusters related
to the bitmaps.

Also leave a comment in qcow2_read_extensions to remind future
feature additions to think about fast-path removal, since we
just barely fixed the same bug for LUKS encryption.

It's a pain that qemu-img has not yet been taught to manipulate,
or even at a very minimum display, information about persistent
bitmaps; instead, we have to use QMP commands.  It's also a
pain that only qeury-block and x-debug-block-dirty-bitmap-sha256
will allow bitmap introspection; but the former requires the
node to be hooked to a block device, and the latter is experimental.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              |  17 ++--
 tests/qemu-iotests/176     |  55 ++++++++++--
 tests/qemu-iotests/176.out | 216 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 270 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e9a86b7443..f2731a7cb5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -376,6 +376,8 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 
         default:
             /* unknown magic - save it in case we need to rewrite the header */
+            /* If you add a new feature, make sure to also update the fast
+             * path of qcow2_make_empty() to deal with it. */
             {
                 Qcow2UnknownHeaderExtension *uext;
 
@@ -3600,15 +3602,16 @@ static int qcow2_make_empty(BlockDriverState *bs)
 
     l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
 
-    if (s->qcow_version >= 3 && !s->snapshots &&
+    if (s->qcow_version >= 3 && !s->snapshots && !s->nb_bitmaps &&
         3 + l1_clusters <= s->refcount_block_size &&
         s->crypt_method_header != QCOW_CRYPT_LUKS) {
-        /* The following function only works for qcow2 v3 images (it requires
-         * the dirty flag) and only as long as there are no snapshots (because
-         * it completely empties the image). Furthermore, the L1 table and three
-         * additional clusters (image header, refcount table, one refcount
-         * block) have to fit inside one refcount block. It cannot be used
-         * for LUKS (yet) as it throws away the LUKS header cluster(s) */
+        /* The following function only works for qcow2 v3 images (it
+         * requires the dirty flag) and only as long as there are no
+         * features that reserve extra clusters (such as snapshots,
+         * LUKS header, or persistent bitmaps), because it completely
+         * empties the image.  Furthermore, the L1 table and three
+         * additional clusters (image header, refcount table, one
+         * refcount block) have to fit inside one refcount block. */
         return make_completely_empty(bs);
     }
 
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 950b28720e..0f31a20294 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -3,10 +3,11 @@
 # Commit changes into backing chains and empty the top image if the
 # backing image is not explicitly specified.
 #
-# Variant of 097, which includes snapshots to test different codepath
-# in qcow2
+# Variant of 097, which includes snapshots and persistent bitmaps, to
+# tickle the slow codepath in qcow2. See also 198, for another feature
+# that tickles the slow codepath.
 #
-# Copyright (C) 2014 Red Hat, Inc.
+# Copyright (C) 2014, 2017 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -43,11 +44,18 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-# Any format supporting backing files and bdrv_make_empty
+# This test is specific to qcow2
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 
+function run_qemu()
+{
+    $QEMU -nographic -qmp stdio -serial none "$@" 2>&1 \
+	| _filter_testdir | _filter_qmp | _filter_qemu
+}
+
+for reason in snapshot bitmap; do
 
 # Four passes:
 #  0: Two-layer backing chain, commit to upper backing file (implicitly)
@@ -66,14 +74,29 @@ _supported_os Linux
 for i in 0 1 2 3; do
 
 echo
-echo "=== Test pass $i ==="
+echo "=== Test pass $reason.$i ==="
 echo
 
 len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
 TEST_IMG="$TEST_IMG.base" _make_test_img $len
 TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
 _make_test_img -b "$TEST_IMG.itmd" $len
-$QEMU_IMG snapshot -c snap "$TEST_IMG"
+# Update the top image to use a feature that is incompatible with fast path
+case $reason in
+    snapshot) $QEMU_IMG snapshot -c snap "$TEST_IMG" ;;
+    bitmap)
+	run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": { "driver": "qcow2", "node-name": "drive0",
+     "file": { "driver": "file", "filename": "$TEST_IMG" } } }
+{ "execute": "block-dirty-bitmap-add",
+  "arguments": { "node": "drive0", "name": "bitmap0",
+     "persistent": true, "autoload": true } }
+{ "execute": "quit" }
+EOF
+	;;
+esac
 
 $QEMU_IO -c "write -P 1 0x7ffd0000 192k" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "write -P 2 0x7ffe0000 128k" "$TEST_IMG.itmd" | _filter_qemu_io
@@ -122,8 +145,26 @@ $QEMU_IMG map "$TEST_IMG.base" | _filter_qemu_img_map
 $QEMU_IMG map "$TEST_IMG.itmd" | _filter_qemu_img_map
 $QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
 
-done
+# Check that the reason for slow path is still present, as appropriate
+case $reason in
+    snapshot)
+	$QEMU_IMG snapshot -l "$TEST_IMG" |
+	    sed 's/^\(.\{20\}\).*/\1/; s/ *$//' ;;
+    bitmap)
+	run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": { "driver": "qcow2", "node-name": "drive0",
+     "file": { "driver": "file", "filename": "$TEST_IMG" } } }
+{ "execute": "x-debug-block-dirty-bitmap-sha256",
+  "arguments": { "node": "drive0", "name": "bitmap0" } }
+{ "execute": "quit" }
+EOF
+	;;
+esac
 
+done
+done
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 6271fa7d6f..e62085cd0a 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -1,6 +1,6 @@
 QA output created by 176
 
-=== Test pass 0 ===
+=== Test pass snapshot.0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
@@ -36,8 +36,11 @@ Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+Snapshot list:
+ID        TAG
+1         snap
 
-=== Test pass 1 ===
+=== Test pass snapshot.1 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
@@ -74,8 +77,11 @@ Offset          Length          File
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
+Snapshot list:
+ID        TAG
+1         snap
 
-=== Test pass 2 ===
+=== Test pass snapshot.2 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
@@ -112,8 +118,11 @@ Offset          Length          File
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
+Snapshot list:
+ID        TAG
+1         snap
 
-=== Test pass 3 ===
+=== Test pass snapshot.3 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
@@ -147,4 +156,203 @@ Offset          Length          File
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
+Snapshot list:
+ID        TAG
+1         snap
+
+=== Test pass bitmap.0 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+=== Test pass bitmap.1 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+=== Test pass bitmap.2 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+=== Test pass bitmap.3 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
-- 
2.13.6
