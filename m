Received: from eggs.gnu.org ([2001:4830:134:3::10]:52367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chaz1-0000xF-VY
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chaz1-0007S2-4d
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:57:52 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-19-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
Date: Sat, 25 Feb 2017 12:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-19-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cBhiaiccOwRgA3Po7U4EgojQgGAfgHvfJ"
Subject: Re: [Qemu-devel] [PATCH 18/54] block: Default .bdrv_child_perm()
 for format drivers
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
--cBhiaiccOwRgA3Po7U4EgojQgGAfgHvfJ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
Subject: Re: [PATCH 18/54] block: Default .bdrv_child_perm() for format
 drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-19-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
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
>  block.c                   | 42 +++++++++++++++++++++++++++++++++++++++=
+++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 523cbd3..f2e7178 100644
> --- a/block.c
> +++ b/block.c
> @@ -1554,6 +1554,48 @@ void bdrv_filter_default_perms(BlockDriverState =
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
> +         * writable and resizable backing file. */
> +        if (shared & BLK_PERM_WRITE) {
> +            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;

Wouldn't this break CONSISTENT_READ?

Max

> +        } else {
> +            shared =3D 0;
> +        }
> +
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
> index 17f4c2d..eb0598e 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -880,6 +880,14 @@ void bdrv_filter_default_perms(BlockDriverState *b=
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



--cBhiaiccOwRgA3Po7U4EgojQgGAfgHvfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixcTUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8jcH/21ATQWk18tD5GwsJSkv8rztopxsn+mV
IXcl9QJJviFHbJd0RcETTXLtcAFjslWtlHbAOt1d4/bgGD3nLs4mtFo92KoCFrpM
2P1J3Hd4i8i/BRWoBvIynOzMgCUXrUn49Ekd3bBYwqp+oUEL1fdvKwJLCUznvKhx
WzOdYmHLkKATRqtztuM8TA81pptGPo+LEF5pIWQ8Wu1wIgI7A9+C+Vzyn5hbAoUw
E0uQeE/vs4Iizn4dwbQnujmOdkFt8dTwZJqDDsksW+ubGwG4mSeiTKRFvxyr+Hfv
MgLRj+TdXc6dX5UxcBr3YOv203IuJDhn6fyRgqUGNS1xL6/Qxev3p5k=
=mdYA
-----END PGP SIGNATURE-----

--cBhiaiccOwRgA3Po7U4EgojQgGAfgHvfJ--
