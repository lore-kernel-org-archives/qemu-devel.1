Received: from eggs.gnu.org ([2001:4830:134:3::10]:51266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtY-0001H5-G5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtW-0002wU-2c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:48 -0400
Date: Tue, 19 Sep 2017 17:56:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919075602.GS27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CRjAHycgiaTQGSqU"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-16-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 15/21] spapr: modify
 spapr_populate_pci_dt() to use a 'nr_irqs' argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--CRjAHycgiaTQGSqU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:29PM +0200, C=E9dric Le Goater wrote:
> This adds some flexibility in the definition of the number of
> available IRQS used in a sPAPR machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This doesn't seem sensible.  You've already stated that the XIVE and
XICS need equivalent irq number spaces, so in particular they should
have the same number of irqs advertised.

> ---
>  hw/ppc/spapr.c              | 2 +-
>  hw/ppc/spapr_pci.c          | 4 ++--
>  include/hw/pci-host/spapr.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e3ff1fbc988..5d69df928434 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1093,7 +1093,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, XICS_IRQS_=
SPAPR);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index d84abf1070a0..05b0a067458e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2073,7 +2073,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>                            uint32_t xics_phandle,
> -                          void *fdt)
> +                          void *fdt, int nr_irqs)
>  {
>      int bus_off, i, j, ret;
>      char nodename[FDT_NAME_MAX];
> @@ -2142,7 +2142,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_irqs));
> =20
>      /* Dynamic DMA window */
>      if (phb->ddw_enabled) {
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 38470b2f0e5c..40146f72c103 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -115,7 +115,7 @@ PCIHostState *spapr_create_phb(sPAPRMachineState *spa=
pr, int index);
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>                            uint32_t xics_phandle,
> -                          void *fdt);
> +                          void *fdt, int nr_irqs);
> =20
>  void spapr_pci_rtas_init(void);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CRjAHycgiaTQGSqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAzZIACgkQbDjKyiDZ
s5KyuRAAtqqEhhZeX7Vqq39NDhiwLzI8pZ9aHO2P3hzLdRoNVJ2imsA3BT/cMbBw
UeV0drD9b3+7ZYLYO3ynNVYiqKPxuon/aby9RZ0LG6g8QmET/gIpOSX60U5r0JTP
e7lhN3XosSdtkx8Aif1zs/UXlLuC+KpDiS3OU3FG7cCo+5zSuwHixL0nhnyuPFUJ
oOWnkh4bdEGJ5LJ1kyAGBihzAqqWc3CQaNa3nOOxP3o9LX2a3vikdigcE9B6A/18
nqcwbVzEB3qrelCwUHMkc0X4wADt5aqQDwgufZCPMWqZP1I/n03nyDriaMNZbY6z
+U0zDeSH1CfD6UZR/s3DUo3Lq6EI1YfUM+pAH4pnx86cpcKHvs50bWfyFOO10OIm
1CAVSQ+yO0bs/ptLhAmOqlO3bU8351W5U4s+NiERudx7mu19PL/MAVbTBLC8xWhb
/YCryMt3ui/sPSR73LxshguYTv2V+eqvneRPIt+8cFoOrifPTDGj7qusG6xQUiPG
+tH9ddWPILyc6QQaqJHth9caM+7IqX2rxhaPkQ9N81Gx8QNCdA7UHRzTE3LExGRI
eLu7nzNIe5cumAxWSgh5fLYey7jMAl1/TGiT4lfimyR+KCnS9AxIMQinlmhSi3Jo
/k1pqeW0I5njMiGZbEgRCah+gcD8gWRj8EcgMIli7VkFTTAiIzs=
=Ru5E
-----END PGP SIGNATURE-----

--CRjAHycgiaTQGSqU--
