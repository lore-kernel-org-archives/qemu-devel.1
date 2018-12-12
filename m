Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZB-0003Ol-6V
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZA-0001iB-Dg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:25 +0100
Message-Id: <20181212132735.16080-32-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/41] block: Use bdrv_reopen_set_read_only() in
 qmp_change_backing_file()
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
 blockdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 81f95d920b..6fa6969cd0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4100,7 +4100,6 @@ void qmp_change_backing_file(const char *device,
     BlockDriverState *image_bs =3D NULL;
     Error *local_err =3D NULL;
     bool ro;
-    int open_flags;
     int ret;
=20
     bs =3D qmp_get_root_bs(device, errp);
@@ -4142,13 +4141,10 @@ void qmp_change_backing_file(const char *device,
     }
=20
     /* if not r/w, reopen to make r/w */
-    open_flags =3D image_bs->open_flags;
     ro =3D bdrv_is_read_only(image_bs);
=20
     if (ro) {
-        bdrv_reopen(image_bs, open_flags | BDRV_O_RDWR, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (bdrv_reopen_set_read_only(image_bs, false, errp) !=3D 0) {
             goto out;
         }
     }
@@ -4164,7 +4160,7 @@ void qmp_change_backing_file(const char *device,
     }
=20
     if (ro) {
-        bdrv_reopen(image_bs, open_flags, &local_err);
+        bdrv_reopen_set_read_only(image_bs, true, &local_err);
         error_propagate(errp, local_err);
     }
=20
--=20
2.19.2
