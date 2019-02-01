Received: from eggs.gnu.org ([209.51.188.92]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWO-0006MV-2w
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWL-0002rt-PQ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:19 +0100
Message-Id: <20190201192935.18394-16-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 15/31] blkverify: Make bdrv_dirname()
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

blkverify's BDSs have a file BDS, but we do not want this to be
preferred over the raw node. There is no way to decide between the two
(and not really a reason to, either), so just return NULL in blkverify's
implementation of bdrv_dirname().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/blkverify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 035d77b64a..3c7d4c8729 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -313,6 +313,15 @@ static void blkverify_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
     }
 }
=20
+static char *blkverify_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* In general, there are two BDSs with different dirnames below this=
 one;
+     * so there is no unique dirname we could return (unless both are eq=
ual by
+     * chance). Therefore, to be consistent, just always return NULL. */
+    error_setg(errp, "Cannot generate a base directory for blkverify nod=
es");
+    return NULL;
+}
+
 static BlockDriver bdrv_blkverify =3D {
     .format_name                      =3D "blkverify",
     .protocol_name                    =3D "blkverify",
@@ -324,6 +333,7 @@ static BlockDriver bdrv_blkverify =3D {
     .bdrv_child_perm                  =3D bdrv_filter_default_perms,
     .bdrv_getlength                   =3D blkverify_getlength,
     .bdrv_refresh_filename            =3D blkverify_refresh_filename,
+    .bdrv_dirname                     =3D blkverify_dirname,
=20
     .bdrv_co_preadv                   =3D blkverify_co_preadv,
     .bdrv_co_pwritev                  =3D blkverify_co_pwritev,
--=20
2.20.1
