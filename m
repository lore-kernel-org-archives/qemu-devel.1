Received: from eggs.gnu.org ([2001:4830:134:3::10]:33246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkn-0000u2-Gw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkm-0006db-7l
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:48 +0100
Message-Id: <20180309161933.8168-12-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/56] qcow2: Check snapshot L1 tables in
 qcow2_check_metadata_overlap()
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

From: Alberto Garcia <berto@igalia.com>

The inactive-l2 overlap check iterates uses the L1 tables from all
snapshots, but it does not validate them first.

We now have a function to take care of this, so let's use it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c     | 10 +++++++++-
 tests/qemu-iotests/080     |  4 ++++
 tests/qemu-iotests/080.out |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 2f7e710fa6..b18ea0ca98 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2642,9 +2642,17 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
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
index 315edbc26f..d622ac06c0 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -66,6 +66,8 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Error while amending options: Invalid argument
+Failed to flush the refcount block cache: Invalid argument
+write failed: Invalid argument
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -74,4 +76,6 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Error while amending options: File too large
+Failed to flush the refcount block cache: File too large
+write failed: File too large
 *** done
-- 
2.13.6
