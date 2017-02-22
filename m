Received: from eggs.gnu.org ([2001:4830:134:3::10]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXwy-0003ZH-RS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXwx-0006XL-RE
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:31:24 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-23-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a6bf4bc1-c673-17fa-336d-f9d45686cba5@redhat.com>
Date: Wed, 22 Feb 2017 15:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-23-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q3aOxuhlKa0KxaPPu68pBvk9dIjrLpEC1"
Subject: Re: [Qemu-devel] [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
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
--Q3aOxuhlKa0KxaPPu68pBvk9dIjrLpEC1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <a6bf4bc1-c673-17fa-336d-f9d45686cba5@redhat.com>
Subject: Re: [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-23-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Now that all block drivers with children tell us what permissions they
> need from each of their children, bdrv_attach_child() can use this
> information and make the right requirements while trying to attach new
> children.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 1c5f211..054e6f0 100644
> --- a/block.c
> +++ b/block.c
> @@ -1659,10 +1659,14 @@ BdrvChild *bdrv_attach_child(BlockDriverState *=
parent_bs,
>                               Error **errp)
>  {
>      BdrvChild *child;
> +    uint64_t perm, shared_perm;
> +
> +    assert(parent_bs->drv);
> +    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
> +                                    0, BLK_PERM_ALL, &perm, &shared_pe=
rm);

Another Second Thought=E2=84=A2: Why do we request no permissions for the=
 new
child here? Seems weird to me. Shouldn't the caller specify the
necessary permissions and what can be shared?

Max

> =20
> -    /* FIXME Use real permissions */
>      child =3D bdrv_root_attach_child(child_bs, child_name, child_role,=

> -                                   0, BLK_PERM_ALL, parent_bs, errp);
> +                                   perm, shared_perm, parent_bs, errp)=
;
>      if (child =3D=3D NULL) {
>          return NULL;
>      }
>=20



--Q3aOxuhlKa0KxaPPu68pBvk9dIjrLpEC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitoLESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbesH/iXwde28WDOX9kCTQbZ3GwL0tMppGgBv
Z+HglPReATic7i1l6Mbm0Ypc1mV8+HMhtQeanRZsHbN3M81XUeAuir1h7Jq3f6++
psKaU+rn3c/Rnw49v+NlvH1XVvHwjtGGCXPhnGuBt7ciyxY+2jDCrG9CPlFH1rgr
Tg0PH3zldSr9BxGiLT+jWMKPPCrUTo999VRTPb8OHU06AKopY6kZMHPBShXOv8+j
ijsVAc10s6J7CWhHHzY4UUxNumJOf2zNHVUFiP0GEIugaKLgSIfbhqjROdhu5k9D
mm7hE0EpM52bPMfIyNl3nWt1Ja2xMsT5ZIvhnobQnsDkUKUe4t6+XXk=
=6YxG
-----END PGP SIGNATURE-----

--Q3aOxuhlKa0KxaPPu68pBvk9dIjrLpEC1--
