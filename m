Received: from eggs.gnu.org ([2001:4830:134:3::10]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqcW-0004WD-OR
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqcV-0007EO-MC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:26:36 -0400
Date: Fri, 15 Jun 2018 16:26:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615152628.GD12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] block-backend: Add blk_aio_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:04:15PM +0800, Fam Zheng wrote:

Why is a new _aio_ interface needed?  Aren't the copy_range callers
coroutines?

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 36 ++++++++++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  4 ++++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index e20a204bee..36d928e13d 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1213,6 +1213,14 @@ typedef struct BlkRwCo {
>              unsigned long int req;
>              void *buf;
>          } ioctl;
> +
> +        struct {
> +            BlockBackend *dst_blk;
> +            int64_t src_off;
> +            int64_t dst_off;
> +            int bytes;
> +            BdrvRequestFlags flags;
> +        } copy_range;
>      };
> =20
>  } BlkRwCo;
> @@ -1505,6 +1513,34 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int=
64_t offset,
>      return blk_aio_prwv(blk, &rwco, blk_aio_write_entry, cb, opaque);
>  }
> =20
> +static void blk_aio_copy_range_entry(void *opaque)
> +{
> +    BlkAioEmAIOCB *acb =3D opaque;
> +    BlkRwCo *rwco =3D &acb->rwco;
> +
> +    rwco->ret =3D blk_co_copy_range(rwco->blk, rwco->copy_range.src_off,
> +                                  rwco->copy_range.dst_blk,
> +                                  rwco->copy_range.dst_off,
> +                                  rwco->copy_range.bytes,
> +                                  rwco->copy_range.flags);
> +    blk_aio_complete(acb);
> +}
> +
> +BlockAIOCB *blk_aio_copy_range(BlockBackend *src, int64_t src_offset,
> +                               BlockBackend *dst, int64_t dst_offset,
> +                               uint64_t bytes, BdrvRequestFlags flags,
> +                               BlockCompletionFunc *cb, void *opaque)
> +{
> +    BlkRwCo rwco =3D (BlkRwCo) {
> +        .copy_range.src_off =3D src_offset,
> +        .copy_range.dst_blk =3D dst,
> +        .copy_range.dst_off =3D dst_offset,
> +        .copy_range.bytes =3D bytes,
> +        .copy_range.flags =3D flags,
> +    };
> +    return blk_aio_prwv(src, &rwco, blk_aio_copy_range_entry, cb, opaque=
);
> +}
> +
>  static void blk_aio_flush_entry(void *opaque)
>  {
>      BlkAioEmAIOCB *acb =3D opaque;
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
> index 8d03d493c2..ea121eac3f 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -147,6 +147,10 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
>                            BlockCompletionFunc *cb, void *opaque);
>  BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int byte=
s,
>                               BlockCompletionFunc *cb, void *opaque);
> +BlockAIOCB *blk_aio_copy_range(BlockBackend *src, int64_t src_offset,
> +                               BlockBackend *dst, int64_t dst_offset,
> +                               uint64_t bytes, BdrvRequestFlags flags,
> +                               BlockCompletionFunc *cb, void *opaque);
>  void blk_aio_cancel(BlockAIOCB *acb);
>  void blk_aio_cancel_async(BlockAIOCB *acb);
>  int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
> --=20
> 2.17.0
>=20

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI9qjAAoJEJykq7OBq3PIiz4IAL3vjb1utC+sjdhvuAwZxk1A
/+pW9hi4IkMIvJuNlR7X8cakwQOPbehNjTO5GGbFRDy96pQoC3Zj9gNWbR5NQOXV
zJIUH0W1EcSV5JXuas3tTHWt5Y2WpZO4mkJ5TA1bm9XLHvLFjyyElD/0lNzkWULr
3y07EHqGO9o/jz6cEMRCl5VH4EdP76a7sDmlnOGXL9FnEP0pbWX3JJJNqp17GfgF
aCGRogzUgoVeqGBLZ1GIkBR7vDpf3rF83ddUu485qjIdHrPUCJS9SZuvsiQU1L1L
N/jVjoDb24o3jpEqQ3USrbYVyU/5emLdCqC85JAqrF5sl0Ym3eAs6YkpmFUP8vU=
=rRQA
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
