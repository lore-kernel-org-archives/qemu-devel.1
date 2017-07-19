Received: from eggs.gnu.org ([2001:4830:134:3::10]:60288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXkbM-00079n-P6
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXkbL-0006yS-4L
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:45:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 19 Jul 2017 10:44:47 +0200
Message-Id: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org

Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
nodes above the top layer of mirror and commit block jobs. The
assumption made there was that since libvirt doesn't do node-level
management of the block layer yet, it shouldn't be affected by added
nodes.

This is true as far as commands issued by libvirt are concerned. It only
uses BlockBackend names to address nodes, so any operations it performs
still operate on the root of the tree as intended.

However, the assumption breaks down when you consider query commands,
which return data for the wrong node now. These commands also return
information on some child nodes (bs->file and/or bs->backing), which
libvirt does make use of, and which refer to the wrong nodes, too.

One of the consequences is that oVirt gets wrong information about the
image size and stops the VM in response as long as a mirror or commit
job is running:

https://bugzilla.redhat.com/show_bug.cgi?id=1470634

This patch fixes the problem by hiding the implict nodes created
automatically by the mirror and commit block jobs in the output of
query-block and BlockBackend-based query-blockstats as long as the user
doesn't indicate that they are aware of those nodes by providing a node
name for them in the QMP command to start the block job.

The node-based commands query-named-block-nodes and query-blockstats
with query-nodes=true still show all nodes, including implicit ones.
This ensures that users that are capable of node-level management can
still access the full information; users that only know BlockBackends
won't use these commands.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c             |  3 +++
 block/mirror.c             |  3 +++
 block/qapi.c               | 13 ++++++++++++-
 include/block/block_int.h  |  1 +
 qapi/block-core.json       |  6 ++++--
 tests/qemu-iotests/041     | 23 +++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 7 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 5cc910f..c7857c3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -346,6 +346,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     if (commit_top_bs == NULL) {
         goto fail;
     }
+    if (!filter_node_name) {
+        commit_top_bs->implicit = true;
+    }
     commit_top_bs->total_sectors = top->total_sectors;
     bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
 
diff --git a/block/mirror.c b/block/mirror.c
index 8583b76..c9a6a3c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1168,6 +1168,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (mirror_top_bs == NULL) {
         return;
     }
+    if (!filter_node_name) {
+        mirror_top_bs->implicit = true;
+    }
     mirror_top_bs->total_sectors = bs->total_sectors;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
diff --git a/block/qapi.c b/block/qapi.c
index 95b2e2d..0ed23b8 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -324,6 +324,11 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
     BlockDriverState *bs = blk_bs(blk);
     char *qdev;
 
+    /* Skip automatically inserted nodes that the user isn't aware of */
+    while (bs && bs->drv && bs->implicit) {
+        bs = backing_bs(bs);
+    }
+
     info->device = g_strdup(blk_name(blk));
     info->type = g_strdup("unknown");
     info->locked = blk_dev_is_medium_locked(blk);
@@ -518,12 +523,18 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
         }
     } else {
         for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+            BlockDriverState *bs = blk_bs(blk);
             BlockStatsList *info = g_malloc0(sizeof(*info));
             AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
 
+            /* Skip automatically inserted nodes that the user isn't aware of */
+            while (bs && bs->drv && bs->implicit) {
+                bs = backing_bs(bs);
+            }
+
             aio_context_acquire(ctx);
-            s = bdrv_query_bds_stats(blk_bs(blk), true);
+            s = bdrv_query_bds_stats(bs, true);
             s->has_device = true;
             s->device = g_strdup(blk_name(blk));
             bdrv_query_blk_stats(s->stats, blk);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5c6b761..d4f4ea7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -549,6 +549,7 @@ struct BlockDriverState {
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
     bool force_share; /* if true, always allow all shared permissions */
+    bool implicit;  /* if true, this filter node was automatically inserted */
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ff8e2ba..006e048 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -520,7 +520,8 @@
 #
 # Get a list of BlockInfo for all virtual block devices.
 #
-# Returns: a list of @BlockInfo describing each virtual block device
+# Returns: a list of @BlockInfo describing each virtual block device. Filter
+# nodes that were created implicitly are skipped over.
 #
 # Since: 0.14.0
 #
@@ -780,7 +781,8 @@
 #               information, but not "backing".
 #               If false or omitted, the behavior is as before - query all the
 #               device backends, recursively including their "parent" and
-#               "backing". (Since 2.3)
+#               "backing". Filter nodes that were created implicitly are
+#               skipped over in this mode. (Since 2.3)
 #
 # Returns: A list of @BlockStats for each virtual block devices.
 #
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 2f54986..b798cca 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -169,6 +169,29 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
+    # Tests that the insertion of the mirror_top filter node doesn't make a
+    # difference to query-block
+    def test_implicit_node(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
+                             target=self.qmp_target)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('query-block')
+        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 1)
+
+        self.cancel_and_wait(force=True)
+        result = self.vm.qmp('query-block')
+        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 1)
+        self.vm.shutdown()
+
     def test_medium_not_found(self):
         if iotests.qemu_default_machine != 'pc':
             return
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index e30fd3b..c28b392 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-...............................................................................
+.....................................................................................
 ----------------------------------------------------------------------
-Ran 79 tests
+Ran 85 tests
 
 OK
-- 
1.8.3.1
