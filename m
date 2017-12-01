Received: from eggs.gnu.org ([2001:4830:134:3::10]:39793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eKp5J-0000V0-LB
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eKp5I-0004yU-8X
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:26:45 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Deepa Srinivasan <deepa.srinivasan@oracle.com>
In-Reply-To: <1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
Date: Fri, 1 Dec 2017 09:27:09 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <29EF0C0C-64D0-4440-A8FF-99079E7D4703@oracle.com>
References: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
	<1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mark.kanda@oracle.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Kevin, Paolo, Stefan,

Are there any further comments on this patch? Can this patch be =
committed?

Thanks
Deepa

> On Nov 23, 2017, at 8:55 AM, Deepa Srinivasan =
<deepa.srinivasan@oracle.com> wrote:
>=20
> Starting qemu with the following arguments causes qemu to segfault:
> ... -device lsi,id=3Dlsi0 -drive =
file=3Discsi:<...>,format=3Draw,if=3Dnone,node-name=3D
> iscsi1 -device scsi-block,bus=3Dlsi0.0,id=3D<...>,drive=3Discsi1
>=20
> This patch fixes blk_aio_ioctl() so it does not pass stack addresses =
to
> blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() =
returns. More
> details about the bug follow.
>=20
> blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
> coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
>=20
> When blk_aio_ioctl() is executed from within a coroutine context (e.g.
> iscsi_bh_cb()), aio_co_enter() adds the coroutine =
(blk_aio_ioctl_entry) to
> the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
>=20
> When blk_aio_ioctl_entry() executes later, it accesses an invalid =
pointer:
> ....
>    BlkRwCo *rwco =3D &acb->rwco;
>=20
>    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
>                             rwco->qiov->iov[0].iov_base);  <--- qiov =
is
>                                                                 =
invalid here
> ...
>=20
> In the case when blk_aio_ioctl() is called from a non-coroutine =
context,
> blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() =
calls
> qemu_coroutine_yield(), blk_aio_ioctl() will return. When the =
coroutine
> execution is complete, control returns to blk_aio_ioctl_entry() after =
the call
> to blk_co_ioctl(). There is no invalid reference after this point, but =
the
> function is still holding on to invalid pointers.
>=20
> The fix is to change blk_aio_prwv() to accept a void pointer for the =
IO buffer
> rather than a QEMUIOVector. blk_aio_prwv() passes this through in =
BlkRwCo and the
> coroutine function casts it to QEMUIOVector or uses the void pointer =
directly.
>=20
> Signed-off-by: Deepa Srinivasan <deepa.srinivasan@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> ---
> block/block-backend.c | 51 =
+++++++++++++++++++++++++--------------------------
> 1 file changed, 25 insertions(+), 26 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index baef8e7..2d0d9b6 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1140,7 +1140,7 @@ int coroutine_fn blk_co_pwritev(BlockBackend =
*blk, int64_t offset,
> typedef struct BlkRwCo {
>     BlockBackend *blk;
>     int64_t offset;
> -    QEMUIOVector *qiov;
> +    void *iobuf;
>     int ret;
>     BdrvRequestFlags flags;
> } BlkRwCo;
> @@ -1148,17 +1148,19 @@ typedef struct BlkRwCo {
> static void blk_read_entry(void *opaque)
> {
>     BlkRwCo *rwco =3D opaque;
> +    QEMUIOVector *qiov =3D rwco->iobuf;
>=20
> -    rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, =
rwco->qiov->size,
> -                              rwco->qiov, rwco->flags);
> +    rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
> +                              qiov, rwco->flags);
> }
>=20
> static void blk_write_entry(void *opaque)
> {
>     BlkRwCo *rwco =3D opaque;
> +    QEMUIOVector *qiov =3D rwco->iobuf;
>=20
> -    rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, =
rwco->qiov->size,
> -                               rwco->qiov, rwco->flags);
> +    rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
> +                               qiov, rwco->flags);
> }
>=20
> static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
> @@ -1178,7 +1180,7 @@ static int blk_prw(BlockBackend *blk, int64_t =
offset, uint8_t *buf,
>     rwco =3D (BlkRwCo) {
>         .blk    =3D blk,
>         .offset =3D offset,
> -        .qiov   =3D &qiov,
> +        .iobuf  =3D &qiov,
>         .flags  =3D flags,
>         .ret    =3D NOT_DONE,
>     };
> @@ -1275,7 +1277,7 @@ static void blk_aio_complete_bh(void *opaque)
> }
>=20
> static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int =
bytes,
> -                                QEMUIOVector *qiov, CoroutineEntry =
co_entry,
> +                                void *iobuf, CoroutineEntry co_entry,
>                                 BdrvRequestFlags flags,
>                                 BlockCompletionFunc *cb, void *opaque)
> {
> @@ -1287,7 +1289,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend =
*blk, int64_t offset, int bytes,
>     acb->rwco =3D (BlkRwCo) {
>         .blk    =3D blk,
>         .offset =3D offset,
> -        .qiov   =3D qiov,
> +        .iobuf  =3D iobuf,
>         .flags  =3D flags,
>         .ret    =3D NOT_DONE,
>     };
> @@ -1310,10 +1312,11 @@ static void blk_aio_read_entry(void *opaque)
> {
>     BlkAioEmAIOCB *acb =3D opaque;
>     BlkRwCo *rwco =3D &acb->rwco;
> +    QEMUIOVector *qiov =3D rwco->iobuf;
>=20
> -    assert(rwco->qiov->size =3D=3D acb->bytes);
> +    assert(qiov->size =3D=3D acb->bytes);
>     rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
> -                              rwco->qiov, rwco->flags);
> +                              qiov, rwco->flags);
>     blk_aio_complete(acb);
> }
>=20
> @@ -1321,10 +1324,11 @@ static void blk_aio_write_entry(void *opaque)
> {
>     BlkAioEmAIOCB *acb =3D opaque;
>     BlkRwCo *rwco =3D &acb->rwco;
> +    QEMUIOVector *qiov =3D rwco->iobuf;
>=20
> -    assert(!rwco->qiov || rwco->qiov->size =3D=3D acb->bytes);
> +    assert(!qiov || qiov->size =3D=3D acb->bytes);
>     rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, acb->bytes,
> -                               rwco->qiov, rwco->flags);
> +                               qiov, rwco->flags);
>     blk_aio_complete(acb);
> }
>=20
> @@ -1453,8 +1457,10 @@ int blk_co_ioctl(BlockBackend *blk, unsigned =
long int req, void *buf)
> static void blk_ioctl_entry(void *opaque)
> {
>     BlkRwCo *rwco =3D opaque;
> +    QEMUIOVector *qiov =3D rwco->iobuf;
> +
>     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
> -                             rwco->qiov->iov[0].iov_base);
> +                             qiov->iov[0].iov_base);
> }
>=20
> int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
> @@ -1467,24 +1473,15 @@ static void blk_aio_ioctl_entry(void *opaque)
>     BlkAioEmAIOCB *acb =3D opaque;
>     BlkRwCo *rwco =3D &acb->rwco;
>=20
> -    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
> -                             rwco->qiov->iov[0].iov_base);
> +    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
> +
>     blk_aio_complete(acb);
> }
>=20
> BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, =
void *buf,
>                           BlockCompletionFunc *cb, void *opaque)
> {
> -    QEMUIOVector qiov;
> -    struct iovec iov;
> -
> -    iov =3D (struct iovec) {
> -        .iov_base =3D buf,
> -        .iov_len =3D 0,
> -    };
> -    qemu_iovec_init_external(&qiov, &iov, 1);
> -
> -    return blk_aio_prwv(blk, req, 0, &qiov, blk_aio_ioctl_entry, 0, =
cb, opaque);
> +    return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, =
opaque);
> }
>=20
> int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
> @@ -1900,7 +1897,9 @@ int blk_truncate(BlockBackend *blk, int64_t =
offset, PreallocMode prealloc,
> static void blk_pdiscard_entry(void *opaque)
> {
>     BlkRwCo *rwco =3D opaque;
> -    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, =
rwco->qiov->size);
> +    QEMUIOVector *qiov =3D rwco->iobuf;
> +
> +    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, =
qiov->size);
> }
>=20
> int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
> --=20
> 2.7.4
>=20
>=20
