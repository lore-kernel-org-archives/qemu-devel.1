Received: from eggs.gnu.org ([209.51.188.92]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gj3tB-0007ZR-2j
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gj3t3-00010r-97
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:10:56 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:37021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gj3t2-0000yU-24
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:10:49 -0500
Received: from player793.ha.ovh.net (unknown [10.109.146.175])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id DAC01110DC1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 16:10:43 +0100 (CET)
Date: Mon, 14 Jan 2019 16:10:20 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190114161020.297ac3b2@bahia.lan>
In-Reply-To: <cdbc7f08-f0f7-725e-8511-6a303696c1ef@kaod.org>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724066386.525985.7102226604937744914.stgit@bahia.lan>
	<cdbc7f08-f0f7-725e-8511-6a303696c1ef@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/13] spapr_irq: Allow synchronization
 of a single irq state to KVM
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

On Mon, 14 Jan 2019 09:19:50 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/11/19 10:04 PM, Greg Kurz wrote:
> > When using the in-kernel interrupt controller, the state of all irqs is
> > synchronized to KVM at machine reset time. In the case of PHB hotplug, =
we
> > will need to synchronize LSIs manually. =20
>=20
> Yes. This is because the interrupt sources in the KVM XICS device have=20
> already been initialized as MSIs.=20
>=20
> Can not we reset the source when it is claimed ?=20
>=20
> An alternative solution would be to initialize the SPAPR_IRQ_PCI_LSI rang=
e=20
> as LSIs at a KVM level.
>=20

I don't really want to add some dependency to sPAPR code in KVM XICS... what
about claiming LSIs for all possible PHBs at machine init time ?

> Thanks,
>=20
> C.
>=20
> > Do this for the existing KVM XICS implementation and put a placeholder =
for
> > the upcoming KVM XIVE.>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics_kvm.c         |   67 +++++++++++++++++++++++++-----------=
--------
> >  hw/ppc/spapr_irq.c         |   31 ++++++++++++++++++++
> >  include/hw/ppc/spapr_irq.h |    2 +
> >  include/hw/ppc/xics.h      |    2 +
> >  4 files changed, 73 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index dff13300504c..d3bbb2bcf19c 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -253,43 +253,52 @@ static void ics_synchronize_state(ICSState *ics)
> >      ics_get_kvm_state(ics);
> >  }
> > =20
> > -static int ics_set_kvm_state(ICSState *ics, int version_id)
> > +int ics_set_kvm_state_one(ICSState *ics, unsigned srcno, Error **errp)
> >  {
> > +    ICSIRQState *irq;
> >      uint64_t state;
> > -    int i;
> > -    Error *local_err =3D NULL;
> > =20
> > -    for (i =3D 0; i < ics->nr_irqs; i++) {
> > -        ICSIRQState *irq =3D &ics->irqs[i];
> > -        int ret;
> > +    assert(srcno < ics->nr_irqs);
> > =20
> > -        state =3D irq->server;
> > -        state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_=
MASK)
> > -            << KVM_XICS_PRIORITY_SHIFT;
> > -        if (irq->priority !=3D irq->saved_priority) {
> > -            assert(irq->priority =3D=3D 0xff);
> > -            state |=3D KVM_XICS_MASKED;
> > -        }
> > +    irq =3D &ics->irqs[srcno];
> > +    state =3D irq->server;
> > +    state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
> > +        << KVM_XICS_PRIORITY_SHIFT;
> > +    if (irq->priority !=3D irq->saved_priority) {
> > +        assert(irq->priority =3D=3D 0xff);
> > +        state |=3D KVM_XICS_MASKED;
> > +    }
> > =20
> > -        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> > -            state |=3D KVM_XICS_LEVEL_SENSITIVE;
> > -            if (irq->status & XICS_STATUS_ASSERTED) {
> > -                state |=3D KVM_XICS_PENDING;
> > -            }
> > -        } else {
> > -            if (irq->status & XICS_STATUS_MASKED_PENDING) {
> > -                state |=3D KVM_XICS_PENDING;
> > -            }
> > -        }
> > -        if (irq->status & XICS_STATUS_PRESENTED) {
> > -                state |=3D KVM_XICS_PRESENTED;
> > +    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> > +        state |=3D KVM_XICS_LEVEL_SENSITIVE;
> > +        if (irq->status & XICS_STATUS_ASSERTED) {
> > +            state |=3D KVM_XICS_PENDING;
> >          }
> > -        if (irq->status & XICS_STATUS_QUEUED) {
> > -                state |=3D KVM_XICS_QUEUED;
> > +    } else {
> > +        if (irq->status & XICS_STATUS_MASKED_PENDING) {
> > +            state |=3D KVM_XICS_PENDING;
> >          }
> > +    }
> > +    if (irq->status & XICS_STATUS_PRESENTED) {
> > +        state |=3D KVM_XICS_PRESENTED;
> > +    }
> > +    if (irq->status & XICS_STATUS_QUEUED) {
> > +        state |=3D KVM_XICS_QUEUED;
> > +    }
> > +
> > +    return kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> > +                             srcno + ics->offset, &state, true, errp);
> > +}
> > +
> > +static int ics_set_kvm_state(ICSState *ics, int version_id)
> > +{
> > +    int i;
> > +    Error *local_err =3D NULL;
> > +
> > +    for (i =3D 0; i < ics->nr_irqs; i++) {
> > +        int ret;
> > =20
> > -        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOU=
RCES,
> > -                                i + ics->offset, &state, true, &local_=
err);
> > +        ret =3D ics_set_kvm_state_one(ics, i, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return ret;
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index ba0df9ae2e1b..2cf666c2ebc5 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -236,6 +236,17 @@ static void spapr_irq_reset_xics(sPAPRMachineState=
 *spapr, Error **errp)
> >      /* TODO: create the KVM XICS device */
> >  }
> > =20
> > +static void spapr_irq_sync_to_kvm_xics(sPAPRMachineState *spapr, int i=
rq,
> > +                                       Error **errp)
> > +{
> > +    MachineState *machine =3D MACHINE(spapr);
> > +    ICSState *ics =3D spapr->ics;
> > +
> > +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> > +        ics_set_kvm_state_one(ics, irq - ics->offset, errp);
> > +    }
> > +}
> > +
> >  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> >  #define SPAPR_IRQ_XICS_NR_MSIS     \
> >      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> > @@ -256,6 +267,7 @@ sPAPRIrq spapr_irq_xics =3D {
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> >      .get_phandle =3D spapr_get_phandle_xics,
> > +    .sync_to_kvm =3D spapr_irq_sync_to_kvm_xics,
> >  };
> > =20
> >  /*
> > @@ -389,6 +401,12 @@ static void spapr_irq_set_irq_xive(void *opaque, i=
nt srcno, int val)
> >      xive_source_set_irq(&spapr->xive->source, srcno, val);
> >  }
> > =20
> > +static void spapr_irq_sync_to_kvm_xive(sPAPRMachineState *spapr, int i=
rq,
> > +                                       Error **errp)
> > +{
> > +    /* TODO: to be implemented when adding KVM XIVE support */
> > +}
> > +
> >  /*
> >   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
> >   * with XICS.
> > @@ -413,6 +431,7 @@ sPAPRIrq spapr_irq_xive =3D {
> >      .reset       =3D spapr_irq_reset_xive,
> >      .set_irq     =3D spapr_irq_set_irq_xive,
> >      .get_phandle =3D spapr_get_phandle_xive,
> > +    .sync_to_kvm =3D spapr_irq_sync_to_kvm_xive,
> >  };
> > =20
> >  /*
> > @@ -577,6 +596,11 @@ static uint32_t spapr_irq_get_phandle_dual(sPAPRMa=
chineState *spapr, void *fdt,
> >      return spapr_irq_current(spapr)->get_phandle(spapr, fdt, errp);
> >  }
> > =20
> > +static void spapr_irq_sync_to_kvm_dual(sPAPRMachineState *spapr, int i=
rq,
> > +                                       Error **errp)
> > +{
> > +    spapr_irq_current(spapr)->sync_to_kvm(spapr, irq, errp);
> > +}
> > =20
> >  /*
> >   * Define values in sync with the XIVE and XICS backend
> > @@ -600,6 +624,7 @@ sPAPRIrq spapr_irq_dual =3D {
> >      .reset       =3D spapr_irq_reset_dual,
> >      .set_irq     =3D spapr_irq_set_irq_dual,
> >      .get_phandle =3D spapr_irq_get_phandle_dual,
> > +    .sync_to_kvm =3D spapr_irq_sync_to_kvm_dual,
> >  };
> > =20
> >  /*
> > @@ -645,6 +670,11 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Err=
or **errp)
> >      }
> >  }
> > =20
> > +void spapr_irq_sync_to_kvm(sPAPRMachineState *spapr, int irq, Error **=
errp)
> > +{
> > +    spapr->irq->sync_to_kvm(spapr, irq, errp);
> > +}
> > +
> >  /*
> >   * XICS legacy routines - to deprecate one day
> >   */
> > @@ -717,4 +747,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> >      .get_phandle =3D spapr_get_phandle_xics,
> > +    .sync_to_kvm =3D spapr_irq_sync_to_kvm_xics,
> >  };
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 990743a23582..9c111f3211b3 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -48,6 +48,7 @@ typedef struct sPAPRIrq {
> >      void (*reset)(sPAPRMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
> >      uint32_t (*get_phandle)(sPAPRMachineState *spapr, void *fdt, Error=
 **errp);
> > +    void (*sync_to_kvm)(sPAPRMachineState *spapr, int irq, Error **err=
p);
> >  } sPAPRIrq;
> > =20
> >  extern sPAPRIrq spapr_irq_xics;
> > @@ -61,6 +62,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq=
, int num);
> >  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> >  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
> >  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> > +void spapr_irq_sync_to_kvm(sPAPRMachineState *spapr, int irq, Error **=
errp);
> > =20
> >  /*
> >   * XICS legacy routines
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index fad786e8b22d..52de166a2982 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -203,4 +203,6 @@ void icp_resend(ICPState *ss);
> >  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> >                     Error **errp);
> > =20
> > +int ics_set_kvm_state_one(ICSState *ics, unsigned srcno, Error **errp);
> > +
> >  #endif /* XICS_H */
> >  =20
>=20
