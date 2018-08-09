Received: from eggs.gnu.org ([2001:4830:134:3::10]:42752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbB-0002Sy-OS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbA-00082P-SA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:09 +0200
Message-Id: <20180809213528.14738-13-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 12/31] block: Add
 bdrv_make_absolute_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

This is a general function for making a filename that is relative to a
certain BDS absolute.

It calls bdrv_get_full_backing_filename_from_filename() for now, but
that will be changed in a follow-up patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 369c8fa027..6606eeb7f4 100644
--- a/block.c
+++ b/block.c
@@ -319,16 +319,29 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
     }
 }
 
-char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+/*
+ * If @filename is empty or NULL, this function returns NULL without
+ * setting @errp.  In all other cases, NULL will only be returned with
+ * @errp set.
+ */
+static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
+                                         const char *filename, Error **errp)
 {
-    char *backed;
+    char *bs_filename;
 
-    bdrv_refresh_filename(bs);
+    bdrv_refresh_filename(relative_to);
+
+    bs_filename = relative_to->exact_filename[0]
+                      ? relative_to->exact_filename
+                      : relative_to->filename;
 
-    backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
-    return bdrv_get_full_backing_filename_from_filename(backed,
-                                                        bs->backing_file,
-                                                        errp);
+    return bdrv_get_full_backing_filename_from_filename(bs_filename,
+                                                        filename ?: "", errp);
+}
+
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_make_absolute_filename(bs, bs->backing_file, errp);
 }
 
 void bdrv_register(BlockDriver *bdrv)
-- 
2.17.1
