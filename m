Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elDwJ-0003Uo-Gz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elDwF-0008Bj-Dc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:14:35 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Feb 2018 16:14:00 +0300
Message-Id: <1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/2] iotest 033: add misaligned write-zeroes
 test via truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, berto@igalia.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

This new test case only makes sense for qcow2 while iotest 033 is generic;
however it matches the test purpose perfectly and also 033 contains those
do_test() tricks to pass the alignment, which won't look nice being
duplicated in other tests or moved to the common code.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/qemu-iotests/033     | 28 ++++++++++++++++++++++++++++
 tests/qemu-iotests/033.out | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 2cdfd13..5fa3983 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -64,6 +64,9 @@ do_test()
 	} | $QEMU_IO $IO_EXTRA_ARGS
 }
 
+echo
+echo "=== Test aligned and misaligned write zeroes operations ==="
+
 for write_zero_cmd in "write -z" "aio_write -z"; do
 for align in 512 4k; do
 	echo
@@ -102,7 +105,32 @@ for align in 512 4k; do
 done
 done
 
+
+# Trigger truncate that would shrink qcow2 L1 table, which is done by
+#   clearing one entry (8 bytes) with bdrv_co_pwrite_zeroes()
+
+echo
+echo "=== Test misaligned write zeroes via truncate ==="
+echo
+
+CLUSTER_SIZE=$((64 * 1024))
+L2_COVERAGE=$(($CLUSTER_SIZE * $CLUSTER_SIZE / 8))
+_make_test_img $(($L2_COVERAGE * 2))
+
+do_test 512 "write -P 1 0 0x200" "$TEST_IMG" | _filter_qemu_io
+# next L2 table
+do_test 512 "write -P 1 $L2_COVERAGE 0x200" "$TEST_IMG" | _filter_qemu_io
+
+# only interested in qcow2 here; also other formats might respond with
+#  "not supported" error message
+if [ $IMGFMT = "qcow2" ]; then
+    do_test 512 "truncate $L2_COVERAGE" "$TEST_IMG" | _filter_qemu_io
+fi
+
+do_test 512 "read -P 1 0 0x200" "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
+echo
 echo "*** done"
 rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/033.out b/tests/qemu-iotests/033.out
index 95929ef..57799cb 100644
--- a/tests/qemu-iotests/033.out
+++ b/tests/qemu-iotests/033.out
@@ -1,6 +1,8 @@
 QA output created by 033
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
+=== Test aligned and misaligned write zeroes operations ===
+
 == preparing image ==
 wrote 1024/1024 bytes at offset 512
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -164,4 +166,15 @@ read 512/512 bytes at offset 512
 read 3072/3072 bytes at offset 1024
 3 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+
+=== Test misaligned write zeroes via truncate ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 536870912
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 *** done
-- 
2.7.4
