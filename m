Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvS-0001Qq-Oe
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvO-0006wa-JP
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:18 -0400
Date: Thu, 13 Sep 2018 12:21:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913022135.GS7978@umbus.fritz.box>
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/Dpz40iF3jpiHxF"
Content-Disposition: inline
In-Reply-To: <20180911055503.2303-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: introduce a spapr_irq class
 'nr_msis' attribute
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


--2/Dpz40iF3jpiHxF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 07:55:02AM +0200, C=E9dric Le Goater wrote:
> The number of MSI interrupts a sPAPR machine can allocate is in direct
> relation with the number of interrupts of the sPAPRIrq backend. Define
> statically this value at the sPAPRIrq class level and use it for the
> "ibm,pe-total-#msi" property of the sPAPR PHB.
>=20
> According to the PAPR specs, "ibm,pe-total-#msi" defines the maximum
> number of MSIs that are available to the PE. We choose to advertise
> the maximum number of MSIs that are available to the machine for
> simplicity of the model and to avoid segmenting the MSI interrupt pool
> which can be easily shared. If the pool limit is reached, it can be
> extended dynamically.
>=20
> Finally, remove XICS_IRQS_SPAPR which is now unused.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.1, thanks.

> ---
>  include/hw/ppc/spapr_irq.h | 1 +
>  include/hw/ppc/xics.h      | 2 --
>  hw/ppc/spapr_irq.c         | 9 +++++++--
>  hw/ppc/spapr_pci.c         | 5 +++--
>  4 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 0e98c4474bb2..650f810ad2aa 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> =20
>  typedef struct sPAPRIrq {
>      uint32_t    nr_irqs;
> +    uint32_t    nr_msis;
> =20
>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
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
> index 0cbb5dd39368..fe8be5f5217a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spap=
r, Error **errp)
> =20
>      /* Initialize the MSI IRQ allocator. */
>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MS=
I);
> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
>      }
> =20
>      if (kvm_enabled()) {
> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> +#define SPAPR_IRQ_XICS_NR_IRQS     0x400
> +#define SPAPR_IRQ_XICS_NR_MSIS     \
> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> +
>  sPAPRIrq spapr_irq_xics =3D {
> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
> +    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
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

--2/Dpz40iF3jpiHxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZya8ACgkQbDjKyiDZ
s5J5tg//QlQUvafC5wG1V9Crdip/Sz0GUGmiVvGcJcvCKePQ1RVwzJd+jJrkFnt5
X+x7h8UaZCFoHbpjiFnXAXH1324djGvpRXQY+xANrp2ji8GiqMBEcTlCldCSw0Wc
7se1x1ryNDTGTuy6irm1LQRxoORICkGfDQiGXNdrh+mhCRvqjN6VmJomGZW+sdSC
EuIt94FCuckFLn4qErDcqQrWYSL3vDjoYZmMe7ViAcd9qGJ5svynyDE5ZLSABHCL
E/+LFF7AFqbMqOmr4ab56ax7AUjd0n+DVepHh0SuQVt7r8M8Q1vC0+jDsBPJExKF
NC2NRefaw5qU25o1vq8V+9frGgI91VnNqruxIVCBQO8Ngb3NTg9lXKz96J0LFVkg
rql1neXtX+J5QZON0ORIpB7xy7dwjdv12i5Mup6UuVakRP4QYEdFCE7pC8NynMv2
gRqYfWe7OFngxhKDl+Zx1+V3qXtRKUVmCGuk78+eh6HthLEBSlasvLcsiKUMEJeF
Bs7aVvJwDkppc7f1HaZnOhiswebdil+yFyr427TB64qshG4+LKHeYMeL71eDbOvI
yq2n1jrLBxDmyjjt8dLxpbRvGkK0kWKpq1yQXX7MriUAtN33kaAuK+5Q1Q9FXIP5
tHtt9vshzEa/XReNQDxdMH1vEeIsrDDET9tfFI0BJBC9W4r/FfM=
=GnqO
-----END PGP SIGNATURE-----

--2/Dpz40iF3jpiHxF--
