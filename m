Received: from eggs.gnu.org ([2001:4830:134:3::10]:33913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXXA-0007SI-TZ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXX6-0008EX-RD
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:04:41 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-16-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
Date: Wed, 22 Feb 2017 15:04:29 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-16-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IwP6Hi51k0mgv7wppE0PSiw2qI6Q8pCGJ"
Subject: Re: [Qemu-devel] [PATCH 15/54] block: Involve block drivers in
 permission granting
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
--IwP6Hi51k0mgv7wppE0PSiw2qI6Q8pCGJ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
Subject: Re: [PATCH 15/54] block: Involve block drivers in permission granting
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-16-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> In many cases, the required permissions of one node on its children
> depends on what its parents require from it. For example, the raw forma=
t

*depend

> or most filter drivers only need to request consistent reads if that's
> something that one of their parents wants.
>=20
> In order to achieve this, this patch introduces two new BlockDriver
> callbacks. The first one lets drivers first check (recursively) whether=

> the requested permissions can be set; the second one actually sets the
> new permission bitmask.
>=20
> Also add helper functions that drivers can use in their implementation
> of the callbacks to update their permissions on a specific child.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 176 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  include/block/block_int.h |  61 ++++++++++++++++
>  2 files changed, 237 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index d9f2267..2a86781 100644
> --- a/block.c
> +++ b/block.c
> @@ -1326,11 +1326,145 @@ static int bdrv_fill_options(QDict **options, =
const char *filename,

[...]

> +/*
> + * Notifies drivers that after a previous bdrv_check_perm() call, the
> + * permission update is not performed and any preparations made for it=
 (e.g.
> + * taken file locks) need to be undone.
> + *
> + * This function recursively notifies all child nodes.
> + */
> +static void bdrv_abort_perm_update(BlockDriverState *bs)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    BdrvChild *c;
> +
> +    if (!drv) {
> +        return;
> +    }
> +
> +    if (drv->bdrv_abort_perm_update) {
> +        drv->bdrv_abort_perm_update(bs);
> +    }
> +
> +    QLIST_FOREACH(c, &bs->children, next) {
> +        bdrv_abort_perm_update(c->bs);

Could use bdrv_child_abort_perm_update(c) just for symmetry with
bdrv_check_perm() (which uses bdrv_child_check_perm() to recurse).

> +    }
> +}
> +

[...]

> @@ -1353,8 +1487,47 @@ static int bdrv_check_update_perm(BlockDriverSta=
te *bs, uint64_t new_used_perm,
>              error_setg(errp, "Conflicts with %s", user ?: "another ope=
ration");
>              return -EPERM;
>          }
> +
> +        cumulative_perms |=3D c->perm;
> +        cumulative_shared_perms &=3D c->shared_perm;
> +    }
> +
> +    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_per=
ms, errp);
> +}
> +
> +/* Needs to be followed by a call to either bdrv_set_perm() or
> + * bdrv_abort_perm_update(). */

*"bdrv_child_set_perm() or bdrv_child_abort_perm_update()"?

(Doesn't really matter, but it makes for nicer symmetry.)

> +int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared=
,
> +                          Error **errp)
> +{
> +    return bdrv_check_update_perm(c->bs, perm, shared, c, errp);
> +}

[...]

> @@ -1390,6 +1565,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
> =20
>      ret =3D bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, =
errp);
>      if (ret < 0) {
> +        bdrv_abort_perm_update(child_bs);
>          return NULL;
>      }
> =20

This function doesn't call bdrv_set_perm(). Intentional?

Max

[...]


--IwP6Hi51k0mgv7wppE0PSiw2qI6Q8pCGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitmm0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Au44H/Rm9PZNC4BfeXKFoorc84PRnYE3G9GCd
5Lhs2HxAhcEosVHo/Ji/Z2HXIJglZbA2Pmk/nPnYcgWCvyuYx/xccg2OYSrbjh+j
mYADGLmx/mlDnXXBxWjs6AkyXaolYCu9AWKDzGG0dq6oqM/0QUXeKZBg+WxSkHot
jj80Qwyt61sNdgKbh3awIouls+rYwr7qt/jaNBMGyiR7PKz3doF9PEe9uIWkeL8Z
kuNrM1M/qVM0n75Wh58e/x3KKmF5NlSZ+2lyrqqm0XDgRIk03vx6hMipBhjiqRqW
iN7l+CDfcMUOFO5blgfhve7lQb1Ga1mUPQwDk93aCDWa6Uq4AWlUK8k=
=9N5/
-----END PGP SIGNATURE-----

--IwP6Hi51k0mgv7wppE0PSiw2qI6Q8pCGJ--
