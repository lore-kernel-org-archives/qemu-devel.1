Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHQ-0004sm-VE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHP-0006Hb-Mz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:41 +0200
Message-Id: <20180618164504.24488-13-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/35] block: Don't poll in parent drain
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

bdrv_do_drained_begin() is only safe if we have a single
BDRV_POLL_WHILE() after quiescing all affected nodes. We cannot allow
that parent callbacks introduce a nested polling loop that could cause
graph changes while we're traversing the graph.

Split off bdrv_do_drained_begin_quiesce(), which only quiesces a single
node without waiting for its requests to complete. These requests will
be waited for in the BDRV_POLL_WHILE() call down the call chain.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  9 +++++++++
 block.c               |  2 +-
 block/io.c            | 24 ++++++++++++++++--------
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 254ed2e4c9..067d24cc4a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -591,6 +591,15 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
 void bdrv_drained_begin(BlockDriverState *bs);
 
 /**
+ * bdrv_do_drained_begin_quiesce:
+ *
+ * Quiesces a BDS like bdrv_drained_begin(), but does not wait for already
+ * running requests to complete.
+ */
+void bdrv_do_drained_begin_quiesce(BlockDriverState *bs,
+                                   BdrvChild *parent);
+
+/**
  * Like bdrv_drained_begin, but recursively begins a quiesced section for
  * exclusive access to all child nodes as well.
  */
diff --git a/block.c b/block.c
index 80abd3c2ae..50f8e3dc3b 100644
--- a/block.c
+++ b/block.c
@@ -818,7 +818,7 @@ static char *bdrv_child_get_parent_desc(BdrvChild *c)
 static void bdrv_child_cb_drained_begin(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
-    bdrv_drained_begin(bs);
+    bdrv_do_drained_begin_quiesce(bs, NULL);
 }
 
 static bool bdrv_child_cb_drained_poll(BdrvChild *child)
diff --git a/block/io.c b/block/io.c
index a413841bfc..ffb273708a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -286,15 +286,10 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                           BdrvChild *parent, bool poll)
+void bdrv_do_drained_begin_quiesce(BlockDriverState *bs,
+                                   BdrvChild *parent)
 {
-    BdrvChild *child, *next;
-
-    if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true, recursive, parent, poll);
-        return;
-    }
+    assert(!qemu_in_coroutine());
 
     /* Stop things in parent-to-child order */
     if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
@@ -303,6 +298,19 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
 
     bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true);
+}
+
+static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                                  BdrvChild *parent, bool poll)
+{
+    BdrvChild *child, *next;
+
+    if (qemu_in_coroutine()) {
+        bdrv_co_yield_to_drain(bs, true, recursive, parent, poll);
+        return;
+    }
+
+    bdrv_do_drained_begin_quiesce(bs, parent);
 
     if (recursive) {
         bs->recursive_quiesce_counter++;
-- 
2.13.6
