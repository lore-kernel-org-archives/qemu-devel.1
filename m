Received: from eggs.gnu.org ([209.51.188.92]:44777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7E-0000nQ-WB
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7B-0006ot-E4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M78-0006l3-7g
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:07 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:45 -0500
Message-Id: <20190308202858.26636-5-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] block/dirty-bitmap: change semantics of
 enabled predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Currently, the enabled predicate means something like:
"the QAPI status of the bitmap is ACTIVE."
After this patch, it should mean exclusively:
"This bitmap is recording guest writes, and is allowed to do so."

In many places, this is how this predicate was already used.
Internal usages of the bitmap QPI can call user_locked to find out if
the bitmap is in use by an operation.

To accommodate this, modify the create_successor routine to now
explicitly disable the parent bitmap at creation time.

Justifications:

1. bdrv_dirty_bitmap_status suffers no change from the lack of
   1:1 parity with the new predicates because of the order in which
   the predicates are checked. This is now only for compatibility.

2. bdrv_set_dirty() is unchanged: pre-patch, it was skipping bitmaps that were
   disabled or had a successor, while post-patch it is only skipping bitmaps
   that are disabled. To accommodate this, create_successor now ensures that
   any bitmap with a successor is explicitly disabled.

3. qcow2_store_persistent_dirty_bitmaps: No functional change. This function
   cares only about the literal enabled bit, and makes no effort to check if
   the bitmap is in-use or not. After this patch there are still no ways to
   produce an enabled bitmap with a successor.

4. block_dirty_bitmap_enable_prepare
   block_dirty_bitmap_disable_prepare
   init_dirty_bitmap_migration
   nbd_export_new

   These functions care about the literal enabled bit,
   and already check user_locked separately.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b2b32e0323..2e3192d86f 100644
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
@@ -236,6 +236,7 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
  * Requires that the bitmap is not user_locked and has no successor.
+ * The successor will be enabled if the parent bitmap was.
  * Called with BQL taken.
  */
 int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
@@ -264,6 +265,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
     /* Successor will be on or off based on our current state. */
     child->disabled = bitmap->disabled;
+    bitmap->disabled = true;
 
     /* Install the successor and freeze the parent */
     bitmap->successor = child;
@@ -329,7 +331,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 /**
  * In cases of failure where we can no longer safely delete the parent,
  * we may wish to re-join the parent and child/successor.
- * The merged parent will not be user_locked, nor explicitly re-enabled.
+ * The merged parent will not be user_locked.
+ * The marged parent will be enabled if and only if the successor was enabled.
  * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
  */
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
@@ -347,6 +350,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
         error_setg(errp, "Merging of parent and successor bitmap failed");
         return NULL;
     }
+
+    parent->disabled = successor->disabled;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
-- 
2.17.2
