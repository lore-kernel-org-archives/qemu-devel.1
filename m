Received: from eggs.gnu.org ([2001:4830:134:3::10]:43123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBum-0000XG-KO
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBul-00082K-Og
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:19 +0100
Message-Id: <1487689130-30373-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 23/54] block: Add permissions to BlockBackend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The BlockBackend can now store the permissions that its user requires.
This is necessary because nodes can be ejected from or inserted into a
BlockBackend and all of these operations must make sure that the user
still gets what it requested initially.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c          | 27 +++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9bb4528..1ed75c6 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -59,6 +59,9 @@ struct BlockBackend {
     bool iostatus_enabled;
     BlockDeviceIoStatus iostatus;
 
+    uint64_t perm;
+    uint64_t shared_perm;
+
     bool allow_write_beyond_eof;
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
@@ -126,6 +129,8 @@ BlockBackend *blk_new(void)
 
     blk = g_new0(BlockBackend, 1);
     blk->refcnt = 1;
+    blk->perm = 0;
+    blk->shared_perm = BLK_PERM_ALL;
     blk_set_enable_write_cache(blk, true);
 
     qemu_co_queue_init(&blk->public.throttled_reqs[0]);
@@ -511,6 +516,27 @@ void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs)
     }
 }
 
+/*
+ * Sets the permission bitmasks that the user of the BlockBackend needs.
+ */
+int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
+                 Error **errp)
+{
+    int ret;
+
+    if (blk->root) {
+        ret = bdrv_child_try_set_perm(blk->root, perm, shared_perm, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    blk->perm = perm;
+    blk->shared_perm = shared_perm;
+
+    return 0;
+}
+
 static int blk_do_attach_dev(BlockBackend *blk, void *dev)
 {
     if (blk->dev) {
@@ -557,6 +583,7 @@ void blk_detach_dev(BlockBackend *blk, void *dev)
     blk->dev_ops = NULL;
     blk->dev_opaque = NULL;
     blk->guest_block_size = 512;
+    blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);
     blk_unref(blk);
 }
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index f365a51..4a18e86 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -105,6 +105,8 @@ void blk_remove_bs(BlockBackend *blk);
 void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs);
 bool bdrv_has_blk(BlockDriverState *bs);
 bool bdrv_is_root_node(BlockDriverState *bs);
+int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
+                 Error **errp);
 
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
 void blk_iostatus_enable(BlockBackend *blk);
-- 
1.8.3.1
