Received: from eggs.gnu.org ([2001:4830:134:3::10]:59228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLp-00034V-PI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLo-00060X-MZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:35 +0100
Message-Id: <1487006583-24350-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 13/41] block: Request real permissions in
 bdrv_attach_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Now that all block drivers with children tell us what permissions they
need from each of their children, bdrv_attach_child() can use this
information and make the right requirements while trying to attach new
children.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 682548a..fd06549 100644
--- a/block.c
+++ b/block.c
@@ -1558,10 +1558,21 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              Error **errp)
 {
     BdrvChild *child;
+    uint64_t perm, shared_perm;
+
+    /* XXX This check is a workaround for bdrv_open_inherit(), which attaches
+     * bs->file before bs is opened for format probing. The 'else' branch
+     * really shouldn't exist. */
+    if (parent_bs->drv) {
+        parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
+                                        0, BLK_PERM_ALL, &perm, &shared_perm);
+    } else {
+        perm = 0;
+        shared_perm = BLK_PERM_ALL;
+    }
 
-    /* FIXME Use real permissions */
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
-                                   0, BLK_PERM_ALL, parent_bs, errp);
+                                   perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
         return NULL;
     }
@@ -2041,6 +2052,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
      * probing, the block drivers will do their own bdrv_open_child() for the
      * same BDS, which is why we put the node name back into options. */
     if ((flags & BDRV_O_PROTOCOL) == 0) {
+        /* FIXME Really shouldn't try to open a child for a still closed bs,
+         * see bdrv_attach_child() */
         file = bdrv_open_child(filename, options, "file", bs,
                                &child_file, true, &local_err);
         if (local_err) {
-- 
1.8.3.1
