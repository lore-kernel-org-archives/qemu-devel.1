Received: from eggs.gnu.org ([2001:4830:134:3::10]:45120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fbTrl-0001IC-7A
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fbTrk-0002RP-8P
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:45:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Jul 2018 18:45:42 +0200
Message-Id: <20180706164542.9476-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Fix copy-on-read crash with partial
 final cluster
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

If the virtual disk size isn't aligned to full clusters,
bdrv_co_do_copy_on_readv() may get pnum == 0 before having the full
cluster completed, which will let it run into an assertion failure:

qemu-io: block/io.c:1203: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

Check for EOF, assert that we read at least as much as the read request
originally wanted to have (which is true at EOF because otherwise
bdrv_check_byte_request() would already have returned an error) and
return success early even though we couldn't copy the full cluster.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c                 | 6 ++++++
 tests/qemu-iotests/197     | 9 +++++++++
 tests/qemu-iotests/197.out | 8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/block/io.c b/block/io.c
index 038449f81f..4c0831149c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1200,6 +1200,12 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             pnum = MIN(cluster_bytes, max_transfer);
         }
 
+        /* Stop at EOF if the image ends in the middle of the cluster */
+        if (ret == 0 && pnum == 0) {
+            assert(progress >= bytes);
+            break;
+        }
+
         assert(skip_bytes < pnum);
 
         if (ret <= 0) {
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 3ae4975eec..0369aa5cff 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -109,6 +109,15 @@ $QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 _check_test_img
 $QEMU_IMG compare -f $IMGFMT -F qcow2 "$TEST_IMG" "$TEST_WRAP"
 
+echo
+echo '=== Partial final cluster ==='
+echo
+
+_make_test_img 1024
+$QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -f $IMGFMT -c map "$TEST_IMG"
+_check_test_img
+
 # success, all done
 echo '*** done'
 status=0
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 52b4137d7b..8febda5dea 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -23,4 +23,12 @@ can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on-read on read-only dev
 1023.938 MiB (0x3fff0000) bytes not allocated at offset 3 GiB (0xc0010000)
 No errors were found on the image.
 Images are identical.
+
+=== Partial final cluster ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
+read 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+No errors were found on the image.
 *** done
-- 
2.13.6
