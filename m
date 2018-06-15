Received: from eggs.gnu.org ([2001:4830:134:3::10]:49801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfBJ-0005Y4-PY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfBF-0000bZ-Ob
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:13:45 -0400
Date: Fri, 15 Jun 2018 12:52:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615025257.GM4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pz/qqzCPDfGwIFOg"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] ppc/pnv: introduce a
 pnv_chip_core_realize() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Pz/qqzCPDfGwIFOg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:41PM +0200, C=E9dric Le Goater wrote:
> This extracts from the PvChip realize routine the part creating the
> cores. On Power9, we will need to create the cores after the Xive
> interrupt controller is created.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 72cfe4c2627c..b3b0dd44582f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -822,9 +822,8 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error=
 **errp)
>      }
>  }
> =20
> -static void pnv_chip_realize(DeviceState *dev, Error **errp)
> +static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>  {
> -    PnvChip *chip =3D PNV_CHIP(dev);
>      Error *error =3D NULL;
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>      const char *typename =3D pnv_chip_core_typename(chip);
> @@ -836,14 +835,6 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
>          return;
>      }
> =20
> -    /* XSCOM bridge */
> -    pnv_xscom_realize(chip, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
> -
>      /* Cores */
>      pnv_chip_core_sanitize(chip, &error);
>      if (error) {
> @@ -891,6 +882,27 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
>                                  &PNV_CORE(pnv_core)->xscom_regs);
>          i++;
>      }
> +}
> +
> +static void pnv_chip_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvChip *chip =3D PNV_CHIP(dev);
> +    Error *error =3D NULL;
> +
> +    /* XSCOM bridge */
> +    pnv_xscom_realize(chip, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
> +
> +    /* Cores */
> +    pnv_chip_core_realize(chip, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> =20
>      /* Create LPC controller */
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pz/qqzCPDfGwIFOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjKggACgkQbDjKyiDZ
s5JmwA//Vgych9crP7gvmGUppagxaxh8fTzToeW/GGJ9fWx8uOXguA7pXrA/ML7L
gNn8dPuKHtLxzB8fYQWYuy9FKJ2KM5/txYcWpClbnaJJyIZW6Ek0I3DR1lV46Qwo
V9a5dqFsYPLUckvsAkg4YmANAoDptkLKCV98LbErFhMXP2gGo/HBWooiHK4hEDRV
m5GI7KdqHKwBs3rKv9TaGSAlg26nDp5kmDs5vDjr2pGTxDe/fayqGaSrhnQ8qEF1
TApjQjDs30amvbMYfpZ0rGN4VOlr0NGOcZ1iRQmOngDYJXp+AmFTpCY/MyJmZJU6
nKt+9P3DMjJTjVVuaIzqHAUpcZ0pHIXNI4P/B0VjXjzGO2+uVa/1YWWLC1S949mu
yWt6fYNDsH13id2p7SmPQHZEOtVWVw0+yZPKARZa6ko5jaZ/XJuDpX8r6NDf6DDl
9upqeoybWEcsYm/L6baLwGc0H3zp1n6b8OhPUi1iga1vsevc44J8wJAdCtTaYyQL
8rw3xlRh3BiNXsttk0AtryC5oEs46VwJKb+0woXBUlBBS/SxMwt8Lrw/n6JlNXL7
dUqbxZBnY9yjdXUrLM8apl37jX2Eac8hcyb3UY2Zf6d9ubX8kee3/4u6bUpqAX5F
vkpcNJekgauYM1GqAjKglN/ipRjOraPnjKMiWeHgkfAepDXZVzI=
=N/8s
-----END PGP SIGNATURE-----

--Pz/qqzCPDfGwIFOg--
