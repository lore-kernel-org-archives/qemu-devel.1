Received: from eggs.gnu.org ([2001:4830:134:3::10]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6K01-0008Es-Nl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6K00-0003wQ-LA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:40 +0200
Message-Id: <1493916761-32319-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] block: Fix write/resize permissions for
 inactive images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Format drivers for inactive nodes don't need write/resize permissions on
their bs->file and can share write/resize with another VM (in fact, this
is the whole point of keeping images inactive). Represent this fact in
the op blocker system, so that image locking does the right thing
without special-casing inactive images.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 35 +++++++++++++++++++++++++++++++++--
 include/block/block.h |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 773bd64..cd89467 100644
--- a/block.c
+++ b/block.c
@@ -192,11 +192,20 @@ void path_combine(char *dest, int dest_size,
     }
 }
 
+/* Returns whether the image file is opened as read-only. Note that this can
+ * return false and writing to the image file is still not possible because the
+ * image is inactivated. */
 bool bdrv_is_read_only(BlockDriverState *bs)
 {
     return bs->read_only;
 }
 
+/* Returns whether the image file can be written to right now */
+bool bdrv_is_writable(BlockDriverState *bs)
+{
+    return !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIVE);
+}
+
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
     /* Do not set read_only if copy_on_read is enabled */
@@ -1512,7 +1521,7 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
 
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
-        bdrv_is_read_only(bs))
+        !bdrv_is_writable(bs))
     {
         error_setg(errp, "Block node is read-only");
         return -EPERM;
@@ -1797,7 +1806,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
-        if (!bdrv_is_read_only(bs)) {
+        if (bdrv_is_writable(bs)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
         }
 
@@ -1823,6 +1832,10 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                   BLK_PERM_WRITE_UNCHANGED;
     }
 
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
     *nperm = perm;
     *nshared = shared;
 }
@@ -3969,6 +3982,7 @@ void bdrv_init_with_whitelist(void)
 void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
+    uint64_t perm, shared_perm;
     Error *local_err = NULL;
     int ret;
 
@@ -4005,6 +4019,16 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         return;
     }
 
+    /* Update permissions, they may differ for inactive nodes */
+    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+    ret = bdrv_check_perm(bs, perm, shared_perm, NULL, &local_err);
+    if (ret < 0) {
+        bs->open_flags |= BDRV_O_INACTIVE;
+        error_propagate(errp, local_err);
+        return;
+    }
+    bdrv_set_perm(bs, perm, shared_perm);
+
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
         if (parent->role->activate) {
             parent->role->activate(parent, &local_err);
@@ -4049,6 +4073,8 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
     }
 
     if (setting_flag) {
+        uint64_t perm, shared_perm;
+
         bs->open_flags |= BDRV_O_INACTIVE;
 
         QLIST_FOREACH(parent, &bs->parents, next_parent) {
@@ -4060,6 +4086,11 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
                 }
             }
         }
+
+        /* Update permissions, they may differ for inactive nodes */
+        bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+        bdrv_check_perm(bs, perm, shared_perm, NULL, &error_abort);
+        bdrv_set_perm(bs, perm, shared_perm);
     }
 
     QLIST_FOREACH(child, &bs->children, next) {
diff --git a/include/block/block.h b/include/block/block.h
index 80d51d8..90932b4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -435,6 +435,7 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
+bool bdrv_is_writable(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
-- 
1.8.3.1
