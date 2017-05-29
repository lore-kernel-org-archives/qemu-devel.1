Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOd4-00067z-Bx
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOd3-0002qv-II
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:54 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-25-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0a0f5aec-7e64-5b07-d731-00bcf5c24cf6@redhat.com>
Date: Mon, 29 May 2017 19:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-25-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CI2O82OkEBBgONbc3Cwb2hrrOMU9RNCcs"
Subject: Re: [Qemu-devel] [PATCH 24/25] qmp: block-dirty-bitmap-remove:
 remove persistent
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
--CI2O82OkEBBgONbc3Cwb2hrrOMU9RNCcs
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <0a0f5aec-7e64-5b07-d731-00bcf5c24cf6@redhat.com>
Subject: Re: [PATCH 24/25] qmp: block-dirty-bitmap-remove: remove persistent
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-25-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-25-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Remove persistent bitmap from the storage on block-dirty-bitmap-remove.=

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           | 10 ++++++++++
>  qapi/block-core.json |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index c49d414891..0ad1a658b9 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2802,6 +2802,7 @@ void qmp_block_dirty_bitmap_remove(const char *no=
de, const char *name,
>      AioContext *aio_context;
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> +    Error *local_err =3D NULL;
> =20
>      bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, &aio_context=
, errp);
>      if (!bitmap || !bs) {
> @@ -2814,6 +2815,15 @@ void qmp_block_dirty_bitmap_remove(const char *n=
ode, const char *name,
>                     name);
>          goto out;
>      }
> +
> +    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> +        if (local_err !=3D NULL) {
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +    }
> +
>      bdrv_dirty_bitmap_make_anon(bitmap);
>      bdrv_release_dirty_bitmap(bs, bitmap);
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index e9523b4b8c..933b1a5fe5 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1600,7 +1600,8 @@
>  # @block-dirty-bitmap-remove:
>  #
>  # Stop write tracking and remove the dirty bitmap that was created
> -# with block-dirty-bitmap-add.
> +# with block-dirty-bitmap-add. If bitmap is persistent, remove it from=
 it's

s/If bitmap/If the bitmap/, s/it's/its/

Max

> +# storage too.
>  #
>  # Returns: nothing on success
>  #          If @node is not a valid block device or node, DeviceNotFoun=
d
>=20



--CI2O82OkEBBgONbc3Cwb2hrrOMU9RNCcs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLFycEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLbf
B/95kkQ5HpepzioCrEq7In/kASzFcvas4Zy/DBPxX3mlQhkoWfCrjGcHVvca3Trt
5ETYZX4/2oLR5NRkYyaScjBtVLBdl1KQgE0CbOOsti0Vqi1FLQQ/8U6UH1O3I1kG
r8X/+tr/ViPCPy9rOQexVozKfE/u7KVoz3nAdIHN5efKtw1bMAhuxNFpyQE+EwTS
CrAkdsmdqFZfEXTTh7yzQ9MJfKqmWq/xPuG7g01IpBAOGaGUPqJwQW5JvCo8qJM5
sizPuk4gRENGQxgt6sOBLxqgdu8VDSNw7KNOa7AjMjtDnHUDvXjznXy96OlbqHvi
EB6e0QJ3oKnjX99r3/4hlwws
=L/tR
-----END PGP SIGNATURE-----

--CI2O82OkEBBgONbc3Cwb2hrrOMU9RNCcs--
