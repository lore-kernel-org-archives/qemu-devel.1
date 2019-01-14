Received: from eggs.gnu.org ([209.51.188.92]:37538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj0Ge-0000YO-Dp
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj0Gc-0001De-6t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:18:56 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 14 Jan 2019 11:18:28 +0000
Message-ID: <20190114111744.113188-8-anton.nefedov@virtuozzo.com>
References: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v12 07/10] file-posix: support BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Current write_zeroes implementation is good enough to satisfy this flag too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8d3ec96627..dac218ec7f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -607,6 +607,7 @@ static int raw_open_common(BlockDriverState *bs, QDict =
*options,
         } else {
             s->discard_zeroes =3D true;
             s->has_fallocate =3D true;
+            bs->supported_zero_flags =3D BDRV_REQ_ALLOCATE;
         }
     } else {
         if (!(S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode))) {
@@ -650,10 +651,11 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
 #ifdef CONFIG_XFS
     if (platform_test_xfs_fd(s->fd)) {
         s->is_xfs =3D true;
+        bs->supported_zero_flags =3D BDRV_REQ_ALLOCATE;
     }
 #endif
=20
-    bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP;
+    bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
     ret =3D 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
@@ -1552,6 +1554,10 @@ static int handle_aiocb_write_zeroes(void *opaque)
     s->has_fallocate =3D false;
 #endif
=20
+    if (!s->has_fallocate) {
+        aiocb->bs->supported_zero_flags &=3D ~BDRV_REQ_ALLOCATE;
+    }
+
     return -ENOTSUP;
 }
=20
--=20
2.17.1
