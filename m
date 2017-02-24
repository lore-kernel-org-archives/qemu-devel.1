Received: from eggs.gnu.org ([2001:4830:134:3::10]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKR0-0006gt-JO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQz-0002v9-Gu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:17:05 +0100
Message-Id: <1487960230-18054-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/19] block: Factor out bdrv_open_child_bs()
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

This is the part of bdrv_open_child() that opens a BDS with option
inheritance, but doesn't attach it as a child to the parent yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 61 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/block.c b/block.c
index 40c4dee..6987400 100644
--- a/block.c
+++ b/block.c
@@ -1546,28 +1546,12 @@ free_exit:
     return ret;
 }
 
-/*
- * Opens a disk image whose options are given as BlockdevRef in another block
- * device's options.
- *
- * If allow_none is true, no image will be opened if filename is false and no
- * BlockdevRef is given. NULL will be returned, but errp remains unset.
- *
- * bdrev_key specifies the key for the image's BlockdevRef in the options QDict.
- * That QDict has to be flattened; therefore, if the BlockdevRef is a QDict
- * itself, all options starting with "${bdref_key}." are considered part of the
- * BlockdevRef.
- *
- * The BlockdevRef will be removed from the options QDict.
- */
-BdrvChild *bdrv_open_child(const char *filename,
-                           QDict *options, const char *bdref_key,
-                           BlockDriverState* parent,
-                           const BdrvChildRole *child_role,
-                           bool allow_none, Error **errp)
+static BlockDriverState *
+bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
+                   BlockDriverState *parent, const BdrvChildRole *child_role,
+                   bool allow_none, Error **errp)
 {
-    BdrvChild *c = NULL;
-    BlockDriverState *bs;
+    BlockDriverState *bs = NULL;
     QDict *image_options;
     char *bdref_key_dot;
     const char *reference;
@@ -1594,11 +1578,40 @@ BdrvChild *bdrv_open_child(const char *filename,
         goto done;
     }
 
-    c = bdrv_attach_child(parent, bs, bdref_key, child_role);
-
 done:
     qdict_del(options, bdref_key);
-    return c;
+    return bs;
+}
+
+/*
+ * Opens a disk image whose options are given as BlockdevRef in another block
+ * device's options.
+ *
+ * If allow_none is true, no image will be opened if filename is false and no
+ * BlockdevRef is given. NULL will be returned, but errp remains unset.
+ *
+ * bdrev_key specifies the key for the image's BlockdevRef in the options QDict.
+ * That QDict has to be flattened; therefore, if the BlockdevRef is a QDict
+ * itself, all options starting with "${bdref_key}." are considered part of the
+ * BlockdevRef.
+ *
+ * The BlockdevRef will be removed from the options QDict.
+ */
+BdrvChild *bdrv_open_child(const char *filename,
+                           QDict *options, const char *bdref_key,
+                           BlockDriverState *parent,
+                           const BdrvChildRole *child_role,
+                           bool allow_none, Error **errp)
+{
+    BlockDriverState *bs;
+
+    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_role,
+                            allow_none, errp);
+    if (bs == NULL) {
+        return NULL;
+    }
+
+    return bdrv_attach_child(parent, bs, bdref_key, child_role);
 }
 
 static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
-- 
1.8.3.1
