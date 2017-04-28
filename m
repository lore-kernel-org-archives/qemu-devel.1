Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cb3-0001u7-OC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cb2-0001Ju-33
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:25 +0200
Message-Id: <1493411622-5343-18-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/34] iotests: 109: Filter out "len" of failed
 jobs
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

From: Fam Zheng <famz@redhat.com>

Mirror calculates job len from current I/O progress:

    s->common.len = s->common.offset +
                    (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;

The final "len" of a failed mirror job in iotests 109 depends on the
subtle timing of the completion of read and write issued in the first
mirror iteration.  The second iteration may or may not have run when the
I/O error happens, resulting in non-deterministic output of the
BLOCK_JOB_COMPLETED event text.

Similar to what was done in a752e4786, filter out the field to make the
test robust.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/109           |  6 ++++--
 tests/qemu-iotests/109.out       | 20 ++++++++++----------
 tests/qemu-iotests/common.filter |  6 ++++++
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 6161633..3b496a3 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -81,7 +81,8 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
 
     # This first test should fail: The image format was probed, we may not
     # write an image header at the start of the image
-    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR"
+    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" |
+        _filter_block_job_len
     $QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 
@@ -104,7 +105,8 @@ for sample_img in empty.bochs iotest-dirtylog-10G-4M.vhdx parallels-v1 \
     _make_test_img 64M
     bzcat "$SAMPLE_IMG_DIR/$sample_img.bz2" > "$TEST_IMG.src"
 
-    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" | _filter_block_job_offset
+    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" |
+        _filter_block_job_offset | _filter_block_job_len
     $QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
 
     run_qemu "$TEST_IMG" "$TEST_IMG.src" "'format': 'raw'," "BLOCK_JOB_READY"
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 55fe536..dc02f9e 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -10,7 +10,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -31,7 +31,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 512, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 512, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -52,7 +52,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 262144, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 262144, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -73,7 +73,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -94,7 +94,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -115,7 +115,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -135,7 +135,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -155,7 +155,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -175,7 +175,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -195,7 +195,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index e83885a..f58548d 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -99,6 +99,12 @@ _filter_block_job_offset()
     sed -e 's/, "offset": [0-9]\+,/, "offset": OFFSET,/'
 }
 
+# replace block job len
+_filter_block_job_len()
+{
+    sed -e 's/, "len": [0-9]\+,/, "len": LEN,/g'
+}
+
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-- 
1.8.3.1
