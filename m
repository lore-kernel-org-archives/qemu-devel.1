Received: from eggs.gnu.org ([2001:4830:134:3::10]:43884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzY17-0000Vu-FO
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXrP-0007da-42
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:53:02 -0400
Date: Tue, 11 Sep 2018 11:50:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911015032.GG7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline
In-Reply-To: <20180910110222.8162-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr_pci: fix "ibm,
 pe-total-#msi" value
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


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 01:02:22PM +0200, C=E9dric Le Goater wrote:
> The "ibm,pe-total-#msi" property of the sPAPR PHB defines the number
> of allocatable MSI interrupts. This is currently set to XICS_IRQS_SPAPR
> which covers the full IRQ number space of the machine. This is wrong.
>=20
> Fix the definition by using the 'nr_msis' attribute of the sPAPRIrq
> class and remove XICS_IRQS_SPAPR which is now unused.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Oh.. right.. I think it makes more sense to just merge this into the
first patch.

> ---
>  include/hw/ppc/xics.h | 2 --
>  hw/ppc/spapr_irq.c    | 2 +-
>  hw/ppc/spapr_pci.c    | 5 +++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9c2916c9b23a..9958443d1984 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
>      ICPState *(*icp_get)(XICSFabric *xi, int server);
>  } XICSFabricClass;
> =20
> -#define XICS_IRQS_SPAPR               1024
> -
>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
> =20
>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b14d7bce00ea..e77b94cc685e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -290,7 +290,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
>      return first + ics->offset;
>  }
> =20
> -#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     XICS_IRQS_SPAPR
> +#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> =20
>  sPAPRIrq spapr_irq_xics_legacy =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 6bcb4f419b6b..bb736177e76c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2121,6 +2121,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      sPAPRTCETable *tcet;
>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
>      sPAPRFDT s_fdt;
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machine(=
));
> =20
>      /* Start populating the FDT */
>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> @@ -2138,8 +2139,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
> -    /* TODO: fine tune the total count of allocatable MSIs per PHB */
> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> +                          smc->irq->nr_msis));
> =20
>      /* Dynamic DMA window */
>      if (phb->ddw_enabled) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXH2gACgkQbDjKyiDZ
s5LNbhAAhA7t0Djf7Sq4rnnxO7si/j6cPpW3iRX8IEZijofQy0DJruYJ5LaWhS28
4hG60KNR4JA43VUbxwxO2DpOojbGfCXPraoBqxk6risFIaOJQZoMYeCzAyFPRJBY
85hGohLH5SNo3NMdyWrWDwlLqsO920Q8ZstQ0mWrzrJ8WiQmxE6wMIwpLdvCpkWX
Hs9x19yFND2BrQP69TMTQpugVDbw4A9b2scwf0p8KniVRNGQWPiNIjN7oyi3EHJP
8nf73GHaEFONljeaZhSwsg62XrlK3UFeAxOdZP0HYyjH/alf9yBPTZ4UhIbk+3jH
gnkPJG5u2ACv7TMDzwKIpioEveUaPtFB03y4XhZFsH7Lah9TNU5t/0SYrrdMv6yN
OsJj8dvOojEGsB/I+B2EH4E10gemdGDaX18YzhwBmjoPTdQWVixRw9azcE+TfXSE
q49zg9JXKc4TvAHvMIiKp5FpOruqhqAzXSKdaWXALfx272uVpD1DpPJlcGKN7QMq
6qO5Uzsitl1XFlVGIde57TFdY0a7l3+SeqX0eMfPTYRVKPXOPILr73jCd0hCMeez
6EJPAZUmCaq7kqF0nDq7dd/kJkkzHjST3SlLoCAPavBvdRqg/ON7BwWa1pBuAMg8
inZ4/ZBDV4lEWZuiMA34ynyh8MTYw7FQSCCk9IfOWDSVRrPninU=
=CjZL
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
