Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0O2m-00013L-2c
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0O2k-00083f-PD
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:59:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 18 Apr 2017 15:59:11 +0800
Message-Id: <20170418075911.7579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Mirror calculates job len from current I/O progress:

    s->common.len = s->common.offset +
                    (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;

The final "len" of a failed mirror job in iotests 109 depends on the
subtle timing of the completion of read and write issued in the first
mirror iteration.  The second iteration may or may not have run when the
I/O error happens, resulting in an undeterministic output of the
BLOCK_JOB_COMPLETED event text.

Similar to what was done in a752e4786, filter out the field to make the
test robust.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/109           |  3 ++-
 tests/qemu-iotests/109.out       | 12 ++++++------
 tests/qemu-iotests/common.filter |  6 ++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 927151a..6d61cf1 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -80,7 +80,8 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
 
     # This first test should fail: The image format was probed, we may not
     # write an image header at the start of the image
-    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR"
+    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" | \
+        _filter_block_job_len
     $QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 55fe536..6454b7e 100644
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
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 1040013..d712633 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -92,6 +92,12 @@ _filter_block_job_offset()
     sed -e 's/, "offset": [0-9]\+,/, "offset": OFFSET,/'
 }
 
+# replace block job len
+_filter_block_job_len()
+{
+    sed -e 's/, "len": [0-9]\+,/, "len": LEN,/'
+}
+
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-- 
2.9.3
