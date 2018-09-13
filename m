Received: from eggs.gnu.org ([2001:4830:134:3::10]:40371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvS-0001Qs-QP
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvO-0006wk-KC
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:18 -0400
Date: Thu, 13 Sep 2018 12:22:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913022229.GT7978@umbus.fritz.box>
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-2-clg@kaod.org>
	<20180911093452.1608d5fc@bahia.lan>
	<c4858950-8a98-603c-ce21-1a12357cf7b8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u+FGODhbLwgAeSOU"
Content-Disposition: inline
In-Reply-To: <c4858950-8a98-603c-ce21-1a12357cf7b8@kaod.org>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--u+FGODhbLwgAeSOU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 09:56:06AM +0200, C=E9dric Le Goater wrote:
> On 09/11/2018 09:34 AM, Greg Kurz wrote:
> > On Tue, 11 Sep 2018 07:55:02 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> The number of MSI interrupts a sPAPR machine can allocate is in direct
> >> relation with the number of interrupts of the sPAPRIrq backend. Define
> >> statically this value at the sPAPRIrq class level and use it for the
> >> "ibm,pe-total-#msi" property of the sPAPR PHB.
> >>
> >> According to the PAPR specs, "ibm,pe-total-#msi" defines the maximum
> >> number of MSIs that are available to the PE. We choose to advertise
> >> the maximum number of MSIs that are available to the machine for
> >> simplicity of the model and to avoid segmenting the MSI interrupt pool
> >> which can be easily shared. If the pool limit is reached, it can be
> >> extended dynamically.
> >>
> >> Finally, remove XICS_IRQS_SPAPR which is now unused.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >=20
> > Looks good to me. Just one comment below.
> >=20
> >>  include/hw/ppc/spapr_irq.h | 1 +
> >>  include/hw/ppc/xics.h      | 2 --
> >>  hw/ppc/spapr_irq.c         | 9 +++++++--
> >>  hw/ppc/spapr_pci.c         | 5 +++--
> >>  4 files changed, 11 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> index 0e98c4474bb2..650f810ad2aa 100644
> >> --- a/include/hw/ppc/spapr_irq.h
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> >> =20
> >>  typedef struct sPAPRIrq {
> >>      uint32_t    nr_irqs;
> >> +    uint32_t    nr_msis;
> >> =20
> >>      void (*init)(sPAPRMachineState *spapr, Error **errp);
> >>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
> >> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >> index 9c2916c9b23a..9958443d1984 100644
> >> --- a/include/hw/ppc/xics.h
> >> +++ b/include/hw/ppc/xics.h
> >> @@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
> >>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> >>  } XICSFabricClass;
> >> =20
> >> -#define XICS_IRQS_SPAPR               1024
> >> -
> >>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
> >> =20
> >>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index 0cbb5dd39368..fe8be5f5217a 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *s=
papr, Error **errp)
> >> =20
> >>      /* Initialize the MSI IRQ allocator. */
> >>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> >> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
> >> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
> >>      }
> >> =20
> >>      if (kvm_enabled()) {
> >> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachin=
eState *spapr, Monitor *mon)
> >>      ics_pic_print_info(spapr->ics, mon);
> >>  }
> >> =20
> >> +#define SPAPR_IRQ_XICS_NR_IRQS     0x400
> >> +#define SPAPR_IRQ_XICS_NR_MSIS     \
> >> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> >> +
> >>  sPAPRIrq spapr_irq_xics =3D {
> >> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
> >> +    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
> >> +    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> >> =20
> >>      .init        =3D spapr_irq_init_xics,
> >>      .claim       =3D spapr_irq_claim_xics,
> >> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >> index 6bcb4f419b6b..bb736177e76c 100644
> >> --- a/hw/ppc/spapr_pci.c
> >> +++ b/hw/ppc/spapr_pci.c
> >> @@ -2121,6 +2121,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> >>      sPAPRTCETable *tcet;
> >>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
> >>      sPAPRFDT s_fdt;
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machi=
ne());
> >> =20
> >=20
> > It is a bit unfortunate to add another user of qdev_get_machine()...
> >=20
> >>      /* Start populating the FDT */
> >>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> >> @@ -2138,8 +2139,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> >>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
> >>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
> >>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", =
0x1));
> >> -    /* TODO: fine tune the total count of allocatable MSIs per PHB */
> >> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQ=
S_SPAPR));
> >> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> >> +                          smc->irq->nr_msis));
> >> =20
> >=20
> > ... and to expose machine class internals. Since spapr_populate_pci_dt(=
) is only
> > called from the core machine code, maybe have the caller to pass the nu=
mber of
> > MSIs ?
>=20
> yes we could add an extra parameter to spapr_populate_pci_dt()

I'd like to see this as a followup.
>=20
> > Anyway, this can be done in a followup patch so:
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Thanks,
>=20
> C.
> >=20
> >>      /* Dynamic DMA window */
> >>      if (phb->ddw_enabled) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u+FGODhbLwgAeSOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZyeUACgkQbDjKyiDZ
s5IVqRAAketnadwmFMzAe9UlcGwEtU9fHEiMl8bNzNMPdnv4pxZ87uGvnzLf0Fms
wra2YTI0MtBJ2qMIoKpqQ2vNR5KzH0+rWGGoYtw5XcpzRWUR/0nf/Y7+w5Ue9FfM
FCDiKfsyC0SowoBLLAbv2zNtDWaUx7a5IfFnap/vlN6L+TcPcQldoU6+LWM2nUyI
0AaiEwxkc8vIy3tR3C8EBcOmVYcOgbMFiZB9MEDtwG7O+TNUWebz1goNKjVv6WmT
U2VHKiQ1Mvxu3ByYu9hyR/uz5mrc+38uPT6p7EMqrPL+48bk4SjEFB2DqXm4Ityc
sq0YcHlQnOHaiuZNrnlSU6+osrr/eK81GQHIOpT4Dp7XUKY4nCXTBoU3Ep4hSDIH
BLyn/7HZf/E10//CUDMI5Y+gF75C3VRgHLAklKBMFlMZPArMiUoIFitMwyMJVxLM
PTgMgYzt3YtG7dnLJbIPzOJEl/G59+Ie3mIhuuE4vWYxcFBkzVCeflXrp6uIBZg6
+Crmb6lTBjI5PVr/BcjwZnAIxzsuZ2htRwErJ2Sdu85Z6ZadQV/13uxy6wAtUTu5
AZPBRefz8kqDmXpva7TJvaZt+qv2Z2E+38cRv2YJHvEpTwqFcPh//t0N56Vt3jLQ
zb4tUtPY/zXF6hCUxn36s+xsMkqzywHijqu8OKNQySzZFtJUy2A=
=XFTD
-----END PGP SIGNATURE-----

--u+FGODhbLwgAeSOU--
