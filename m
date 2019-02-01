Received: from eggs.gnu.org ([209.51.188.92]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWO-0006MY-3O
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWL-0002rm-P9
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:20 +0100
Message-Id: <20190201192935.18394-17-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 16/31] quorum: Make bdrv_dirname() return
 NULL
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

While the common implementation for bdrv_dirname() should return NULL
for quorum BDSs already (because they do not have a file node and their
exact_filename field should be empty), there is no reason not to make
that explicit.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index cf9d7c16c2..a890f21e85 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1094,6 +1094,16 @@ static void quorum_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
     bs->full_open_options =3D opts;
 }
=20
+static char *quorum_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* In general, there are multiple BDSs with different dirnames below=
 this
+     * one; so there is no unique dirname we could return (unless all ar=
e equal
+     * by chance, or there is only one). Therefore, to be consistent, ju=
st
+     * always return NULL. */
+    error_setg(errp, "Cannot generate a base directory for quorum nodes"=
);
+    return NULL;
+}
+
 static BlockDriver bdrv_quorum =3D {
     .format_name                        =3D "quorum",
=20
@@ -1102,6 +1112,7 @@ static BlockDriver bdrv_quorum =3D {
     .bdrv_open                          =3D quorum_open,
     .bdrv_close                         =3D quorum_close,
     .bdrv_refresh_filename              =3D quorum_refresh_filename,
+    .bdrv_dirname                       =3D quorum_dirname,
=20
     .bdrv_co_flush_to_disk              =3D quorum_co_flush,
=20
--=20
2.20.1
