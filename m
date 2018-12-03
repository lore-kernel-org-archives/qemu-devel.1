Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFr-0002IT-Vi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFm-0004uI-5j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:07 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 3 Dec 2018 10:14:53 +0000
Message-ID: <20181203101429.88735-2-anton.nefedov@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 1/9] mirror: inherit supported write/zero
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
---
 block/mirror.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..56908c9b19 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1528,8 +1528,12 @@ static void mirror_start_job(const char *job_id, Blo=
ckDriverState *bs,
         mirror_top_bs->implicit =3D true;
     }
     mirror_top_bs->total_sectors =3D bs->total_sectors;
-    mirror_top_bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED;
-    mirror_top_bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED;
+    mirror_top_bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->supported_write_flags);
+    mirror_top_bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP)
+         & bs->supported_zero_flags);
+
     bs_opaque =3D g_new0(MirrorBDSOpaque, 1);
     mirror_top_bs->opaque =3D bs_opaque;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
--=20
2.17.1
