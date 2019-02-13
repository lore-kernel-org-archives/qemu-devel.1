Received: from eggs.gnu.org ([209.51.188.92]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu49G-0005by-Oy
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu3yV-0000r5-CY
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:29:57 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:23:53 -0500
Message-Id: <20190213232356.21034-4-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-1-jsnow@redhat.com>
References: <20190213232356.21034-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] block/dirty-bitmap: change semantics of
 enabled predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Currently, enabled means something like "the status of the bitmap
is ACTIVE." After this patch, it should mean exclusively: "This
bitmap is recording guest writes, and is allowed to do so."

In many places, this is how this predicate was already used.
We'll allow users to call user_locked if they're really curious about
finding out if the bitmap is in use by an operation.

To accommodate this, modify the create_successor routine to now
explicitly disable the parent bitmap at creation time.


Justifications:

1. bdrv_dirty_bitmap_status suffers no change from the lack of
   1:1 parity with the new predicates because of the order in which
   the predicates are checked. This is now only for compatibility.

2. bdrv_set_dirty_bitmap is only used by mirror, which does not use
   disabled bitmaps -- all of these writes are internal usages.
   Therefore, we should allow writes even in the disabled state.
   The condition is removed.

3. bdrv_reset_dirty_bitmap Similarly, this is only used internally by
   mirror and migration. In these contexts it is always enabled anyway,
   but our API does not need to enforce this.

4. bdrv_set_dirty() is unchanged: pre-patch, it was skipping bitmaps that were
   disabled or had a successor, while post-patch it is only skipping bitmaps
   that are disabled. To accommodate this, create_successor now ensures that
   any bitmap with a successor is explicitly disabled.

5. qcow2_store_persistent_dirty_bitmaps: This only ever wanted to check if the
   bitmap was enabled or not. Theoretically if we save during an operation,
   this now gets set as enabled instead of disabled, but this cannot happen
   in practice because jobs must be finished before we close the disk.

6. block_dirty_bitmap_enable_prepare only ever cared about the
   literal bit, and already checked for user_locked beforehand.

7. block_dirty_bitmap_disable_prepare ditto as above.

8. init_dirty_bitmap_migration also already checks user_locked,
   so this call can be a simple enabled/disabled check.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/dirty-bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 639ebc0645..bb2e19e0d8 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -209,7 +209,7 @@ bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 {
-    return !(bitmap->disabled || bitmap->successor);
+    return !bitmap->disabled;
 }
 
 /* Called with BQL taken.  */
@@ -264,6 +264,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
     /* Successor will be on or off based on our current state. */
     child->disabled = bitmap->disabled;
+    bitmap->disabled = true;
 
     /* Install the successor and freeze the parent */
     bitmap->successor = child;
@@ -346,6 +347,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
         error_setg(errp, "Merging of parent and successor bitmap failed");
         return NULL;
     }
+
+    parent->disabled = successor->disabled;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
@@ -542,7 +545,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, offset, bytes);
 }
@@ -559,7 +561,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, offset, bytes);
 }
-- 
2.17.2
