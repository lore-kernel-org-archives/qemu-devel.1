Received: from eggs.gnu.org ([2001:4830:134:3::10]:39715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXuQ-0001bj-6c
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXuP-000668-61
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:28:46 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-17-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <64d326d6-8b82-c48e-c1a9-161fb6085ea7@redhat.com>
Date: Wed, 22 Feb 2017 15:28:35 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-17-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="af7gGt0fXRf3gS86dNLntFO8NwE6gTTDW"
Subject: Re: [Qemu-devel] [PATCH 16/54] block: Default .bdrv_child_perm()
 for filter drivers
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
--af7gGt0fXRf3gS86dNLntFO8NwE6gTTDW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <64d326d6-8b82-c48e-c1a9-161fb6085ea7@redhat.com>
Subject: Re: [PATCH 16/54] block: Default .bdrv_child_perm() for filter
 drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-17-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Most filters need permissions related to read and write for their
> children, but only if the node has a parent that wants to use the same
> operation on the filter. The same is true for resize.
>=20
> This adds a default implementation that simply forwards all necessary
> permissions to all children of the node and leaves the other permission=
s
> unchanged.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 24 ++++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 2a86781..523cbd3 100644
> --- a/block.c
> +++ b/block.c
> @@ -1531,6 +1531,30 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64=
_t perm, uint64_t shared,
>      return 0;
>  }
> =20
> +#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
> +                                 | BLK_PERM_WRITE \
> +                                 | BLK_PERM_WRITE_UNCHANGED \
> +                                 | BLK_PERM_RESIZE)
> +#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROU=
GH)
> +
> +void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared)
> +{
> +    if (c =3D=3D NULL) {
> +        *nperm =3D 0;
> +        *nshared =3D BLK_PERM_ALL;

On second thought, I don't understand this. Why isn't this

*nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
*nshared =3D shared & DEFAULT_PERM_PASSTHROUGH;

?

Max

> +        return;
> +    }
> +
> +    *nperm =3D (perm & DEFAULT_PERM_PASSTHROUGH) |
> +             (c->perm & DEFAULT_PERM_UNCHANGED);
> +    *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) |
> +               (c->shared_perm & DEFAULT_PERM_UNCHANGED);
> +}
> +
> +
>  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs)
>  {
>      BlockDriverState *old_bs =3D child->bs;


--af7gGt0fXRf3gS86dNLntFO8NwE6gTTDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitoBMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuDsH/3yA4mOQF2MmTq+cNp6v20M4UeImDERR
a3xlBQHf2JIGATegJQM3/bjrJsKPDfb0BuTnM9hney3eeIX9/+iUHBHgJKcfCT/s
oy4QXjsCmVlhs8vVPFCSzb54azcxkVGXFm6J6i3o0JWkrEYKCwvhlkSe3f3kxYZi
53uGuUtLWUfDUIzHifA8MEj0OGkf/Iun+RqwCHkrisAnLX/6dq3zWgYk9mlimNvB
SOGn+qpMYixcMA9+0my4Zl8aa1iuCOgYhhapWbuaEGf4y+RLCvx3jSp5OJ1PG1bu
38StgfSgUT4QaCJj2Zr3I6b496nJqMaF7x1TlLdLuyulydMch02DusU=
=D75+
-----END PGP SIGNATURE-----

--af7gGt0fXRf3gS86dNLntFO8NwE6gTTDW--
