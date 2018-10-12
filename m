Received: from eggs.gnu.org ([2001:4830:134:3::10]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2z-0007gf-Ms
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2y-00060G-GZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Oct 2018 13:55:31 +0200
Message-Id: <20181012115532.12645-8-kwolf@redhat.com>
In-Reply-To: <20181012115532.12645-1-kwolf@redhat.com>
References: <20181012115532.12645-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 7/8] gluster: Support auto-read-only option
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
---
 block/gluster.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/gluster.c b/block/gluster.c
index 4fd55a9cc5..68d20c8830 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -849,6 +849,15 @@ static int qemu_gluster_open(BlockDriverState *bs,  =
QDict *options,
     qemu_gluster_parse_flags(bdrv_flags, &open_flags);
=20
     s->fd =3D glfs_open(s->glfs, gconf->path, open_flags);
+    if (!s->fd && errno =3D=3D EACCES) {
+        /* Try to degrade to read-only, but if it doesn't work, still us=
e the
+         * normal error message. */
+        ret =3D bdrv_apply_auto_read_only(bs, NULL, NULL);
+        if (ret =3D=3D 0) {
+            open_flags =3D (open_flags & ~O_RDWR) | O_RDONLY;
+            s->fd =3D glfs_open(s->glfs, gconf->path, open_flags);
+        }
+    }
     if (!s->fd) {
         ret =3D -errno;
     }
--=20
2.19.1
