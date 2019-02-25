Received: from eggs.gnu.org ([209.51.188.92]:37851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5E-0000fQ-7Y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5B-0001Kc-Du
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:11 +0100
Message-Id: <20190225152053.15976-30-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/71] block: Skip implicit nodes for filename
 info
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

bdrv_refresh_filename() should simply skip all implicit nodes.  They are
supposed to be invisible to the user, so they should not appear in
filename information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190201192935.18394-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block.c b/block.c
index d97f5e7084..31e4664a42 100644
--- a/block.c
+++ b/block.c
@@ -5549,6 +5549,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bdrv_refresh_filename(child->bs);
     }
=20
+    if (bs->implicit) {
+        /* For implicit nodes, just copy everything from the single chil=
d */
+        child =3D QLIST_FIRST(&bs->children);
+        assert(QLIST_NEXT(child, next) =3D=3D NULL);
+
+        pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+                child->bs->exact_filename);
+        pstrcpy(bs->filename, sizeof(bs->filename), child->bs->filename)=
;
+
+        bs->full_open_options =3D qobject_ref(child->bs->full_open_optio=
ns);
+
+        return;
+    }
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file =
name
          * information before refreshing it */
--=20
2.20.1
