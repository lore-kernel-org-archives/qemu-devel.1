Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqDa-0006zS-AZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqDU-0005GK-8t
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:00:50 -0400
Date: Fri, 15 Jun 2018 16:00:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615150034.GB12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] block: Check if block drivers can do
 copy offloading
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:04:13PM +0800, Fam Zheng wrote:
> This avoids the wasteful cluster allocation in qcow2 before actually
> trying an unsupported copy range call, for example.

I don't understand how this function can work.  dst is never traversed
so does it always return false?

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c                   | 12 ++++++++++++
>  block/file-posix.c        |  9 +++++++++
>  block/io.c                |  3 +++
>  block/iscsi.c             |  8 ++++++++
>  block/qcow2.c             | 11 +++++++++++
>  block/raw-format.c        |  6 ++++++
>  include/block/block_int.h |  4 ++++
>  7 files changed, 53 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 501b64c819..28aa8d8a65 100644
> --- a/block.c
> +++ b/block.c
> @@ -5320,3 +5320,15 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverSt=
ate *bs, const char *name,
> =20
>      return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
>  }
> +
> +bool bdrv_can_copy_range(BdrvChild *src, BdrvChild *dst)
> +{
> +    BlockDriverState *bs;
> +
> +    if (!src || !src->bs) {
> +        return false;
> +    }

src checked but not dst.  Does this mean src can be NULL but dst cannot
be NULL, and why?

> +    bs =3D src->bs;
> +    return bs && bs->drv && bs->drv->bdrv_can_copy_range &&

src->bs was already checked, so bs !=3D NULL here and doesn't need a check.

> +static bool qcow2_can_copy_range(BlockDriverState *bs, BdrvChild *dst)
> +{
> +    bool r =3D bdrv_can_copy_range(bs->file, dst);
> +
> +    if (bs->backing) {
> +        r =3D r && bdrv_can_copy_range(bs->backing, dst);
> +    }
> +    return r;
> +}

This is too conservative.  It assumes every range includes clusters from
both bs->file and bs->backing, which is not true.

An || instead of && would return false positives in some cases, which
defeats the bdrv_can_copy_range() optimization, but at least allows
copy-offloading in all cases where it could be done.

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 888b7f7bff..2c51cd420f 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -235,6 +235,9 @@ struct BlockDriver {
>                                                uint64_t bytes,
>                                                BdrvRequestFlags flags);
> =20
> +    bool (*bdrv_can_copy_range)(BlockDriverState *bs,
> +                                BdrvChild *dst);
> +
>      /*
>       * Building block for bdrv_block_status[_above] and
>       * bdrv_is_allocated[_above].  The driver should answer only
> @@ -1139,5 +1142,6 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild =
*src, uint64_t src_offset,
>  int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offs=
et,
>                                         BdrvChild *dst, uint64_t dst_offs=
et,
>                                         uint64_t bytes, BdrvRequestFlags =
flags);
> +bool bdrv_can_copy_range(BdrvChild *src, BdrvChild *dst);

Please document this API and .bdrv_can_copy_range().

Please don't make me remind you.  Eventually I'll forget too.

An important point for the doc comments:

  This function is a lightweight check that avoids expensive operations
  performed by a full bdrv_co_copy_range() call.  This function may
  produce false positives.  It is still possible for
  bdrv_co_copy_range() to return -ENOTSUP after bdrv_can_copy_range()
  has returned true.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI9SSAAoJEJykq7OBq3PIUwcIAMo75IXTgojLQFFQTO/suVDI
0y1ZOq5uYKZZNiiRZx/lv2S5atyMg5B0V4iCvgOL4bjy8sBCeHyENtogTw2nZO5J
wCqncaQ5Jr/1BP+P/t4vyTfVkV8zEaTAZWpNvwP+FZde0x9bkkaQJ00EVTIF5X07
9z3/OLL4LUTmoOBmbgplTBgxpPY625eZN0gvYjTlJFZk/ry5fXPFpcf8yHzBXhyz
RLRJWcfvOcWmunboEuZNhEUqFxGaWkwWlfm3JqK8GAq6371B3QWA8ScFeYrnB6Nk
9yQKzSMsTldf5eHirxqy9/TunDDS/CZje1ra+L4WGKgXx0Pb08B0luQ28K5y6O4=
=ddxG
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
