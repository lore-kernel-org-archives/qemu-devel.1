Received: from eggs.gnu.org ([209.51.188.92]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gudVD-0001ww-Qy
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gudVC-00072Z-Q1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:26:03 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:55131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gudVC-0006Mb-J1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:26:02 -0500
Received: from player715.ha.ovh.net (unknown [10.109.160.76])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 449261170DB
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:25:32 +0100 (CET)
Date: Fri, 15 Feb 2019 14:25:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215142526.4440daf8@bahia.lan>
In-Reply-To: <2dea9d93-8662-2a32-deef-c45add6d87cd@kaod.org>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023082996.1011724.16237920586343905010.stgit@bahia.lan>
	<2dea9d93-8662-2a32-deef-c45add6d87cd@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] xics: Handle KVM interrupt
 presentation from "simple" ICS code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, 15 Feb 2019 13:59:36 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 2/15/19 12:40 PM, Greg Kurz wrote:
> > We want to use the "simple" ICS type in both KVM and non-KVM setups.
> > Teach the "simple" ICS how to present interrupts to KVM and adapt
> > sPAPR accordingly. =20
>=20
> I don't see the benefits of this change.
>=20

Consistency with what the rest of the series actually does: hiding the
KVM details under XICS. But I agree it doesn't buy anything more so
I don't mind if it is dropped.

> C.
>=20
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics.c        |    5 +++++
> >  hw/intc/xics_kvm.c    |    3 +--
> >  hw/ppc/spapr_irq.c    |    7 +------
> >  include/hw/ppc/xics.h |    2 +-
> >  4 files changed, 8 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 49401745c410..3009fa747277 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -466,6 +466,11 @@ void ics_simple_set_irq(void *opaque, int srcno, i=
nt val)
> >  {
> >      ICSState *ics =3D (ICSState *)opaque;
> > =20
> > +    if (kvm_irqchip_in_kernel()) {
> > +        ics_kvm_set_irq(ics, srcno, val);
> > +        return;
> > +    }
> > +
> >      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> >          ics_simple_set_irq_lsi(ics, srcno, val);
> >      } else {
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index e7b8d4c29ce6..f34eacda03e7 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -259,9 +259,8 @@ int ics_set_kvm_state(ICSState *ics)
> >      return 0;
> >  }
> > =20
> > -void ics_kvm_set_irq(void *opaque, int srcno, int val)
> > +void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
> >  {
> > -    ICSState *ics =3D opaque;
> >      struct kvm_irq_level args;
> >      int rc;
> > =20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index e6893df61e76..9f43b7b3bf16 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -222,13 +222,8 @@ static int spapr_irq_post_load_xics(sPAPRMachineSt=
ate *spapr, int version_id)
> >  static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
> >  {
> >      sPAPRMachineState *spapr =3D opaque;
> > -    MachineState *machine =3D MACHINE(opaque);
> > =20
> > -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> > -        ics_kvm_set_irq(spapr->ics, srcno, val);
> > -    } else {
> > -        ics_simple_set_irq(spapr->ics, srcno, val);
> > -    }
> > +    ics_simple_set_irq(spapr->ics, srcno, val);
> >  }
> > =20
> >  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **err=
p)
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 06e87128f88e..61bd0fb9784f 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -180,7 +180,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
> >  void ics_simple_write_xive(ICSState *ics, int nr, int server,
> >                             uint8_t priority, uint8_t saved_priority);
> >  void ics_simple_set_irq(void *opaque, int srcno, int val);
> > -void ics_kvm_set_irq(void *opaque, int srcno, int val);
> > =20
> >  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> >  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> > @@ -201,5 +200,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp=
);
> >  void ics_get_kvm_state(ICSState *ics);
> >  int ics_set_kvm_state(ICSState *ics);
> >  void ics_synchronize_state(ICSState *ics);
> > +void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
> > =20
> >  #endif /* XICS_H */
> >  =20
>=20
