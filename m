Received: from eggs.gnu.org ([2001:4830:134:3::10]:53251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYBFS-00088p-Ps
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYBFQ-0004hT-RB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:12:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 20 Jul 2017 15:11:54 +0200
Message-Id: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org

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

This patch fixes the problem by hiding the implicit nodes created
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

v3:
- Fixed skipping during the recursion for query-block [Peter]
- Fixed backing_file_depth
- More thorough test case for mirror, added one for commit

v2:
- Skip implicit nodes not only on the top level, but also during the recursive
  calls [Peter]
- Spelling fix in the commit message [Manos]

 block.c                    | 13 -------------
 block/commit.c             |  3 +++
 block/mirror.c             |  3 +++
 block/qapi.c               | 33 +++++++++++++++++++++++++++------
 include/block/block.h      |  1 -
 include/block/block_int.h  |  1 +
 qapi/block-core.json       |  6 ++++--
 tests/qemu-iotests/040     | 30 +++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |  4 ++--
 tests/qemu-iotests/041     | 38 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |  4 ++--
 11 files changed, 108 insertions(+), 28 deletions(-)

diff --git a/block.c b/block.c
index 2dd9262..37e72b7 100644
--- a/block.c
+++ b/block.c
@@ -3973,19 +3973,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     return retval;
 }
 
-int bdrv_get_backing_file_depth(BlockDriverState *bs)
-{
-    if (!bs->drv) {
-        return 0;
-    }
-
-    if (!bs->backing) {
-        return 0;
-    }
-
-    return 1 + bdrv_get_backing_file_depth(bs->backing->bs);
-}
-
 void bdrv_init(void)
 {
     module_call_init(MODULE_INIT_BLOCK);
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
index 95b2e2d..d2b18ee 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -64,7 +64,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->backing_file = g_strdup(bs->backing_file);
     }
 
-    info->backing_file_depth = bdrv_get_backing_file_depth(bs);
     info->detect_zeroes = bs->detect_zeroes;
 
     if (blk && blk_get_public(blk)->throttle_state) {
@@ -125,6 +124,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     bs0 = bs;
     p_image_info = &info->image;
+    info->backing_file_depth = 0;
     while (1) {
         Error *local_err = NULL;
         bdrv_query_image_info(bs0, p_image_info, &local_err);
@@ -133,13 +133,21 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
             qapi_free_BlockDeviceInfo(info);
             return NULL;
         }
+
         if (bs0->drv && bs0->backing) {
+            info->backing_file_depth++;
             bs0 = bs0->backing->bs;
             (*p_image_info)->has_backing_image = true;
             p_image_info = &((*p_image_info)->backing_image);
         } else {
             break;
         }
+
+        /* Skip automatically inserted nodes that the user isn't aware of for
+         * query-block (blk != NULL), but not for query-named-block-nodes */
+        while (blk && bs0 && bs0->drv && bs0->implicit) {
+            bs0 = backing_bs(bs0);
+        }
     }
 
     return info;
@@ -324,6 +332,11 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
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
@@ -434,8 +447,8 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     }
 }
 
-static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
-                                 bool query_backing)
+static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
+                                        bool blk_level)
 {
     BlockStats *s = NULL;
 
@@ -446,6 +459,14 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
         return s;
     }
 
+    /* Skip automatically inserted nodes that the user isn't aware of in
+     * a BlockBackend-level command. Stay at the exact node for a node-level
+     * command. */
+    while (blk_level && bs->drv && bs->implicit) {
+        bs = backing_bs(bs);
+        assert(bs);
+    }
+
     if (bdrv_get_node_name(bs)[0]) {
         s->has_node_name = true;
         s->node_name = g_strdup(bdrv_get_node_name(bs));
@@ -455,12 +476,12 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
 
     if (bs->file) {
         s->has_parent = true;
-        s->parent = bdrv_query_bds_stats(bs->file->bs, query_backing);
+        s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
     }
 
-    if (query_backing && bs->backing) {
+    if (blk_level && bs->backing) {
         s->has_backing = true;
-        s->backing = bdrv_query_bds_stats(bs->backing->bs, query_backing);
+        s->backing = bdrv_query_bds_stats(bs->backing->bs, blk_level);
     }
 
     return s;
diff --git a/include/block/block.h b/include/block/block.h
index b3e2674..34770bb 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -300,7 +300,6 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                                        int bytes, BdrvRequestFlags flags);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
-int bdrv_get_backing_file_depth(BlockDriverState *bs);
 void bdrv_refresh_filename(BlockDriverState *bs);
 int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
                   Error **errp);
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
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 9d381d9..95b7510 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -81,7 +81,7 @@ class TestSingleDrive(ImageCommitTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
-        self.vm = iotests.VM().add_drive(test_img, interface="none")
+        self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=mid,backing.backing.node-name=base", interface="none")
         self.vm.add_device("virtio-scsi-pci")
         self.vm.add_device("scsi-hd,id=scsi0,drive=drive0")
         self.vm.launch()
@@ -163,6 +163,34 @@ class TestSingleDrive(ImageCommitTestCase):
 
         self.assert_no_active_block_jobs()
 
+    # Tests that the insertion of the commit_top filter node doesn't make a
+    # difference to query-blockstat
+    def test_implicit_node(self):
+        if self.image_len == 0:
+            return
+
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
+                             base=backing_img, speed=(self.image_len / 4))
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('query-block')
+        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', mid_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 2)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', mid_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/backing-image/filename', backing_img)
+
+        result = self.vm.qmp('query-blockstats')
+        self.assert_qmp(result, 'return[0]/node-name', 'top')
+        self.assert_qmp(result, 'return[0]/backing/node-name', 'mid')
+        self.assert_qmp(result, 'return[0]/backing/backing/node-name', 'base')
+
+        self.cancel_and_wait()
+        self.assert_no_active_block_jobs()
+
 class TestRelativePaths(ImageCommitTestCase):
     image_len = 1 * 1024 * 1024
     test_len = 1 * 1024 * 256
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 6d9bee1..e20a75c 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...........................
+.............................
 ----------------------------------------------------------------------
-Ran 27 tests
+Ran 29 tests
 
 OK
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 2f54986..60f09cc 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -42,7 +42,7 @@ class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=base")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
@@ -169,6 +169,42 @@ class TestSingleDrive(iotests.QMPTestCase):
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
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', backing_img)
+
+        result = self.vm.qmp('query-blockstats')
+        self.assert_qmp(result, 'return[0]/node-name', 'top')
+        self.assert_qmp(result, 'return[0]/backing/node-name', 'base')
+
+        self.cancel_and_wait(force=True)
+        result = self.vm.qmp('query-block')
+        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 1)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', backing_img)
+
+        result = self.vm.qmp('query-blockstats')
+        self.assert_qmp(result, 'return[0]/node-name', 'top')
+        self.assert_qmp(result, 'return[0]/backing/node-name', 'base')
+
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
