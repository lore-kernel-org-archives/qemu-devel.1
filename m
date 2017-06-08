Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIt4Z-0000h1-Oz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIt4W-00042h-Gx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:45:43 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:54407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIt4W-00041g-75
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:45:40 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6136C37A3E
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 10:45:37 +0200 (CEST)
Date: Thu, 8 Jun 2017 10:45:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608104530.65b7d53e@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608020112.GT13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<20170608020112.GT13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/sebk755XxX330LY7a_ENh45";
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/sebk755XxX330LY7a_ENh45
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 12:01:12 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 07, 2017 at 07:17:09PM +0200, Greg Kurz wrote:
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
> > realization in order to synchronize with KVM. =20
>=20
> Ok, what enforces those ordering constraints?
>=20

I'm not sure about what you're asking... I had to re-order because
xics_cpu_setup() used to be called after the vCPU is realized and
put in PAPR mode.

Especially, we have these lines:

    switch (PPC_INPUT(env)) {
    case PPC_FLAGS_INPUT_POWER7:
        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
        break;

    case PPC_FLAGS_INPUT_970:
        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
        break;

They depend on env->irq_inputs being allocated. This happens on the

spapr_cpu_core_realize_child()
{
    ...
    object_property_set_bool(child, true, "realized", &local_err);
     object_property_set_bool()
      object_property_set_qobject()
       object_property_set()
        property_set_bool()
         device_set_realized()
          ppc_cpu_realizefn()
           init_ppc_proc()
            init_proc_POWER8()
             ppcPOWER7_irq_init()

and, when using xics_kvm:

icp_kvm_cpu_setup()
{
    ...
    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd, vc=
pu_id);

This ioctl returns EINVAL because it fails the kvmppc_sanity_check() in KVM.

It depends on QEMU enabling KVM_CAP_PPC_PAPR for the vCPU, which happens in:

spapr_cpu_core_realize_child()
{
    ...
    spapr_cpu_init(spapr, cpu, &local_err);
     cpu_ppc_set_papr()
      kvmppc_set_papr()

> > Since ICPState objects are freed when unrealized, xics_cpu_destroy() is=
n't
> > needed anymore and can be safely dropped.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
>=20
> Looks pretty good, though a couple nits below.
>=20

Thanks. I'm also thinking about going one step further and converting
xics_kvm to use the icpc->realize() handler instead of icpc->cpu_setup().
Makes sense ?

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
> > +    obj =3D object_property_get_link(OBJECT(dev), "cs", &err); =20
>=20
> I don't like the name "cs" for an externally visible property.  "cpu"
> would be better.
>=20

Right. I'll fix this.

> > +    if (!obj) {
> > +        error_setg(errp, "%s: required link 'xics' not found: %s", =20
>=20
> Copy/paste mistake in this message.
>=20

Oops :)

> > +                   __func__, error_get_pretty(err));
> > +        return;
> > +    }
> > +
> > +    cpu =3D POWERPC_CPU(obj);
> > +    cpu->intc =3D OBJECT(icp);
> > +    icp->cs =3D CPU(obj);
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
> > +    object_property_add_const_link(obj, "cs", child, &error_abort);
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
> > +    object_property_add_const_link(obj, "cs", child, &error_abort);
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


--Sig_/sebk755XxX330LY7a_ENh45
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5DqoACgkQAvw66wEB28IuRgCdERPIPS50y84VxAS9nJ7dTS9r
7uoAn2PF14P2ePiOIT8T2mvG4NxgxR37
=/l6G
-----END PGP SIGNATURE-----

--Sig_/sebk755XxX330LY7a_ENh45--
