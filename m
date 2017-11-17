Received: from eggs.gnu.org ([2001:4830:134:3::10]:42852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCU-0001AX-1b
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCP-0002F4-1c
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:35 +0100
Message-Id: <20171117181653.20651-8-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/25] block: Fix permissions in image activation
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

Inactive images generally request less permissions for their image files
than they would if they were active (in particular, write permissions).
Activating the image involves extending the permissions, therefore.

drv->bdrv_invalidate_cache() can already require write access to the
image file, so we have to update the permissions earlier than that.
The current code does it only later, so we have to move up this part.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 0ed0c27140..752fe6192b 100644
--- a/block.c
+++ b/block.c
@@ -4174,7 +4174,29 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         }
     }
 
+    /*
+     * Update permissions, they may differ for inactive nodes.
+     *
+     * Note that the required permissions of inactive images are always a
+     * subset of the permissions required after activating the image. This
+     * allows us to just get the permissions upfront without restricting
+     * drv->bdrv_invalidate_cache().
+     *
+     * It also means that in error cases, we don't have to try and revert to
+     * the old permissions (which is an operation that could fail, too). We can
+     * just keep the extended permissions for the next time that an activation
+     * of the image is tried.
+     */
     bs->open_flags &= ~BDRV_O_INACTIVE;
+    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_err);
+    if (ret < 0) {
+        bs->open_flags |= BDRV_O_INACTIVE;
+        error_propagate(errp, local_err);
+        return;
+    }
+    bdrv_set_perm(bs, perm, shared_perm);
+
     if (bs->drv->bdrv_invalidate_cache) {
         bs->drv->bdrv_invalidate_cache(bs, &local_err);
         if (local_err) {
@@ -4191,16 +4213,6 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         return;
     }
 
-    /* Update permissions, they may differ for inactive nodes */
-    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_err);
-    if (ret < 0) {
-        bs->open_flags |= BDRV_O_INACTIVE;
-        error_propagate(errp, local_err);
-        return;
-    }
-    bdrv_set_perm(bs, perm, shared_perm);
-
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
         if (parent->role->activate) {
             parent->role->activate(parent, &local_err);
-- 
2.13.6
