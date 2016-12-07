Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEh3D-00040m-L3
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEh3C-0004cZ-M5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:34:43 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bf580075-64f6-3e87-1787-8b2aae884424@redhat.com>
Date: Wed, 7 Dec 2016 19:34:31 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0agecLpfEecxg2O9CEdOfLaw8cKqpcdPQ"
Subject: Re: [Qemu-devel] [PATCH 08/21] block: introduce auto-loading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0agecLpfEecxg2O9CEdOfLaw8cKqpcdPQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <bf580075-64f6-3e87-1787-8b2aae884424@redhat.com>
Subject: Re: [PATCH 08/21] block: introduce auto-loading bitmaps
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps store in the disk image, which should

s/store/stored/

> be loaded when the image is opened and become BdrvDirtyBitmaps for the
> corresponding drive.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 14 ++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  3 +++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 39ddea3..450379c 100644
> --- a/block.c
> +++ b/block.c
> @@ -1137,6 +1137,13 @@ static int bdrv_open_common(BlockDriverState *bs=
, BdrvChild *file,
>          goto free_and_fail;
>      }
> =20
> +    bdrv_load_autoloading_dirty_bitmaps(bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +        goto free_and_fail;
> +    }
> +
>      assert(bdrv_opt_mem_align(bs) !=3D 0);
>      assert(bdrv_min_mem_align(bs) !=3D 0);
>      assert(is_power_of_2(bs->bl.request_alignment));

These asserts should stay directly after the bdrv_refresh_limits() block
(i.e. the bdrv_load_autoloading_dirty_bitmaps() call should be moved
here, after them).

The rest looks good.

Max

> @@ -4093,3 +4100,10 @@ void bdrv_del_child(BlockDriverState *parent_bs,=
 BdrvChild *child, Error **errp)
> =20
>      parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
>  }
> +
> +void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error *=
*errp)
> +{
> +    if (bs->drv && bs->drv->bdrv_load_autoloading_dirty_bitmaps) {
> +        bs->drv->bdrv_load_autoloading_dirty_bitmaps(bs, errp);
> +    }
> +}
> diff --git a/include/block/block.h b/include/block/block.h
> index 49bb0b2..f701da2 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -552,4 +552,6 @@ void bdrv_add_child(BlockDriverState *parent, Block=
DriverState *child,
>                      Error **errp);
>  void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error =
**errp);
> =20
> +void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error *=
*errp);
> +
>  #endif
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 83a423c..ca955f0 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -320,6 +320,9 @@ struct BlockDriver {
>      void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,=

>                             Error **errp);
> =20
> +    void (*bdrv_load_autoloading_dirty_bitmaps)(BlockDriverState *bs,
> +                                                Error **errp);
> +
>      QLIST_ENTRY(BlockDriver) list;
>  };
> =20
>=20



--0agecLpfEecxg2O9CEdOfLaw8cKqpcdPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhIVjgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+pgH/3eufdAA20y/T1Dh2Bu/eEnNMcysDNAE
n4CBsqCn2vdjTbSwDZPn+rhRbqm+uimu1YZcVyqKQjaqgaS8k3bddz5Iyn6R2HzV
JQokihQqsFYZKPphcMKnEz9RVcDy/AO/BW3ESrJmyRxm6bdoZU0CUs6aCSXl4jq2
bBpCUgAZvQl1EJEV5safMLoJKh97SIeB1E9xyuLXN4VM9De9wvPRkOhPFQ5/YyUm
pdhv7zlAEQ5iqYGN5Dr52n3were+L+Vnf9fGkllfDxW4Uwk4ujrJ7HX6GNkMBNiy
5PccQaX8dhgk1xu3qbiek518nK0HfVGOpJXBBvy3gDLDlxh6cdrTwr0=
=Y3/A
-----END PGP SIGNATURE-----

--0agecLpfEecxg2O9CEdOfLaw8cKqpcdPQ--
