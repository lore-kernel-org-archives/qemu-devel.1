Received: from eggs.gnu.org ([2001:4830:134:3::10]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1g0Kn0-0003Am-0S
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1g0Kmy-0006uC-BR
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:07:41 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:51872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1g0Kmy-0006em-5U
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:07:40 -0400
Received: from player714.ha.ovh.net (unknown [10.109.146.53])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7B94EF9ADC
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 08:07:29 +0200 (CEST)
Date: Thu, 13 Sep 2018 08:07:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180913080723.683b99cf@bahia.lan>
In-Reply-To: <20180913051605.26408-1-clg@kaod.org>
References: <20180913051605.26408-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 13 Sep 2018 07:16:05 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> So that we don't have to call qdev_get_machine() to get the machine
> class and the sPAPRIrq backend holding the number of MSIs.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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
