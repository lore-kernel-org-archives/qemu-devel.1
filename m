Received: from eggs.gnu.org ([2001:4830:134:3::10]:47377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG3-0006Mc-PE
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG1-0003bJ-V3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:39 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:36 +0000
Message-ID: <20181218075707.12006-5-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 04/10] block: introduce BDRV_REQ_ALLOCATE
 flag
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

The flag is supposed to indicate that the region of the disk image has
to be sufficiently allocated so it reads as zeroes.

The call with the flag set must return -ENOTSUP if allocation cannot
be done efficiently.
This has to be made sure of by both
  - the drivers that support the flag
  - and the common block layer (so it will not fall back to any slowpath
    (like writing zero buffers) in case the driver does not support
    the flag).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/block/block.h     | 10 +++++++++-
 include/block/block_int.h |  3 ++-
 block/io.c                | 14 +++++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f70a843b72..643d32f4b8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -83,8 +83,16 @@ typedef enum {
      */
     BDRV_REQ_SERIALISING        =3D 0x80,
=20
+    /*
+     * The BDRV_REQ_ALLOCATE flag is used to indicate that the driver has =
to
+     * efficiently allocate the space so it reads as zeroes, or return an =
error.
+     * If this flag is set then BDRV_REQ_ZERO_WRITE must also be set.
+     * This flag cannot be set together with BDRV_REQ_MAY_UNMAP.
+     */
+    BDRV_REQ_ALLOCATE           =3D 0x100,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               =3D 0xff,
+    BDRV_REQ_MASK               =3D 0x1ff,
 } BdrvRequestFlags;
=20
 typedef struct BlockSizes {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..833129d912 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -724,7 +724,8 @@ struct BlockDriverState {
      * their children. */
     unsigned int supported_write_flags;
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
-     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_WRITE_UNCHANGED) */
+     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_WRITE_UNCHANGED, BDRV_REQ_ALLOCATE)
+     */
     unsigned int supported_zero_flags;
=20
     /* the following member gives a name to every node on the bs graph. */
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..66006a089d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1534,7 +1534,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
=20
-        if (ret =3D=3D -ENOTSUP) {
+        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
             /* Fall back to bounce buffer if write zeroes is unsupported *=
/
             BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WRITE;
=20
@@ -1773,6 +1773,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvC=
hild *child,
=20
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
+        if (flags & BDRV_REQ_ALLOCATE) {
+            return -ENOTSUP;
+        }
         buf =3D qemu_blockalign(bs, align);
         iov =3D (struct iovec) {
             .iov_base   =3D buf,
@@ -1858,6 +1861,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     bool use_local_qiov =3D false;
     int ret;
=20
+    assert(!((flags & BDRV_REQ_ALLOCATE) && (flags & BDRV_REQ_MAY_UNMAP)))=
;
+    assert(!((flags & BDRV_REQ_ALLOCATE) && !(flags & BDRV_REQ_ZERO_WRITE)=
));
+
     trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
=20
     if (!bs->drv) {
@@ -1980,6 +1986,12 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *ch=
ild, int64_t offset,
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
=20
+    if ((flags & BDRV_REQ_ALLOCATE) &&
+        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
+    {
+        return -ENOTSUP;
+    }
+
     if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
         flags &=3D ~BDRV_REQ_MAY_UNMAP;
     }
--=20
2.17.1
