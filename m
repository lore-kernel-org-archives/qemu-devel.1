Received: from eggs.gnu.org ([2001:4830:134:3::10]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdXMr-00068a-HR
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdXMm-0007O8-FX
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:54:29 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:59761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fdXMm-0007L5-50
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:54:24 -0400
Received: from player737.ha.ovh.net (unknown [10.109.105.46])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 65EF6D7EE8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 10:54:22 +0200 (CEST)
Date: Thu, 12 Jul 2018 10:54:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180712105411.1b730451@bahia.lan>
In-Reply-To: <20180712044034.GS22363@umbus.fritz.box>
References: <153123811483.256409.15360824885082888930.stgit@bahia.lan>
	<20180711012802.GN22363@umbus.fritz.box>
	<20180711112641.4e56c25b@bahia.lan>
	<20180712044034.GS22363@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/B5GP5=BxnywxA2wDwsY4jju";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: split ICP into icp-base and icp
 class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

--Sig_/B5GP5=BxnywxA2wDwsY4jju
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jul 2018 14:40:34 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 11, 2018 at 11:26:41AM +0200, Greg Kurz wrote:
> > On Wed, 11 Jul 2018 11:28:02 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Tue, Jul 10, 2018 at 05:55:14PM +0200, Greg Kurz wrote: =20
> > > > Recent cleanup in commit a028dd423ee6 causes QEMU to crash during C=
PU
> > > > hotplug:
> > > >=20
> > > > (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> > > > Segmentation fault (core dumped)
> > > >=20
> > > > When the hotplug path tries to reset the ICP device, we end
> > > > up calling:
> > > >=20
> > > > static void icp_kvm_reset(DeviceState *dev)
> > > > {
> > > >     ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> > > >=20
> > > >     icpc->parent_reset(dev);
> > > >=20
> > > > but icpc->parent_reset is NULL.   =20
> > >=20
> > > This seems terribly complex to address this symptom.  Couldn't we just
> > > do a
> > >=20
> > > 	if (icpc->parent_reset)
> > > 		icpc->parent_reset(dev);
> > >=20
> > > ?
> > >  =20
> >=20
> > This would certainly avoid the SEGV but this would mean that
> > we skip icp_reset() for hot plugged ICPs... and it doesn't
> > address the fact that icp_kvm_reset() is never called for cold
> > plugged ones. =20
>=20
> Ah, yeah, duh.
>=20
> > Commit a028dd423ee6 inverted the control: icp_reset() no
> > longer calls per-ICP type reset function. It is up to each
> > type to call icp_reset(). =20
>=20
> Hrm.. could we have icp_realize() do a qemu_register_reset() on
> dc->reset, rather than on icp_reset() directly.  And make sure the
> base class sets dc->reset correctly too, of course.
>=20
> I think that'll accomplish what we want without rearranging the class
> structure again.
>=20

Yeah, that should work.


> > Maybe I can split the patch to ease review. But if you're really
> > seeking simplicity, the best call is probably to simply revert
> > a028dd423ee6 at this point. =20
>=20
>=20
>=20
>=20
> >  =20
> > > > Indeed, the TYPE_ICP class doesn't implement DeviceClass::reset, but
> > > > rather directly registers a reset handler with qemu_register_reset(=
).
> > > > This is done this way because ICPs aren't SysBus devices but we want
> > > > machine reset to reset them anyway (commit 7ea6e0671754).
> > > >=20
> > > > The crash also proves that ipc_kvm_reset() is obviously not called =
for
> > > > cold plugged devices, ie, TYPE_ICP_KVM should register its own hand=
ler
> > > > with qemu_register_reset().
> > > >=20
> > > > The motivation of commit a028dd423ee6 to have cleaner object patter=
ns
> > > > is good, but it means that all specialized ICP types should register
> > > > their own reset handler to be called at machine reset.
> > > >=20
> > > > So this patchs converts the current TYPE_ICP class into an abstract
> > > > TYPE_ICP_BASE class that implements DeviceClass::reset instead of
> > > > calling qemu_register_reset().
> > > >=20
> > > > The _new_ TYPE_ICP class is derived from TYPE_ICP_BASE to cover the
> > > > the pseries.kernel-irqchip=3Doff case. It merely registers a reset
> > > > handler with qemu_register_reset(). Its device class functions
> > > > are renamed as icp_simple_* to avoid confusion with the base class.
> > > >=20
> > > > All other specialized ICP types are also converted to register their
> > > > own reset handler as well.
> > > >=20
> > > > This matches what we already have with ICS.
> > > >=20
> > > > Since we support CPU hot unplug with spapr, unrealize functions
> > > > are added to TYPE_ICP and TYPE_ICP_KVM so that they can call
> > > > qemu_unregister_reset().
> > > >=20
> > > > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > > > Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >=20
> > > > I've successfully tested the following:
> > > > - pseries with in-kernel XICS
> > > > - pseries with emulated XICS
> > > > - powernv
> > > > - migration of pseries, including migration to QEMU 2.12 and back
> > > > ---
> > > >  hw/intc/xics.c        |   97 +++++++++++++++++++++++++++++++++++++=
+++---------
> > > >  hw/intc/xics_kvm.c    |   27 +++++++++++---
> > > >  hw/intc/xics_pnv.c    |   27 +++++++++++---
> > > >  include/hw/ppc/xics.h |   12 ++++--
> > > >  4 files changed, 129 insertions(+), 34 deletions(-)
> > > >=20
> > > > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > > > index b9f1a3c97214..b478b9120062 100644
> > > > --- a/hw/intc/xics.c
> > > > +++ b/hw/intc/xics.c
> > > > @@ -40,7 +40,7 @@
> > > > =20
> > > >  void icp_pic_print_info(ICPState *icp, Monitor *mon)
> > > >  {
> > > > -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(icp);
> > > >      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> > > > =20
> > > >      if (!icp->output) {
> > > > @@ -255,7 +255,7 @@ static void icp_irq(ICSState *ics, int server, =
int nr, uint8_t priority)
> > > >  static int icp_dispatch_pre_save(void *opaque)
> > > >  {
> > > >      ICPState *icp =3D opaque;
> > > > -    ICPStateClass *info =3D ICP_GET_CLASS(icp);
> > > > +    ICPStateClass *info =3D ICP_BASE_GET_CLASS(icp);
> > > > =20
> > > >      if (info->pre_save) {
> > > >          info->pre_save(icp);
> > > > @@ -267,7 +267,7 @@ static int icp_dispatch_pre_save(void *opaque)
> > > >  static int icp_dispatch_post_load(void *opaque, int version_id)
> > > >  {
> > > >      ICPState *icp =3D opaque;
> > > > -    ICPStateClass *info =3D ICP_GET_CLASS(icp);
> > > > +    ICPStateClass *info =3D ICP_BASE_GET_CLASS(icp);
> > > > =20
> > > >      if (info->post_load) {
> > > >          return info->post_load(icp, version_id);
> > > > @@ -291,9 +291,9 @@ static const VMStateDescription vmstate_icp_ser=
ver =3D {
> > > >      },
> > > >  };
> > > > =20
> > > > -static void icp_reset(void *dev)
> > > > +static void icp_base_reset(DeviceState *dev)
> > > >  {
> > > > -    ICPState *icp =3D ICP(dev);
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > > =20
> > > >      icp->xirr =3D 0;
> > > >      icp->pending_priority =3D 0xff;
> > > > @@ -303,9 +303,9 @@ static void icp_reset(void *dev)
> > > >      qemu_set_irq(icp->output, 0);
> > > >  }
> > > > =20
> > > > -static void icp_realize(DeviceState *dev, Error **errp)
> > > > +static void icp_base_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > > -    ICPState *icp =3D ICP(dev);
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > >      PowerPCCPU *cpu;
> > > >      CPUPPCState *env;
> > > >      Object *obj;
> > > > @@ -345,31 +345,91 @@ static void icp_realize(DeviceState *dev, Err=
or **errp)
> > > >          return;
> > > >      }
> > > > =20
> > > > -    qemu_register_reset(icp_reset, dev);
> > > >      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server=
, icp);
> > > >  }
> > > > =20
> > > > -static void icp_unrealize(DeviceState *dev, Error **errp)
> > > > +static void icp_base_unrealize(DeviceState *dev, Error **errp)
> > > >  {
> > > > -    ICPState *icp =3D ICP(dev);
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > > =20
> > > >      vmstate_unregister(NULL, &vmstate_icp_server, icp);
> > > > -    qemu_unregister_reset(icp_reset, dev);
> > > >  }
> > > > =20
> > > > -static void icp_class_init(ObjectClass *klass, void *data)
> > > > +static void icp_base_class_init(ObjectClass *klass, void *data)
> > > >  {
> > > >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > =20
> > > > -    dc->realize =3D icp_realize;
> > > > -    dc->unrealize =3D icp_unrealize;
> > > > +    dc->realize =3D icp_base_realize;
> > > > +    dc->unrealize =3D icp_base_unrealize;
> > > > +    dc->reset =3D icp_base_reset;
> > > >  }
> > > > =20
> > > > -static const TypeInfo icp_info =3D {
> > > > -    .name =3D TYPE_ICP,
> > > > +static const TypeInfo icp_base_info =3D {
> > > > +    .name =3D TYPE_ICP_BASE,
> > > >      .parent =3D TYPE_DEVICE,
> > > >      .instance_size =3D sizeof(ICPState),
> > > > -    .class_init =3D icp_class_init,
> > > > +    .class_init =3D icp_base_class_init,
> > > > +    .class_size =3D sizeof(ICPStateClass),
> > > > +    .abstract =3D true,
> > > > +};
> > > > +
> > > > +static void icp_simple_reset(DeviceState *dev)
> > > > +{
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(dev);
> > > > +
> > > > +    icpc->parent_reset(dev);
> > > > +}
> > > > +
> > > > +static void icp_simple_reset_handler(void *dev)
> > > > +{
> > > > +    icp_simple_reset(dev);
> > > > +}
> > > > +
> > > > +static void icp_simple_realize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(dev);
> > > > +    Error *local_err =3D NULL;
> > > > +
> > > > +    icpc->parent_realize(dev, &local_err);
> > > > +    if (local_err) {
> > > > +        error_propagate(errp, local_err);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    qemu_register_reset(icp_simple_reset_handler, dev);
> > > > +}
> > > > +
> > > > +static void icp_simple_unrealize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(dev);
> > > > +    Error *local_err =3D NULL;
> > > > +
> > > > +    icpc->parent_unrealize(dev, &local_err);
> > > > +    if (local_err) {
> > > > +        error_propagate(errp, local_err);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    qemu_unregister_reset(icp_simple_reset_handler, dev);
> > > > +}
> > > > +
> > > > +static void icp_simple_class_init(ObjectClass *klass, void *data)
> > > > +{
> > > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_CLASS(klass);
> > > > +
> > > > +    device_class_set_parent_realize(dc, icp_simple_realize,
> > > > +                                    &icpc->parent_realize);
> > > > +    device_class_set_parent_unrealize(dc, icp_simple_unrealize,
> > > > +                                      &icpc->parent_unrealize);
> > > > +    device_class_set_parent_reset(dc, icp_simple_reset, &icpc->par=
ent_reset);
> > > > +}
> > > > +
> > > > +static const TypeInfo icp_simple_info =3D {
> > > > +    .name =3D TYPE_ICP,
> > > > +    .parent =3D TYPE_ICP_BASE,
> > > > +    .instance_size =3D sizeof(ICPState),
> > > > +    .class_init =3D icp_simple_class_init,
> > > >      .class_size =3D sizeof(ICPStateClass),
> > > >  };
> > > > =20
> > > > @@ -744,7 +804,8 @@ static void xics_register_types(void)
> > > >  {
> > > >      type_register_static(&ics_simple_info);
> > > >      type_register_static(&ics_base_info);
> > > > -    type_register_static(&icp_info);
> > > > +    type_register_static(&icp_simple_info);
> > > > +    type_register_static(&icp_base_info);
> > > >      type_register_static(&xics_fabric_info);
> > > >  }
> > > > =20
> > > > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > > > index 30c3769a2084..72e700677059 100644
> > > > --- a/hw/intc/xics_kvm.c
> > > > +++ b/hw/intc/xics_kvm.c
> > > > @@ -116,17 +116,22 @@ static int icp_set_kvm_state(ICPState *icp, i=
nt version_id)
> > > > =20
> > > >  static void icp_kvm_reset(DeviceState *dev)
> > > >  {
> > > > -    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(dev);
> > > > =20
> > > >      icpc->parent_reset(dev);
> > > > =20
> > > > -    icp_set_kvm_state(ICP(dev), 1);
> > > > +    icp_set_kvm_state(ICP_BASE(dev), 1);
> > > > +}
> > > > +
> > > > +static void icp_kvm_reset_handler(void *dev)
> > > > +{
> > > > +    icp_kvm_reset(dev);
> > > >  }
> > > > =20
> > > >  static void icp_kvm_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > > -    ICPState *icp =3D ICP(dev);
> > > > -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(icp);
> > > >      Error *local_err =3D NULL;
> > > >      CPUState *cs;
> > > >      KVMEnabledICP *enabled_icp;
> > > > @@ -166,15 +171,25 @@ static void icp_kvm_realize(DeviceState *dev,=
 Error **errp)
> > > >      enabled_icp =3D g_malloc(sizeof(*enabled_icp));
> > > >      enabled_icp->vcpu_id =3D vcpu_id;
> > > >      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
> > > > +    qemu_register_reset(icp_kvm_reset_handler, icp);
> > > > +}
> > > > +
> > > > +static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > > +
> > > > +    qemu_unregister_reset(icp_kvm_reset_handler, icp);
> > > >  }
> > > > =20
> > > >  static void icp_kvm_class_init(ObjectClass *klass, void *data)
> > > >  {
> > > >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > -    ICPStateClass *icpc =3D ICP_CLASS(klass);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_CLASS(klass);
> > > > =20
> > > >      device_class_set_parent_realize(dc, icp_kvm_realize,
> > > >                                      &icpc->parent_realize);
> > > > +    device_class_set_parent_unrealize(dc, icp_kvm_unrealize,
> > > > +                                      &icpc->parent_unrealize);
> > > >      device_class_set_parent_reset(dc, icp_kvm_reset,
> > > >                                    &icpc->parent_reset);
> > > > =20
> > > > @@ -185,7 +200,7 @@ static void icp_kvm_class_init(ObjectClass *kla=
ss, void *data)
> > > > =20
> > > >  static const TypeInfo icp_kvm_info =3D {
> > > >      .name =3D TYPE_KVM_ICP,
> > > > -    .parent =3D TYPE_ICP,
> > > > +    .parent =3D TYPE_ICP_BASE,
> > > >      .instance_size =3D sizeof(ICPState),
> > > >      .class_init =3D icp_kvm_class_init,
> > > >      .class_size =3D sizeof(ICPStateClass),
> > > > diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
> > > > index fa48505f365e..a29ccb68df73 100644
> > > > --- a/hw/intc/xics_pnv.c
> > > > +++ b/hw/intc/xics_pnv.c
> > > > @@ -33,7 +33,7 @@
> > > > =20
> > > >  static uint64_t pnv_icp_read(void *opaque, hwaddr addr, unsigned w=
idth)
> > > >  {
> > > > -    ICPState *icp =3D ICP(opaque);
> > > > +    ICPState *icp =3D ICP_BASE(opaque);
> > > >      PnvICPState *picp =3D PNV_ICP(opaque);
> > > >      bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
> > > >      uint64_t val =3D 0xffffffff;
> > > > @@ -96,7 +96,7 @@ bad_access:
> > > >  static void pnv_icp_write(void *opaque, hwaddr addr, uint64_t val,
> > > >                                unsigned width)
> > > >  {
> > > > -    ICPState *icp =3D ICP(opaque);
> > > > +    ICPState *icp =3D ICP_BASE(opaque);
> > > >      PnvICPState *picp =3D PNV_ICP(opaque);
> > > >      bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
> > > > =20
> > > > @@ -145,6 +145,18 @@ bad_access:
> > > >      }
> > > >  }
> > > > =20
> > > > +static void pnv_icp_reset(DeviceState *dev)
> > > > +{
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(dev);
> > > > +
> > > > +    icpc->parent_reset(dev);
> > > > +}
> > > > +
> > > > +static void pnv_icp_reset_handler(void *dev)
> > > > +{
> > > > +    pnv_icp_reset(dev);
> > > > +}
> > > > +
> > > >  static const MemoryRegionOps pnv_icp_ops =3D {
> > > >      .read =3D pnv_icp_read,
> > > >      .write =3D pnv_icp_write,
> > > > @@ -161,9 +173,9 @@ static const MemoryRegionOps pnv_icp_ops =3D {
> > > > =20
> > > >  static void pnv_icp_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > > -    ICPState *icp =3D ICP(dev);
> > > > +    ICPState *icp =3D ICP_BASE(dev);
> > > >      PnvICPState *pnv_icp =3D PNV_ICP(icp);
> > > > -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_GET_CLASS(icp);
> > > >      Error *local_err =3D NULL;
> > > > =20
> > > >      icpc->parent_realize(dev, &local_err);
> > > > @@ -174,21 +186,24 @@ static void pnv_icp_realize(DeviceState *dev,=
 Error **errp)
> > > > =20
> > > >      memory_region_init_io(&pnv_icp->mmio, OBJECT(icp), &pnv_icp_op=
s,
> > > >                            icp, "icp-thread", 0x1000);
> > > > +    qemu_register_reset(pnv_icp_reset_handler, icp);
> > > >  }
> > > > =20
> > > >  static void pnv_icp_class_init(ObjectClass *klass, void *data)
> > > >  {
> > > >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > -    ICPStateClass *icpc =3D ICP_CLASS(klass);
> > > > +    ICPStateClass *icpc =3D ICP_BASE_CLASS(klass);
> > > > =20
> > > >      device_class_set_parent_realize(dc, pnv_icp_realize,
> > > >                                      &icpc->parent_realize);
> > > > +    device_class_set_parent_reset(dc, pnv_icp_reset,
> > > > +                                  &icpc->parent_reset);
> > > >      dc->desc =3D "PowerNV ICP";
> > > >  }
> > > > =20
> > > >  static const TypeInfo pnv_icp_info =3D {
> > > >      .name          =3D TYPE_PNV_ICP,
> > > > -    .parent        =3D TYPE_ICP,
> > > > +    .parent        =3D TYPE_ICP_BASE,
> > > >      .instance_size =3D sizeof(PnvICPState),
> > > >      .class_init    =3D pnv_icp_class_init,
> > > >      .class_size    =3D sizeof(ICPStateClass),
> > > > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > > > index 6ac8a9392da6..6a2e45997f8f 100644
> > > > --- a/include/hw/ppc/xics.h
> > > > +++ b/include/hw/ppc/xics.h
> > > > @@ -48,6 +48,9 @@ typedef struct ICSState ICSState;
> > > >  typedef struct ICSIRQState ICSIRQState;
> > > >  typedef struct XICSFabric XICSFabric;
> > > > =20
> > > > +#define TYPE_ICP_BASE "icp-base"
> > > > +#define ICP_BASE(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP_BASE)
> > > > +
> > > >  #define TYPE_ICP "icp"
> > > >  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
> > > > =20
> > > > @@ -57,15 +60,16 @@ typedef struct XICSFabric XICSFabric;
> > > >  #define TYPE_PNV_ICP "pnv-icp"
> > > >  #define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
> > > > =20
> > > > -#define ICP_CLASS(klass) \
> > > > -     OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP)
> > > > -#define ICP_GET_CLASS(obj) \
> > > > -     OBJECT_GET_CLASS(ICPStateClass, (obj), TYPE_ICP)
> > > > +#define ICP_BASE_CLASS(klass) \
> > > > +     OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP_BASE)
> > > > +#define ICP_BASE_GET_CLASS(obj) \
> > > > +     OBJECT_GET_CLASS(ICPStateClass, (obj), TYPE_ICP_BASE)
> > > > =20
> > > >  struct ICPStateClass {
> > > >      DeviceClass parent_class;
> > > > =20
> > > >      DeviceRealize parent_realize;
> > > > +    DeviceUnrealize parent_unrealize;
> > > >      DeviceReset parent_reset;
> > > > =20
> > > >      void (*pre_save)(ICPState *icp);
> > > >    =20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/B5GP5=BxnywxA2wDwsY4jju
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAltHFzMACgkQcdTV5YIv
c9bNEhAAiNS9y/K5h9sZrEHNlbBQtoOPzC7z49e5cRLjrJvmeFaTY6VspuBpaLHR
Suwp25yBryuACzwhYEwPXsGk2BLTbwYL2wNvC70qHnjwvp3mQjpamnV9hXp6D1Xx
3I9a1K4tNUN2+UO6CIpux6o2QL5Yanp+WLXd86yqRK4PxRv4EZ0Ww37JMAagNXGn
RPz+Jf3m75jtwl1hArWGiSelSIlRSm6w650F+1K7RnXNtZfHiY+Uylv+O7ZXQhdb
PnPUFho9LN2nrKa6nGN8bRsPTdFfuMbFHx+1L49KuSvlnN71YksR6emyuwQGnc5h
5Rr/iqhWVeS5MimGk8YEXW7cxOu3YyhlQa+k0Tk9EVlFVsurm47nuYAfeeoxEhPZ
xBm75k/uuAuiOq2gsSF3PGuMBfc1aP3Tajuw6BRw832M3+nKVU6nLvCF9T6zvWu1
BBmOXzJUouZhwljcalaN6yOqfPfksc/F5tqgL6Jr7yeyhX3KBOtsP1vcrKdwFx0L
1yY37dsymI4BSze2hEX6PDnrcG5sXDAXoloQq43hKWRyGmKZvfCiAxz1is7DHgEZ
067esEGR9ZZRSsdjWZWj0zD6vAFoO7k8iiDCkFfGHEt3DdQrRyI5fpSbXUqG37L5
v2vWkth1NKE4SwMYZ6+xKuneVvJkdVGTf6ZvwOenWHMQqQp2fdo=
=hTI8
-----END PGP SIGNATURE-----

--Sig_/B5GP5=BxnywxA2wDwsY4jju--
