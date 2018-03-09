Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5q-0001hf-Jr
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5p-0008OW-NA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:34 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Mar 2018 16:09:09 +0800
Message-Id: <20180309080910.7274-4-famz@redhat.com>
In-Reply-To: <20180309080910.7274-1-famz@redhat.com>
References: <20180309080910.7274-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] block: Use the actual current_flags during
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This complies to the function contract and allows bdrv_backing_options
to make the right decision.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 937f9fe159..1e2b0d822d 100644
--- a/block.c
+++ b/block.c
@@ -2785,14 +2785,14 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  BlockDriverState *bs,
                                                  QDict *options,
                                                  int flags,
-                                                 const BdrvChildRole *role,
+                                                 BdrvChild *child,
                                                  QDict *parent_options,
                                                  int parent_flags)
 {
     assert(bs != NULL);
 
     BlockReopenQueueEntry *bs_entry;
-    BdrvChild *child;
+    BdrvChild *c;
     QDict *old_options, *explicit_options;
 
     /* Make sure that the caller remembered to use a drained section. This is
@@ -2847,10 +2847,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     explicit_options = qdict_clone_shallow(options);
 
     /* Inherit from parent node */
+    assert(!!child == !!parent_options);
     if (parent_options) {
-        assert(!flags);
-        role->inherit_options(&flags, options, parent_flags, parent_options,
-                              0);
+        child->role->inherit_options(&flags, options,
+                                     parent_flags, parent_options,
+                                     child->bs->open_flags);
     }
 
     /* Old values are used for options that aren't set yet */
@@ -2881,23 +2882,23 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     bs_entry->state.perm = UINT64_MAX;
     bs_entry->state.shared_perm = 0;
 
-    QLIST_FOREACH(child, &bs->children, next) {
+    QLIST_FOREACH(c, &bs->children, next) {
         QDict *new_child_options;
         char *child_key_dot;
 
         /* reopen can only change the options of block devices that were
          * implicitly created and inherited options. For other (referenced)
          * block devices, a syntax like "backing.foo" results in an error. */
-        if (child->bs->inherits_from != bs) {
+        if (c->bs->inherits_from != bs) {
             continue;
         }
 
-        child_key_dot = g_strdup_printf("%s.", child->name);
+        child_key_dot = g_strdup_printf("%s.", c->name);
         qdict_extract_subqdict(options, &new_child_options, child_key_dot);
         g_free(child_key_dot);
 
-        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
-                                child->role, options, flags);
+        bdrv_reopen_queue_child(bs_queue, c->bs, new_child_options, 0,
+                                c, options, flags);
     }
 
     return bs_queue;
-- 
2.14.3
