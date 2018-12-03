Received: from eggs.gnu.org ([2001:4830:134:3::10]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFx-0002Oc-Pt
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFr-000501-Vy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:13 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 3 Dec 2018 10:14:59 +0000
Message-ID: <20181203101429.88735-8-anton.nefedov@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 7/9] block: support BDRV_REQ_ALLOCATE in
 passthrough drivers
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

Support the flag if the underlying BDS supports it

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/blkdebug.c     | 2 +-
 block/blkverify.c    | 2 +-
 block/copy-on-read.c | 4 ++--
 block/mirror.c       | 2 +-
 block/raw-format.c   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452925..f0fc2ec276 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -401,7 +401,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
         (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
-        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
             bs->file->bs->supported_zero_flags);
     ret =3D -EINVAL;
=20
diff --git a/block/blkverify.c b/block/blkverify.c
index bb52596cbb..9cb4f94b68 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -146,7 +146,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *=
options, int flags,
          bs->file->bs->supported_write_flags &
          s->test_file->bs->supported_write_flags);
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
-        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
          bs->file->bs->supported_zero_flags &
          s->test_file->bs->supported_zero_flags);
=20
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 64dcc424b5..1eb993699a 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -38,8 +38,8 @@ static int cor_open(BlockDriverState *bs, QDict *options,=
 int flags,
                                     bs->file->bs->supported_write_flags);
=20
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
-                               ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
-                                    bs->file->bs->supported_zero_flags);
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
+         bs->file->bs->supported_zero_flags);
=20
     return 0;
 }
diff --git a/block/mirror.c b/block/mirror.c
index 56908c9b19..9d836a6bd3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1531,7 +1531,7 @@ static void mirror_start_job(const char *job_id, Bloc=
kDriverState *bs,
     mirror_top_bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
         (BDRV_REQ_FUA & bs->supported_write_flags);
     mirror_top_bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
-        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP)
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE)
          & bs->supported_zero_flags);
=20
     bs_opaque =3D g_new0(MirrorBDSOpaque, 1);
diff --git a/block/raw-format.c b/block/raw-format.c
index 6f6dc99b2c..ad7453dc83 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -432,7 +432,7 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
     bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
         (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
-        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
             bs->file->bs->supported_zero_flags);
=20
     if (bs->probed && !bdrv_is_read_only(bs)) {
--=20
2.17.1
