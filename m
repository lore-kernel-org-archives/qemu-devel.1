Received: from eggs.gnu.org ([2001:4830:134:3::10]:33907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6P-0007oN-Sq
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6P-000513-5T
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:21 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:30 +0200
Message-Id: <20170621125047.30294-9-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/25] block: Add
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This is a general function for making a filename that is relative to a
certain BDS absolute.

It calls bdrv_get_full_backing_filename_from_filename() for now, but
that will be changed in a follow-up patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 14beb6b..6f19816 100644
--- a/block.c
+++ b/block.c
@@ -304,15 +304,22 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
     }
 }
 
-char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
+                                         const char *filename, Error **errp)
 {
-    char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
+    char *bs_filename = relative_to->exact_filename[0]
+                        ? relative_to->exact_filename
+                        : relative_to->filename;
 
-    return bdrv_get_full_backing_filename_from_filename(backed,
-                                                        bs->backing_file,
+    return bdrv_get_full_backing_filename_from_filename(bs_filename, filename,
                                                         errp);
 }
 
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_make_absolute_filename(bs, bs->backing_file, errp);
+}
+
 void bdrv_register(BlockDriver *bdrv)
 {
     QLIST_INSERT_HEAD(&bdrv_drivers, bdrv, list);
-- 
2.9.4
