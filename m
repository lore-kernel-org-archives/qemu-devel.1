Received: from eggs.gnu.org ([209.51.188.92]:37481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj0Gd-0000Wo-Ct
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gj0Gb-0001C3-9n
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:18:55 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 14 Jan 2019 11:18:27 +0000
Message-ID: <20190114111744.113188-7-anton.nefedov@virtuozzo.com>
References: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v12 06/10] file-posix: reset fallocate-related
 flags without CONFIG_FALLOCATE*
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

these flags currently affect nothing without CONFIG_FALLOCATE*, so it's
not a bug, but fixing it makes possible to adjust supported zero flag
BDRV_REQ_ALLOCATE regardless of configuration.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8aee7a3fb8..8d3ec96627 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1488,9 +1488,7 @@ static ssize_t handle_aiocb_write_zeroes_block(RawPos=
ixAIOData *aiocb)
 static int handle_aiocb_write_zeroes(void *opaque)
 {
     RawPosixAIOData *aiocb =3D opaque;
-#if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
     BDRVRawState *s =3D aiocb->bs->opaque;
-#endif
 #ifdef CONFIG_FALLOCATE
     int64_t len;
 #endif
@@ -1514,6 +1512,8 @@ static int handle_aiocb_write_zeroes(void *opaque)
         }
         s->has_write_zeroes =3D false;
     }
+#else
+    s->has_write_zeroes =3D false;
 #endif
=20
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1533,6 +1533,8 @@ static int handle_aiocb_write_zeroes(void *opaque)
             s->has_discard =3D false;
         }
     }
+#else
+    s->has_discard =3D false;
 #endif
=20
 #ifdef CONFIG_FALLOCATE
@@ -1546,6 +1548,8 @@ static int handle_aiocb_write_zeroes(void *opaque)
         }
         s->has_fallocate =3D false;
     }
+#else
+    s->has_fallocate =3D false;
 #endif
=20
     return -ENOTSUP;
--=20
2.17.1
