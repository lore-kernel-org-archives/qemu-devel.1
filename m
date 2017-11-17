Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFYxw-0004Pg-5l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFYxu-0007dw-GE
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:13:24 -0500
Date: Fri, 17 Nov 2017 15:54:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171117045412.GC26448@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20171110152017.24324-9-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 08/11] spapr: introduce a
 XICSFabric irq_is_lsi() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:20:14PM +0000, C=E9dric Le Goater wrote:
> It will be used later on to distinguish the allocation of an LSI
> interrupt from an MSI and also to reduce the use of the ICSIRQState
> array of the ICSState object, which is on our way to introduce XIVE.
>=20
> The 'irq' parameter continues to refer to the global IRQ number space.
>=20
> On PowerNV, only the PSI controller interrupts are handled and they
> are all LSIs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

!?! AFAICT this is a step backwards.  The users of ics_is_lsi() here
are in the xics code.  So they already have the right information
locally in the ICSState object.  Why on earth would you indirect
through the fabric.

> ---
>  hw/intc/xics.c        | 26 +++++++++++++++++---------
>  hw/intc/xics_kvm.c    |  4 ++--
>  hw/ppc/pnv.c          | 16 ++++++++++++++++
>  hw/ppc/spapr.c        |  9 +++++++++
>  include/hw/ppc/xics.h |  2 ++
>  5 files changed, 46 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 2c4899f278e2..42880e736697 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -33,6 +33,7 @@
>  #include "trace.h"
>  #include "qemu/timer.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/spapr.h"
>  #include "qemu/error-report.h"
>  #include "qapi/visitor.h"
>  #include "monitor/monitor.h"
> @@ -70,8 +71,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>          }
>          monitor_printf(mon, "  %4x %s %02x %02x\n",
>                         ics->offset + i,
> -                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
> -                       "LSI" : "MSI",
> +                       ics_is_lsi(ics, i) ? "LSI" : "MSI",

!?!=20

>                         irq->priority, irq->status);
>      }
>  }
> @@ -377,6 +377,14 @@ static const TypeInfo icp_info =3D {
>  /*
>   * ICS: Source layer
>   */
> +bool ics_is_lsi(ICSState *ics, int srcno)
> +{
> +    XICSFabric *xi =3D ics->xics;
> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
> +
> +    return xic->irq_is_lsi(xi, srcno + ics->offset);
> +}
> +
>  static void ics_simple_resend_msi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> @@ -435,7 +443,7 @@ static void ics_simple_set_irq(void *opaque, int srcn=
o, int val)
>  {
>      ICSState *ics =3D (ICSState *)opaque;
> =20
> -    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> +    if (ics_is_lsi(ics, srcno)) {
>          ics_simple_set_irq_lsi(ics, srcno, val);
>      } else {
>          ics_simple_set_irq_msi(ics, srcno, val);
> @@ -472,7 +480,7 @@ void ics_simple_write_xive(ICSState *ics, int srcno, =
int server,
>      trace_xics_ics_simple_write_xive(ics->offset + srcno, srcno, server,
>                                       priority);
> =20
> -    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> +    if (ics_is_lsi(ics, srcno)) {
>          ics_simple_write_xive_lsi(ics, srcno);
>      } else {
>          ics_simple_write_xive_msi(ics, srcno);
> @@ -484,10 +492,10 @@ static void ics_simple_reject(ICSState *ics, uint32=
_t nr)
>      ICSIRQState *irq =3D ics->irqs + nr - ics->offset;
> =20
>      trace_xics_ics_simple_reject(nr, nr - ics->offset);
> -    if (irq->flags & XICS_FLAGS_IRQ_MSI) {
> -        irq->status |=3D XICS_STATUS_REJECTED;
> -    } else if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +    if (ics_is_lsi(ics, nr - ics->offset)) {
>          irq->status &=3D ~XICS_STATUS_SENT;
> +    } else {
> +        irq->status |=3D XICS_STATUS_REJECTED;
>      }
>  }
> =20
> @@ -497,7 +505,7 @@ static void ics_simple_resend(ICSState *ics)
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          /* FIXME: filter by server#? */
> -        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> +        if (ics_is_lsi(ics, i)) {
>              ics_simple_resend_lsi(ics, i);
>          } else {
>              ics_simple_resend_msi(ics, i);
> @@ -512,7 +520,7 @@ static void ics_simple_eoi(ICSState *ics, uint32_t nr)
> =20
>      trace_xics_ics_simple_eoi(nr);
> =20
> -    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> +    if (ics_is_lsi(ics, srcno)) {
>          irq->status &=3D ~XICS_STATUS_SENT;
>      }
>  }
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 3091ad3ac2c8..2f10637c9f7c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -258,7 +258,7 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
>              state |=3D KVM_XICS_MASKED;
>          }
> =20
> -        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> +        if (ics_is_lsi(ics, i)) {
>              state |=3D KVM_XICS_LEVEL_SENSITIVE;
>              if (irq->status & XICS_STATUS_ASSERTED) {
>                  state |=3D KVM_XICS_PENDING;
> @@ -293,7 +293,7 @@ static void ics_kvm_set_irq(void *opaque, int srcno, =
int val)
>      int rc;
> =20
>      args.irq =3D srcno + ics->offset;
> -    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
> +    if (!ics_is_lsi(ics, srcno)) {
>          if (!val) {
>              return;
>          }
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 8288940ef9d7..958223376b4c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1035,6 +1035,21 @@ static bool pnv_irq_test(XICSFabric *xi, int irq)
>      return false;
>  }
> =20
> +static bool pnv_irq_is_lsi(XICSFabric *xi, int irq)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    int i;
> +
> +    /* PowerNV machine only has PSI interrupts which are all LSIs */
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        ICSState *ics =3D &pnv->chips[i]->psi.ics;
> +        if (ics_valid_irq(ics, irq)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  static void pnv_pic_print_info(InterruptStatsProvider *obj,
>                                 Monitor *mon)
>  {
> @@ -1120,6 +1135,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
>      xic->ics_get =3D pnv_ics_get;
>      xic->ics_resend =3D pnv_ics_resend;
>      xic->irq_test =3D pnv_irq_test;
> +    xic->irq_is_lsi =3D pnv_irq_is_lsi;
>      ispc->print_info =3D pnv_pic_print_info;
> =20
>      powernv_machine_class_props_init(oc);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cbbd7715a85..ce314fcf38db 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3628,6 +3628,14 @@ static void spapr_irq_free_block_2_11(XICSFabric *=
xi, int irq, int num)
>      }
>  }
> =20
> +static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> +    int srcno =3D irq - spapr->ics->offset;
> +
> +    return spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI;
> +}
> +
>  static bool spapr_irq_test(XICSFabric *xi, int irq)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> @@ -3765,6 +3773,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      xic->irq_test =3D spapr_irq_test;
>      xic->irq_alloc_block =3D spapr_irq_alloc_block;
>      xic->irq_free_block =3D spapr_irq_free_block;
> +    xic->irq_is_lsi =3D spapr_irq_is_lsi;
> =20
>      ispc->print_info =3D spapr_pic_print_info;
>      /* Force NUMA node memory size to be a multiple of
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 30e7f2e0a7dd..478f8e510179 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -179,6 +179,7 @@ typedef struct XICSFabricClass {
>      bool (*irq_test)(XICSFabric *xi, int irq);
>      int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>      void (*irq_free_block)(XICSFabric *xi, int irq, int num);
> +    bool (*irq_is_lsi)(XICSFabric *xi, int irq);
>  } XICSFabricClass;
> =20
>  #define XICS_IRQS_SPAPR               1024
> @@ -205,6 +206,7 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
>  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> +bool ics_is_lsi(ICSState *ics, int srno);
> =20
>  void ics_resend(ICSState *ics);
>  void icp_resend(ICPState *ss);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloOa3QACgkQbDjKyiDZ
s5IGqw//SPp1wsZ07UurnBnbVeqGyAK5+ZB0JJLR1g5jb1GsuFCEAv1qOD+MVYwU
ipfK942flrdvoB41Kqtsy7jkWbcgsc8Ya7ON7/X0DKWqpLILRPEbo3ki4JP6yGuG
u9szV1Fk8AMKwra7cJkbOGW0auZSNKEuTHTp8yLgykxWWwTpxNOSqbNo+lNy1PnR
VEr0KnuFbZCvqqmEqyOuw4NI/kui0oU5YFhsmK19e5Lp8OGhqGYaMG6limgTeFJ/
obT3hpbJMZ+BnYdkmQBczQM2w6vJfNxwADJmYNnhh+t62Qt/Uf8mK+Ko5GYpuQo1
vmlmwrIJxufqeQ1sa2GvmEMCV/HjgJRvYyOMr4hsVXj8dO1NPSWqOeD8X8NGi4QG
cV7zTZgqhm3wKG8XMV8uTvtaKBKQt4kE2mWHkDv2F1AYDdzQRRELWAQRU5L9W+8x
4M9thwFVH6VouJj029yYNzTW3iEw00C3yASfxVYmnc9FKqQ3Hyo1vIdCjU98T29l
9MKoooFOpe6l9CIBiucVN8oH8AfWXEbmVbQe55mVDL/tpgwm0sTZklOzYyjxsve4
rdrWAVY3H2Ua8sfrLOdBjGI6qPZ1EALNYbG0fnoYwW4woWPf1v/7iowuuUxSi6Nu
NVbpiCRooYm8+g8Oqysla70iP+174GvQt8FU5oIdeavA29DDxuc=
=JMN8
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
