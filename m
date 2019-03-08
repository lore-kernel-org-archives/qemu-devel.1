Received: from eggs.gnu.org ([209.51.188.92]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2352-0002zb-Es
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2351-0002xj-2S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Date: Fri, 8 Mar 2019 11:01:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308000107.GD7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fblc08uBQ7kpPybH"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 05/15] ppc/pnv: add a 'dt_isa_nodename'
 to the chip
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


--fblc08uBQ7kpPybH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:38PM +0100, C=E9dric Le Goater wrote:
> The ISA bus has a different DT nodename on POWER9. Compute the name
> when the PnvChip is realized, that is before it is used by the machine
> to populate the device tree with the ISA devices.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I still tend to think that passing an offset into pnv_dt_isa would
have been a better solution, but this will serve.  Applied.

> ---
>  include/hw/ppc/pnv.h |  2 ++
>  hw/ppc/pnv.c         | 18 +++++-------------
>  2 files changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 8d80cb34eebb..c81f157f41a9 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -58,6 +58,8 @@ typedef struct PnvChip {
>      MemoryRegion xscom_mmio;
>      MemoryRegion xscom;
>      AddressSpace xscom_as;
> +
> +    gchar        *dt_isa_nodename;
>  } PnvChip;
> =20
>  #define TYPE_PNV8_CHIP "pnv8-chip"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 922e3ec48bb5..6625562d276d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -417,24 +417,12 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
>      return 0;
>  }
> =20
> -static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
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
>  /* The default LPC bus of a multichip system is on chip 0. It's
>   * recognized by the firmware (skiboot) using a "primary" property.
>   */
>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
>  {
> -    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
> +    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nodena=
me);
>      ForeachPopulateArgs args =3D {
>          .fdt =3D fdt,
>          .offset =3D isa_offset,
> @@ -866,6 +854,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
>                               &error_fatal);
>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
> =20
> +    chip->dt_isa_nodename =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x=
",
> +                                            (uint64_t) PNV_XSCOM_BASE(ch=
ip),
> +                                            PNV_XSCOM_LPC_BASE);
> +
>      /* Interrupt Management Area. This is the memory region holding
>       * all the Interrupt Control Presenter (ICP) registers */
>      pnv_chip_icp_realize(chip8, &local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fblc08uBQ7kpPybH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBsMMACgkQbDjKyiDZ
s5L+QA//ecMPz8iv3KhoyCEscehCUBcU/kpniIuZPvVSE6qM8wnjU7CLQcz/D4/Z
SRxILM4rLf2k4Q58MnY9kqD+7qQQHfn0OKQeXsSAfNEDXNC+kEpOUAR5FL4mO6bC
gpMDxgCPF0SXEcICPeMafftEhypLILg34LwIXarG2kZj8481WQq7UT7zD/VvOsMs
0zo0mOoyqtt7ktmtMBsup7fqbN8Ftk43Bf6WDRj2E5h+N46cAwBgAey9hAqQcvjN
GLK8ZYMZFDHpGWhxCE/zV64xl0sGDFWtzSiH+AlbsvYxgA6ur1hwTSegaUscZia8
9OH04hUW4yWnhcfmAuyD5X/yApZgc4iqws2LIVfC0aD5oqyzsaownEfH0lI4+oyE
0SbPfiZZz/4HN1wZgbump1jAauiK46dTk9hC4xn5NZ0OY92cBA1CLfiTr8GaZyjC
m4VGJxnlhb9jYhFZXRp5U4i3ehCII8v6Mfv0NIRhaLjWhXNenF3UXJl7zbWsn8wO
C03sxKY8g5SfV8tQTyFWt02/hR/d6o+UAmV9nqB/I8ac2OXNdUkbi9KBBT7E25p9
qAqTYgUl0V8XF3GbLEDJQiabai/mi/ipIQQgrVX0nS4HnZicJjzHoT2aTPUGK+c1
p1yd4Qfb/VspN9Bz0yVm4+IUO4JKzDgCeEPSQ1G4Yrdwa0VdrdI=
=dISh
-----END PGP SIGNATURE-----

--fblc08uBQ7kpPybH--
