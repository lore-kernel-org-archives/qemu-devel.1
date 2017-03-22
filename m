Received: from eggs.gnu.org ([2001:4830:134:3::10]:47052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6O-0005xg-K0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6I-0003aV-Uz
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:16 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 22 Mar 2017 13:31:01 -0400
Message-Id: <20170322173102.18180-4-jcody@redhat.com>
In-Reply-To: <20170322173102.18180-1-jcody@redhat.com>
References: <20170322173102.18180-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 3/4] block-backend: add drained_begin /
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
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

Allow block backends to forward drain requests to their devices/users.
The initial intended purpose for this patch is to allow BBs to forward
requests along to BlockJobs, which will want to pause if their associated
BB has entered a drained region.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20170316212351.13797-3-jsnow@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/block-backend.c          | 24 ++++++++++++++++++++++--
 include/sysemu/block-backend.h |  8 ++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09..0b63773 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -65,6 +65,8 @@ struct BlockBackend {
     bool allow_write_beyond_eof;
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+
+    int quiesce_counter;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -699,12 +701,17 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
                      void *opaque)
 {
     /* All drivers that use blk_set_dev_ops() are qdevified and we want to keep
-     * it that way, so we can assume blk->dev is a DeviceState if blk->dev_ops
-     * is set. */
+     * it that way, so we can assume blk->dev, if present, is a DeviceState if
+     * blk->dev_ops is set. Non-device users may use dev_ops without device. */
     assert(!blk->legacy_dev);
 
     blk->dev_ops = ops;
     blk->dev_opaque = opaque;
+
+    /* Are we currently quiesced? Should we enforce this right now? */
+    if (blk->quiesce_counter && ops->drained_begin) {
+        ops->drained_begin(opaque);
+    }
 }
 
 /*
@@ -1870,6 +1877,12 @@ static void blk_root_drained_begin(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
 
+    if (++blk->quiesce_counter == 1) {
+        if (blk->dev_ops && blk->dev_ops->drained_begin) {
+            blk->dev_ops->drained_begin(blk->dev_opaque);
+        }
+    }
+
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
@@ -1881,7 +1894,14 @@ static void blk_root_drained_begin(BdrvChild *child)
 static void blk_root_drained_end(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
+    assert(blk->quiesce_counter);
 
     assert(blk->public.io_limits_disabled);
     --blk->public.io_limits_disabled;
+
+    if (--blk->quiesce_counter == 0) {
+        if (blk->dev_ops && blk->dev_ops->drained_end) {
+            blk->dev_ops->drained_end(blk->dev_opaque);
+        }
+    }
 }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 096c17f..7462228 100644
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
+     * Runs when the backend's last drain request ends.
+     */
+    void (*drained_end)(void *opaque);
 } BlockDevOps;
 
 /* This struct is embedded in (the private) BlockBackend struct and contains
-- 
2.9.3
