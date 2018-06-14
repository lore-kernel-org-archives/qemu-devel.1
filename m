Received: from eggs.gnu.org ([2001:4830:134:3::10]:38690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISW-0000VD-VX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTIST-0004UW-3L
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:01 -0400
Date: Thu, 14 Jun 2018 11:33:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013306.GC3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<7a407b15b683417745e71a95452d5094e6e9fe94.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <7a407b15b683417745e71a95452d5094e6e9fe94.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 6/9] sm501: Do not clear read only bits
 when writing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, h@umbus.fritz.box
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> When writing registers that have read only bits we have to avoid
> changing these bits as they may have non zero values. Make sure we use
> the correct masks to mask out read only and reserved bits when
> changing registers.
>=20
> Also remove extra spaces from dram_control and arbitration_control
> assignments.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v3: Not only preserve read only bits but also allow clearing r/w
> bits

Applied to ppc-for-3.0, thanks.

>=20
>  hw/display/sm501.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index e47be99..ca0840f 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -836,27 +836,30 @@ static void sm501_system_config_write(void *opaque,=
 hwaddr addr,
> =20
>      switch (addr) {
>      case SM501_SYSTEM_CONTROL:
> -        s->system_control =3D value & 0xE300B8F7;
> +        s->system_control &=3D 0x10DB0000;
> +        s->system_control |=3D value & 0xEF00B8F7;
>          break;
>      case SM501_MISC_CONTROL:
> -        s->misc_control =3D value & 0xFF7FFF20;
> +        s->misc_control &=3D 0xEF;
> +        s->misc_control |=3D value & 0xFF7FFF10;
>          break;
>      case SM501_GPIO31_0_CONTROL:
>          s->gpio_31_0_control =3D value;
>          break;
>      case SM501_GPIO63_32_CONTROL:
> -        s->gpio_63_32_control =3D value;
> +        s->gpio_63_32_control =3D value & 0xFF80FFFF;
>          break;
>      case SM501_DRAM_CONTROL:
>          s->local_mem_size_index =3D (value >> 13) & 0x7;
>          /* TODO : check validity of size change */
> -        s->dram_control |=3D  value & 0x7FFFFFC3;
> +        s->dram_control &=3D 0x80000000;
> +        s->dram_control |=3D value & 0x7FFFFFC3;
>          break;
>      case SM501_ARBTRTN_CONTROL:
> -        s->arbitration_control =3D  value & 0x37777777;
> +        s->arbitration_control =3D value & 0x37777777;
>          break;
>      case SM501_IRQ_MASK:
> -        s->irq_mask =3D value;
> +        s->irq_mask =3D value & 0xFFDF3F5F;
>          break;
>      case SM501_MISC_TIMING:
>          s->misc_timing =3D value & 0xF31F1FFF;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxdIACgkQbDjKyiDZ
s5KmZRAAw9dw1O3lq720b9M1ZU/+VP8OzwhF5NFQmg+zDXXgTNLb0Afv/4jCr2d1
vPRzMoXHwQmnDqhmBgn8DUVRytAs2i1XW2od5Lv/mxKloaLm33C6ec5LhXiXy6wr
VqE4VDHutBElsDbYDtmxfluRyDxxE5hnC+F1yx56bLY4z+5dLDSG/YcSiNeqyTrr
DNPhqnrum3a5X6vgXbngWxwgvpE/yW9JzVVWvi+j06xwPu9II/9Er5DnUwsJ3Yfl
CZmLefYbimcXxnKGnYlhvJ8exnLr+W9wf+AMyf4BpxbXW9sOT6k/2EBGbToamoOJ
HgO4lOH3V45/i4DOr+Vm3+s5RP7Ub2r0HEE3KoP/5cfwQfAHq751QGAzS46geyUT
6tgTwPs6fQ5rg8z0rGdevJdachRasbjzXS1bYtkukTE4XaI+s8vxeLHjalKIkqZF
2tNkgzELjL9/NoluHgpLuEpPv/PgBM9v/+znaI20rCg8arH6sTvm5ONu9+3dffR/
CLTqXvmEoGVMW9563TZrWBEfjRbg1fyMv/gNJZovnGioAA3ogdCtdI/2j2OYrcTC
8jpAifd1TGbq7V8bcZMzY9uP2vGBjSSXRFvncJsWTKZ7iqg+wj343cVteo548oqt
UN8VNgcL+d4N8UGaSGzer05LJJvfHPrQ0FCg7qCsI6149WmXAbU=
=cJkZ
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
