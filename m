Received: from eggs.gnu.org ([2001:4830:134:3::10]:48641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwIq3-00021c-42
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 21:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwIq1-0008Kw-Vu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 21:37:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  6 Apr 2017 20:37:09 -0500
Message-Id: <20170407013709.18440-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9?] qcow2: Allow discard of final
 unaligned cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, "open list:qcow2" <qemu-block@nongnu.org>

As mentioned in commit 0c1bd46, we ignored requests to
discard the trailing cluster of an unaligned image.  While
discard is an advisory operation from the guest standpoint,
(and we are therefore free to ignore any request), our
qcow2 implementation exploits the fact that a discarded
cluster reads back as 0.  As long as we discard on cluster
boundaries, we are fine; but that means we could observe
non-zero data leaked at the tail of an unaligned image.

Enhance iotest 66 to cover this case, and fix the implementation
to honor a discard request on the final partial cluster.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I can't convince myself whether we strongly rely on aligned discards
to guarantee that we read back zeroes on qcow2 (it would be a
stronger contract than what the block layer requires of pdiscard,
since the guest cannot guarantee that a discard does anything). If
we do, then this is a bug fix worthy of 2.9. If we don't, then the
changes to test 66 rely on internal implementation (but the test is
already specific to qcow2), and the patch can wait for 2.10.

At any rate, I do know that we don't want to make discard work on
sub-cluster boundaries anywhere except at the tail of the image
(that's what write-zeroes is for, and it may be slower when it
has to do COW or read-modify-write).  Any reliance that we (might)
have on whole-cluster discards reading back as 0 is also relying
on using aligned operations.

 block/qcow2.c              |  7 ++++++-
 tests/qemu-iotests/066     | 12 +++++++-----
 tests/qemu-iotests/066.out | 12 ++++++++----
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6a92d2e..863d889 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2515,7 +2515,12 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,

     if (!QEMU_IS_ALIGNED(offset | count, s->cluster_size)) {
         assert(count < s->cluster_size);
-        return -ENOTSUP;
+        /* Ignore partial clusters, except for the special case of the
+         * complete partial cluster at the end of an unaligned file */
+        if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
+            offset + count != bs->total_sectors * BDRV_SECTOR_SIZE) {
+            return -ENOTSUP;
+        }
     }

     qemu_co_mutex_lock(&s->lock);
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 364166d..c2116a3 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -42,16 +42,18 @@ _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux

+# Intentionally create an unaligned image
 IMGOPTS="compat=1.1"
-IMG_SIZE=64M
+IMG_SIZE=$((64 * 1024 * 1024 + 512))

 echo
-echo "=== Testing snapshotting an image with zero clusters ==="
+echo "=== Testing cluster discards ==="
 echo
 _make_test_img $IMG_SIZE
-# Write some normal clusters, zero them (creating preallocated zero clusters)
-# and discard those
-$QEMU_IO -c "write 0 256k" -c "write -z 0 256k" -c "discard 0 256k" "$TEST_IMG" \
+# Write some normal clusters, zero some of them (creating preallocated
+# zero clusters) and discard everything. Everything should now read as 0.
+$QEMU_IO -c "write 0 256k" -c "write -z 0 256k" -c "write 64M 512" \
+	 -c "discard 0 $IMG_SIZE" -c "read -P 0 0 $IMG_SIZE" "$TEST_IMG" \
          | _filter_qemu_io
 # Check the image (there shouldn't be any leaks)
 _check_test_img
diff --git a/tests/qemu-iotests/066.out b/tests/qemu-iotests/066.out
index 7bc9a10..7c1f31a 100644
--- a/tests/qemu-iotests/066.out
+++ b/tests/qemu-iotests/066.out
@@ -1,13 +1,17 @@
 QA output created by 066

-=== Testing snapshotting an image with zero clusters ===
+=== Testing cluster discards ===

-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67109376
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-discard 262144/262144 bytes at offset 0
-256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 67108864
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 67109376/67109376 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 67109376/67109376 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 *** done
-- 
2.9.3
