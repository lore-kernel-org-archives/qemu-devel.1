Received: from eggs.gnu.org ([2001:4830:134:3::10]:59833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAt-000713-4I
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAo-0005bC-7O
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:27 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 Nov 2017 17:42:24 +0200
Message-Id: <33492fad2f21dff38a33a96decb38983aee7e405.1509550787.git.berto@igalia.com>
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
References: <cover.1509550787.git.berto@igalia.com>
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
References: <cover.1509550787.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 3/4] qcow2: Don't open images with
 header.refcount_table_clusters == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

qcow2_do_open() is checking that header.refcount_table_clusters is not
too large, but it doesn't check that it's greater than zero. Apart
from the fact that an image like that is obviously corrupted, trying
to use it crashes QEMU since we end up with a null s->refcount_table
after qcow2_refcount_init().

These images can however be repaired, so allow opening them if the
BDRV_O_CHECK flag is set.

Signed-off-by: Alberto Garcia <berto@igalia.com>
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
index 40f85cc216..8fcfce1260 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -260,6 +260,13 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
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
index 5b8b518486..6db399d674 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -195,4 +195,9 @@ write failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+
+=== Testing zero refcount table size ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
 *** done
-- 
2.11.0
