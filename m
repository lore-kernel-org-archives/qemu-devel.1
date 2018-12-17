Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cf-00077s-CR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1ce-0006DF-Ei
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:25 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:29 +0100
Message-Id: <20181217224348.14922-13-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 12/31] block: Add
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
 block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 615ffa7f40..08b89b86fd 100644
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
2.19.2
