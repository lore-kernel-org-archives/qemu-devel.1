Received: from eggs.gnu.org ([2001:4830:134:3::10]:37377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsna0-0002GE-UV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZz-0004Uq-Ji
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:08 +0200
Message-Id: <20170915101008.16646-7-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
References: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] block: Fix permissions after bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

If we switch between read-only and read-write, the permissions that
image format drivers need on bs->file change, too. Make sure to update
the permissions during bdrv_reopen().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 082eb2cd9c..3c3af462e4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -166,6 +166,7 @@ typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
+    uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
     void *opaque;
diff --git a/block.c b/block.c
index 204cbb46c7..5c65fac672 100644
--- a/block.c
+++ b/block.c
@@ -2781,6 +2781,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     bs_entry->state.explicit_options = explicit_options;
     bs_entry->state.flags = flags;
 
+    /* This needs to be overwritten in bdrv_reopen_prepare() */
+    bs_entry->state.perm = UINT64_MAX;
+    bs_entry->state.shared_perm = 0;
+
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options;
         char *child_key_dot;
@@ -2887,6 +2891,52 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
     return ret;
 }
 
+static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQueue *q,
+                                                          BdrvChild *c)
+{
+    BlockReopenQueueEntry *entry;
+
+    QSIMPLEQ_FOREACH(entry, q, entry) {
+        BlockDriverState *bs = entry->state.bs;
+        BdrvChild *child;
+
+        QLIST_FOREACH(child, &bs->children, next) {
+            if (child == c) {
+                return entry;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
+                             uint64_t *perm, uint64_t *shared)
+{
+    BdrvChild *c;
+    BlockReopenQueueEntry *parent;
+    uint64_t cumulative_perms = 0;
+    uint64_t cumulative_shared_perms = BLK_PERM_ALL;
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        parent = find_parent_in_reopen_queue(q, c);
+        if (!parent) {
+            cumulative_perms |= c->perm;
+            cumulative_shared_perms &= c->shared_perm;
+        } else {
+            uint64_t nperm, nshared;
+
+            bdrv_child_perm(parent->state.bs, bs, c, c->role, q,
+                            parent->state.perm, parent->state.shared_perm,
+                            &nperm, &nshared);
+
+            cumulative_perms |= nperm;
+            cumulative_shared_perms &= nshared;
+        }
+    }
+    *perm = cumulative_perms;
+    *shared = cumulative_shared_perms;
+}
 
 /*
  * Prepares a BlockDriverState for reopen. All changes are staged in the
@@ -2952,6 +3002,9 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    /* Calculate required permissions after reopening */
+    bdrv_reopen_perm(queue, reopen_state->bs,
+                     &reopen_state->perm, &reopen_state->shared_perm);
 
     ret = bdrv_flush(reopen_state->bs);
     if (ret) {
@@ -3007,6 +3060,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         } while ((entry = qdict_next(reopen_state->options, entry)));
     }
 
+    ret = bdrv_check_perm(reopen_state->bs, queue, reopen_state->perm,
+                          reopen_state->shared_perm, NULL, errp);
+    if (ret < 0) {
+        goto error;
+    }
+
     ret = 0;
 
 error:
@@ -3047,6 +3106,9 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 
     bdrv_refresh_limits(bs, NULL);
 
+    bdrv_set_perm(reopen_state->bs, reopen_state->perm,
+                  reopen_state->shared_perm);
+
     new_can_write =
         !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
     if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
@@ -3080,6 +3142,8 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
     }
 
     QDECREF(reopen_state->explicit_options);
+
+    bdrv_abort_perm_update(reopen_state->bs);
 }
 
 
-- 
2.13.5
