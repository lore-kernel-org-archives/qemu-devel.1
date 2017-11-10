Received: from eggs.gnu.org ([2001:4830:134:3::10]:54845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxY-0001B4-Q5
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxX-00043K-O9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:28 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:31:07 +0100
Message-Id: <20171110203111.7666-2-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/5] qcow2: check_errors are fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

When trying to repair a dirty image, qcow2_check() may apparently
succeed (no really fatal error occurred that would prevent the check
from continuing), but if check_errors in the result object is non-zero,
we cannot trust the image to be usable.

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1728639
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              |  5 ++++-
 tests/qemu-iotests/060     | 20 ++++++++++++++++++++
 tests/qemu-iotests/060.out | 23 +++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 92e5d548e3..d4fcb0250d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1475,7 +1475,10 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         BdrvCheckResult result = {0};
 
         ret = qcow2_check(bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
-        if (ret < 0) {
+        if (ret < 0 || result.check_errors) {
+            if (ret >= 0) {
+                ret = -EIO;
+            }
             error_setg_errno(errp, -ret, "Could not repair dirty image");
             goto fail;
         }
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index fae08b03bf..56bdf1ee2e 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -301,6 +301,26 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "48"                "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "=== Testing dirty corrupt image ==="
+echo
+
+_make_test_img 64M
+
+# Let the refblock appear unaligned
+poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\xff\xff\x2a\x00"
+# Mark the image dirty, thus forcing an automatic check when opening it
+poke_file "$TEST_IMG" 72 "\x00\x00\x00\x00\x00\x00\x00\x01"
+# Open the image (qemu should refuse to do so)
+$QEMU_IO -c close "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+
+echo '--- Repairing ---'
+
+# The actual repair should have happened (because of the dirty bit),
+# but some cleanup may have failed (like freeing the old reftable)
+# because the image was already marked corrupt by that point
+_check_test_img -r all
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 62c22701b8..f013fe73c0 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -284,4 +284,27 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+
+=== Testing dirty corrupt image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+ERROR refcount block 0 is not cluster aligned; refcount table entry corrupted
+IMGFMT: Marking image as corrupt: Refblock offset 0xffff2a00 unaligned (reftable index: 0); further corruption events will be suppressed
+Can't get refcount for cluster 0: Input/output error
+Can't get refcount for cluster 1: Input/output error
+Can't get refcount for cluster 2: Input/output error
+Can't get refcount for cluster 3: Input/output error
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+can't open device TEST_DIR/t.IMGFMT: Could not repair dirty image: Input/output error
+--- Repairing ---
+Leaked cluster 1 refcount=1 reference=0
+Repairing cluster 1 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 *** done
-- 
2.13.6
