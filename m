Received: from eggs.gnu.org ([2001:4830:134:3::10]:33948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce5AU-00006h-CP
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce5AT-0004gq-EK
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:23:10 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-14-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6914490-1927-e0a6-e683-97fca0d5329f@redhat.com>
Date: Wed, 15 Feb 2017 20:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-14-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eEiXXrcF3Vm6SADcj3Se9vWvnvKraehgF"
Subject: Re: [Qemu-devel] [RFC PATCH 13/41] block: Request real permissions
 in bdrv_attach_child()
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
--eEiXXrcF3Vm6SADcj3Se9vWvnvKraehgF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <b6914490-1927-e0a6-e683-97fca0d5329f@redhat.com>
Subject: Re: [RFC PATCH 13/41] block: Request real permissions in
 bdrv_attach_child()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-14-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Now that all block drivers with children tell us what permissions they
> need from each of their children, bdrv_attach_child() can use this
> information and make the right requirements while trying to attach new
> children.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 682548a..fd06549 100644
> --- a/block.c
> +++ b/block.c
> @@ -1558,10 +1558,21 @@ BdrvChild *bdrv_attach_child(BlockDriverState *=
parent_bs,
>                               Error **errp)
>  {
>      BdrvChild *child;
> +    uint64_t perm, shared_perm;
> +
> +    /* XXX This check is a workaround for bdrv_open_inherit(), which a=
ttaches
> +     * bs->file before bs is opened for format probing. The 'else' bra=
nch
> +     * really shouldn't exist. */
> +    if (parent_bs->drv) {
> +        parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
> +                                        0, BLK_PERM_ALL, &perm, &share=
d_perm);
> +    } else {
> +        perm =3D 0;
> +        shared_perm =3D BLK_PERM_ALL;
> +    }
> =20
> -    /* FIXME Use real permissions */
>      child =3D bdrv_root_attach_child(child_bs, child_name, child_role,=

> -                                   0, BLK_PERM_ALL, parent_bs, errp);
> +                                   perm, shared_perm, parent_bs, errp)=
;
>      if (child =3D=3D NULL) {
>          return NULL;
>      }
> @@ -2041,6 +2052,8 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
>       * probing, the block drivers will do their own bdrv_open_child() =
for the
>       * same BDS, which is why we put the node name back into options. =
*/
>      if ((flags & BDRV_O_PROTOCOL) =3D=3D 0) {
> +        /* FIXME Really shouldn't try to open a child for a still clos=
ed bs,
> +         * see bdrv_attach_child() */

That gives me hope for my remark on patch 1. :-)

Max

>          file =3D bdrv_open_child(filename, options, "file", bs,
>                                 &child_file, true, &local_err);
>          if (local_err) {
>=20



--eEiXXrcF3Vm6SADcj3Se9vWvnvKraehgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikqpQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AV3oIAJ8yK1qzmXMYaiMfnkT3Q9qagdPJoZI9
rnKexyjIRXCFhhbm7pBMS3fjGjrqv6Wxe8+H0tZWsFpt+5GPVsT2vBOwH9UGJ92/
M2/Sc5bRA36jwjbAYpCWQiHw/JsVAIHgMYxGpmuJ54NFOLoF4ChA1c6uUJgEPEeX
uXORsWS8nONp6yvapI65LiD/7cWtymbtAVp4SVgjdYbDUiQ8bGa4Gixwv6jOla/G
o8mKTiOEPye+nANUdDfPf6ufO1BbFc8xt2cjxyF9N0/Mwl0dWOmF1528rvWrH57F
xI3FtcE/okqKXU9VT82IYiNVsflgH5mqXe4N8FZjXqejkciHWf1E6uQ=
=+hlv
-----END PGP SIGNATURE-----

--eEiXXrcF3Vm6SADcj3Se9vWvnvKraehgF--
