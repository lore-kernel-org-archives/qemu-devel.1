Received: from eggs.gnu.org ([2001:4830:134:3::10]:60790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCL-0008I9-9a
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCG-0006lt-7q
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:57 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:05 +0300
Message-Id: <1509551048-129830-13-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 12/15] qcow2: check space leak at the end of
 the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Pavel Butsykin <pbutsykin@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

Preallocated space in the image may remain unused; the patch adds
the functionality to identify and fix it in the qcow2_check
to avoid wasting storage space on the host.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c                      | 32 +++++++++++++
 tests/qemu-iotests/026.out         | 94 +++++++++++++++++++++++++++++---------
 tests/qemu-iotests/026.out.nocache | 94 +++++++++++++++++++++++++++++---------
 tests/qemu-iotests/029.out         |  5 +-
 tests/qemu-iotests/060.out         | 10 +++-
 tests/qemu-iotests/061.out         |  5 +-
 tests/qemu-iotests/066.out         |  5 +-
 tests/qemu-iotests/098.out         |  7 ++-
 tests/qemu-iotests/108.out         |  5 +-
 tests/qemu-iotests/112.out         |  5 +-
 10 files changed, 210 insertions(+), 52 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5e2b543..ef65b5f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -530,6 +530,33 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     return 0;
 }
 
+static int qcow2_check_extra_preallocation(BlockDriverState *bs,
+    BdrvCheckResult *res, BdrvCheckMode fix)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t img_size = bdrv_getlength(bs->file->bs);
+
+    if (res->image_end_offset < img_size) {
+        uint64_t count =
+            DIV_ROUND_UP(img_size - res->image_end_offset, s->cluster_size);
+        fprintf(stderr, "%s space leaked at the end of the image %jd\n",
+                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                img_size - res->image_end_offset);
+        res->leaks += count;
+        if (fix & BDRV_FIX_LEAKS) {
+            int ret = bdrv_truncate(bs->file, res->image_end_offset,
+                                    PREALLOC_MODE_OFF, NULL);
+            if (ret < 0) {
+                res->check_errors++;
+                return ret;
+            }
+            res->leaks_fixed += count;
+        }
+    }
+
+    return 0;
+}
+
 static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
                        BdrvCheckMode fix)
 {
@@ -538,6 +565,11 @@ static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
         return ret;
     }
 
+    ret = qcow2_check_extra_preallocation(bs, result, fix);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (fix && result->check_errors == 0 && result->corruptions == 0) {
         ret = qcow2_mark_clean(bs);
         if (ret < 0) {
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 86a50a2..29cc41e 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -5,7 +5,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write
 write failed: Input/output error
-No errors were found on the image.
+ERROR space leaked at the end of the image 1024
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write -b
@@ -33,7 +36,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 1024
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write -b
@@ -468,20 +474,27 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 394240
+
+770 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 5120
 
-55 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -489,19 +502,26 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 265728
 
-251 leaked clusters were found on the image.
+770 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 394240
+
+770 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
@@ -520,20 +540,27 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 27648
 
-11 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -541,27 +568,35 @@ Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 21504
 
-23 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 131584
 
-11 leaked clusters were found on the image.
+268 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -569,27 +604,35 @@ Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 131584
 
-23 leaked clusters were found on the image.
+280 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 132608
 
-11 leaked clusters were found on the image.
+270 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -597,8 +640,9 @@ Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 132608
 
-23 leaked clusters were found on the image.
+282 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
@@ -651,7 +695,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: on
 write failed: Input/output error
-No errors were found on the image.
+ERROR space leaked at the end of the image 98304
+
+96 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
@@ -665,7 +712,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 98304
+
+96 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index ea2e166..42b258b 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -5,7 +5,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
-No errors were found on the image.
+ERROR space leaked at the end of the image 1024
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: on; write -b
@@ -33,7 +36,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 1024
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: on; write -b
@@ -476,20 +482,27 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 394240
+
+770 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 5120
 
-55 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -497,19 +510,26 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 265728
 
-251 leaked clusters were found on the image.
+770 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 394240
+
+770 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write 
@@ -528,20 +548,27 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 27648
 
-11 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -549,27 +576,35 @@ Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 21504
 
-23 leaked clusters were found on the image.
+65 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 131584
 
-11 leaked clusters were found on the image.
+268 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -577,27 +612,35 @@ Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 131584
 
-23 leaked clusters were found on the image.
+280 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write -b
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 33280
+
+65 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 132608
 
-11 leaked clusters were found on the image.
+270 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -605,8 +648,9 @@ Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+ERROR space leaked at the end of the image 132608
 
-23 leaked clusters were found on the image.
+282 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
@@ -659,7 +703,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: on
 write failed: Input/output error
-No errors were found on the image.
+ERROR space leaked at the end of the image 98304
+
+96 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
@@ -673,7 +720,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
 write failed: No space left on device
-No errors were found on the image.
+ERROR space leaked at the end of the image 98304
+
+96 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
diff --git a/tests/qemu-iotests/029.out b/tests/qemu-iotests/029.out
index 5bc93e0..7176e38 100644
--- a/tests/qemu-iotests/029.out
+++ b/tests/qemu-iotests/029.out
@@ -6,7 +6,10 @@ is smaller than the current L1 table.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-No errors were found on the image.
+ERROR space leaked at the end of the image 65536
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 736dc30..290ccec 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -78,20 +78,26 @@ Leaked cluster 9 refcount=1 reference=0
 Repairing cluster 4 refcount=1 reference=2
 Repairing cluster 9 refcount=1 reference=0
 Repairing OFLAG_COPIED data cluster: l2_entry=8000000000040000 refcount=2
+ERROR space leaked at the end of the image 65536
 The following inconsistencies were found and repaired:
 
     1 leaked clusters
     2 corruptions
 
 Double checking the fixed image now...
-No errors were found on the image.
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 incompatible_features     0x0
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     0x0
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-No errors were found on the image.
+ERROR space leaked at the end of the image 131072
+
+2 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 942485d..87aaebf 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -328,7 +328,10 @@ wrote 131072/131072 bytes at offset 0
 No errors were found on the image.
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-No errors were found on the image.
+ERROR space leaked at the end of the image 196608
+
+3 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/066.out b/tests/qemu-iotests/066.out
index 093431e..81ef795 100644
--- a/tests/qemu-iotests/066.out
+++ b/tests/qemu-iotests/066.out
@@ -13,7 +13,10 @@ discard 67109376/67109376 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 67109376/67109376 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-No errors were found on the image.
+ERROR space leaked at the end of the image 327680
+
+5 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Offset          Length          Mapped to       File
 
 === Writing to preallocated zero clusters ===
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 7634d0e..733249f 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -20,7 +20,10 @@ Leaked cluster 4 refcount=1 reference=0
 Leaked cluster 5 refcount=1 reference=0
 Repairing cluster 4 refcount=1 reference=0
 Repairing cluster 5 refcount=1 reference=0
-No errors were found on the image.
+ERROR space leaked at the end of the image 131072
+
+2 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 
 === reftable_update ===
 
@@ -34,6 +37,7 @@ ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
 Rebuilding refcount structure
 Repairing cluster 1 refcount=1 reference=0
+Repairing space leaked at the end of the image 65536
 No errors were found on the image.
 
 === refblock_alloc ===
@@ -48,5 +52,6 @@ ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
 Rebuilding refcount structure
 Repairing cluster 1 refcount=1 reference=0
+Repairing space leaked at the end of the image 65536
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/108.out b/tests/qemu-iotests/108.out
index 75bab8d..d178b1e 100644
--- a/tests/qemu-iotests/108.out
+++ b/tests/qemu-iotests/108.out
@@ -68,13 +68,16 @@ Rebuilding refcount structure
 Repairing cluster 1 refcount=1 reference=0
 Repairing cluster 2 refcount=1 reference=0
 Repairing cluster 16 refcount=1 reference=0
+ERROR space leaked at the end of the image 720896
 The following inconsistencies were found and repaired:
 
     0 leaked clusters
     2 corruptions
 
 Double checking the fixed image now...
-No errors were found on the image.
+
+11 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 
 --- Signed overflow after the refblock ---
 
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index 81b04d1..7386be8 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -93,7 +93,10 @@ refcount bits: 1
 
 === Amend from refcount_bits=1 to refcount_bits=64 ===
 
-No errors were found on the image.
+ERROR space leaked at the end of the image 131072
+
+2 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 refcount bits: 64
 
 === Amend to compat=0.10 ===
-- 
2.7.4
