Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewx-0005YP-Gm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEeww-0004Dn-IE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:01 +0100
Message-Id: <20171114172417.7654-5-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 04/20] qcow2: Don't open images with
 header.refcount_table_clusters == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

From: Alberto Garcia <berto@igalia.com>

qcow2_do_open() is checking that header.refcount_table_clusters is not
too large, but it doesn't check that it's greater than zero. Apart
from the fact that an image like that is obviously corrupted, trying
to use it crashes QEMU since we end up with a null s->refcount_table
after qcow2_refcount_init().

These images can however be repaired, so allow opening them if the
BDRV_O_CHECK flag is set.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: f9750f50c80359babba11062e88f5075a47e8e16.1509718618.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 6 ++++++
 tests/qemu-iotests/060     | 7 +++++++
 tests/qemu-iotests/060.out | 5 +++++
 3 files changed, 18 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 92cb9f9bfa..defc1fe49f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1280,6 +1280,12 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    if (header.refcount_table_clusters == 0 && !(flags & BDRV_O_CHECK)) {
+        error_setg(errp, "Image does not contain a reference count table");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     ret = validate_table_offset(bs, s->refcount_table_offset,
                                 s->refcount_table_size, sizeof(uint64_t));
     if (ret < 0) {
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index c3bce27b33..656af50883 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -270,6 +270,13 @@ poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 # write will try to allocate a compressed data cluster at offset 0.
 $QEMU_IO -c "write -c 0k 64k" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "=== Testing zero refcount table size ==="
+echo
+_make_test_img 64M
+poke_file "$TEST_IMG" "56"                "\x00\x00\x00\x00"
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index cf8790ff57..58456e8487 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -203,4 +203,9 @@ wrote 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of compressed cluster at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+
+=== Testing zero refcount table size ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
 *** done
-- 
2.13.6
