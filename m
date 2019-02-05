Received: from eggs.gnu.org ([209.51.188.92]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gr0xm-0005bs-5y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gr0xg-0004fJ-NP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:40:32 -0500
Date: Tue, 5 Feb 2019 17:03:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190205060307.GL22661@umbus.fritz.box>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774527936.1208625.3070534654296462659.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <154774527936.1208625.3070534654296462659.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 02/19] spapr: Rename xics to intc in
 interrupt controller agnostic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 06:14:39PM +0100, Greg Kurz wrote:
> All this code is used with both the XICS and XIVE interrupt controllers.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
> v3: - s/spapr_dt_intc_irq/spapr_dt_irq
> ---
>  hw/ppc/spapr.c              |    6 +++---
>  hw/ppc/spapr_events.c       |    2 +-
>  hw/ppc/spapr_pci.c          |    6 +++---
>  hw/ppc/spapr_vio.c          |    2 +-
>  include/hw/pci-host/spapr.h |    2 +-
>  include/hw/ppc/spapr.h      |    2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 83081defde4e..26f8e55cc25e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -96,7 +96,7 @@
> =20
>  #define MIN_RMA_SLOF            128UL
> =20
> -#define PHANDLE_XICP            0x00001111
> +#define PHANDLE_INTC            0x00001111
> =20
>  /* These two functions implement the VCPU id numbering: one to compute t=
hem
>   * all and one to identify thread 0 of a VCORE. Any change to the first =
one
> @@ -1276,7 +1276,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
> =20
>      /* /interrupt controller */
>      spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
> -                          PHANDLE_XICP);
> +                          PHANDLE_INTC);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -1296,7 +1296,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
>                                      spapr->irq->nr_msis);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 32719a1b72d0..b9c7ecb9e987 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -282,7 +282,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
>              continue;
>          }
> =20
> -        spapr_dt_xics_irq(interrupts, source->irq, false);
> +        spapr_dt_irq(interrupts, source->irq, false);
> =20
>          _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
>          _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b74f2632ecc6..ccdaf2c9a606 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2066,7 +2066,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
> =20
>  }
> =20
> -int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
> +int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
>                            uint32_t nr_msis)
>  {
>      int bus_off, i, j, ret;
> @@ -2164,8 +2164,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t xics_phandle, void *fdt,
>              irqmap[1] =3D 0;
>              irqmap[2] =3D 0;
>              irqmap[3] =3D cpu_to_be32(j+1);
> -            irqmap[4] =3D cpu_to_be32(xics_phandle);
> -            spapr_dt_xics_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, t=
rue);
> +            irqmap[4] =3D cpu_to_be32(intc_phandle);
> +            spapr_dt_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, true);
>          }
>      }
>      /* Write interrupt map */
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 7e8a9ad09337..f80b70a39c46 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -158,7 +158,7 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
>      if (dev->irq) {
>          uint32_t ints_prop[2];
> =20
> -        spapr_dt_xics_irq(ints_prop, dev->irq, false);
> +        spapr_dt_irq(ints_prop, dev->irq, false);
>          ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
>                            sizeof(ints_prop));
>          if (ret < 0) {
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 4eb3a2ce3eb8..e0e683c32469 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -113,7 +113,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
>      return spapr_qirq(spapr, phb->lsi_table[pin].irq);
>  }
> =20
> -int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
> +int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
>                            uint32_t nr_msis);
> =20
>  void spapr_pci_rtas_init(void);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9e01a5a12e4a..f988dc6924b8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -682,7 +682,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr);
>   * "interrupt-controller" node has its "#interrupt-cells" property set t=
o 2 (ie,
>   * VIO devices, RTAS event sources and PHBs).
>   */
> -static inline void spapr_dt_xics_irq(uint32_t *intspec, int irq, bool is=
_lsi)
> +static inline void spapr_dt_irq(uint32_t *intspec, int irq, bool is_lsi)
>  {
>      intspec[0] =3D cpu_to_be32(irq);
>      intspec[1] =3D is_lsi ? cpu_to_be32(1) : 0;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZJxoACgkQbDjKyiDZ
s5LVlw/+MbBoAoheT+pWEoOcdBjkcofIRCLxt4tgOmqZ3cuWKX+Xu9kncoCG2c8q
MLHCz7xqQ4Gsaq7/MyzKOxK4kGaRwEdSh2KR8ynq8Zdn31EqXlGT023+VPRdQXAQ
SvQe4b/mBZ/vmmbHCDh2Em0TnWeO3TnjcdpJejenwHEhYHUx17SVv4kvjQZlhHFE
MYEsZJBC0miRVvHidsoVc9xzILxhOrnUugua+vz7pgI0cqgUp7jkyuiGP5eikMca
LL2Nyx7qn9dDRoX9rX/A2cHYaHxuyhi9+EL07coONhStSHTgeeq1k74ZaiPmsMZq
hB+VsG1mKAKwjPKx3e9xkz7bKix96jMVlf4XKBxrhtynQKwUKqkkOKQyeS9BlQnR
KcjAkUW7A2EVae2/L3zEhE0byCXytKI9IJKCof8wHBY2SmhdcXRglBYN9LuH+qKL
K8N/v33yMVA0gS9KVN7fvC5PSMxEsICkPBkJCSerZ9CVNRSDvcVUcJXSqAsOQmlH
jxGKzj+1qSlXY/NsjcwUpv3uyxMG/OqDsznoGV/jvD9evIsQa1KkCJ5HfMb+2YKq
pSQPlxUiJWLg/zRbAE1yj9j61NaFoO9bJuwzIoLMC/VBrr7Up/ydcbqftMvUGtET
+bEW/g3J+eoKzaFZVPJWPL51N/Vap9pCpRKZWkaG58ktZKaqyLk=
=I9YG
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
