Received: from eggs.gnu.org ([2001:4830:134:3::10]:37461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfe-0002ze-53
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfc-0002CM-SG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 19 Oct 2018 18:30:10 +0200
Message-Id: <20181019163013.11787-7-kwolf@redhat.com>
In-Reply-To: <20181019163013.11787-1-kwolf@redhat.com>
References: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/11] file-posix: Support auto-read-only
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=3Doff, but auto-read-only=3Don is given, open the file
read-write if we have the permissions, but instead of erroring out for
read-only files, just degrade to read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2da3a76355..0c1b81ce4b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -527,9 +527,22 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
=20
     s->fd =3D -1;
     fd =3D qemu_open(filename, s->open_flags, 0644);
-    if (fd < 0) {
-        ret =3D -errno;
-        error_setg_errno(errp, errno, "Could not open '%s'", filename);
+    ret =3D fd < 0 ? -errno : 0;
+
+    if (ret =3D=3D -EACCES || ret =3D=3D -EROFS) {
+        /* Try to degrade to read-only, but if it doesn't work, still us=
e the
+         * normal error message. */
+        if (bdrv_apply_auto_read_only(bs, NULL, NULL) =3D=3D 0) {
+            bdrv_flags &=3D ~BDRV_O_RDWR;
+            raw_parse_flags(bdrv_flags, &s->open_flags);
+            assert(!(s->open_flags & O_CREAT));
+            fd =3D qemu_open(filename, s->open_flags);
+            ret =3D fd < 0 ? -errno : 0;
+        }
+    }
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not open '%s'", filename);
         if (ret =3D=3D -EROFS) {
             ret =3D -EACCES;
         }
--=20
2.19.1
