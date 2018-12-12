Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z5-0003Hg-5l
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z4-0001cv-C2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:21 +0100
Message-Id: <20181212132735.16080-28-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/41] block: Use bdrv_reopen_set_read_only() in
 bdrv_backing_update_filename()
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

From: Alberto Garcia <berto@igalia.com>

This patch replaces the bdrv_reopen() calls that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 7178872560..d7b94794f4 100644
--- a/block.c
+++ b/block.c
@@ -1079,11 +1079,11 @@ static int bdrv_backing_update_filename(BdrvChild=
 *c, BlockDriverState *base,
                                         const char *filename, Error **er=
rp)
 {
     BlockDriverState *parent =3D c->opaque;
-    int orig_flags =3D bdrv_get_flags(parent);
+    bool read_only =3D bdrv_is_read_only(parent);
     int ret;
=20
-    if (!(orig_flags & BDRV_O_RDWR)) {
-        ret =3D bdrv_reopen(parent, orig_flags | BDRV_O_RDWR, errp);
+    if (read_only) {
+        ret =3D bdrv_reopen_set_read_only(parent, false, errp);
         if (ret < 0) {
             return ret;
         }
@@ -1095,8 +1095,8 @@ static int bdrv_backing_update_filename(BdrvChild *=
c, BlockDriverState *base,
         error_setg_errno(errp, -ret, "Could not update backing file link=
");
     }
=20
-    if (!(orig_flags & BDRV_O_RDWR)) {
-        bdrv_reopen(parent, orig_flags, NULL);
+    if (read_only) {
+        bdrv_reopen_set_read_only(parent, true, NULL);
     }
=20
     return ret;
--=20
2.19.2
