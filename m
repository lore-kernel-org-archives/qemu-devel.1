Received: from eggs.gnu.org ([2001:4830:134:3::10]:37084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC9-0003C3-0i
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC7-0005He-MT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Nov 2017 16:10:16 +0100
Message-Id: <20171121151017.28158-7-kwolf@redhat.com>
In-Reply-To: <20171121151017.28158-1-kwolf@redhat.com>
References: <20171121151017.28158-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Alberto Garcia <berto@igalia.com>

bdrv_close() skips much of its logic when bs->drv is NULL. This is
fine when we're closing a BlockDriverState that has just been created
(because e.g the initialization process failed), but it's not enough
in other cases.

For example, when a valid qcow2 image is found to be corrupted then
QEMU marks it as such in the file header and then sets bs->drv to
NULL in order to make the BlockDriverState unusable. When that BDS is
later closed then many of its data structures are not freed (leaking
their memory) and none of its children are detached. This results in
bdrv_close_all() failing to close all BDSs and making this assertion
fail when QEMU is being shut down:

   bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.

This patch makes bdrv_close() do the full uninitialization process
in all cases. This fixes the problem with corrupted images and still
works fine with freshly created BDSs.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20171106145345.12038-1-berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 57 +++++++++++++++++++++++-----------------------
 tests/qemu-iotests/060     | 13 +++++++++++
 tests/qemu-iotests/060.out | 12 ++++++++++
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/block.c b/block.c
index 68b724206d..9a1a0d1e73 100644
--- a/block.c
+++ b/block.c
@@ -3198,6 +3198,7 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
 static void bdrv_close(BlockDriverState *bs)
 {
     BdrvAioNotifier *ban, *ban_next;
+    BdrvChild *child, *next;
 
     assert(!bs->job);
     assert(!bs->refcnt);
@@ -3207,43 +3208,41 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_drain(bs); /* in case flush left pending I/O */
 
     if (bs->drv) {
-        BdrvChild *child, *next;
-
         bs->drv->bdrv_close(bs);
         bs->drv = NULL;
+    }
 
-        bdrv_set_backing_hd(bs, NULL, &error_abort);
+    bdrv_set_backing_hd(bs, NULL, &error_abort);
 
-        if (bs->file != NULL) {
-            bdrv_unref_child(bs, bs->file);
-            bs->file = NULL;
-        }
+    if (bs->file != NULL) {
+        bdrv_unref_child(bs, bs->file);
+        bs->file = NULL;
+    }
 
-        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            /* TODO Remove bdrv_unref() from drivers' close function and use
-             * bdrv_unref_child() here */
-            if (child->bs->inherits_from == bs) {
-                child->bs->inherits_from = NULL;
-            }
-            bdrv_detach_child(child);
+    QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+        /* TODO Remove bdrv_unref() from drivers' close function and use
+         * bdrv_unref_child() here */
+        if (child->bs->inherits_from == bs) {
+            child->bs->inherits_from = NULL;
         }
-
-        g_free(bs->opaque);
-        bs->opaque = NULL;
-        atomic_set(&bs->copy_on_read, 0);
-        bs->backing_file[0] = '\0';
-        bs->backing_format[0] = '\0';
-        bs->total_sectors = 0;
-        bs->encrypted = false;
-        bs->sg = false;
-        QDECREF(bs->options);
-        QDECREF(bs->explicit_options);
-        bs->options = NULL;
-        bs->explicit_options = NULL;
-        QDECREF(bs->full_open_options);
-        bs->full_open_options = NULL;
+        bdrv_detach_child(child);
     }
 
+    g_free(bs->opaque);
+    bs->opaque = NULL;
+    atomic_set(&bs->copy_on_read, 0);
+    bs->backing_file[0] = '\0';
+    bs->backing_format[0] = '\0';
+    bs->total_sectors = 0;
+    bs->encrypted = false;
+    bs->sg = false;
+    QDECREF(bs->options);
+    QDECREF(bs->explicit_options);
+    bs->options = NULL;
+    bs->explicit_options = NULL;
+    QDECREF(bs->full_open_options);
+    bs->full_open_options = NULL;
+
     bdrv_release_named_dirty_bitmaps(bs);
     assert(QLIST_EMPTY(&bs->dirty_bitmaps));
 
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 1eca09417b..14797dd3b0 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -426,6 +426,19 @@ echo '--- Repairing ---'
 _check_test_img -q -r all
 _check_test_img -r all
 
+echo
+echo "=== Testing the QEMU shutdown with a corrupted image ==="
+echo
+_make_test_img 64M
+poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io drive \"write 0 512\"'}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -drive if=none,node-name=drive,file="$TEST_IMG",driver=qcow2 \
+    | _filter_qmp | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 56f5eb15d8..c4cb7c665e 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -399,4 +399,16 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
+
+=== Testing the QEMU shutdown with a corrupted image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount table); further corruption events will be suppressed
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing invalid write on metadata (overlaps with refcount table)", "offset": 65536, "node-name": "drive", "fatal": true, "size": 65536}}
+write failed: Input/output error
+{"return": ""}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
-- 
2.13.6
