Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2pU-0006T8-M8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2pS-000637-HD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:16:40 -0400
Date: Wed, 13 Jun 2018 20:15:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613101537.GL30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-7-david@gibson.dropbear.id.au>
	<20180613121112.39eccc06@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzNDI+ywLU1Yk1Ay"
Content-Disposition: inline
In-Reply-To: <20180613121112.39eccc06@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] target/ppc: Replace intc pointer with
 a general machine_data pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--NzNDI+ywLU1Yk1Ay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 12:11:12PM +0200, Greg Kurz wrote:
> On Wed, 13 Jun 2018 16:57:06 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > PowerPCCPU contains an (Object *)intc used to point to the cpu's interr=
upt
> > controller.  Or more precisely to the "presentation" component of the
> > interrupt controller relevant to this cpu.
> >=20
> > Really, this field is machine specific.  The machines which use it can
> > point it to different types of object depending on their needs, and most
> > machines don't use it at all (since they have older style PICs which do=
n't
> > have per-cpu presentation components).
> >=20
> > There's also other information that's per-cpu, but platform/machine
> > specific.  So replace the intc pointer with a (void *)machine_data which
> > can be managed as the machine type likes to conveniently store per cpu
> > information.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> This looks good, just one question below...
>=20
> >  hw/intc/xics.c                  |  5 +++--
> >  hw/intc/xics_spapr.c            | 16 +++++++++++-----
> >  hw/ppc/pnv.c                    |  4 ++--
> >  hw/ppc/pnv_core.c               | 11 +++++++++--
> >  hw/ppc/spapr.c                  |  8 ++++----
> >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++---
> >  include/hw/ppc/pnv_core.h       |  9 +++++++++
> >  include/hw/ppc/spapr_cpu_core.h | 10 ++++++++++
> >  include/hw/ppc/xics.h           |  4 ++--
> >  target/ppc/cpu.h                |  2 +-
> >  10 files changed, 61 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index e73e623e3b..689ad44e5f 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -383,7 +383,8 @@ static const TypeInfo icp_info =3D {
> >      .class_size =3D sizeof(ICPStateClass),
> >  };
> > =20
> > -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Erro=
r **errp)
> > +ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> > +                     Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> >      Object *obj;
> > @@ -401,7 +402,7 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi, Error **errp)
> >          obj =3D NULL;
> >      }
> > =20
> > -    return obj;
> > +    return ICP(obj);
> >  }
> > =20
> >  /*
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 2e27b92b87..01c76717cf 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -31,6 +31,7 @@
> >  #include "trace.h"
> >  #include "qemu/timer.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/ppc/xics.h"
> >  #include "hw/ppc/fdt.h"
> >  #include "qapi/visitor.h"
> > @@ -43,8 +44,9 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
> >                             target_ulong opcode, target_ulong *args)
> >  {
> >      target_ulong cppr =3D args[0];
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > =20
> > -    icp_set_cppr(ICP(cpu->intc), cppr);
> > +    icp_set_cppr(spapr_cpu->icp, cppr);
> >      return H_SUCCESS;
> >  }
> > =20
> > @@ -65,7 +67,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
> >  static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >                             target_ulong opcode, target_ulong *args)
> >  {
> > -    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +    uint32_t xirr =3D icp_accept(spapr_cpu->icp);
> > =20
> >      args[0] =3D xirr;
> >      return H_SUCCESS;
> > @@ -74,7 +77,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
> >  static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >                               target_ulong opcode, target_ulong *args)
> >  {
> > -    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +    uint32_t xirr =3D icp_accept(spapr_cpu->icp);
> > =20
> >      args[0] =3D xirr;
> >      args[1] =3D cpu_get_host_ticks();
> > @@ -84,9 +88,10 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
> >  static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >                            target_ulong opcode, target_ulong *args)
> >  {
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      target_ulong xirr =3D args[0];
> > =20
> > -    icp_eoi(ICP(cpu->intc), xirr);
> > +    icp_eoi(spapr_cpu->icp, xirr);
> >      return H_SUCCESS;
> >  }
> > =20
> > @@ -94,7 +99,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> >                              target_ulong opcode, target_ulong *args)
> >  {
> >      uint32_t mfrr;
> > -    uint32_t xirr =3D icp_ipoll(ICP(cpu->intc), &mfrr);
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +    uint32_t xirr =3D icp_ipoll(spapr_cpu->icp, &mfrr);
> > =20
> >      args[0] =3D xirr;
> >      args[1] =3D mfrr;
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 0b9508d94d..3a36c6ac6a 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1013,7 +1013,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int =
pir)
> >  {
> >      PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> > =20
> > -    return cpu ? ICP(cpu->intc) : NULL;
> > +    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
> >  }
> > =20
> >  static void pnv_pic_print_info(InterruptStatsProvider *obj,
> > @@ -1026,7 +1026,7 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        icp_pic_print_info(ICP(cpu->intc), mon);
> > +        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
> >      }
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index c70dbbe056..86448ade87 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -105,6 +105,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSF=
abric *xi, Error **errp)
> >      int core_pir;
> >      int thread_index =3D 0; /* TODO: TCG supports only one thread */
> >      ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
> > +    PnvCPUState *pnv_cpu;
> >      Error *local_err =3D NULL;
> > =20
> >      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
> > @@ -113,7 +114,9 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSF=
abric *xi, Error **errp)
> >          return;
> >      }
> > =20
> > -    cpu->intc =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err=
);
> > +    cpu->machine_data =3D pnv_cpu =3D g_new0(PnvCPUState, 1);
> > +
> > +    pnv_cpu->icp =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_=
err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > @@ -194,8 +197,12 @@ err:
> > =20
> >  static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> >  {
> > +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > +
> >      qemu_unregister_reset(pnv_cpu_reset, cpu);
> > -    object_unparent(cpu->intc);
> > +    object_unparent(OBJECT(pnv_cpu->icp));
> > +    cpu->machine_data =3D NULL;
>=20
> Is this really needed ? I mean cpu is supposed to be freed by
> object_unparent() below, right ? Is there a case where we would
> dereference this anyway ?

It's probably not necessary.  But, it's not a hot path, so I figured
might as well be paranoid.  If it goes horribly wrong, a NULL
dereference is probably easier to debug than a random stale pointer
dereference.

> In all cases, better safe than sorry, so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +    g_free(pnv_cpu);
> >      cpu_remove_sync(CPU(cpu));
> >      object_unparent(OBJECT(cpu));
> >  }
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f59999daac..cbab6b6b7e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1745,8 +1745,8 @@ static int spapr_post_load(void *opaque, int vers=
ion_id)
> >      if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
> >          CPUState *cs;
> >          CPU_FOREACH(cs) {
> > -            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -            icp_resend(ICP(cpu->intc));
> > +            sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(POWERPC_CPU(c=
s));
> > +            icp_resend(spapr_cpu->icp);
> >          }
> >      }
> > =20
> > @@ -3783,7 +3783,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, in=
t vcpu_id)
> >  {
> >      PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
> > =20
> > -    return cpu ? ICP(cpu->intc) : NULL;
> > +    return cpu ? spapr_cpu_state(cpu)->icp : NULL;
> >  }
> > =20
> >  #define ICS_IRQ_FREE(ics, srcno)   \
> > @@ -3925,7 +3925,7 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        icp_pic_print_info(ICP(cpu->intc), mon);
> > +        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> >      }
> > =20
> >      ics_pic_print_info(spapr->ics, mon);
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 7fdb3b6667..544bda93e2 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -104,8 +104,12 @@ const char *spapr_get_cpu_core_type(const char *cp=
u_type)
> > =20
> >  static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
> >  {
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> >      qemu_unregister_reset(spapr_cpu_reset, cpu);
> > -    object_unparent(cpu->intc);
> > +    object_unparent(OBJECT(spapr_cpu->icp));
> > +    cpu->machine_data =3D NULL;
> > +    g_free(spapr_cpu);
> >      cpu_remove_sync(CPU(cpu));
> >      object_unparent(OBJECT(cpu));
> >  }
> > @@ -127,12 +131,15 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> >      Error *local_err =3D NULL;
> > +    sPAPRCPUState *spapr_cpu;
> > =20
> >      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
> >      if (local_err) {
> >          goto error;
> >      }
> > =20
> > +    spapr_cpu =3D cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
> > +
> >      /* Set time-base frequency to 512 MHz */
> >      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> > =20
> > @@ -142,8 +149,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> >      spapr_cpu_reset(cpu);
> > =20
> > -    cpu->intc =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC=
(spapr),
> > -                           &local_err);
> > +    spapr_cpu->icp =3D icp_create(OBJECT(cpu), spapr->icp_type,
> > +                                XICS_FABRIC(spapr), &local_err);
> >      if (local_err) {
> >          goto error;
> >      }
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index 447ae761f7..f81dff28aa 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
> >  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> >  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> > =20
> > +typedef struct PnvCPUState {
> > +    ICPState *icp;
> > +} PnvCPUState;
> > +
> > +static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
> > +{
> > +    return cpu->machine_data;
> > +}
> > +
> >  #endif /* _PPC_PNV_CORE_H */
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 47dcfda12b..e3d2aa45a4 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -41,4 +41,14 @@ typedef struct sPAPRCPUCoreClass {
> >  const char *spapr_get_cpu_core_type(const char *cpu_type);
> >  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3);
> > =20
> > +typedef struct ICPState ICPState;
> > +typedef struct sPAPRCPUState {
> > +    ICPState *icp;
> > +} sPAPRCPUState;
> > +
> > +static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
> > +{
> > +    return (sPAPRCPUState *)cpu->machine_data;
> > +}
> > +
> >  #endif
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 6cebff47a7..48930d91e5 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -207,7 +207,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
> >  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> >  void xics_spapr_init(sPAPRMachineState *spapr);
> > =20
> > -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> > -                   Error **errp);
> > +ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> > +                     Error **errp);
> > =20
> >  #endif /* XICS_H */
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index a91f1a8777..abf0bf0224 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1204,7 +1204,7 @@ struct PowerPCCPU {
> >      int vcpu_id;
> >      uint32_t compat_pvr;
> >      PPCVirtualHypervisor *vhyp;
> > -    Object *intc;
> > +    void *machine_data;
> >      int32_t node_id; /* NUMA node this CPU belongs to */
> >      PPCHash64Options *hash64_opts;
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzNDI+ywLU1Yk1Ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg7sYACgkQbDjKyiDZ
s5I3nA//XAgHJes+8p/2xGjbRfHlJVxdOFdikBPLi6OLjmNOJzswzU5AOkbGRTdt
fH5WE4Ta/F7xtoGDlJ7EagcbPPAYY9S/UAMlrmGHM34NJGE5Z84KgWxaJYvtwSu6
XlTe6QrG2qVEpI+HP2//QVzsG42PuLN4bcFa+6anOz2rtz2bxpnnbpN9TGiisFDa
0QLGTJdp3kRFwKKE2QNzYxH0SuXGJT6fvKwU2NWfb2wYNggKZa2OU0MuZuFWqrUv
sGPlcdwzxesBbPyJTTSwUN9AA03CZEP/TwyQZU6tT1cGuziOYlRazIdJ2GdUM4sx
Y3sNzuVAuSZaW0m585qzfLWSUrGFqY3Y6JSEGJtzww5Bqvxnt4dWF6rVVVVva++j
/LW4MLNCVFshUXj8hFJtB9NfAjgU+ao85OyHhUDAyqhpBQ5KHoZfFUYHDaIaII+7
u/QbaZhUhqDeaxc7E9kKy0bVNl/UFqBnyKJkd6oN20FFTit+g2L4oGsOPNdifKpZ
TVHQ1qwrA2koAesnIV2tYnVAZUgxNgTkgtCpnHGxkM9hLWt8iTQrBF2jI+jDYSff
5uLKTSldKMoL/QauBzbMCwXTeVX8LYzcY5Iu9Odtoz9aDlRjU2IvFRnhx6JqNGxy
M4XW+j7KQ+ZMj1ND9AjFTQbbTzyGzXQjlqngZL7W04zp9k8UITU=
=KNQQ
-----END PGP SIGNATURE-----

--NzNDI+ywLU1Yk1Ay--
