Received: from eggs.gnu.org ([209.51.188.92]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIq-0005aE-0R
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIo-0001z7-G0
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:03 -0500
Date: Sat, 26 Jan 2019 15:31:29 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126023128.GF22942@umbus>
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-4-clg@kaod.org>
	<20190117091426.1175a851@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20190117091426.1175a851@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: move the interrupt presenters
 under machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 09:14:26AM +0100, Greg Kurz wrote:
> On Thu, 17 Jan 2019 08:53:26 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > Next step is to remove them from under the PowerPCCPU
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

>=20
> >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> >  hw/intc/spapr_xive.c            |  3 ++-
> >  hw/intc/xics_spapr.c            | 11 ++++++-----
> >  hw/ppc/spapr.c                  |  2 +-
> >  hw/ppc/spapr_cpu_core.c         |  8 ++++----
> >  hw/ppc/spapr_irq.c              | 17 ++++++++++-------
> >  6 files changed, 25 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 9e2821e4b31f..d64f86bc284e 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -46,6 +46,8 @@ typedef struct sPAPRCPUState {
> >      uint64_t vpa_addr;
> >      uint64_t slb_shadow_addr, slb_shadow_size;
> >      uint64_t dtl_addr, dtl_size;
> > +    struct ICPState *icp;
> > +    struct XiveTCTX *tctx;
> >  } sPAPRCPUState;
> > =20
> >  static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 136d872f16bc..a0f5ff929447 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -16,6 +16,7 @@
> >  #include "monitor/monitor.h"
> >  #include "hw/ppc/fdt.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/ppc/spapr_xive.h"
> >  #include "hw/ppc/xive.h"
> >  #include "hw/ppc/xive_regs.h"
> > @@ -394,7 +395,7 @@ static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xr=
tr, CPUState *cs)
> >  {
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -    return cpu->tctx;
> > +    return spapr_cpu_state(cpu)->tctx;
> >  }
> > =20
> >  static const VMStateDescription vmstate_spapr_xive_end =3D {
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index de6cc15b6474..e2d8b3818336 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -31,6 +31,7 @@
> >  #include "trace.h"
> >  #include "qemu/timer.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/ppc/xics.h"
> >  #include "hw/ppc/xics_spapr.h"
> >  #include "hw/ppc/fdt.h"
> > @@ -45,7 +46,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
> >  {
> >      target_ulong cppr =3D args[0];
> > =20
> > -    icp_set_cppr(cpu->icp, cppr);
> > +    icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
> >      return H_SUCCESS;
> >  }
> > =20
> > @@ -66,7 +67,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
> >  static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >                             target_ulong opcode, target_ulong *args)
> >  {
> > -    uint32_t xirr =3D icp_accept(cpu->icp);
> > +    uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> > =20
> >      args[0] =3D xirr;
> >      return H_SUCCESS;
> > @@ -75,7 +76,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
> >  static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >                               target_ulong opcode, target_ulong *args)
> >  {
> > -    uint32_t xirr =3D icp_accept(cpu->icp);
> > +    uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> > =20
> >      args[0] =3D xirr;
> >      args[1] =3D cpu_get_host_ticks();
> > @@ -87,7 +88,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
> >  {
> >      target_ulong xirr =3D args[0];
> > =20
> > -    icp_eoi(cpu->icp, xirr);
> > +    icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
> >      return H_SUCCESS;
> >  }
> > =20
> > @@ -95,7 +96,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> >                              target_ulong opcode, target_ulong *args)
> >  {
> >      uint32_t mfrr;
> > -    uint32_t xirr =3D icp_ipoll(cpu->icp, &mfrr);
> > +    uint32_t xirr =3D icp_ipoll(spapr_cpu_state(cpu)->icp, &mfrr);
> > =20
> >      args[0] =3D xirr;
> >      args[1] =3D mfrr;
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 83081defde4e..181f994c87a7 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3896,7 +3896,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, in=
t vcpu_id)
> >  {
> >      PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
> > =20
> > -    return cpu ? cpu->icp : NULL;
> > +    return cpu ? spapr_cpu_state(cpu)->icp : NULL;
> >  }
> > =20
> >  static void spapr_pic_print_info(InterruptStatsProvider *obj,
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 0405306d1e59..ef6cbb9c2943 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -194,11 +194,11 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu,=
 sPAPRCPUCore *sc)
> >          vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machin=
e_data);
> >      }
> >      qemu_unregister_reset(spapr_cpu_reset, cpu);
> > -    if (cpu->icp) {
> > -        object_unparent(OBJECT(cpu->icp));
> > +    if (spapr_cpu_state(cpu)->icp) {
> > +        object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
> >      }
> > -    if (cpu->tctx) {
> > -        object_unparent(OBJECT(cpu->tctx));
> > +    if (spapr_cpu_state(cpu)->tctx) {
> > +        object_unparent(OBJECT(spapr_cpu_state(cpu)->tctx));
> >      }
> >      cpu_remove_sync(CPU(cpu));
> >      object_unparent(OBJECT(cpu));
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 1da7a32348fc..2d7a7c163876 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -12,6 +12,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/ppc/spapr_xive.h"
> >  #include "hw/ppc/xics.h"
> >  #include "hw/ppc/xics_spapr.h"
> > @@ -185,7 +186,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineS=
tate *spapr, Monitor *mon)
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        icp_pic_print_info(cpu->icp, mon);
> > +        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> >      }
> > =20
> >      ics_pic_print_info(spapr->ics, mon);
> > @@ -196,6 +197,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMac=
hineState *spapr,
> >  {
> >      Error *local_err =3D NULL;
> >      Object *obj;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > =20
> >      obj =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr=
),
> >                       &local_err);
> > @@ -204,7 +206,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMac=
hineState *spapr,
> >          return;
> >      }
> > =20
> > -    cpu->icp =3D ICP(obj);
> > +    spapr_cpu->icp =3D ICP(obj);
> >  }
> > =20
> >  static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int vers=
ion_id)
> > @@ -213,7 +215,7 @@ static int spapr_irq_post_load_xics(sPAPRMachineSta=
te *spapr, int version_id)
> >          CPUState *cs;
> >          CPU_FOREACH(cs) {
> >              PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -            icp_resend(cpu->icp);
> > +            icp_resend(spapr_cpu_state(cpu)->icp);
> >          }
> >      }
> >      return 0;
> > @@ -334,7 +336,7 @@ static void spapr_irq_print_info_xive(sPAPRMachineS=
tate *spapr,
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        xive_tctx_pic_print_info(cpu->tctx, mon);
> > +        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> >      }
> > =20
> >      spapr_xive_pic_print_info(spapr->xive, mon);
> > @@ -345,6 +347,7 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMac=
hineState *spapr,
> >  {
> >      Error *local_err =3D NULL;
> >      Object *obj;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > =20
> >      obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &l=
ocal_err);
> >      if (local_err) {
> > @@ -352,13 +355,13 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
> >          return;
> >      }
> > =20
> > -    cpu->tctx =3D XIVE_TCTX(obj);
> > +    spapr_cpu->tctx =3D XIVE_TCTX(obj);
> > =20
> >      /*
> >       * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> >       * don't beneficiate from the reset of the XIVE IRQ backend
> >       */
> > -    spapr_xive_set_tctx_os_cam(cpu->tctx);
> > +    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> >  }
> > =20
> >  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int vers=
ion_id)
> > @@ -374,7 +377,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState =
*spapr, Error **errp)
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> >          /* (TCG) Set the OS CAM line of the thread interrupt context. =
*/
> > -        spapr_xive_set_tctx_os_cam(cpu->tctx);
> > +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> >      }
> > =20
> >      /* Activate the XIVE MMIOs */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLxoAACgkQbDjKyiDZ
s5LsNQ//URvJg3xbV5yGN3U2+cXr65+nlZiu4ibhNe+E9PnSto+t672UMw6MIDlk
fLBaCl6Hw93rw5bAEdMI4otVE9FdHZpnWXQxv+FdehovwdxOHsjtJRFz0ggweJ2O
GQRHfZFItw+gkLOM2/D3VfaRuQDUAXAVTCGBVHYOtywtaqp6Klbt3+gtwerZOf81
2tSrztvf31IAy4VRrwwig4VuwSKG5J6iI8kloowZdLX6/b6u2I9sx4Kc4yFj89HS
l8yEdQA7WBHwSurCZWFM6dzzdaYDqHanmynSn40FSPtaN5ckAifaXND4J6pEOFoa
RFvhRynGZgVmz+23OhiOHA2rsbJEDKOqmHPmN76nnj8p83sHcFwYIF7Bx2VUqiUe
rxZgV+epuERlsBqB/8PKxNVIsx3KruJZy0sUJIpYP08LaGNwqBv3r7sTXt3kPdIw
quom/W/12hp4AN+E6OwvqBsq2Ap0d4FdcAuPCr3LhcPw6x/Moh+HMCRcjuP2dzDi
Xui2DPU8R0jja/BU39lroEl1AA/aTu+mbqq9VGnuBJF3JKUgUuhVZsdKThXqR6zm
V0cNfljSagrbqBwamjKMUs0aCCfUY3QoL9T6DpRamfch/2Q0Nypuombged3YIxDH
IHyEHDhWBOdYwG7PG/f4hsL2wLQn9pPqNJzemN09qb4AVE1yknU=
=8VYo
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
