Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCj-0001Tq-3x
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCh-0002Zp-G9
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:49 +0100
Message-Id: <20171117181653.20651-22-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/25] qcow2: Add bounds check to
 get_refblock_offset()
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

From: Max Reitz <mreitz@redhat.com>

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1728661
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171110203111.7666-5-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h              |  6 ------
 block/qcow2-refcount.c     | 26 +++++++++++++++++++++++++-
 tests/qemu-iotests/060     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 22 ++++++++++++++++++++++
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 782a206ecb..6f0ff15dd0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -527,12 +527,6 @@ uint32_t offset_to_reftable_index(BDRVQcow2State *s, uint64_t offset)
     return offset >> (s->refcount_block_bits + s->cluster_bits);
 }
 
-static inline uint64_t get_refblock_offset(BDRVQcow2State *s, uint64_t offset)
-{
-    uint32_t index = offset_to_reftable_index(s, offset);
-    return s->refcount_table[index] & REFT_OFFSET_MASK;
-}
-
 /* qcow2.c functions */
 int qcow2_backing_read1(BlockDriverState *bs, QEMUIOVector *qiov,
                   int64_t sector_num, int nb_sectors);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 60b8eef3e8..3de1ab51ba 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3077,16 +3077,40 @@ done:
     return ret;
 }
 
+static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t index = offset_to_reftable_index(s, offset);
+    int64_t covering_refblock_offset = 0;
+
+    if (index < s->refcount_table_size) {
+        covering_refblock_offset = s->refcount_table[index] & REFT_OFFSET_MASK;
+    }
+    if (!covering_refblock_offset) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Refblock at %#" PRIx64 " is "
+                                "not covered by the refcount structures",
+                                offset);
+        return -EIO;
+    }
+
+    return covering_refblock_offset;
+}
+
 static int qcow2_discard_refcount_block(BlockDriverState *bs,
                                         uint64_t discard_block_offs)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t refblock_offs = get_refblock_offset(s, discard_block_offs);
+    int64_t refblock_offs;
     uint64_t cluster_index = discard_block_offs >> s->cluster_bits;
     uint32_t block_index = cluster_index & (s->refcount_block_size - 1);
     void *refblock;
     int ret;
 
+    refblock_offs = get_refblock_offset(bs, discard_block_offs);
+    if (refblock_offs < 0) {
+        return refblock_offs;
+    }
+
     assert(discard_block_offs != 0);
 
     ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 44141f6243..c230696b3a 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -359,6 +359,52 @@ echo '--- Repairing ---'
 _check_test_img -q -r all
 _check_test_img -r all
 
+echo
+echo "=== Discarding an out-of-bounds refblock ==="
+echo
+
+_make_test_img 64M
+
+# Pretend there's a refblock really up high
+poke_file "$TEST_IMG" "$(($rt_offset+8))" "\x00\xff\xff\xff\x00\x00\x00\x00"
+# Let's try to shrink the qcow2 image so that the block driver tries
+# to discard that refblock (and see what happens!)
+$QEMU_IMG resize --shrink "$TEST_IMG" 32M
+
+echo '--- Checking and retrying ---'
+# Image should not be resized
+_img_info | grep 'virtual size'
+# But it should pass this check, because the "partial" resize has
+# already overwritten refblocks past the end
+_check_test_img -r all
+# So let's try again
+$QEMU_IMG resize --shrink "$TEST_IMG" 32M
+_img_info | grep 'virtual size'
+
+echo
+echo "=== Discarding a non-covered in-bounds refblock ==="
+echo
+
+IMGOPTS='refcount_bits=1' _make_test_img 64M
+
+# Pretend there's a refblock somewhere where there is no refblock to
+# cover it (but the covering refblock has a valid index in the
+# reftable)
+# Every refblock covers 65536 * 8 * 65536 = 32 GB, so we have to point
+# to 0x10_0000_0000 (64G) to point to the third refblock
+poke_file "$TEST_IMG" "$(($rt_offset+8))" "\x00\x00\x00\x10\x00\x00\x00\x00"
+$QEMU_IMG resize --shrink "$TEST_IMG" 32M
+
+echo '--- Checking and retrying ---'
+# Image should not be resized
+_img_info | grep 'virtual size'
+# But it should pass this check, because the "partial" resize has
+# already overwritten refblocks past the end
+_check_test_img -r all
+# So let's try again
+$QEMU_IMG resize --shrink "$TEST_IMG" 32M
+_img_info | grep 'virtual size'
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 07dfdcac99..358e54cdc9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -348,4 +348,26 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
+
+=== Discarding an out-of-bounds refblock ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Refblock at 0xffffff00000000 is not covered by the refcount structures; further corruption events will be suppressed
+qemu-img: Failed to discard unused refblocks: Input/output error
+--- Checking and retrying ---
+virtual size: 64M (67108864 bytes)
+No errors were found on the image.
+Image resized.
+virtual size: 32M (33554432 bytes)
+
+=== Discarding a non-covered in-bounds refblock ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Refblock at 0x1000000000 is not covered by the refcount structures; further corruption events will be suppressed
+qemu-img: Failed to discard unused refblocks: Input/output error
+--- Checking and retrying ---
+virtual size: 64M (67108864 bytes)
+No errors were found on the image.
+Image resized.
+virtual size: 32M (33554432 bytes)
 *** done
-- 
2.13.6
