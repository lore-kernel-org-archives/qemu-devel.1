Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG8-0006PI-BW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG6-0003fq-Ma
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:44 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:40 +0000
Message-ID: <20181218075707.12006-7-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 06/10] file-posix: reset fallocate-related
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
not a bug. Fixing it makes possible to adjust supported zero flag
BDRV_REQ_ALLOCATE regardless of configuration (in the following patch).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/file-posix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d8f0b93752..a65e464cbc 100644
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
