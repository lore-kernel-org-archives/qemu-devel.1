Received: from eggs.gnu.org ([209.51.188.92]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glE1m-000881-Pt
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glE1l-0003qc-Kr
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:24:46 -0500
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:46177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1glE1l-0003pQ-Dw
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:24:45 -0500
Received: from player699.ha.ovh.net (unknown [10.109.146.137])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6EC1E1CA083
	for <qemu-devel@nongnu.org>; Sun, 20 Jan 2019 15:24:43 +0100 (CET)
Date: Sun, 20 Jan 2019 15:24:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190120152422.5f257401@bahia.lan>
In-Reply-To: <cba61268-408a-916a-7211-b5d8b0c1eee1@kaod.org>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774528595.1208625.15523908858345133758.stgit@bahia.lan>
	<cba61268-408a-916a-7211-b5d8b0c1eee1@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/19] xics: Disintricate allocation and
 type setting of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Fri, 18 Jan 2019 13:26:29 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/17/19 6:14 PM, Greg Kurz wrote:
> > The current code assumes that an interrupt is allocated as soon as its
> > type is set to MSI or LSI. PHB hotplug will require to be able to set
> > the type of an interrupt before actually allocating it.
> >=20
> > Disintricate type setting from allocation by using another flag bit for
> > the latter. Introduce a new ics_claim_irq() function for allocation. The
> > behavior of aborting if the same irq gets allocated twice is kept.
> >=20
> > ics_set_irq_type() now only sets the type to MSI or LSI. It doesn't bri=
ng
> > anything to abort if the type was already set before. Drop the assert
> > and XICS_FLAGS_IRQ_MASK on the way.
> >=20
> > Older QEMUs don't know about XICS_FLAGS_IRQ_CLAIMED. In order to safely
> > handle incoming migration, we must fix the irq flags. This is done at
> > post load thanks to a compat property. We don't need to do anything for
> > backward migration since older machines only care for the irq type.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> =20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> In case of a respin, may be transform macro ICS_IRQ_FREE() in a static=20
> inline helper.
>=20

Yeah, there will be a respin (see my other mail in this thread) and I'll
just do that.

> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/core/machine.c     |    4 ++++
> >  hw/intc/xics.c        |   28 +++++++++++++++++++++++++---
> >  hw/ppc/pnv_psi.c      |    1 +
> >  hw/ppc/spapr_irq.c    |    4 +---
> >  include/hw/ppc/xics.h |    8 ++++++--
> >  5 files changed, 37 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 1a0a9ab1117a..536a34092367 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -25,6 +25,10 @@
> > =20
> >  GlobalProperty hw_compat_3_1[] =3D {
> >      {
> > +        .driver   =3D "ics-base",
> > +        .property =3D "has-claimed-flag",
> > +        .value    =3D "off",
> > +    },{
> >          .driver   =3D "pcie-root-port",
> >          .property =3D "x-speed",
> >          .value    =3D "2_5",
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 16e8ffa2aaf7..82cf04548907 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -75,7 +75,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
> >      for (i =3D 0; i < ics->nr_irqs; i++) {
> >          ICSIRQState *irq =3D ics->irqs + i;
> > =20
> > -        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
> > +        if (!(irq->flags & XICS_FLAGS_IRQ_CLAIMED)) {
> >              continue;
> >          }
> >          monitor_printf(mon, "  %4x %s %02x %02x\n",
> > @@ -662,6 +662,22 @@ static int ics_base_dispatch_post_load(void *opaqu=
e, int version_id)
> >      ICSState *ics =3D opaque;
> >      ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> > =20
> > +    if (!ics->has_claimed_flag) {
> > +        int i;
> > +
> > +        for (i =3D 0; i < ics->nr_irqs; i++) {
> > +            ICSIRQState *irq =3D ics->irqs + i;
> > +
> > +            /*
> > +             * For older machines, allocating the irq and setting its =
type is
> > +             * the same thing.
> > +             */
> > +            if (irq->flags & (XICS_FLAGS_IRQ_LSI| XICS_FLAGS_IRQ_MSI))=
 {
> > +                irq->flags |=3D XICS_FLAGS_IRQ_CLAIMED;
> > +            }
> > +        }
> > +    }
> > +
> >      if (info->post_load) {
> >          return info->post_load(ics, version_id);
> >      }
> > @@ -702,6 +718,7 @@ static const VMStateDescription vmstate_ics_base =
=3D {
> > =20
> >  static Property ics_base_properties[] =3D {
> >      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> > +    DEFINE_PROP_BOOL("has-claimed-flag", ICSState, has_claimed_flag, t=
rue),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> > @@ -741,10 +758,15 @@ ICPState *xics_icp_get(XICSFabric *xi, int server)
> >      return xic->icp_get(xi, server);
> >  }
> > =20
> > -void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
> > +void ics_claim_irq(ICSState *ics, int srcno)
> >  {
> > -    assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
> > +    assert(ICS_IRQ_FREE(ics, srcno));
> > +
> > +    ics->irqs[srcno].flags |=3D XICS_FLAGS_IRQ_CLAIMED;
> > +}
> > =20
> > +void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
> > +{
> >      ics->irqs[srcno].flags |=3D
> >          lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
> >  }
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index 8ced09506321..ced34e1119dc 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -488,6 +488,7 @@ static void pnv_psi_realize(DeviceState *dev, Error=
 **errp)
> > =20
> >      for (i =3D 0; i < ics->nr_irqs; i++) {
> >          ics_set_irq_type(ics, i, true);
> > +        ics_claim_irq(ics, i);
> >      }
> > =20
> >      psi->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr=
_irqs);
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 1da7a32348fc..86c712d15382 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -125,9 +125,6 @@ error:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > -#define ICS_IRQ_FREE(ics, srcno)   \
> > -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> > -
> >  static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, boo=
l lsi,
> >                                  Error **errp)
> >  {
> > @@ -146,6 +143,7 @@ static int spapr_irq_claim_xics(sPAPRMachineState *=
spapr, int irq, bool lsi,
> >      }
> > =20
> >      ics_set_irq_type(ics, irq - ics->offset, lsi);
> > +    ics_claim_irq(ics, irq - ics->offset);
> >      return 0;
> >  }
> > =20
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index fad786e8b22d..e3be5cc663c5 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -131,6 +131,7 @@ struct ICSState {
> >      /*< public >*/
> >      uint32_t nr_irqs;
> >      uint32_t offset;
> > +    bool has_claimed_flag;
> >      ICSIRQState *irqs;
> >      XICSFabric *xics;
> >  };
> > @@ -153,13 +154,15 @@ struct ICSIRQState {
> >  #define XICS_STATUS_PRESENTED          0x10
> >  #define XICS_STATUS_QUEUED             0x20
> >      uint8_t status;
> > -/* (flags & XICS_FLAGS_IRQ_MASK) =3D=3D 0 means the interrupt is not a=
llocated */
> >  #define XICS_FLAGS_IRQ_LSI             0x1
> >  #define XICS_FLAGS_IRQ_MSI             0x2
> > -#define XICS_FLAGS_IRQ_MASK            0x3
> > +#define XICS_FLAGS_IRQ_CLAIMED         0x4
> >      uint8_t flags;
> >  };
> > =20
> > +#define ICS_IRQ_FREE(ics, srcno)   \
> > +    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_CLAIMED)))
> > +
> >  struct XICSFabric {
> >      Object parent;
> >  };
> > @@ -193,6 +196,7 @@ void ics_simple_write_xive(ICSState *ics, int nr, i=
nt server,
> >  void ics_simple_set_irq(void *opaque, int srcno, int val);
> >  void ics_kvm_set_irq(void *opaque, int srcno, int val);
> > =20
> > +void ics_claim_irq(ICSState *ics, int srcno);
> >  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> >  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> >  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> >  =20
>=20
