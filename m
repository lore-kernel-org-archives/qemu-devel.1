Received: from eggs.gnu.org ([2001:4830:134:3::10]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvQVK-0006YZ-Kd
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvQVI-0007lq-5E
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:36:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  4 Apr 2017 17:35:56 +0200
Message-Id: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com, Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com, qemu-devel@nongnu.org

Usually guest devices don't like other writers to the same image, so
they use blk_set_perm() to prevent this from happening. In the migration
phase before the VM is actually running, though, they don't have a
problem with writes to the image. On the other hand, storage migration
needs to be able to write to the image in this phase, so the restrictive
blk_set_perm() call of qdev devices breaks it.

This patch flags all BlockBackends with a qdev device as
blk->disable_perm during incoming migration, which means that the
requested permissions are stored in the BlockBackend, but not actually
applied to its root node yet.

Once migration has finished and the VM should be resumed, the
permissions are applied. If they cannot be applied (e.g. because the NBD
server used for block migration hasn't been shut down), resuming the VM
fails.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 40 +++++++++++++++++++++++++++++++++++++++-
 include/block/block.h |  2 ++
 migration/migration.c |  8 ++++++++
 qmp.c                 |  6 ++++++
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0b63773..f817040 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -61,6 +61,7 @@ struct BlockBackend {
 
     uint64_t perm;
     uint64_t shared_perm;
+    bool disable_perm;
 
     bool allow_write_beyond_eof;
 
@@ -578,7 +579,7 @@ int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
 {
     int ret;
 
-    if (blk->root) {
+    if (blk->root && !blk->disable_perm) {
         ret = bdrv_child_try_set_perm(blk->root, perm, shared_perm, errp);
         if (ret < 0) {
             return ret;
@@ -597,15 +598,52 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
     *shared_perm = blk->shared_perm;
 }
 
+/*
+ * Notifies the user of all BlockBackends that migration has completed. qdev
+ * devices can tighten their permissions in response (specifically revoke
+ * shared write permissions that we needed for storage migration).
+ *
+ * If an error is returned, the VM cannot be allowed to be resumed.
+ */
+void blk_resume_after_migration(Error **errp)
+{
+    BlockBackend *blk;
+    Error *local_err = NULL;
+
+    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+        if (!blk->disable_perm) {
+            continue;
+        }
+
+        blk->disable_perm = false;
+
+        blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            blk->disable_perm = true;
+            return;
+        }
+    }
+}
+
 static int blk_do_attach_dev(BlockBackend *blk, void *dev)
 {
     if (blk->dev) {
         return -EBUSY;
     }
+
+    /* While migration is still incoming, we don't need to apply the
+     * permissions of guest device BlockBackends. We might still have a block
+     * job or NBD server writing to the image for storage migration. */
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        blk->disable_perm = true;
+    }
+
     blk_ref(blk);
     blk->dev = dev;
     blk->legacy_dev = false;
     blk_iostatus_reset(blk);
+
     return 0;
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..3e09222 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -366,6 +366,8 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
+void blk_resume_after_migration(Error **errp);
+
 /* Ensure contents are flushed to disk.  */
 int bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..ad4036f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -349,6 +349,14 @@ static void process_incoming_migration_bh(void *opaque)
         exit(EXIT_FAILURE);
     }
 
+    /* If we get an error here, just don't restart the VM yet. */
+    blk_resume_after_migration(&local_err);
+    if (local_err) {
+        error_free(local_err);
+        local_err = NULL;
+        autostart = false;
+    }
+
     /*
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
diff --git a/qmp.c b/qmp.c
index fa82b59..a744e44 100644
--- a/qmp.c
+++ b/qmp.c
@@ -207,6 +207,12 @@ void qmp_cont(Error **errp)
         }
     }
 
+    blk_resume_after_migration(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart = 1;
     } else {
-- 
1.8.3.1
