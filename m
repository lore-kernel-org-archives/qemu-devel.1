Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cr-0007KY-Kh
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cq-0006MN-CT
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:34 +0100
Message-Id: <20181217224348.14922-18-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 17/31] block/nbd: Make bdrv_dirname()
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73..bca127c8f5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -564,6 +564,16 @@ static void nbd_refresh_filename(BlockDriverState *b=
s, QDict *options)
     bs->full_open_options =3D opts;
 }
=20
+static char *nbd_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* The generic bdrv_dirname() implementation is able to work out som=
e
+     * directory name for NBD nodes, but that would be wrong. So far the=
re is no
+     * specification for how "export paths" would work, so NBD does not =
have
+     * directory names. */
+    error_setg(errp, "Cannot generate a base directory for NBD nodes");
+    return NULL;
+}
+
 static BlockDriver bdrv_nbd =3D {
     .format_name                =3D "nbd",
     .protocol_name              =3D "nbd",
@@ -582,6 +592,7 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static BlockDriver bdrv_nbd_tcp =3D {
@@ -602,6 +613,7 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static BlockDriver bdrv_nbd_unix =3D {
@@ -622,6 +634,7 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static void bdrv_nbd_init(void)
--=20
2.19.2
