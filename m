Received: from eggs.gnu.org ([2001:4830:134:3::10]:43182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0LP6-0003pB-3q
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0LP4-0000ie-Up
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:47:04 -0400
Date: Thu, 13 Sep 2018 16:05:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913060501.GV7978@umbus.fritz.box>
References: <20180913051605.26408-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KxKI/R+N9hudrWbn"
Content-Disposition: inline
In-Reply-To: <20180913051605.26408-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: add an extra 'nr_msis' argument
 to spapr_populate_pci_dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--KxKI/R+N9hudrWbn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 07:16:05AM +0200, C=E9dric Le Goater wrote:
> So that we don't have to call qdev_get_machine() to get the machine
> class and the sPAPRIrq backend holding the number of MSIs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/pci-host/spapr.h | 5 ++---
>  hw/ppc/spapr.c              | 2 +-
>  hw/ppc/spapr_pci.c          | 9 +++------
>  3 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 0fae4fc6a4e5..7c66c3872f96 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -113,9 +113,8 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
> =20
>  PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
> =20
> -int spapr_populate_pci_dt(sPAPRPHBState *phb,
> -                          uint32_t xics_phandle,
> -                          void *fdt);
> +int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
> +                          uint32_t nr_msis);
> =20
>  void spapr_pci_rtas_init(void);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index eba7d60a30a7..98868d893ad8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1267,7 +1267,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, smc->irq->=
nr_msis);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bb736177e76c..c2271e6ed462 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2069,9 +2069,8 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
> =20
>  }
> =20
> -int spapr_populate_pci_dt(sPAPRPHBState *phb,
> -                          uint32_t xics_phandle,
> -                          void *fdt)
> +int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
> +                          uint32_t nr_msis)
>  {
>      int bus_off, i, j, ret;
>      gchar *nodename;
> @@ -2121,7 +2120,6 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      sPAPRTCETable *tcet;
>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
>      sPAPRFDT s_fdt;
> -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machine(=
));
> =20
>      /* Start populating the FDT */
>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> @@ -2139,8 +2137,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> -                          smc->irq->nr_msis));
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_msis));
> =20
>      /* Dynamic DMA window */
>      if (phb->ddw_enabled) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KxKI/R+N9hudrWbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZ/gsACgkQbDjKyiDZ
s5If3hAAkZHZJreavrpCJlu6o3Pcha/4429QWtlyuSOCF/hEVn4zhyM2JkVpXSQe
lQNqbxDZ/hTYEyz62qNEW+FsOs5xZM87O0/aj7h0TA4Oy9KHj+TPxB5A8yN8Ej8H
YlBq1wWHs+NBkgJ6eTnhrNVUisW1PfLUZq5Ok+UsSRJ0esYwSPWmYRCMlrBE9Abw
9/PZbJzXZwCguVHlLlQ0x0cwgIuhfCzCd7Ic+LfGJy/OD1xDS7KyOZeOJUL+tojG
AUD16cY6NgbBbr4QVJ1NTg3oHRyfAiufr8SluaGZdhIgnLEeIaAnx/l4gpg7Jd3O
q+VV+UiKls/4cQ4kYYonHhdRW59nHDw6jbquSURG5gSr0Va27KkCmP36CX3Aq/tI
WwHra/EFEYyDzXLeMsEeCTsNXQ44egZCEHQTTcrbH4hC3+Wf8TYETejXjwjczYVp
HR6EwowhmhwIG1ZcpWlrzhyP5zVWXdAz55BdSJCGGmyWC1uT0uCF0lhqIwPcQ1aA
HL+s+HmdCySvwg4PM4uZZFzC1uukZ8mugAlOGEV383fG7MeQ9A0nbIGP6PtRGdD4
/JPiVtTJDmBTZjne1dmgc9zhKDmLFbK8ZY2HxIT1tdUiamiljNwrPQNhaLasfIId
t+c0fslWvtSWGH5JNUB6Zz3V60Ac+Px6J8/zKaQbaw4ZITTZUuo=
=yWHp
-----END PGP SIGNATURE-----

--KxKI/R+N9hudrWbn--
