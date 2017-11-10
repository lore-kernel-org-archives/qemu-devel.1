Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxr-0001Vp-GA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxq-0004Kg-De
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:47 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:31:11 +0100
Message-Id: <20171110203111.7666-6-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned
 offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

Instead of using an assertion, it is better to emit a corruption event
here.  Checking all offsets for correct alignment can be tedious and it
is easily possible to forget to do so.  qcow2_cache_do_get() is a
function every L2 and refblock access has to go through, so this is a
good central point to add such a check.

And for good measure, let us also add an assertion that the offset is
non-zero.  Making this a corruption event is not feasible, because a
zero offset usually means something special (such as the cluster is
unused), so all callers should be checking this anyway.  If they do not,
it is their fault, hence the assertion here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cache.c        | 21 +++++++++++++++++++++
 tests/qemu-iotests/060     | 21 +++++++++++++++++++++
 tests/qemu-iotests/060.out | 29 +++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 75746a7f43..a5baaba0ff 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -62,6 +62,18 @@ static inline int qcow2_cache_get_table_idx(BlockDriverState *bs,
     return idx;
 }
 
+static inline const char *qcow2_cache_get_name(BDRVQcow2State *s, Qcow2Cache *c)
+{
+    if (c == s->refcount_block_cache) {
+        return "refcount block";
+    } else if (c == s->l2_table_cache) {
+        return "L2 table";
+    } else {
+        /* Do not abort, because this is not critical */
+        return "unknown";
+    }
+}
+
 static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
                                       int i, int num_tables)
 {
@@ -314,9 +326,18 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     uint64_t min_lru_counter = UINT64_MAX;
     int min_lru_index = -1;
 
+    assert(offset != 0);
+
     trace_qcow2_cache_get(qemu_coroutine_self(), c == s->l2_table_cache,
                           offset, read_from_disk);
 
+    if (offset_into_cluster(s, offset)) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Cannot get entry from %s "
+                                "cache: Offset %#" PRIx64 " is unaligned",
+                                qcow2_cache_get_name(s, c), offset);
+        return -EIO;
+    }
+
     /* Check if the table is already cached */
     i = lookup_index = (offset / s->cluster_size * 4) % c->size;
     do {
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index c230696b3a..1eca09417b 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -405,6 +405,27 @@ _check_test_img -r all
 $QEMU_IMG resize --shrink "$TEST_IMG" 32M
 _img_info | grep 'virtual size'
 
+echo
+echo "=== Discarding a refblock covered by an unaligned refblock ==="
+echo
+
+IMGOPTS='refcount_bits=1' _make_test_img 64M
+
+# Same as above
+poke_file "$TEST_IMG" "$(($rt_offset+8))" "\x00\x00\x00\x10\x00\x00\x00\x00"
+# But now we actually "create" an unaligned third refblock
+poke_file "$TEST_IMG" "$(($rt_offset+16))" "\x00\x00\x00\x00\x00\x00\x02\x00"
+$QEMU_IMG resize --shrink "$TEST_IMG" 32M
+
+echo '--- Repairing ---'
+# Fails the first repair because the corruption prevents the check
+# function from double-checking
+# (Using -q for the first invocation, because otherwise the
+#  double-check error message appears above the summary for some
+#  reason -- so let's just hide the summary)
+_check_test_img -q -r all
+_check_test_img -r all
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 358e54cdc9..56f5eb15d8 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -370,4 +370,33 @@ virtual size: 64M (67108864 bytes)
 No errors were found on the image.
 Image resized.
 virtual size: 32M (33554432 bytes)
+
+=== Discarding a refblock covered by an unaligned refblock ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Cannot get entry from refcount block cache: Offset 0x200 is unaligned; further corruption events will be suppressed
+qemu-img: Failed to discard unused refblocks: Input/output error
+--- Repairing ---
+Repairing refcount block 1 is outside image
+ERROR refcount block 2 is not cluster aligned; refcount table entry corrupted
+qcow2: Marking image as corrupt: Refblock offset 0x200 unaligned (reftable index: 0x2); further corruption events will be suppressed
+Can't get refcount for cluster 1048576: Input/output error
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+Repairing cluster 1048576 refcount=1 reference=0
+qemu-img: Check failed: No medium found
+Leaked cluster 1 refcount=1 reference=0
+Leaked cluster 2 refcount=1 reference=0
+Leaked cluster 1048576 refcount=1 reference=0
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+Repairing cluster 1048576 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    3 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 *** done
-- 
2.13.6
