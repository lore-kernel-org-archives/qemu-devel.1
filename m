Received: from eggs.gnu.org ([2001:4830:134:3::10]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG0-0006Ih-Hk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAFz-0003Y0-6A
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:36 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:32 +0000
Message-ID: <20181218075707.12006-3-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 02/10] blkverify: set supported write/zero
 flags
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/blkverify.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index 89bf4386e3..bb52596cbb 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -141,8 +141,14 @@ static int blkverify_open(BlockDriverState *bs, QDict =
*options, int flags,
         goto fail;
     }
=20
-    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED;
-    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED;
+    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA &
+         bs->file->bs->supported_write_flags &
+         s->test_file->bs->supported_write_flags);
+    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+         bs->file->bs->supported_zero_flags &
+         s->test_file->bs->supported_zero_flags);
=20
     ret =3D 0;
 fail:
--=20
2.17.1
