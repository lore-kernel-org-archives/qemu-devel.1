Received: from eggs.gnu.org ([209.51.188.92]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5G-0000iP-P7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5C-0001MQ-V2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:20 +0100
Message-Id: <20190225152053.15976-39-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/71] block: Add bdrv_make_absolute_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This is a general function for making a filename that is relative to a
certain BDS absolute.

It calls bdrv_get_full_backing_filename_from_filename() for now, but
that will be changed in a follow-up patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190201192935.18394-13-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index a2203f0cfe..c66cd111e1 100644
--- a/block.c
+++ b/block.c
@@ -338,16 +338,29 @@ char *bdrv_get_full_backing_filename_from_filename(=
const char *backed,
     }
 }
=20
-char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+/*
+ * If @filename is empty or NULL, this function returns NULL without
+ * setting @errp.  In all other cases, NULL will only be returned with
+ * @errp set.
+ */
+static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
+                                         const char *filename, Error **e=
rrp)
 {
-    char *backed;
+    char *bs_filename;
=20
-    bdrv_refresh_filename(bs);
+    bdrv_refresh_filename(relative_to);
+
+    bs_filename =3D relative_to->exact_filename[0]
+                      ? relative_to->exact_filename
+                      : relative_to->filename;
=20
-    backed =3D bs->exact_filename[0] ? bs->exact_filename : bs->filename=
;
-    return bdrv_get_full_backing_filename_from_filename(backed,
-                                                        bs->backing_file=
,
-                                                        errp);
+    return bdrv_get_full_backing_filename_from_filename(bs_filename,
+                                                        filename ?: "", =
errp);
+}
+
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_make_absolute_filename(bs, bs->backing_file, errp);
 }
=20
 void bdrv_register(BlockDriver *bdrv)
--=20
2.20.1
