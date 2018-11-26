Received: from eggs.gnu.org ([2001:4830:134:3::10]:40345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRFdl-0007un-Ot
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRFdk-0003ZR-RJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:05:25 -0500
References: <20181126112828.23047-1-kwolf@redhat.com>
	<20181126112828.23047-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
Date: Mon, 26 Nov 2018 13:05:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181126112828.23047-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aIPdFjsHT2Wq6qsHy6ZJ9AEzztZFBvy9S"
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] block: Don't inactivate
 children before parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aIPdFjsHT2Wq6qsHy6ZJ9AEzztZFBvy9S
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
Subject: Re: [PATCH for-3.1 1/2] block: Don't inactivate children before
 parents
References: <20181126112828.23047-1-kwolf@redhat.com>
 <20181126112828.23047-2-kwolf@redhat.com>
In-Reply-To: <20181126112828.23047-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 12:28, Kevin Wolf wrote:
> bdrv_child_cb_inactivate() asserts that parents are already inactive
> when children get inactivated. This precondition is necessary because
> parents could still issue requests in their inactivation code.
>=20
> When block nodes are created individually with -blockdev, all of them
> are monitor owned and will be returned by bdrv_next() in an undefined
> order (in practice, in the order of their creation, which is usually
> children before parents), which obviously fails the assertion.
>=20
> This patch fixes the ordering by skipping nodes with still active
> parents in bdrv_inactivate_recurse() because we know that they will be
> covered by recursion when the last active parent becomes inactive.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 5ba3435f8f..0569275e31 100644
> --- a/block.c
> +++ b/block.c
> @@ -4612,6 +4612,22 @@ void bdrv_invalidate_cache_all(Error **errp)
>      }
>  }
> =20
> +static bool bdrv_has_active_bds_parent(BlockDriverState *bs)
> +{
> +    BdrvChild *parent;
> +
> +    QLIST_FOREACH(parent, &bs->parents, next_parent) {
> +        if (parent->role->parent_is_bds) {
> +            BlockDriverState *parent_bs =3D parent->opaque;
> +            if (!(parent_bs->open_flags & BDRV_O_INACTIVE)) {
> +                return true;
> +            }
> +        }
> +    }

Now I see why you say this might make sense as a permission.

> +
> +    return false;
> +}
> +
>  static int bdrv_inactivate_recurse(BlockDriverState *bs,
>                                     bool setting_flag)
>  {
> @@ -4622,6 +4638,12 @@ static int bdrv_inactivate_recurse(BlockDriverSt=
ate *bs,
>          return -ENOMEDIUM;
>      }
> =20
> +    /* Make sure that we don't inactivate a child before its parent.
> +     * It will be covered by recursion from the yet active parent. */
> +    if (bdrv_has_active_bds_parent(bs)) {
> +        return 0;
> +    }
> +

Hm.  Wouldn't it make more sense to always return early when there are
any BDS parents?  Because if there are any BDS parents and none of them
are active (anymore), then this child will have been inactivated
already, and we can save ourselves the trouble of going through the rest
of the function again.

Do drivers support multiple calls to .bdrv_in_activate() at all?

Max

>      if (!setting_flag && bs->drv->bdrv_inactivate) {
>          ret =3D bs->drv->bdrv_inactivate(bs);
>          if (ret < 0) {
>=20



--aIPdFjsHT2Wq6qsHy6ZJ9AEzztZFBvy9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv74XIACgkQ9AfbAGHV
z0B5jAgAuQAgeSWA5fSM+tX/OIIu/P+sR3enyZ+6NkQ0eYW98gm8GLUJwZ+2H1mf
kfP3PGX1KO0kz9PCb4jmBmmauOk4M9HmcA2fJ/EeAu0ImunZ2Y7NNPCngGeS7/8Q
VjlqqYlOFepuexAteSiBa4KL1imSKYrucmA93L+tQW+FA5UEDwUg/Q8x4BIK8+Zk
kXMxAAOYy5d5Hxr/Fsa+WXGkSqNzn08iC//Ev21Jugjj1Pw0F6+jgSFcNMqSY1eo
f0T+yJDiq+uuCuIg3ARZaHMiMDK3mdgH0CO82LXC+MpllEPeRps31nUhFQE3hll3
BWKKx+q6HML8gOLZ0vf9Ejg4gYaH4A==
=lCOQ
-----END PGP SIGNATURE-----

--aIPdFjsHT2Wq6qsHy6ZJ9AEzztZFBvy9S--
