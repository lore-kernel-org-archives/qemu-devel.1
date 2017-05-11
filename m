Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBO-0003IX-4g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBM-0008VH-EK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:56 +0200
Message-Id: <1494513181-7900-54-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 53/58] iotests: Improve _filter_qemu_img_map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Although _filter_qemu_img_map documents that it scrubs offsets, it
was only doing so for human mode.  Of the existing tests using the
filter (97, 122, 150, 154, 176), two of them are affected, but it
does not hurt the validity of the tests to not require particular
mappings (another test, 66, uses offsets but intentionally does not
pass through _filter_qemu_img_map, because it checks that offsets
are unchanged before and after an operation).

Another justification for this patch is that it will allow a future
patch to utilize 'qemu-img map --output=json' to check the status of
preallocated zero clusters without regards to the mapping (since
the qcow2 mapping can be very sensitive to the chosen cluster size,
when preallocation is not in use).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-9-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122.out       | 16 ++++++++--------
 tests/qemu-iotests/154.out       | 30 +++++++++++++++---------------
 tests/qemu-iotests/common.filter |  4 +++-
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 9317d80..47d8656 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -112,7 +112,7 @@ read 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 63963136/63963136 bytes at offset 3145728
 61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 
 convert -c -S 0:
 read 3145728/3145728 bytes at offset 0
@@ -134,7 +134,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 
 convert -c -S 0 with source backing file:
 read 3145728/3145728 bytes at offset 0
@@ -152,7 +152,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 
 convert -c -S 0 -B ...
 read 3145728/3145728 bytes at offset 0
@@ -176,11 +176,11 @@ wrote 1024/1024 bytes at offset 17408
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 convert -S 4k
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": 8192},
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 1024, "length": 7168, "depth": 0, "zero": true, "data": false},
-{ "start": 8192, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": 9216},
+{ "start": 8192, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": 10240},
+{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
 
 convert -c -S 4k
@@ -192,9 +192,9 @@ convert -c -S 4k
 { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
 
 convert -S 8k
-[{ "start": 0, "length": 9216, "depth": 0, "zero": false, "data": true, "offset": 8192},
+[{ "start": 0, "length": 9216, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": 17408},
+{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
 
 convert -c -S 8k
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index da9eabd..d3b68e7 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -42,9 +42,9 @@ read 1024/1024 bytes at offset 65536
 read 2048/2048 bytes at offset 67584
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 32768, "depth": 1, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 36864, "length": 28672, "depth": 1, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
+{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 69632, "length": 134148096, "depth": 1, "zero": true, "data": false}]
 
 == backing file contains non-zero data after write_zeroes ==
@@ -69,9 +69,9 @@ read 1024/1024 bytes at offset 44032
 read 3072/3072 bytes at offset 40960
 3 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 32768, "depth": 1, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 36864, "length": 4096, "depth": 1, "zero": true, "data": false},
-{ "start": 40960, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
+{ "start": 40960, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 45056, "length": 134172672, "depth": 1, "zero": true, "data": false}]
 
 == write_zeroes covers non-zero data ==
@@ -143,13 +143,13 @@ read 1024/1024 bytes at offset 67584
 read 5120/5120 bytes at offset 68608
 5 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 32768, "depth": 1, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 32768, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 36864, "length": 4096, "depth": 0, "zero": true, "data": false},
 { "start": 40960, "length": 8192, "depth": 1, "zero": true, "data": false},
-{ "start": 49152, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
+{ "start": 49152, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 53248, "length": 4096, "depth": 0, "zero": true, "data": false},
 { "start": 57344, "length": 8192, "depth": 1, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 28672},
+{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 69632, "length": 4096, "depth": 0, "zero": true, "data": false},
 { "start": 73728, "length": 134144000, "depth": 1, "zero": true, "data": false}]
 
@@ -186,13 +186,13 @@ read 1024/1024 bytes at offset 72704
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 32768, "depth": 1, "zero": true, "data": false},
 { "start": 32768, "length": 4096, "depth": 0, "zero": true, "data": false},
-{ "start": 36864, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 36864, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 40960, "length": 8192, "depth": 1, "zero": true, "data": false},
 { "start": 49152, "length": 4096, "depth": 0, "zero": true, "data": false},
-{ "start": 53248, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
+{ "start": 53248, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 57344, "length": 8192, "depth": 1, "zero": true, "data": false},
 { "start": 65536, "length": 4096, "depth": 0, "zero": true, "data": false},
-{ "start": 69632, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 28672},
+{ "start": 69632, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 73728, "length": 134144000, "depth": 1, "zero": true, "data": false}]
 
 == spanning two clusters, partially overwriting backing file ==
@@ -212,7 +212,7 @@ read 1024/1024 bytes at offset 5120
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2048/2048 bytes at offset 6144
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 8192, "depth": 0, "zero": false, "data": true, "offset": 20480},
+[{ "start": 0, "length": 8192, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 8192, "length": 134209536, "depth": 1, "zero": true, "data": false}]
 
 == spanning multiple clusters, non-zero in first cluster ==
@@ -227,7 +227,7 @@ read 2048/2048 bytes at offset 65536
 read 10240/10240 bytes at offset 67584
 10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 65536, "depth": 1, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 69632, "length": 8192, "depth": 0, "zero": true, "data": false},
 { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data": false}]
 
@@ -257,7 +257,7 @@ read 2048/2048 bytes at offset 75776
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 65536, "depth": 1, "zero": true, "data": false},
 { "start": 65536, "length": 8192, "depth": 0, "zero": true, "data": false},
-{ "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data": false}]
 
 == spanning multiple clusters, partially overwriting backing file ==
@@ -278,8 +278,8 @@ read 2048/2048 bytes at offset 74752
 read 1024/1024 bytes at offset 76800
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 65536, "depth": 1, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 20480},
+{ "start": 65536, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 69632, "length": 4096, "depth": 0, "zero": true, "data": false},
-{ "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
+{ "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data": false}]
 *** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index f58548d..2f595b2 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -152,10 +152,12 @@ _filter_img_info()
         -e "/log_size: [0-9]\\+/d"
 }
 
-# filter out offsets and file names from qemu-img map
+# filter out offsets and file names from qemu-img map; good for both
+# human and json output
 _filter_qemu_img_map()
 {
     sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
+        -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
         -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
 }
 
-- 
1.8.3.1
