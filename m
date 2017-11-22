Received: from eggs.gnu.org ([2001:4830:134:3::10]:46332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIiw-00060f-Ev
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIiv-0000Cq-8r
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:17:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2017 19:16:56 -0500
Message-Id: <20171122001656.12996-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Both of these tests are for formats which now stipulate that they are
read-only. Adjust the tests to match.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/075 | 18 +++++++++---------
 tests/qemu-iotests/078 | 14 +++++++-------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 770d51c6cb..caa30d4743 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -48,56 +48,56 @@ offsets_offset=136
 echo
 echo "== check that the first sector can be read =="
 _use_sample_img simple-pattern.cloop.bz2
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== check that the last sector can be read =="
 _use_sample_img simple-pattern.cloop.bz2
-$QEMU_IO -c "read $((1024 * 1024 - 512)) 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read $((1024 * 1024 - 512)) 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== block_size must be a multiple of 512 =="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\x00\x00\x02\x01"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== block_size cannot be zero =="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\x00\x00\x00\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== huge block_size ==="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\xff\xff\xfe\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== offsets_size overflow ==="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$n_blocks_offset" "\xff\xff\xff\xff"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== refuse images that require too many offsets ==="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$n_blocks_offset" "\x04\x00\x00\x01"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== refuse images with non-monotonically increasing offsets =="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$offsets_offset" "\x00\x00\x00\x00\xff\xff\xff\xff"
 poke_file "$TEST_IMG" $((offsets_offset + 8)) "\x00\x00\x00\x00\xff\xfe\x00\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== refuse images with invalid compressed block size =="
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$offsets_offset" "\x00\x00\x00\x00\x00\x00\x00\x00"
 poke_file "$TEST_IMG" $((offsets_offset + 8)) "\xff\xff\xff\xff\xff\xff\xff\xff"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index f333e9ac84..a106c26f6b 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -48,41 +48,41 @@ disk_size_offset=$((0x58))
 echo
 echo "== Read from a valid image =="
 _use_sample_img empty.bochs.bz2
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Negative catalog size =="
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\xff\xff\xff\xff"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Overflow for catalog size * sizeof(uint32_t) =="
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\x00\x00\x00\x40"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Too small catalog bitmap for image size =="
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$disk_size_offset" "\x00\xc0\x0f\x00\x00\x00\x00\x7f"
-{ $QEMU_IO -c "read 2T 4k" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 2T 4k" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\x10\x00\x00\x00"
-{ $QEMU_IO -c "read 0xfbe00 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 0xfbe00 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Negative extent size =="
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$extent_size_offset" "\x00\x00\x00\x80"
-{ $QEMU_IO -c "read 768k 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 768k 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== Zero extent size =="
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$extent_size_offset" "\x00\x00\x00\x00"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 # success, all done
 echo "*** done"
-- 
2.14.3
