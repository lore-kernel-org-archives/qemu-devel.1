Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcon-0002Kl-0l
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcoi-0007vJ-38
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:32 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  3 Nov 2017 16:18:51 +0200
Message-Id: <92dac37191ae7844a2da22c122204eb493cc3133.1509718618.git.berto@igalia.com>
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
References: <cover.1509718618.git.berto@igalia.com>
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
References: <cover.1509718618.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 2/7] qcow2: Prevent allocating L2 tables at
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

If the refcount data is corrupted then we can end up trying to
allocate a new L2 table at offset 0 in the image, triggering an
assertion in the qcow2 cache that would crash QEMU:

  qcow2_cache_entry_mark_dirty: Assertion `c->entries[i].offset != 0' failed

This patch adds an explicit check for this scenario and a new test
case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      | 8 ++++++++
 tests/qemu-iotests/060     | 7 +++++++
 tests/qemu-iotests/060.out | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fb10e26068..2e072ed155 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -278,6 +278,14 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
         goto fail;
     }
 
+    /* If we're allocating the table at offset 0 then something is wrong */
+    if (l2_offset == 0) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
+                                "allocation of L2 table at offset 0");
+        ret = -EIO;
+        goto fail;
+    }
+
     ret = qcow2_cache_flush(bs, s->refcount_block_cache);
     if (ret < 0) {
         goto fail;
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index dead26aeaf..40f85cc216 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -253,6 +253,13 @@ poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 # causing a refcount block to be allocated at offset 0
 $QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "=== Testing empty refcount block ==="
+echo
+_make_test_img 64M
+poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 872719009c..5b8b518486 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -189,4 +189,10 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of refcount block at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+
+=== Testing empty refcount block ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
+write failed: Input/output error
 *** done
-- 
2.11.0
