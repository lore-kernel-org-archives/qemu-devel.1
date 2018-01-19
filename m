Received: from eggs.gnu.org ([2001:4830:134:3::10]:52899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecO7j-0000Qr-T4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecO7g-0008OR-Np
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:17:51 -0500
Date: Fri, 19 Jan 2018 15:17:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119041730.GE30352@umbus.fritz.box>
References: <20180119014313.480EB7456D6@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0/mZ2nErRHiqrPHn"
Content-Disposition: inline
In-Reply-To: <20180119014313.480EB7456D6@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sii3112: Add explicit type casts to avoid
 unintended sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--0/mZ2nErRHiqrPHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:18:59PM +0100, BALATON Zoltan wrote:
> Noticed by Coverity
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ide/sii3112.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index e2f5562..17aa930 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -79,13 +79,13 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr=
 addr,
>          val |=3D (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*S=
ATAINT0*/
>          val |=3D (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*S=
ATAINT1*/
>          val |=3D (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
> -        val |=3D d->i.bmdma[0].status << 16;
> -        val |=3D d->i.bmdma[1].status << 24;
> +        val |=3D (uint32_t)d->i.bmdma[0].status << 16;
> +        val |=3D (uint32_t)d->i.bmdma[1].status << 24;
>          break;
>      case 0x18:
>          val =3D d->i.bmdma[1].cmd;
>          val |=3D (d->regs[1].confstat & (1UL << 11) ? (1 << 4) : 0);
> -        val |=3D d->i.bmdma[1].status << 16;
> +        val |=3D (uint32_t)d->i.bmdma[1].status << 16;
>          break;
>      case 0x80 ... 0x87:
>          if (size =3D=3D 1) {
> @@ -128,7 +128,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr=
 addr,
>          val =3D (d->i.bus[0].ifs[0].blk) ? 0x113 : 0;
>          break;
>      case 0x148:
> -        val =3D d->regs[0].sien << 16;
> +        val =3D (uint32_t)d->regs[0].sien << 16;
>          break;
>      case 0x180:
>          val =3D d->regs[1].scontrol;
> @@ -137,7 +137,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr=
 addr,
>          val =3D (d->i.bus[1].ifs[0].blk) ? 0x113 : 0;
>          break;
>      case 0x1c8:
> -        val =3D d->regs[1].sien << 16;
> +        val =3D (uint32_t)d->regs[1].sien << 16;
>          break;
>      default:
>          val =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0/mZ2nErRHiqrPHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphcVkACgkQbDjKyiDZ
s5LqLRAAgpk53ja4CtN0MxsVBzND0OYWDx0UBuBJWBpRlJG3dMi2+nmjSyB5CU9A
aXJsJ4j2zTTsPxYrXEFB+BlYEqXf3hiZD2c1wnCAQpo/y0+XXytKGVwaCkPA7ezP
Il8lhca76h6oda05dJrI5UoE/YD9zVl4AKqMIaH62AQFVq7cCeEkMx7szFkqEwrB
YgWupQeyHj4FS3AwdWryieBt244mDosX3dmiYGBemwc5PJeAgRSqoKQUYX4lBZym
l5TgcAGgx3dR7g/8lnaP4bMUj8yIgMlVYV9FNmg2TmnUZo8lhGtc3Gd54C1pi8/Y
aQ0C8bOiyJ4GujooMKDgpk5qhl3WZG/4y5TyM8w3oP/frW/YRkB+5uSJkLjzbctZ
MD9F0N8PgU4YxaeWv0pSMX3TpetpjWMTsbncUbkpq84oq4qOubIcprXy+tdcagZX
70H/KFfx1eb0BQBeDE1eIVI+hXbn6wYBHzgrFqeswN94Yb5rSVOTIcqtauyQ+SaG
a7JxX/mcE5TDLW/hTczfkG7GrjNG68JOAarf6hV7ojG6CBGt+CNki8Rdy6VhWVbn
fAmutY+PKfsF/+6MI5fi68Mk7u3fmfzDO1WoiWAs98MeKy+gpyMb0DVuVew9XWnX
G+g7T0pc6L8B0gZly7iZH0bD/Z6Tr5IIr2a0RTDKhC+eJq529wI=
=xEvo
-----END PGP SIGNATURE-----

--0/mZ2nErRHiqrPHn--
