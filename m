Received: from eggs.gnu.org ([2001:4830:134:3::10]:50199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce37P-0005e4-Ld
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce37O-0006Vi-JD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:11:51 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-10-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
Date: Wed, 15 Feb 2017 18:11:41 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-10-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NkvwbqmfdcaPxV09gLplRwtIeDapTIwdw"
Subject: Re: [Qemu-devel] [RFC PATCH 09/41] block: Default
 .bdrv_child_perm() for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NkvwbqmfdcaPxV09gLplRwtIeDapTIwdw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
Subject: Re: [RFC PATCH 09/41] block: Default .bdrv_child_perm() for format
 drivers
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-10-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Almost all format drivers have the same characteristics as far as
> permissions are concerned: They have one or more children for storing
> their own data and, more importantly, metadata (can be written to and
> grow even without external write requests, must be protected against
> other writers and present consistent data) and optionally a backing fil=
e
> (this is just data, so like for a filter, it only depends on what the
> parent nodes need).
>=20
> This provides a default implementation that can be shared by most of
> our format drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 37 +++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 290768d..8e99bb5 100644
> --- a/block.c
> +++ b/block.c
> @@ -1459,6 +1459,43 @@ void bdrv_filter_default_perms(BlockDriverState =
*bs, BdrvChild *c,
>                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
>  }
> =20
> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared)
> +{
> +    bool backing =3D (role =3D=3D &child_backing);
> +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
> +
> +    if (!backing) {
> +        /* Apart from the modifications below, the same permissions ar=
e
> +         * forwarded and left alone as for filters */
> +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &s=
hared);
> +
> +        /* Format drivers may touch metadata even if the guest doesn't=
 write */
> +        if (!bdrv_is_read_only(bs)) {
> +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> +        }
> +
> +        /* bs->file always needs to be consistent because of the metad=
ata. We
> +         * can never allow other users to resize or write to it. */
> +        perm |=3D BLK_PERM_CONSISTENT_READ;
> +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> +    } else {
> +        /* We want consistent read from backing files if the parent ne=
eds it.
> +         * No other operations are performed on backing files. */
> +        perm &=3D BLK_PERM_CONSISTENT_READ;
> +
> +        /* If the parent can deal with changing data, we're okay with =
a
> +         * writable backing file. */

Are we OK with a resizable backing file, too? I'm not sure, actually.
Maybe we should just forbid it and hope nobody asks for it.

Max

> +        shared &=3D BLK_PERM_WRITE;
> +        shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
> +                  BLK_PERM_WRITE_UNCHANGED;
> +    }
> +
> +    *nperm =3D perm;
> +    *nshared =3D shared;
> +}
> =20
>  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs)
>  {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 2d74f92..46f51a6 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -885,6 +885,14 @@ void bdrv_filter_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>                                 uint64_t perm, uint64_t shared,
>                                 uint64_t *nperm, uint64_t *nshared);
> =20
> +/* Default implementation for BlockDriver.bdrv_child_perm() that can b=
e used by
> + * (non-raw) image formats: Like above for bs->backing, but for bs->fi=
le it
> + * requires WRITE | RESIZE for read-write images, always requires
> + * CONSISTENT_READ and doesn't share WRITE. */
> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared);
> =20
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
>=20



--NkvwbqmfdcaPxV09gLplRwtIeDapTIwdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliki80SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwxAH/0L9I1gyzQ+aRmAv/FYX74sa+Rn1f7sF
dzqlkf5q7uCUsKsU/l3+/XZ+0PKpKsZ3o2jYxAm1NrEw5XSVzKVul/RiVkg29puN
QDz+oRol9MefK1Dv+xIlq7sOb/UUFgtkXp4de1rUt1aneMoJdf1zEg6GsY9tw5wb
sa4JGJfUQDx8PbOwqnHN8KE5vHYI3md20Hik/eBqGKfbPt9SGFHcnV1K2wVug1KR
16FQhkXYvD9Z2SAtKr+A7BxhNW1XnbyYCE9jEW4q8lvTz3tjiYPvIVawWEzPL1RX
Vk6fmXF6fQZgaV+uvhSa4Qp2nGlUhZpFdG70HPqjhWDBScReYFbIGGM=
=i2up
-----END PGP SIGNATURE-----

--NkvwbqmfdcaPxV09gLplRwtIeDapTIwdw--
