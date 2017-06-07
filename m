Received: from eggs.gnu.org ([2001:4830:134:3::10]:41184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIhz8-0007Zy-EO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIhz3-00045W-HA
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:55:22 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:47739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIhz3-00045E-7X
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:55:17 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6C4F53DE52
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 22:55:15 +0200 (CEST)
Date: Wed, 7 Jun 2017 22:55:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
In-Reply-To: <c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SrWEfUWnDEjtyXFJjmlGwbb";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/SrWEfUWnDEjtyXFJjmlGwbb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jun 2017 20:11:38 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/07/2017 07:17 PM, Greg Kurz wrote:
> > Until recently, spapr used to allocate ICPState objects for the lifetime
> > of the machine. They would only be associated to vCPUs in xics_cpu_setu=
p()
> > when plugging a CPU core.
> >=20
> > Now that ICPState objects have the same lifecycle as vCPUs, it is
> > possible to associate them during realization.
> >=20
> > This patch hence open-codes xics_cpu_setup() in icp_realize(). The vCPU
> > is passed as a property. Note that vCPU now needs to be realized first
> > for the IRQs to be allocated. It also needs to resetted before ICPState
> > realization in order to synchronize with KVM.
> >=20
> > Since ICPState objects are freed when unrealized, xics_cpu_destroy() is=
n't
> > needed anymore and can be safely dropped. =20
>=20
> I like the idea but I think the assignment of ->cs attribute should be=20
> moved under icp_kvm_cpu_setup(), as it is only used under xics_kvm by=20
> the kvm_vcpu_ioctl() calls.=20
>=20

Well, cs->cpu_index is also used for traces and to implement the 'info pic'
monitor command.

> Ideally, we should also introduce :
>=20
> 	struct KvmState {
> 	    ICPState parent_obj;
> =09
> 	    CPUState *cs;
> 	};
>=20
> That would be cleaner, but that might introduce some migration compat=20
> issues  again ...
>=20

No, as long as it doesn't change state, we're good. My concern is more
about how to pass cs to xics_kvm and the cs->cpu_index to xics.

> Some minor comments below,
>=20
> Thanks,
>=20
> C.=20
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics.c          |   76 ++++++++++++++++++++-------------------=
--------
> >  hw/ppc/pnv_core.c       |   16 ++++------
> >  hw/ppc/spapr_cpu_core.c |   21 ++++++-------
> >  include/hw/ppc/xics.h   |    2 -
> >  4 files changed, 48 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index ec73f02144c9..330441ff7fe8 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -38,50 +38,6 @@
> >  #include "monitor/monitor.h"
> >  #include "hw/intc/intc.h"
> > =20
> > -void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
> > -{
> > -    CPUState *cs =3D CPU(cpu);
> > -    ICPState *icp =3D ICP(cpu->intc);
> > -
> > -    assert(icp);
> > -    assert(cs =3D=3D icp->cs);
> > -
> > -    icp->output =3D NULL;
> > -    icp->cs =3D NULL;
> > -}
> > -
> > -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp)
> > -{
> > -    CPUState *cs =3D CPU(cpu);
> > -    CPUPPCState *env =3D &cpu->env;
> > -    ICPStateClass *icpc;
> > -
> > -    assert(icp);
> > -
> > -    cpu->intc =3D OBJECT(icp);
> > -    icp->cs =3D cs;
> > -
> > -    icpc =3D ICP_GET_CLASS(icp);
> > -    if (icpc->cpu_setup) {
> > -        icpc->cpu_setup(icp, cpu);
> > -    }
> > -
> > -    switch (PPC_INPUT(env)) {
> > -    case PPC_FLAGS_INPUT_POWER7:
> > -        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
> > -        break;
> > -
> > -    case PPC_FLAGS_INPUT_970:
> > -        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
> > -        break;
> > -
> > -    default:
> > -        error_report("XICS interrupt controller does not support this =
CPU "
> > -                     "bus model");
> > -        abort();
> > -    }
> > -}
> > -
> >  void icp_pic_print_info(ICPState *icp, Monitor *mon)
> >  {
> >      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> > @@ -343,6 +299,8 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
> >  {
> >      ICPState *icp =3D ICP(dev);
> >      ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> > +    PowerPCCPU *cpu;
> > +    CPUPPCState *env;
> >      Object *obj;
> >      Error *err =3D NULL;
> > =20
> > @@ -355,6 +313,36 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
> > =20
> >      icp->xics =3D XICS_FABRIC(obj);
> > =20
> > +    obj =3D object_property_get_link(OBJECT(dev), "cs", &err);
> > +    if (!obj) {
> > +        error_setg(errp, "%s: required link 'xics' not found: %s",
> > +                   __func__, error_get_pretty(err));
> > +        return;
> > +    }
> > +
> > +    cpu =3D POWERPC_CPU(obj);
> > +    cpu->intc =3D OBJECT(icp);
> > +    icp->cs =3D CPU(obj); =20
>=20
> only xics_kvm needs ->cs.=20
>=20

yeah, maybe the base class should only have a cpu_index field:

    icp->cpu_index =3D CPU(obj)->cpu_index;

> > +
> > +    if (icpc->cpu_setup) {
> > +        icpc->cpu_setup(icp, cpu);
> > +    }
> > +
> > +    env =3D &cpu->env;
> > +    switch (PPC_INPUT(env)) {
> > +    case PPC_FLAGS_INPUT_POWER7:
> > +        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
> > +        break;
> > +
> > +    case PPC_FLAGS_INPUT_970:
> > +        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
> > +        break;
> > +
> > +    default:
> > +        error_setg(errp, "XICS interrupt controller does not support t=
his CPU bus model");
> > +        return;
> > +    }
> > +
> >      if (icpc->realize) {
> >          icpc->realize(dev, errp);
> >      }
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index e8a9a94d5a24..1393005e76f3 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -118,19 +118,19 @@ static void pnv_core_realize_child(Object *child,=
 XICSFabric *xi, Error **errp)
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      Object *obj;
> > =20
> > -    obj =3D object_new(TYPE_PNV_ICP);
> > -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> > -    object_unref(obj);
> > -    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abo=
rt);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > +    object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > =20
> > -    object_property_set_bool(child, true, "realized", &local_err);
> > +    obj =3D object_new(TYPE_PNV_ICP);
> > +    object_property_add_child(child, "icp", obj, NULL);
> > +    object_unref(obj);
> > +    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abo=
rt);
> > +    object_property_add_const_link(obj, "cs", child, &error_abort); =20
>=20
> may be link the cpu object instead ?=20
>=20

I'm not sure to understand... isn't child supposed to be a CPU index here ?

> > +    object_property_set_bool(obj, true, "realized", &local_err);
> >      if (local_err) {
> > -        object_unparent(obj);
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > @@ -141,8 +141,6 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > -
> > -    xics_cpu_setup(xi, cpu, ICP(obj));
> >  }
> > =20
> >  static void pnv_core_realize(DeviceState *dev, Error **errp)
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 029a14120edd..9a6259525953 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -53,9 +53,6 @@ static void spapr_cpu_reset(void *opaque)
> > =20
> >  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> >  {
> > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > -
> > -    xics_cpu_destroy(XICS_FABRIC(spapr), cpu);
> >      qemu_unregister_reset(spapr_cpu_reset, cpu);
> >  }
> > =20
> > @@ -140,28 +137,28 @@ static void spapr_cpu_core_realize_child(Object *=
child, Error **errp)
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >      CPUState *cs =3D CPU(child);
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    Object *obj;
> > +    Object *obj =3D NULL;
> > =20
> > -    obj =3D object_new(spapr->icp_type);
> > -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> > -    object_unref(obj);
> > -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_=
abort);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > +    object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> >          goto error;
> >      }
> > =20
> > -    object_property_set_bool(child, true, "realized", &local_err);
> > +    spapr_cpu_init(spapr, cpu, &local_err);
> >      if (local_err) {
> >          goto error;
> >      }
> > =20
> > -    spapr_cpu_init(spapr, cpu, &local_err);
> > +    obj =3D object_new(spapr->icp_type);
> > +    object_property_add_child(child, "icp", obj, &error_abort);
> > +    object_unref(obj);
> > +    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_=
abort);
> > +    object_property_add_const_link(obj, "cs", child, &error_abort); =20
>=20
> same here.
>=20
> > +    object_property_set_bool(obj, true, "realized", &local_err);
> >      if (local_err) {
> >          goto error;
> >      }
> > =20
> > -    xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
> >      return;
> > =20
> >  error:
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 40a506eacfb4..05767a15be9a 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -183,8 +183,6 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint3=
2_t phandle);
> > =20
> >  qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
> >  ICPState *xics_icp_get(XICSFabric *xi, int server);
> > -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp);
> > -void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
> > =20
> >  /* Internal XICS interfaces */
> >  void icp_set_cppr(ICPState *icp, uint8_t cppr);
> >  =20
>=20


--Sig_/SrWEfUWnDEjtyXFJjmlGwbb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk4aCsACgkQAvw66wEB28JFKACggDn6lIPI4wFI7XHe/YYyeFAS
ofQAnA2P4Pkh4PRwsPQVnEBdP9sn9wiS
=AW+u
-----END PGP SIGNATURE-----

--Sig_/SrWEfUWnDEjtyXFJjmlGwbb--
