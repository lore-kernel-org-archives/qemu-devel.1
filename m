Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOk-0007v3-Ly
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOj-0006oG-8v
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:30 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:42 +0100
Message-Id: <20171120201004.14999-4-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 03/25] block: Add
 BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

If the backing file is overridden, this most probably does change the
guest-visible data of a BDS. Therefore, we will need to consider this in
bdrv_refresh_filename().

Adding a new field to the BDS is not nice, but it is very simple and
exactly keeps track of whether the backing file has been overridden.

This commit adds a FIXME which will be remedied by a follow-up commit.
Until then, the respective piece of code will not result in any behavior
that is worse than what we currently have.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h |  1 +
 block.c                   | 13 +++++++++++++
 block/mirror.c            |  4 ++++
 blockdev.c                | 16 ++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5482775ec..5e9734d8b5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -619,6 +619,7 @@ struct BlockDriverState {
     char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
                                     this file image */
     char backing_format[16]; /* if non-zero and backing_file exists */
+    bool backing_overridden; /* backing file has been specified by the user */
 
     QDict *full_open_options;
     char exact_filename[PATH_MAX];
diff --git a/block.c b/block.c
index 4aebf590d8..eb67dfbcc0 100644
--- a/block.c
+++ b/block.c
@@ -2233,6 +2233,11 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     reference = qdict_get_try_str(parent_options, bdref_key);
     if (reference || qdict_haskey(options, "file.filename")) {
         backing_filename[0] = '\0';
+
+        /* FIXME: Should also be set to true if @options contains other runtime
+         *        options which control the data that is read from the backing
+         *        BDS */
+        bs->backing_overridden = true;
     } else if (bs->backing_file[0] == '\0' && qdict_size(options) == 0) {
         QDECREF(options);
         goto free_exit;
@@ -2434,6 +2439,9 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
         goto out;
     }
 
+    bs_snapshot->backing_overridden = true;
+    bdrv_refresh_filename(bs_snapshot);
+
 out:
     QDECREF(snapshot_options);
     g_free(tmp_filename);
@@ -2564,6 +2572,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     backing = qdict_get_try_str(options, "backing");
     if (backing && *backing == '\0') {
         flags |= BDRV_O_NO_BACKING;
+        bs->backing_overridden = true;
         qdict_del(options, "backing");
     }
 
@@ -4976,6 +4985,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
      * refresh those first */
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_refresh_filename(child->bs);
+
+        if (child->role == &child_backing && child->bs->backing_overridden) {
+            bs->backing_overridden = true;
+        }
     }
 
     if (drv->bdrv_refresh_filename) {
diff --git a/block/mirror.c b/block/mirror.c
index f059981f19..d6e487fb2e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -530,6 +530,10 @@ static void mirror_exit(BlockJob *job, void *opaque)
             error_report_err(local_err);
             data->ret = -EPERM;
         }
+
+        /* The target image's file already has been created with the backing
+         * file we just set, so there is no need to set backing_overridden or
+         * call bdrv_refresh_filename(). */
     }
 
     if (s->to_replace) {
diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..b0393e1786 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1781,6 +1781,8 @@ static void external_snapshot_commit(BlkActionState *common)
 {
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
+    TransactionAction *action = common->action;
+    bool image_was_existing = false;
 
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
@@ -1789,6 +1791,20 @@ static void external_snapshot_commit(BlkActionState *common)
         bdrv_reopen(state->old_bs, state->old_bs->open_flags & ~BDRV_O_RDWR,
                     NULL);
     }
+
+    if (action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC) {
+        BlockdevSnapshotSync *s = action->u.blockdev_snapshot_sync.data;
+        if (s->has_mode && s->mode == NEW_IMAGE_MODE_EXISTING) {
+            image_was_existing = true;
+        }
+    } else {
+        image_was_existing = true;
+    }
+
+    if (image_was_existing) {
+        state->new_bs->backing_overridden = true;
+        bdrv_refresh_filename(state->new_bs);
+    }
 }
 
 static void external_snapshot_abort(BlkActionState *common)
-- 
2.13.6
