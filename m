Received: from eggs.gnu.org ([2001:4830:134:3::10]:48352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJm-0006v2-Qk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJj-0006pk-Gi
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:30 -0400
Received: from mail-db5eur01on0106.outbound.protection.outlook.com
	([104.47.2.106]:27443
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJj-0006pK-5q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:27 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:40 +0300
Message-ID: <1495186480-114192-14-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 13/13] iotest 046: test simultaneous cluster
 write error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/qemu-iotests/046     | 38 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/046.out | 23 +++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf..c210b55 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -29,7 +29,8 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
+    rm "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -188,6 +189,37 @@ overlay_io | $QEMU_IO blkdebug::"$TEST_IMG" | _filter_qemu_io |\
 	sed -e 's/bytes at offset [0-9]*/bytes at offset XXX/g'
 
 echo
+echo "== Concurrency error case =="
+
+# 1. 1st request allocated the cluster, stop before it writes and updates L2
+# 2. 2nd request starts at the same cluster must complete write and start
+#    waiting for the 1st to update L2
+# 3. Resume the 1st request to make it fail (injected error)
+# 4. 2nd request must wake and fail as well
+#    1 cluster will end up leaked
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "write_aio"
+sector = "0xb00"
+EOF
+function error_io()
+{
+cat <<EOF
+discard 0x120000 0x20000
+break write_aio A
+aio_write -P 180 0x120000 0x200
+wait_break A
+aio_write -P 181 0x120200 0x10000
+resume A
+EOF
+}
+
+error_io | $QEMU_IO "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG" | _filter_qemu_io |\
+	sed -e 's/bytes at offset [0-9]*/bytes at offset XXX/g'
+
+_check_test_img -r leaks
+
+echo
 echo "== Verify image content =="
 
 function verify_io()
@@ -259,6 +291,10 @@ function verify_io()
     # Undefined content for 0x10c000 0x8000
     echo read -P 160 0x114000 0x8000
     echo read -P 17  0x11c000 0x4000
+
+    echo read -P ${discarded:-18} 0x120000 0x10000
+    echo read -P 181 0x130000 0x200
+    echo read -P ${discarded:-19} 0x130200 0xfe00
 }
 
 verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index ca2c740..a065102 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -140,6 +140,23 @@ wrote 32768/32768 bytes at offset XXX
 wrote 98304/98304 bytes at offset XXX
 96 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+== Concurrency error case ==
+discard 131072/131072 bytes at offset XXX
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+blkdebug: Suspended request 'A'
+blkdebug: Resuming request 'A'
+aio_write failed: Input/output error
+aio_write failed: Input/output error
+Leaked cluster 22 refcount=1 reference=0
+Repairing cluster 22 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
 == Verify image content ==
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -235,5 +252,11 @@ read 32768/32768 bytes at offset 1130496
 32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 16384/16384 bytes at offset 1163264
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 1179648
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 1245184
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65024/65024 bytes at offset 1245696
+63.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 *** done
-- 
2.7.4
