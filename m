Received: from eggs.gnu.org ([2001:4830:134:3::10]:60521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3PE-0005aT-5A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3PD-0007me-21
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:30:16 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-12-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df098565-f960-4941-d1d6-46f542f813d3@redhat.com>
Date: Wed, 15 Feb 2017 18:30:04 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-12-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UW1LW1DNFvptxfIW92VreOAJkux4DEBtV"
Subject: Re: [Qemu-devel] [RFC PATCH 11/41] vvfat: Implement
 .bdrv_child_perm()
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
--UW1LW1DNFvptxfIW92VreOAJkux4DEBtV
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <df098565-f960-4941-d1d6-46f542f813d3@redhat.com>
Subject: Re: [RFC PATCH 11/41] vvfat: Implement .bdrv_child_perm()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-12-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> vvfat is the last remaining driver that can have children, but doesn't
> implement .bdrv_child_perm() yet. The default handlers aren't suitable
> here, so let's implement a very simple driver-specific one that protect=
s
> the internal child from being used by other users as good as our
> permissions permit.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vvfat.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index c6bf67e..7246432 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -3052,6 +3052,18 @@ err:
>      return ret;
>  }
> =20
> +static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                             const BdrvChildRole *role,
> +                             uint64_t perm, uint64_t shared,
> +                             uint64_t *nperm, uint64_t *nshared)
> +{
> +    assert(role =3D=3D &child_vvfat_qcow);
> +
> +    /* This is a private node, nobody should try to attach to it */
> +    *nperm =3D BLK_PERM_WRITE;
> +    *nshared =3D 0;

0 for shared is probably enough to ward every other access off, but
maybe we should still pro forma request consistent read access...?

Max

> +}
> +
>  static void vvfat_close(BlockDriverState *bs)
>  {
>      BDRVVVFATState *s =3D bs->opaque;
> @@ -3077,6 +3089,7 @@ static BlockDriver bdrv_vvfat =3D {
>      .bdrv_file_open         =3D vvfat_open,
>      .bdrv_refresh_limits    =3D vvfat_refresh_limits,
>      .bdrv_close             =3D vvfat_close,
> +    .bdrv_child_perm        =3D vvfat_child_perm,
> =20
>      .bdrv_co_preadv         =3D vvfat_co_preadv,
>      .bdrv_co_pwritev        =3D vvfat_co_pwritev,
>=20



--UW1LW1DNFvptxfIW92VreOAJkux4DEBtV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikkBwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AagMH/1MbhM1d2O+AsXOUDUqp9Pqsyhda/bk3
85Yko6onUTSExKbs1fP7kx3UiWi/JUSQ1CiEbjgCqFkFW7EnjcYW+rQrZ1tbGTRj
+n/kukC9PKej4jCWo5iavJdDQuXgFPMrvHoMl2aXB3ooRfJ4HXVsTF89X3jn2YzI
quiIe5oQAkjp6iKHRd0PSRzjNVQdQkUrcALAG7WsWULOvO5S/a+Xse+zDR8hQILp
nrPA3VDaKZ09Wnn09c1JcRO8M5wDR5bQvKLJySO42kl0XecxDJokVvl3Kc6+jRat
FH/Qf6MGQ1A4KDYKz5gwbnAgxt+A24FAT436rpNL294Vp5sFM1QUOfk=
=rTfV
-----END PGP SIGNATURE-----

--UW1LW1DNFvptxfIW92VreOAJkux4DEBtV--
