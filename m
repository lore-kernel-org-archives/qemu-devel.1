Received: from eggs.gnu.org ([2001:4830:134:3::10]:41299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InJ-0002tX-QJ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InF-0004b0-L4
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:33 +0200
Message-Id: <20180411163940.2523-13-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 12/19] block: Don't poll in parent drain
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

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
index 91bf3b4e36..de2cba2c74 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -578,6 +578,15 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool top_level, bool recursive);
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
index 9fe39ac8c1..330238de19 100644
--- a/block.c
+++ b/block.c
@@ -817,7 +817,7 @@ static char *bdrv_child_get_parent_desc(BdrvChild *c)
 static void bdrv_child_cb_drained_begin(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
-    bdrv_drained_begin(bs);
+    bdrv_do_drained_begin_quiesce(bs, NULL);
 }
 
 static bool bdrv_child_cb_drained_poll(BdrvChild *child)
diff --git a/block/io.c b/block/io.c
index 1287630c58..f372b9ffb0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -277,15 +277,10 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
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
@@ -294,6 +289,19 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
 
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
