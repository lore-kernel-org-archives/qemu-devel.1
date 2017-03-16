Received: from eggs.gnu.org ([2001:4830:134:3::10]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYS-0002zS-Pi
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYR-0004Vv-Np
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:46:02 -0400
Message-Id: <20170316004603.20609-3-jsnow@redhat.com>
In-Reply-To: <20170316004603.20609-1-jsnow@redhat.com>
References: <20170316004603.20609-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC patch 2/3] block-backend: add drained_begin /
 drained_end ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>

---

RFC questions:

- Does the presence of blk->quiesce_counter relieve the burden of needing
  blk->public.io_limits_disabled? I could probably eliminate this counter
  entirely and just spy on the root node's quiescent state at key moments
  instead. I am confident I'm traipsing on delicate drain semantics.

- Should I treat the separation of a quisced BDS/BB as a drained_end request
  as an analogue to how blk_insert_bs (in this patch) handles this?

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/block-backend.c          | 25 +++++++++++++++++++++++++
 include/sysemu/block-backend.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09..eb85e8b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -65,6 +65,8 @@ struct BlockBackend {
     bool allow_write_beyond_eof;
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+
+    int quiesce_counter;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -559,6 +561,11 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     }
     bdrv_ref(bs);
 
+    /* The new BDS may be quiescent, we should attempt to match */
+    if (bs->quiesce_counter) {
+        blk_root_drained_begin(blk->root);
+    }
+
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
         throttle_timers_attach_aio_context(
@@ -705,6 +712,11 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
 
     blk->dev_ops = ops;
     blk->dev_opaque = opaque;
+
+    /* Are we currently quiesced? Should we enforce this right now? */
+    if (blk->quiesce_counter && ops->drained_begin) {
+        ops->drained_begin(opaque);
+    }
 }
 
 /*
@@ -1870,9 +1882,15 @@ static void blk_root_drained_begin(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
 
+    blk->quiesce_counter++;
+
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
+    if (blk->dev_ops && blk->dev_ops->drained_begin) {
+        blk->dev_ops->drained_begin(blk->dev_opaque);
+    }
+
     if (blk->public.io_limits_disabled++ == 0) {
         throttle_group_restart_blk(blk);
     }
@@ -1882,6 +1900,13 @@ static void blk_root_drained_end(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
 
+    assert(blk->quiesce_counter);
+    blk->quiesce_counter--;
+
     assert(blk->public.io_limits_disabled);
     --blk->public.io_limits_disabled;
+
+    if (blk->dev_ops && blk->dev_ops->drained_end) {
+        blk->dev_ops->drained_end(blk->dev_opaque);
+    }
 }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 096c17f..c6f4408 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -58,6 +58,14 @@ typedef struct BlockDevOps {
      * Runs when the size changed (e.g. monitor command block_resize)
      */
     void (*resize_cb)(void *opaque);
+    /*
+     * Runs when the backend receives a drain request.
+     */
+    void (*drained_begin)(void *opaque);
+    /*
+     * Runs when the backend's drain request ends.
+     */
+    void (*drained_end)(void *opaque);
 } BlockDevOps;
 
 /* This struct is embedded in (the private) BlockBackend struct and contains
-- 
2.9.3
