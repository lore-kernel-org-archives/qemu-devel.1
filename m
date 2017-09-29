Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYn-00013D-Pg
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYn-00033V-2B
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:45 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:30 +0200
Message-Id: <20170929165347.29658-9-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 08/25] block: Add
 bdrv_make_absolute_filename()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is a general function for making a filename that is relative to a
certain BDS absolute.

It calls bdrv_get_full_backing_filename_from_filename() for now, but
that will be changed in a follow-up patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 488abfbfc4..2da242c1e9 100644
--- a/block.c
+++ b/block.c
@@ -308,13 +308,24 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
     }
 }
 
-char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+/* If @filename is empty or NULL, this function returns NULL without
+ * setting @errp.  In all other cases, NULL will only be returned with
+ * @errp set.
+ */
+static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
+                                         const char *filename, Error **errp)
 {
-    char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
+    char *bs_filename = relative_to->exact_filename[0]
+                        ? relative_to->exact_filename
+                        : relative_to->filename;
+
+    return bdrv_get_full_backing_filename_from_filename(bs_filename,
+                                                        filename ?: "", errp);
+}
 
-    return bdrv_get_full_backing_filename_from_filename(backed,
-                                                        bs->backing_file,
-                                                        errp);
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_make_absolute_filename(bs, bs->backing_file, errp);
 }
 
 void bdrv_register(BlockDriver *bdrv)
-- 
2.13.6
