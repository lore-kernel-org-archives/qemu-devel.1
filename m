Received: from eggs.gnu.org ([2001:4830:134:3::10]:42494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1l5-0002zJ-Sk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1l4-000224-O9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:44 +0100
Message-Id: <20171221142251.18366-13-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/19] block: Add
 bdrv_subtree_drained_begin/end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

bdrv_drained_begin() waits for the completion of requests in the whole
subtree, but it only actually keeps its immediate bs parameter quiesced
until bdrv_drained_end().

Add a version that keeps the whole subtree drained. As of this commit,
graph changes cannot be allowed during a subtree drained section, but
this will be fixed soon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 13 +++++++++++++
 block/io.c            | 54 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 60c5d11029..de9c5a2b9b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -608,12 +608,25 @@ void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
 void bdrv_drained_begin(BlockDriverState *bs);
 
 /**
+ * Like bdrv_drained_begin, but recursively begins a quiesced section for
+ * exclusive access to all child nodes as well.
+ *
+ * Graph changes are not allowed during a subtree drain section.
+ */
+void bdrv_subtree_drained_begin(BlockDriverState *bs);
+
+/**
  * bdrv_drained_end:
  *
  * End a quiescent section started by bdrv_drained_begin().
  */
 void bdrv_drained_end(BlockDriverState *bs);
 
+/**
+ * End a quiescent section started by bdrv_subtree_drained_begin().
+ */
+void bdrv_subtree_drained_end(BlockDriverState *bs);
+
 void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
diff --git a/block/io.c b/block/io.c
index 09de0a9070..6befef166d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -145,6 +145,7 @@ typedef struct {
     BlockDriverState *bs;
     bool done;
     bool begin;
+    bool recursive;
     BdrvChild *parent;
 } BdrvCoDrainData;
 
@@ -218,8 +219,10 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     return waited;
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent);
-static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
+static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                                  BdrvChild *parent);
+static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                                BdrvChild *parent);
 
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
@@ -229,9 +232,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 
     bdrv_dec_in_flight(bs);
     if (data->begin) {
-        bdrv_do_drained_begin(bs, data->parent);
+        bdrv_do_drained_begin(bs, data->recursive, data->parent);
     } else {
-        bdrv_do_drained_end(bs, data->parent);
+        bdrv_do_drained_end(bs, data->recursive, data->parent);
     }
 
     data->done = true;
@@ -239,7 +242,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 }
 
 static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
-                                                bool begin, BdrvChild *parent)
+                                                bool begin, bool recursive,
+                                                BdrvChild *parent)
 {
     BdrvCoDrainData data;
 
@@ -253,6 +257,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         .bs = bs,
         .done = false,
         .begin = begin,
+        .recursive = recursive,
         .parent = parent,
     };
     bdrv_inc_in_flight(bs);
@@ -265,10 +270,13 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent)
+static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                                  BdrvChild *parent)
 {
+    BdrvChild *child, *next;
+
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true, parent);
+        bdrv_co_yield_to_drain(bs, true, recursive, parent);
         return;
     }
 
@@ -280,19 +288,32 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent)
     bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true, false);
     bdrv_drain_recurse(bs);
+
+    if (recursive) {
+        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+            bdrv_do_drained_begin(child->bs, true, child);
+        }
+    }
 }
 
 void bdrv_drained_begin(BlockDriverState *bs)
 {
-    bdrv_do_drained_begin(bs, NULL);
+    bdrv_do_drained_begin(bs, false, NULL);
+}
+
+void bdrv_subtree_drained_begin(BlockDriverState *bs)
+{
+    bdrv_do_drained_begin(bs, true, NULL);
 }
 
-static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
+static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                                BdrvChild *parent)
 {
+    BdrvChild *child, *next;
     int old_quiesce_counter;
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, false, parent);
+        bdrv_co_yield_to_drain(bs, false, recursive, parent);
         return;
     }
     assert(bs->quiesce_counter > 0);
@@ -304,11 +325,22 @@ static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
     if (old_quiesce_counter == 1) {
         aio_enable_external(bdrv_get_aio_context(bs));
     }
+
+    if (recursive) {
+        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+            bdrv_do_drained_end(child->bs, true, child);
+        }
+    }
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, NULL);
+    bdrv_do_drained_end(bs, false, NULL);
+}
+
+void bdrv_subtree_drained_end(BlockDriverState *bs)
+{
+    bdrv_do_drained_end(bs, true, NULL);
 }
 
 /*
-- 
2.13.6
