Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcua-0006cj-8x
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcuX-0006Bc-SH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:48:20 -0400
Date: Fri, 15 Jun 2018 10:19:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615001951.GG4129@umbus.fritz.box>
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
	<20180614044129.13606-7-david@gibson.dropbear.id.au>
	<20180614153443.42951304@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <20180614153443.42951304@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv3 6/7] target/ppc: Replace intc pointer
 with a general machine_data pointer
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


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 03:34:43PM +0200, Greg Kurz wrote:
> On Thu, 14 Jun 2018 14:41:28 +1000
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
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
>=20
> Ouch... I am having some concerns with this patch now.
>=20
> First, I gave a try to CPU hotplug with the full series applied. It
> causes QEMU to crash:
>=20
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffee3feaa0 (LWP 23290)]
> kvm_arch_put_registers (cs=3D0x11497fd0, level=3D<optimized out>) at /hom=
e/greg/Work/qemu/qemu-spapr/target/ppc/kvm.c:1068
> 1068                if (kvm_put_vpa(cs) < 0) {
> (gdb) p ((PowerPCCPU *)cs)->machine_data
> $1 =3D (void *) 0x0
> (gdb) thread apply all bt
>=20
> Thread 6 (Thread 0x7fffee3feaa0 (LWP 23290)):
> #0  kvm_arch_put_registers (cs=3D0x11497fd0, level=3D<optimized out>) at =
/home/greg/Work/qemu/qemu-spapr/target/ppc/kvm.c:1068
> #1  0x00000000100b3a18 in do_kvm_cpu_synchronize_post_init (cpu=3D<optimi=
zed out>, arg=3D...) at /home/greg/Work/qemu/qemu-spapr/accel/kvm/kvm-all.c=
:1817
> #2  0x00000000102c2d18 in process_queued_cpu_work (cpu=3D<optimized out>)=
 at /home/greg/Work/qemu/qemu-spapr/cpus-common.c:342
> #3  0x0000000010081e88 in qemu_wait_io_event_common (cpu=3D0x11497fd0) at=
 /home/greg/Work/qemu/qemu-spapr/cpus.c:1158
> #4  0x0000000010081f38 in qemu_wait_io_event (cpu=3D0x11497fd0) at /home/=
greg/Work/qemu/qemu-spapr/cpus.c:1185
> #5  0x0000000010084248 in qemu_kvm_cpu_thread_fn (arg=3D0x11497fd0) at /h=
ome/greg/Work/qemu/qemu-spapr/cpus.c:1220
> #6  0x0000000010608cb0 in qemu_thread_start (args=3D0x10eb0510) at /home/=
greg/Work/qemu/qemu-spapr/util/qemu-thread-posix.c:507
> #7  0x00007ffff2758af4 in start_thread () from /lib64/libpthread.so.0
> #8  0x00007ffff2688814 in clone () from /lib64/libc.so.6
>=20
> [...]
>=20
> Thread 1 (Thread 0x7ffff0ee2650 (LWP 23234)):
> #0  0x00007ffff275e72c in pthread_cond_wait@@GLIBC_2.17 () from /lib64/li=
bpthread.so.0
> #1  0x00000000106095d0 in qemu_cond_wait_impl (cond=3D0x10cf7028 <qemu_wo=
rk_cond>, mutex=3D0x10cd4d60 <qemu_global_mutex>, file=3D0x107b2ea8 "/home/=
greg/Work/qemu/qemu-spapr/cpus-common.c", line=3D<optimized out>) at /home/=
greg/Work/qemu/qemu-spapr/util/qemu-thread-posix.c:164
> #2  0x00000000102c23d8 in do_run_on_cpu (cpu=3D<optimized out>, func=3D<o=
ptimized out>, data=3D..., mutex=3D0x10cd4d60 <qemu_global_mutex>) at /home=
/greg/Work/qemu/qemu-spapr/cpus-common.c:152
> #3  0x0000000010083cb0 in run_on_cpu (cpu=3D<optimized out>, func=3D<opti=
mized out>, data=3D...) at /home/greg/Work/qemu/qemu-spapr/cpus.c:1126
> #4  0x00000000100b4bc4 in kvm_cpu_synchronize_post_init (cpu=3D<optimized=
 out>) at /home/greg/Work/qemu/qemu-spapr/accel/kvm/kvm-all.c:1823
> #5  0x000000001047dbe8 in cpu_synchronize_post_init (cpu=3D0x11497fd0) at=
 /home/greg/Work/qemu/qemu-spapr/include/sysemu/hw_accel.h:48
> #6  cpu_common_realizefn (dev=3D0x11497fd0, errp=3D<optimized out>) at /h=
ome/greg/Work/qemu/qemu-spapr/qom/cpu.c:347
> #7  0x00000000101aded4 in ppc_cpu_realize (dev=3D0x11497fd0, errp=3D0x7ff=
fffffce50) at /home/greg/Work/qemu/qemu-spapr/target/ppc/translate_init.inc=
=2Ec:9695
> #8  0x0000000010326410 in device_set_realized (obj=3D0x11497fd0, value=3D=
<optimized out>, errp=3D0x7fffffffd080) at /home/greg/Work/qemu/qemu-spapr/=
hw/core/qdev.c:826
> #9  0x00000000104c6ae0 in property_set_bool (obj=3D0x11497fd0, v=3D<optim=
ized out>, name=3D<optimized out>, opaque=3D0x1182a120, errp=3D0x7fffffffd0=
80) at /home/greg/Work/qemu/qemu-spapr/qom/object.c:1930
> #10 0x00000000104c9838 in object_property_set (obj=3D0x11497fd0, v=3D0x11=
9a0e20, name=3D0x1074fd90 "realized", errp=3D0x7fffffffd080) at /home/greg/=
Work/qemu/qemu-spapr/qom/object.c:1122
> #11 0x00000000104ccd6c in object_property_set_qobject (obj=3D0x11497fd0, =
value=3D<optimized out>, name=3D<optimized out>, errp=3D<optimized out>) at=
 /home/greg/Work/qemu/qemu-spapr/qom/qom-qobject.c:27
> #12 0x00000000104c9b00 in object_property_set_bool (obj=3D0x11497fd0, val=
ue=3D<optimized out>, name=3D<optimized out>, errp=3D<optimized out>) at /h=
ome/greg/Work/qemu/qemu-spapr/qom/object.c:1188
> #13 0x0000000010168500 in spapr_realize_vcpu (errp=3D0x7fffffffd078, spap=
r=3D<optimized out>, cpu=3D0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/h=
w/ppc/spapr_cpu_core.c:143
>=20
> This happens when the core CPU realization code decides to copy the full
> set of registers to KVM, but the machine_data pointer is still NULL.
>=20
> So I think the fix belongs to this patch, see below.
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
> > index f7cf33f547..746bc5c2c5 100644
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
> > @@ -188,8 +191,12 @@ err:
> > =20
> >  static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> >  {
> > +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > +
> >      qemu_unregister_reset(pnv_cpu_reset, cpu);
> > -    object_unparent(cpu->intc);
> > +    object_unparent(OBJECT(pnv_cpu->icp));
> > +    cpu->machine_data =3D NULL;
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
>=20
> machine_data is a cpu attribute and all users of spapr_cpu_state() assume=
 it
> is always valid. It should be set before any code tries to dereference it,
> which I believe cannot happen before the call to object_property_set_bool=
().
> So I guess setting it at the beginning of the function should be fine (at
> least, it fixes the crash).

Ah, good point.  I've moved it up before setting realized, for both
spapr and pnv.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjBicACgkQbDjKyiDZ
s5LdSRAApO5dVsvE1NIZ4wQVxYjN0vi8Pw3GSjkRCZ1cHy3apduGZuHOIPZ2w7oL
5vuJloDJWAd+X2/VVCO9ASBGu621KCNtlkzpH2j8+inZrYVNCKNRHQkVw9sMwnNX
den579aZhdAFlpcC17wltDaIdAbuzF19L0jTA9QDTQotOJupiv50CRHqiq0bCl8s
98kxGdICGOsOXwqd3vOqpDYHubD1OJaWGytOO37ze6qegDuwLuVT6wSQzkcOGgll
PxtNGIiLwzpJowuXP6u9eyICHdsBCFlXSXlKF2icOWWn/e3JXwJaksKGcVqYYeDd
MgAz8R8j+dWNBm1J4SNF1dR50boj2pTJDo8trKKv3MknKFofmnpCmWXe5JNCdPqp
+dkG6F40qftdBU/NWMD+wK1Jj9RohDJqc6KItpZ8Myb5ycxt3j/rl2WKH1uAYB4c
l9yV6WDfRfvUeUrGEAimH/65eBOyyITfj4TUt8runNTBnDptzyyzRRNnx2b4Z8i0
wW7AHHoz/TiRCT6+D4IzNCrjn9uMXeXawLPnKXtCrOtEQfs4EUjc5BSonvl9Zl09
L6cwn68tuT+xbsqd9n6kitazUaGB96aV63u29vil/2SIAUYuMpxIMy6+5DrT+ged
EdBZEIbtEyJ5MVyNmO0gojKXm0WmcpQJbXObTdAdcfv0bcxgPUI=
=qBww
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
