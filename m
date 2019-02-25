Received: from eggs.gnu.org ([209.51.188.92]:38085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5L-0000pV-V7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5I-0001Rm-Lr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:25 +0100
Message-Id: <20190225152053.15976-44-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/71] block/nbd: Make bdrv_dirname() return NULL
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

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190201192935.18394-18-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 9db5eded89..83e6e9e442 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -528,6 +528,16 @@ static void nbd_refresh_filename(BlockDriverState *b=
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
@@ -546,6 +556,7 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static BlockDriver bdrv_nbd_tcp =3D {
@@ -566,6 +577,7 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static BlockDriver bdrv_nbd_unix =3D {
@@ -586,6 +598,7 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
+    .bdrv_dirname               =3D nbd_dirname,
 };
=20
 static void bdrv_nbd_init(void)
--=20
2.20.1
