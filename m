Received: from eggs.gnu.org ([2001:4830:134:3::10]:33159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cK-0006p7-Fc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cI-0005y1-Qc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:04 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:20 +0100
Message-Id: <20181217224348.14922-4-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 03/31] block: Skip implicit nodes for
 filename info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

bdrv_refresh_filename() should simply skip all implicit nodes.  They are
supposed to be invisible to the user, so they should not appear in
filename information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block.c b/block.c
index 6c6ccb1749..589d43e18a 100644
--- a/block.c
+++ b/block.c
@@ -5331,6 +5331,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
2.19.2
