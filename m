Received: from eggs.gnu.org ([209.51.188.92]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzUt-0005jH-Dk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzIq-0003u5-Bk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 16:14:30 +0300
Message-Id: <20190227131433.197063-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 2/5] qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, vsementsov@virtuozzo.com

qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
an unpredictable amount of memory on corrupted table entries, which are
referencing regions far beyond the end of file.

Prevent this, by skipping such regions from further processing.

Interesting that iotest 138 checks exactly the behavior which we fix
here. So, change the test appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     | 19 +++++++++++++++++++
 tests/qemu-iotests/138     | 12 +++++-------
 tests/qemu-iotests/138.out |  5 ++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 16e8942343..add1bbf54f 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1508,12 +1508,31 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start, last, cluster_offset, k, refcount;
+    int64_t file_len;
     int ret;
 
     if (size <= 0) {
         return 0;
     }
 
+    file_len = bdrv_getlength(bs->file->bs);
+    if (file_len < 0) {
+        return file_len;
+    }
+
+    /*
+     * Last cluster of qcow2 image may be semi-allocated, so it may be OK to
+     * reference some space after file end but it should be less than one
+     * cluster.
+     */
+    if (offset + size - file_len >= s->cluster_size) {
+        fprintf(stderr, "ERROR: counting reference for region exceeding the "
+                "end of the file by one cluster or more: offset 0x%" PRIx64
+                " size 0x%" PRIx64 "\n", offset, size);
+        res->corruptions++;
+        return 0;
+    }
+
     start = start_of_cluster(s, offset);
     last = start_of_cluster(s, offset + size - 1);
     for(cluster_offset = start; cluster_offset <= last;
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index eccbcae3a6..12e20762e5 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -54,15 +54,13 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
 # Put the data cluster at a multiple of 2 TB, resulting in the image apparently
 # having a multiple of 2^32 clusters
 # (To be more specific: It is at 32 PB)
-poke_file "$TEST_IMG" 2048 "\x80\x80\x00\x00\x00\x00\x00\x00"
+poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x00\x00\x00\x00"
 
 # An offset of 32 PB results in qemu-img check having to allocate an in-memory
-# refcount table of 128 TB (16 bit refcounts, 512 byte clusters).
-# This should be generally too much for any system and thus fail.
-# What this test is checking is that the qcow2 driver actually tries to allocate
-# such a large amount of memory (and is consequently aborting) instead of having
-# truncated the cluster count somewhere (which would result in much less memory
-# being allocated and then a segfault occurring).
+# refcount table of 128 TB (16 bit refcounts, 512 byte clusters), if qemu-img
+# don't check that referenced data cluster is far beyond the end of file.
+# But starting from 4.0, qemu-img does this check, and instead of "Cannot
+# allocate memory", we have an error showing that l2 entry is invalid.
 _check_test_img
 
 # success, all done
diff --git a/tests/qemu-iotests/138.out b/tests/qemu-iotests/138.out
index 3fe911f85a..aca7d47a80 100644
--- a/tests/qemu-iotests/138.out
+++ b/tests/qemu-iotests/138.out
@@ -5,5 +5,8 @@ QA output created by 138
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=512
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Check failed: Cannot allocate memory
+ERROR: counting reference for region exceeding the end of the file by one cluster or more: offset 0x80000000000000 size 0x200
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
 *** done
-- 
2.18.0
