Received: from eggs.gnu.org ([2001:4830:134:3::10]:34242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4Vd-0000DY-HB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4VZ-0007Tp-FR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:33 -0400
Date: Tue, 19 Jun 2018 10:28:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619002818.GJ25461@umbus.fritz.box>
References: <20180618170540.12143-1-clg@kaod.org>
	<20180618170540.12143-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kTN++mu+z+U/mv0o"
Content-Disposition: inline
In-Reply-To: <20180618170540.12143-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ppc/pnv: consolidate the creation
 of the ISA bus device tree
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


--kTN++mu+z+U/mv0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 07:05:40PM +0200, C=E9dric Le Goater wrote:
> The device tree node of the ISA bus was being partially done in
> different places. Move all the nodes creation under the same routine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 51 +++++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a29ea996b45d..7401ffe5b01c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -265,18 +265,6 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uin=
t32_t pir,
>      g_free(reg);
>  }
> =20
> -static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
> -{
> -    char *name;
> -    int offset;
> -
> -    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> -                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
> -    offset =3D fdt_path_offset(fdt, name);
> -    g_free(name);
> -    return offset;
> -}
> -
>  static void pnv_dt_chip(PnvChip *chip, void *fdt)
>  {
>      const char *typename =3D pnv_chip_core_typename(chip);
> @@ -285,16 +273,6 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
> =20
>      pnv_dt_xscom(chip, fdt, 0);
> =20
> -    /* The default LPC bus of a multichip system is on chip 0. It's
> -     * recognized by the firmware (skiboot) using a "primary"
> -     * property.
> -     */
> -    if (chip->chip_id =3D=3D 0x0) {
> -        int lpc_offset =3D pnv_chip_lpc_offset(chip, fdt);
> -
> -        _FDT((fdt_setprop(fdt, lpc_offset, "primary", NULL, 0)));
> -    }
> -
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> =20
> @@ -418,16 +396,35 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
>      return 0;
>  }
> =20
> -static void pnv_dt_isa(ISABus *bus, void *fdt, int lpc_offset)
> +static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)

AFAICT, this only has one caller, so you could probably fold it in
there.  Not a big deal, though.

> +{
> +    char *name;
> +    int offset;
> +
> +    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> +                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
> +    offset =3D fdt_path_offset(fdt, name);
> +    g_free(name);
> +    return offset;
> +}
> +
> +/* The default LPC bus of a multichip system is on chip 0. It's
> + * recognized by the firmware (skiboot) using a "primary" property.
> + */
> +static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
>  {
> +    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
>      ForeachPopulateArgs args =3D {
>          .fdt =3D fdt,
> -        .offset =3D lpc_offset,
> +        .offset =3D isa_offset,
>      };
> =20
> +    _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
> +
>      /* ISA devices are not necessarily parented to the ISA bus so we
>       * can not use object_child_foreach() */
> -    qbus_walk_children(BUS(bus), pnv_dt_isa_device, NULL, NULL, NULL, &a=
rgs);
> +    qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,
> +                       &args);
>  }
> =20
>  static void *pnv_dt_create(MachineState *machine)
> @@ -438,7 +435,6 @@ static void *pnv_dt_create(MachineState *machine)
>      char *buf;
>      int off;
>      int i;
> -    int lpc_offset;
> =20
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> @@ -480,8 +476,7 @@ static void *pnv_dt_create(MachineState *machine)
>      }
> =20
>      /* Populate ISA devices on chip 0 */
> -    lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
> -    pnv_dt_isa(pnv->isa_bus, fdt, lpc_offset);
> +    pnv_dt_isa(pnv, fdt);
> =20
>      if (pnv->bmc) {
>          pnv_dt_bmc_sensors(pnv->bmc, fdt);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kTN++mu+z+U/mv0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoTiIACgkQbDjKyiDZ
s5IZxg/9HIYI2m35PyXZd1eMfRkB1IPUk0oGOgmcgsoaqsz3SY6xwOH9IQxqTlWp
4TLx2XnzaPoJTjKKXYmsQ+xri/1eYMFzbvlQew8Hv5JVuSljHUTX5xoepZsaG7zH
LnFwn+zXE0hdgUFnaATO6u5hx/MG+l43yO1jVli9KBhWyjSrs16d0ye3MTAfVHA5
HQnUGjml9NAFvnLtrZRfzSn9ICxwqkJorlQsJBDoNue+5sxVaoKPM6ynsJR32B2j
E/5WV7eM+H0Hpg8yWUdoBtTK1sLXbg7IzF0xz57AP2A0ULaCv2vjdHkQ/oKeLfaR
YSmfUP6TBCbeslpxIvSygysTJQyGs5E0kZflb6P4lxEWPQeVys/XdPRtejJcALoe
pbbMWcRkCHhbsk5bd6IG7a0686A55eiw44JHvJzlFTBAT4Iv2/laPD4gUWR3A4GX
z8U8wJ7j+zRk2rS4uwjjIMoqhkMEhJX3q1EL95G6w4gHW0sBorp6Q5L+v8DujYqp
AwvaBSO2Y+tPuP59p/CqZo1D3c6wblVXhsv8fpWp/IP1BYVgnPDY1afZuMRBrsRV
rLBBJeDqLl3SfS07utoJ9nivTGALNXvxt+BAYUhRDodsQzXlMwhy4VI5nhsoOroN
XNcfOG/MsNBH2gS8ysr6Fa3HF7nsfFGv1vcIotYJptYOZYDHuds=
=unCN
-----END PGP SIGNATURE-----

--kTN++mu+z+U/mv0o--
