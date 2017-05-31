Received: from eggs.gnu.org ([2001:4830:134:3::10]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG33t-0007AK-US
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG33s-0007EJ-Ja
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:49:18 -0400
Date: Wed, 31 May 2017 13:49:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124908.GZ16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-26-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w5er4h4/Yf2qR8D9"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-26-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 25/29] qed: Implement
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
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--w5er4h4/Yf2qR8D9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:06PM +0200, Kevin Wolf wrote:
> Most of the qed code is now synchronous and matches the coroutine model.
> One notable exception is the serialisation between requests which can
> still schedule a callback. Before we can replace this with coroutine
> locks, let's convert the driver's external interfaces to the coroutine
> versions.
>=20
> We need to be careful to handle both requests that call the completion
> callback directly from the calling coroutine (i.e. fully synchronous
> code) and requests that involve some callback, so that we need to yield
> and wait for the completion callback coming from outside the coroutine.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 94 +++++++++++++++++++++++++------------------------------=
------
>  1 file changed, 39 insertions(+), 55 deletions(-)
>=20
> diff --git a/block/qed.c b/block/qed.c
> index 6a83df2..29c3dc5 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -1326,16 +1326,31 @@ static void qed_aio_next_io(QEDAIOCB *acb)
>      }
>  }
> =20
> -static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
> -                                 int64_t sector_num,
> -                                 QEMUIOVector *qiov, int nb_sectors,
> -                                 BlockCompletionFunc *cb,
> -                                 void *opaque, int flags)
> +typedef struct QEDRequestCo {
> +    Coroutine *co;
> +    bool done;
> +    int ret;
> +} QEDRequestCo;
> +
> +static void coroutine_fn qed_co_request_cb(void *opaque, int ret)
> +{
> +    QEDRequestCo *co =3D opaque;
> +
> +    co->done =3D true;
> +    co->ret =3D ret;
> +    qemu_coroutine_enter_if_inactive(co->co);
> +}
> +
> +static int qed_co_request(BlockDriverState *bs, int64_t sector_num,
> +                          QEMUIOVector *qiov, int nb_sectors, int flags)

Missing coroutine_fn.

>  {
> -    QEDAIOCB *acb =3D qemu_aio_get(&qed_aiocb_info, bs, cb, opaque);
> +    QEDRequestCo co =3D {
> +        .co     =3D qemu_coroutine_self(),
> +        .done   =3D false,
> +    };
> +    QEDAIOCB *acb =3D qemu_aio_get(&qed_aiocb_info, bs, qed_co_request_c=
b, &co);
> =20
> -    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors,
> -                        opaque, flags);
> +    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors, &co, fl=
ags);
> =20
>      acb->flags =3D flags;
>      acb->qiov =3D qiov;
> @@ -1348,43 +1363,24 @@ static BlockAIOCB *qed_aio_setup(BlockDriverState=
 *bs,
> =20
>      /* Start request */
>      qed_aio_start_io(acb);
> -    return &acb->common;
> -}
> =20
> -static BlockAIOCB *bdrv_qed_aio_readv(BlockDriverState *bs,
> -                                      int64_t sector_num,
> -                                      QEMUIOVector *qiov, int nb_sectors,
> -                                      BlockCompletionFunc *cb,
> -                                      void *opaque)
> -{
> -    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb, opaque, 0=
);
> +    if (!co.done) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    return co.ret;
>  }
> =20
> -static BlockAIOCB *bdrv_qed_aio_writev(BlockDriverState *bs,
> -                                       int64_t sector_num,
> -                                       QEMUIOVector *qiov, int nb_sector=
s,
> -                                       BlockCompletionFunc *cb,
> -                                       void *opaque)
> +static int bdrv_qed_co_readv(BlockDriverState *bs, int64_t sector_num,
> +                             int nb_sectors, QEMUIOVector *qiov)

Missing coroutine_fn.  More below.

>  {
> -    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb,
> -                         opaque, QED_AIOCB_WRITE);
> +    return qed_co_request(bs, sector_num, qiov, nb_sectors, 0);
>  }
> =20
> -typedef struct {
> -    Coroutine *co;
> -    int ret;
> -    bool done;
> -} QEDWriteZeroesCB;
> -
> -static void coroutine_fn qed_co_pwrite_zeroes_cb(void *opaque, int ret)
> +static int bdrv_qed_co_writev(BlockDriverState *bs, int64_t sector_num,
> +                                      int nb_sectors, QEMUIOVector *qiov)
>  {
> -    QEDWriteZeroesCB *cb =3D opaque;
> -
> -    cb->done =3D true;
> -    cb->ret =3D ret;
> -    if (cb->co) {
> -        aio_co_wake(cb->co);
> -    }
> +    return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WR=
ITE);
>  }
> =20
>  static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
> @@ -1392,9 +1388,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(B=
lockDriverState *bs,
>                                                    int count,
>                                                    BdrvRequestFlags flags)
>  {
> -    BlockAIOCB *blockacb;
>      BDRVQEDState *s =3D bs->opaque;
> -    QEDWriteZeroesCB cb =3D { .done =3D false };
>      QEMUIOVector qiov;
>      struct iovec iov;
> =20
> @@ -1411,19 +1405,9 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(=
BlockDriverState *bs,
>      iov.iov_len =3D count;
> =20
>      qemu_iovec_init_external(&qiov, &iov, 1);
> -    blockacb =3D qed_aio_setup(bs, offset >> BDRV_SECTOR_BITS, &qiov,
> -                             count >> BDRV_SECTOR_BITS,
> -                             qed_co_pwrite_zeroes_cb, &cb,
> -                             QED_AIOCB_WRITE | QED_AIOCB_ZERO);
> -    if (!blockacb) {
> -        return -EIO;
> -    }
> -    if (!cb.done) {
> -        cb.co =3D qemu_coroutine_self();
> -        qemu_coroutine_yield();
> -    }
> -    assert(cb.done);
> -    return cb.ret;
> +    return qed_co_request(bs, offset >> BDRV_SECTOR_BITS, &qiov,
> +                          count >> BDRV_SECTOR_BITS,
> +                          QED_AIOCB_WRITE | QED_AIOCB_ZERO);
>  }
> =20
>  static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error=
 **errp)
> @@ -1619,8 +1603,8 @@ static BlockDriver bdrv_qed =3D {
>      .bdrv_create              =3D bdrv_qed_create,
>      .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
>      .bdrv_co_get_block_status =3D bdrv_qed_co_get_block_status,
> -    .bdrv_aio_readv           =3D bdrv_qed_aio_readv,
> -    .bdrv_aio_writev          =3D bdrv_qed_aio_writev,
> +    .bdrv_co_readv            =3D bdrv_qed_co_readv,
> +    .bdrv_co_writev           =3D bdrv_qed_co_writev,
>      .bdrv_co_pwrite_zeroes    =3D bdrv_qed_co_pwrite_zeroes,
>      .bdrv_truncate            =3D bdrv_qed_truncate,
>      .bdrv_getlength           =3D bdrv_qed_getlength,
> --=20
> 1.8.3.1
>=20
>=20

--w5er4h4/Yf2qR8D9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrvEAAoJEJykq7OBq3PIxhkH/11rEyZJSa70Ir5FWEtuTZKr
ZoCCeFs78eXB/zODiMQQXo4Q/Aaud1Bzubq5NXbnF6Ttn4g3Z152kNyZJxB8IfD4
5XcHAVGw0nupWCGOAe1aJdyyTzI9N35ewDiN70IzsRJDq4MMFhN+PmOWzNkJQjfd
KvxqNb2GpLWym7+wZZJl5N3xdp3D+GFVCFWO8kptqY8kHqm1v305q6XTiy9ytyPG
NSuvCCAreMfgpfeR4pBjzu9YAQI/AgMIitVm09YFGctpRB72oHyJeWADg/C0g5Kx
hWpPTIkPFhM2pDBXrkbHwjGK3/Dw3YIUohczeARfiC5PTGrmf5LOTGVpRhWb9Lo=
=9Rtt
-----END PGP SIGNATURE-----

--w5er4h4/Yf2qR8D9--
