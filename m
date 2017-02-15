Received: from eggs.gnu.org ([2001:4830:134:3::10]:45922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce2wQ-0003ZW-0P
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce2wP-00036N-4y
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:00:30 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-8-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <870983e7-9590-1889-a388-c1168b566cb6@redhat.com>
Date: Wed, 15 Feb 2017 18:00:16 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aCpWVkWUs1JBmv9tqJf3bn2rO2bkM548c"
Subject: Re: [Qemu-devel] [RFC PATCH 07/41] block: Default
 .bdrv_child_perm() for filter drivers
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
--aCpWVkWUs1JBmv9tqJf3bn2rO2bkM548c
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <870983e7-9590-1889-a388-c1168b566cb6@redhat.com>
Subject: Re: [RFC PATCH 07/41] block: Default .bdrv_child_perm() for filter
 drivers
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
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
> index c27cdce..290768d 100644
> --- a/block.c
> +++ b/block.c
> @@ -1436,6 +1436,30 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64=
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
> +        return;
> +    }
> +
> +    *nperm   =3D (perm & DEFAULT_PERM_PASSTHROUGH) |
> +               (c->perm & DEFAULT_PERM_UNCHANGED);
> +    *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) |
> +               (c->shared_perm & DEFAULT_PERM_UNCHANGED);

In my opinion, aligning both equal signs without aligning the ampersands
etc. actually hurts readability. I would not align the equal signs.

Just a stylistic pick, nothing else.

(btw, if it isn't clear: Any patch I'm not replying to looks good to me
-- apart from patch 6 where Fam has already raised the concern I have,
too. I don't give R-bs though because this is still an RFC O:-))

Max

> +}
> +
> +
>  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs)
>  {
>      BlockDriverState *old_bs =3D child->bs;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 8578e17..2d74f92 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -877,6 +877,14 @@ void bdrv_child_set_perm(BdrvChild *c, uint64_t pe=
rm, uint64_t shared);
>  int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shar=
ed,
>                              Error **errp);
> =20
> +/* Default implementation for BlockDriver.bdrv_child_perm() that can b=
e used by
> + * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and =
RESIZE to
> + * all children */
> +void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared);
> +
> =20
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
>=20



--aCpWVkWUs1JBmv9tqJf3bn2rO2bkM548c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikiSASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aa58H/AvC6OXuQjEUYHAF5dg9Ac/EvhtfPcMd
o6ItKJ7LPm6A21rLgX3NJQds03qUrpqeXeJPmaZB8UTdSjPhEMzyIU2oftC9EGJ2
USrO/4U0tlmMEhE2JQg8TtitoMXhi9YI2/isV19PO3UsqyFG4QXSidTanyzdsGH1
6eqrag7eBMaUutTYzcQWwjF3fNWuqJ82NnU4g8wRXU4Fki8L0Cn48Rmm4Qypd+14
og5aNAac589Wzps5No2nv8G+mMO3APMCgLadhw/5bTN6VkDAZo8sueBofmqF1hGU
BCnu0Xpy0Pznnx4TFUDbIo8EFIJ6pIAjYVHOC+n8ytVGI6aHmBmTsWQ=
=Og2x
-----END PGP SIGNATURE-----

--aCpWVkWUs1JBmv9tqJf3bn2rO2bkM548c--
