Received: from eggs.gnu.org ([209.51.188.92]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1nJ-0007pl-LU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1k1-0002YM-1v
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:29:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 22 Jan 2019 13:19:26 +0100
Message-Id: <20190122121926.25554-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block: Apply auto-read-only for ro-whitelist
 drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

If QEMU was configured with a driver in --block-drv-ro-whitelist, trying
to use that driver read-write resulted in an error message even if
auto-read-only=3Don was set.

Consider auto-read-only=3Don for the whitelist checking and use it to
automatically degrade to read-only for block drivers on the read-only
whitelist.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 92a3b45a78..0eba8ebe5c 100644
--- a/block.c
+++ b/block.c
@@ -1438,13 +1438,19 @@ static int bdrv_open_common(BlockDriverState *bs,=
 BlockBackend *file,
     bs->read_only =3D !(bs->open_flags & BDRV_O_RDWR);
=20
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, bs->read_only)) =
{
-        error_setg(errp,
-                   !bs->read_only && bdrv_is_whitelisted(drv, true)
-                        ? "Driver '%s' can only be used for read-only de=
vices"
-                        : "Driver '%s' is not whitelisted",
-                   drv->format_name);
-        ret =3D -ENOTSUP;
-        goto fail_opts;
+        if (!bs->read_only && bdrv_is_whitelisted(drv, true)) {
+            ret =3D bdrv_apply_auto_read_only(bs, NULL, NULL);
+        } else {
+            ret =3D -ENOTSUP;
+        }
+        if (ret < 0) {
+            error_setg(errp,
+                       !bs->read_only && bdrv_is_whitelisted(drv, true)
+                       ? "Driver '%s' can only be used for read-only dev=
ices"
+                       : "Driver '%s' is not whitelisted",
+                       drv->format_name);
+            goto fail_opts;
+        }
     }
=20
     /* bdrv_new() and bdrv_close() make it so */
--=20
2.20.1
