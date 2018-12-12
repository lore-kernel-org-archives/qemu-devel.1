Received: from eggs.gnu.org ([2001:4830:134:3::10]:46671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZB-0003P9-D4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZA-0001i5-Cv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:23 +0100
Message-Id: <20181212132735.16080-30-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/41] block: Use bdrv_reopen_set_read_only() in
 bdrv_commit()
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
 block/commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index a53c2d04b0..53148e610b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -391,7 +391,7 @@ int bdrv_commit(BlockDriverState *bs)
     BlockDriverState *commit_top_bs =3D NULL;
     BlockDriver *drv =3D bs->drv;
     int64_t offset, length, backing_length;
-    int ro, open_flags;
+    int ro;
     int64_t n;
     int ret =3D 0;
     uint8_t *buf =3D NULL;
@@ -410,10 +410,9 @@ int bdrv_commit(BlockDriverState *bs)
     }
=20
     ro =3D bs->backing->bs->read_only;
-    open_flags =3D  bs->backing->bs->open_flags;
=20
     if (ro) {
-        if (bdrv_reopen(bs->backing->bs, open_flags | BDRV_O_RDWR, NULL)=
) {
+        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
             return -EACCES;
         }
     }
@@ -523,7 +522,7 @@ ro_cleanup:
=20
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen(bs->backing->bs, open_flags & ~BDRV_O_RDWR, NULL);
+        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
     }
=20
     return ret;
--=20
2.19.2
