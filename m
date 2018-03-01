Received: from eggs.gnu.org ([2001:4830:134:3::10]:41352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR46-0008BV-HA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR41-0004K8-HK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  1 Mar 2018 18:27:10 +0200
Message-Id: <39f9a5666cc50c3733d01d4d01fb514a5a5da9a5.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 4/7] qcow2: Check snapshot L1 tables in
 qcow2_check_metadata_overlap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The inactive-l2 overlap check iterates uses the L1 tables from all
snapshots, but it does not validate them first.

We now have a function to take care of this, so let's use it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c     | 10 +++++++++-
 tests/qemu-iotests/080     |  4 ++++
 tests/qemu-iotests/080.out |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d46b69d7f3..dcb96e2b16 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2614,9 +2614,17 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
             uint64_t l1_ofs = s->snapshots[i].l1_table_offset;
             uint32_t l1_sz  = s->snapshots[i].l1_size;
             uint64_t l1_sz2 = l1_sz * sizeof(uint64_t);
-            uint64_t *l1 = g_try_malloc(l1_sz2);
+            uint64_t *l1;
             int ret;
 
+            ret = qcow2_validate_table(bs, l1_ofs, l1_sz, sizeof(uint64_t),
+                                       QCOW_MAX_L1_SIZE, "", NULL);
+            if (ret < 0) {
+                return ret;
+            }
+
+            l1 = g_try_malloc(l1_sz2);
+
             if (l1_sz2 && l1 == NULL) {
                 return -ENOMEM;
             }
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 5622604f83..018f815697 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -178,6 +178,8 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x00"
 { $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
+{ $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
+           -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Invalid snapshot L1 table size =="
@@ -187,6 +189,8 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
+{ $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
+           -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 5d9030ab93..cf8f863be2 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -65,6 +65,8 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Error while amending options: Invalid argument
+Failed to flush the refcount block cache: Invalid argument
+write failed: Invalid argument
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -72,4 +74,6 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Error while amending options: File too large
+Failed to flush the refcount block cache: File too large
+write failed: File too large
 *** done
-- 
2.11.0
