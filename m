Received: from eggs.gnu.org ([209.51.188.92]:47195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWS-0006S5-57
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWO-0002tb-1A
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:42 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:22 +0100
Message-Id: <20190201192935.18394-19-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 18/31] block/nfs: Implement bdrv_dirname()
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

While the basic idea is obvious and could be handled by the default
bdrv_dirname() implementation, we cannot generate a directory name if
the gid or uid are set, so we have to explicitly return NULL in those
cases.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/nfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index eab1a2c408..19ee07c321 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -855,6 +855,20 @@ static void nfs_refresh_filename(BlockDriverState *b=
s, QDict *options)
     bs->full_open_options =3D opts;
 }
=20
+static char *nfs_dirname(BlockDriverState *bs, Error **errp)
+{
+    NFSClient *client =3D bs->opaque;
+
+    if (client->uid || client->gid) {
+        bdrv_refresh_filename(bs);
+        error_setg(errp, "Cannot generate a base directory for NFS node =
'%s'",
+                   bs->filename);
+        return NULL;
+    }
+
+    return g_strdup_printf("nfs://%s%s/", client->server->host, client->=
path);
+}
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
 static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
                                                  Error **errp)
@@ -889,6 +903,7 @@ static BlockDriver bdrv_nfs =3D {
     .bdrv_detach_aio_context        =3D nfs_detach_aio_context,
     .bdrv_attach_aio_context        =3D nfs_attach_aio_context,
     .bdrv_refresh_filename          =3D nfs_refresh_filename,
+    .bdrv_dirname                   =3D nfs_dirname,
=20
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_co_invalidate_cache       =3D nfs_co_invalidate_cache,
--=20
2.20.1
