Received: from eggs.gnu.org ([2001:4830:134:3::10]:60238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMC1h-00005G-6q
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 07:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMC1c-0004Cu-Ib
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 07:36:25 -0400
Date: Sat, 17 Jun 2017 14:36:09 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170617113609.vq3eegatdfjv3qps@postretch>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
	<1497634636-20230-26-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ty3civrrgn3cmx7m"
Content-Disposition: inline
In-Reply-To: <1497634636-20230-26-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 25/31] qed: Implement
 .bdrv_co_readv/writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com


--ty3civrrgn3cmx7m
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

On Fri, Jun 16, 2017 at 07:37:10PM +0200, Kevin Wolf wrote:
>Most of the qed code is now synchronous and matches the coroutine model.
>One notable exception is the serialisation between requests which can
>still schedule a callback. Before we can replace this with coroutine
>locks, let's convert the driver's external interfaces to the coroutine
>versions.
>
>We need to be careful to handle both requests that call the completion
>callback directly from the calling coroutine (i.e. fully synchronous
>code) and requests that involve some callback, so that we need to yield
>and wait for the completion callback coming from outside the coroutine.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> block/qed.c | 97 ++++++++++++++++++++++++++------------------------------=
-----
> 1 file changed, 42 insertions(+), 55 deletions(-)
>
>diff --git a/block/qed.c b/block/qed.c
>index e762169..a5111fd 100644
>--- a/block/qed.c
>+++ b/block/qed.c
>@@ -1322,16 +1322,32 @@ static void qed_aio_next_io(QEDAIOCB *acb)
>     }
> }
>
>-static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
>-                                 int64_t sector_num,
>-                                 QEMUIOVector *qiov, int nb_sectors,
>-                                 BlockCompletionFunc *cb,
>-                                 void *opaque, int flags)
>+typedef struct QEDRequestCo {
>+    Coroutine *co;
>+    bool done;
>+    int ret;
>+} QEDRequestCo;
>+
>+static void qed_co_request_cb(void *opaque, int ret)
> {
>-    QEDAIOCB *acb =3D qemu_aio_get(&qed_aiocb_info, bs, cb, opaque);
>+    QEDRequestCo *co =3D opaque;
>
>-    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors,
>-                        opaque, flags);
>+    co->done =3D true;
>+    co->ret =3D ret;
>+    qemu_coroutine_enter_if_inactive(co->co);
>+}
>+
>+static int coroutine_fn qed_co_request(BlockDriverState *bs, int64_t sect=
or_num,
>+                                       QEMUIOVector *qiov, int nb_sectors,
>+                                       int flags)
>+{
>+    QEDRequestCo co =3D {
>+        .co     =3D qemu_coroutine_self(),
>+        .done   =3D false,
>+    };
>+    QEDAIOCB *acb =3D qemu_aio_get(&qed_aiocb_info, bs, qed_co_request_cb=
, &co);
>+
>+    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors, &co, fla=
gs);
>
>     acb->flags =3D flags;
>     acb->qiov =3D qiov;
>@@ -1344,43 +1360,26 @@ static BlockAIOCB *qed_aio_setup(BlockDriverState =
*bs,
>
>     /* Start request */
>     qed_aio_start_io(acb);
>-    return &acb->common;
>-}
>
>-static BlockAIOCB *bdrv_qed_aio_readv(BlockDriverState *bs,
>-                                      int64_t sector_num,
>-                                      QEMUIOVector *qiov, int nb_sectors,
>-                                      BlockCompletionFunc *cb,
>-                                      void *opaque)
>-{
>-    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
>+    if (!co.done) {
>+        qemu_coroutine_yield();
>+    }
>+
>+    return co.ret;
> }
>
>-static BlockAIOCB *bdrv_qed_aio_writev(BlockDriverState *bs,
>-                                       int64_t sector_num,
>-                                       QEMUIOVector *qiov, int nb_sectors,
>-                                       BlockCompletionFunc *cb,
>-                                       void *opaque)
>+static int coroutine_fn bdrv_qed_co_readv(BlockDriverState *bs,
>+                                          int64_t sector_num, int nb_sect=
ors,
>+                                          QEMUIOVector *qiov)
> {
>-    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb,
>-                         opaque, QED_AIOCB_WRITE);
>+    return qed_co_request(bs, sector_num, qiov, nb_sectors, 0);
> }
>
>-typedef struct {
>-    Coroutine *co;
>-    int ret;
>-    bool done;
>-} QEDWriteZeroesCB;
>-
>-static void coroutine_fn qed_co_pwrite_zeroes_cb(void *opaque, int ret)
>+static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
>+                                           int64_t sector_num, int nb_sec=
tors,
>+                                           QEMUIOVector *qiov)
> {
>-    QEDWriteZeroesCB *cb =3D opaque;
>-
>-    cb->done =3D true;
>-    cb->ret =3D ret;
>-    if (cb->co) {
>-        aio_co_wake(cb->co);
>-    }
>+    return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WRI=
TE);
> }
>
> static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
>@@ -1388,9 +1387,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(Bl=
ockDriverState *bs,
>                                                   int count,
>                                                   BdrvRequestFlags flags)
> {
>-    BlockAIOCB *blockacb;
>     BDRVQEDState *s =3D bs->opaque;
>-    QEDWriteZeroesCB cb =3D { .done =3D false };
>     QEMUIOVector qiov;
>     struct iovec iov;
>
>@@ -1407,19 +1404,9 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(B=
lockDriverState *bs,
>     iov.iov_len =3D count;
>
>     qemu_iovec_init_external(&qiov, &iov, 1);
>-    blockacb =3D qed_aio_setup(bs, offset >> BDRV_SECTOR_BITS, &qiov,
>-                             count >> BDRV_SECTOR_BITS,
>-                             qed_co_pwrite_zeroes_cb, &cb,
>-                             QED_AIOCB_WRITE | QED_AIOCB_ZERO);
>-    if (!blockacb) {
>-        return -EIO;
>-    }
>-    if (!cb.done) {
>-        cb.co =3D qemu_coroutine_self();
>-        qemu_coroutine_yield();
>-    }
>-    assert(cb.done);
>-    return cb.ret;
>+    return qed_co_request(bs, offset >> BDRV_SECTOR_BITS, &qiov,
>+                          count >> BDRV_SECTOR_BITS,
>+                          QED_AIOCB_WRITE | QED_AIOCB_ZERO);
> }
>
> static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error =
**errp)
>@@ -1615,8 +1602,8 @@ static BlockDriver bdrv_qed =3D {
>     .bdrv_create              =3D bdrv_qed_create,
>     .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
>     .bdrv_co_get_block_status =3D bdrv_qed_co_get_block_status,
>-    .bdrv_aio_readv           =3D bdrv_qed_aio_readv,
>-    .bdrv_aio_writev          =3D bdrv_qed_aio_writev,
>+    .bdrv_co_readv            =3D bdrv_qed_co_readv,
>+    .bdrv_co_writev           =3D bdrv_qed_co_writev,
>     .bdrv_co_pwrite_zeroes    =3D bdrv_qed_co_pwrite_zeroes,
>     .bdrv_truncate            =3D bdrv_qed_truncate,
>     .bdrv_getlength           =3D bdrv_qed_getlength,
>--=20
>1.8.3.1
>
>
>

--ty3civrrgn3cmx7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllFFCkACgkQc2J8L2kN
9xCmihAAxAqropvsW51a5BFHcxLtXnQ3S5kQu5YrwCVfQnEsEQ4r5h6cHIJHP+Lg
pno9JuplmIRt9Zm2SUtxAQ9NA7oXg2fXKwk4vYs/QtsfWlw97taT1fvtYwI6ZJZ3
+pdrASZmuXPlu68l/KrKJ+NpVKdgccSkP/PdA454xk0wf05jtD2eh/sDKx6GNFK0
Y+vyTrpRjc+nKlFG9f3Rj1CpNtOvRjrid1HcG29LnAo1uagcfdGIPNXIO92PylBU
CIvTEXHGzvWniIeoBX7V7F70yRXa0bEDCGz28+YrR44scEqs4g8bZkzCOjNqUlSp
5fz+iPEKyaNyEDt/G5OB6HEA12dqU5HrglQCNQdCA/JUL4rJAjBTs+kbjmqWmjK3
zvgG0A08fvcwzbvwII9pe47cg3YB58dhAZblR9usrz7HTe0MpuNzVdk46lBBsZlk
ue7evj5nV/NTWh/AgNJTi2N07L+kPp9asH4T1+1L4XvIKNKnbzL/OMyvpJCaRiBb
mTleqPoLOeqF8pZsRgIZt/8sOsVUKeVsuzT9OzAEx18is56uhkItYKXmTxnbwvoi
nJebA2brnCB+GVbKC5paVQqRdgv4gI2RmIaEaEwU541ZrnYBUcjbv6E69qpChWFv
u8SwNKKmtDPWMmg5awsX+dshECxqbu0lnjMz+nDxaRTiiDk4fnk=
=E5g1
-----END PGP SIGNATURE-----

--ty3civrrgn3cmx7m--
