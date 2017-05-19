Received: from eggs.gnu.org ([2001:4830:134:3::10]:48214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJV-0006ja-5P
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJR-0006ki-8N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:13 -0400
Received: from mail-db5eur01on0118.outbound.protection.outlook.com
	([104.47.2.118]:9856
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJQ-0006hy-UF
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:09 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:29 +0300
Message-ID: <1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return true
 if area is outside of backing file
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

in such case, bdrv_get_block_status() shall return 0, *nr == 0

iotest 154 updated accordingly: write-zeroes tail alignment can be detected
as zeroes now, so pwrite_zeroes succeeds

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c              | 6 ++++--
 tests/qemu-iotests/154.out | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2e6a0ec..b885dfc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2482,7 +2482,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     int64_t res;
 
     if (start + count > bs->total_sectors) {
-        count = bs->total_sectors - start;
+        count = start < bs->total_sectors ? bs->total_sectors - start : 0;
     }
 
     if (!count) {
@@ -2490,7 +2490,9 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     }
     res = bdrv_get_block_status_above(bs, NULL, start, count,
                                       &nr, &file);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
+    return res >= 0
+        && (((res & BDRV_BLOCK_ZERO) && nr == count)
+            || nr == 0);
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index d8485ee..259340e 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -322,7 +322,7 @@ wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -348,7 +348,7 @@ wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.7.4
