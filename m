Received: from eggs.gnu.org ([209.51.188.92]:58076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glE8Z-0001js-JT
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glE8Y-0008MK-6K
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:31:47 -0500
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:41578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1glE8X-0008KV-W7
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:31:46 -0500
Received: from player776.ha.ovh.net (unknown [10.109.159.154])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 98F9814F3A0
	for <qemu-devel@nongnu.org>; Sun, 20 Jan 2019 15:31:43 +0100 (CET)
Date: Sun, 20 Jan 2019 15:31:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190120153121.1af80747@bahia.lan>
In-Reply-To: <161148b8-e998-2551-4c7e-20be1b245aab@kaod.org>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774529913.1208625.7473971232891874613.stgit@bahia.lan>
	<161148b8-e998-2551-4c7e-20be1b245aab@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/19] spapr: Set irq type in a
 dedicated function
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

On Fri, 18 Jan 2019 13:34:39 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/17/19 6:14 PM, Greg Kurz wrote:
> > PHB hotplug will need to set the type of all LSIs at machine init.
> >=20
> > Prepare for that by moving the behaviour of setting the type from
> > spapr_irq_claim() to a separate spapr_irq_set_type() function. Have
> > all the callers of spapr_irq_claim() to also call the new function.
> >=20
> > There's no such need of separating allocation and type setting for
> > MSIs, so this introduces a convenient spapr_irq_claim_msi() function
> > for MSI users. =20
>=20
> I would make LSI the special case instead.
>=20

Well... LSI is the special case in the sense it calls two distinct
functions to have the job done instead of one for MSI. :)

But anyway I'm likely to try another approach in v4.

> C.
>=20
> =20
> > Wire all this to the existing backends.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_events.c      |    4 +--
> >  hw/ppc/spapr_irq.c         |   59 ++++++++++++++++++++++++++++++++++++=
--------
> >  hw/ppc/spapr_pci.c         |    5 ++--
> >  hw/ppc/spapr_vio.c         |    2 +
> >  include/hw/ppc/spapr_irq.h |    7 ++++-
> >  5 files changed, 59 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index b9c7ecb9e987..777a70842acc 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -713,7 +713,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
> >          epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >      }
> > =20
> > -    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
> > +    spapr_irq_claim(spapr, epow_irq, &error_fatal);
> > =20
> >      QTAILQ_INIT(&spapr->pending_events);
> > =20
> > @@ -737,7 +737,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
> >              hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >          }
> > =20
> > -        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
> > +        spapr_irq_claim_msi(spapr, hp_irq, &error_fatal);
> > =20
> >          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS=
_HOT_PLUG,
> >                                       hp_irq);
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index bcd816c5a5fb..396dd09bdbe0 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -125,8 +125,7 @@ error:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > -static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > +static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, Err=
or **errp)
> >  {
> >      ICSState *ics =3D spapr->ics;
> > =20
> > @@ -142,11 +141,20 @@ static int spapr_irq_claim_xics(sPAPRMachineState=
 *spapr, int irq, bool lsi,
> >          return -1;
> >      }
> > =20
> > -    ics_set_irq_type(ics, irq - ics->offset, lsi);
> >      ics_claim_irq(ics, irq - ics->offset);
> >      return 0;
> >  }
> > =20
> > +static void spapr_irq_set_type_xics(sPAPRMachineState *spapr, int irq,=
 bool lsi)
> > +{
> > +    ICSState *ics =3D spapr->ics;
> > +
> > +    assert(ics);
> > +    assert(ics_valid_irq(ics, irq));
> > +
> > +    ics_set_irq_type(ics, irq - ics->offset, lsi);
> > +}
> > +
> >  static void spapr_irq_free_xics(sPAPRMachineState *spapr, int irq, int=
 num)
> >  {
> >      ICSState *ics =3D spapr->ics;
> > @@ -245,6 +253,7 @@ sPAPRIrq spapr_irq_xics =3D {
> > =20
> >      .init        =3D spapr_irq_init_xics,
> >      .claim       =3D spapr_irq_claim_xics,
> > +    .set_type    =3D spapr_irq_set_type_xics,
> >      .free        =3D spapr_irq_free_xics,
> >      .qirq        =3D spapr_qirq_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> > @@ -292,17 +301,20 @@ static void spapr_irq_init_xive(sPAPRMachineState=
 *spapr, Error **errp)
> >      spapr_xive_hcall_init(spapr);
> >  }
> > =20
> > -static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > +static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, Err=
or **errp)
> >  {
> >      if (!spapr_xive_irq_claim(spapr->xive, irq)) {
> >          error_setg(errp, "IRQ %d is invalid", irq);
> >          return -1;
> >      }
> > -    xive_source_irq_set(&spapr->xive->source, irq, lsi);
> >      return 0;
> >  }
> > =20
> > +static void spapr_irq_set_type_xive(sPAPRMachineState *spapr, int irq,=
 bool lsi)
> > +{
> > +    xive_source_irq_set(&spapr->xive->source, irq, lsi);
> > +}
> > +
> >  static void spapr_irq_free_xive(sPAPRMachineState *spapr, int irq, int=
 num)
> >  {
> >      int i;
> > @@ -403,6 +415,7 @@ sPAPRIrq spapr_irq_xive =3D {
> > =20
> >      .init        =3D spapr_irq_init_xive,
> >      .claim       =3D spapr_irq_claim_xive,
> > +    .set_type    =3D spapr_irq_set_type_xive,
> >      .free        =3D spapr_irq_free_xive,
> >      .qirq        =3D spapr_qirq_xive,
> >      .print_info  =3D spapr_irq_print_info_xive,
> > @@ -466,19 +479,19 @@ static void spapr_irq_init_dual(sPAPRMachineState=
 *spapr, Error **errp)
> >      }
> >  }
> > =20
> > -static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, boo=
l lsi,
> > +static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq,
> >                                  Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> >      int ret;
> > =20
> > -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> > +    ret =3D spapr_irq_xics.claim(spapr, irq, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return ret;
> >      }
> > =20
> > -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> > +    ret =3D spapr_irq_xive.claim(spapr, irq, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return ret;
> > @@ -487,6 +500,12 @@ static int spapr_irq_claim_dual(sPAPRMachineState =
*spapr, int irq, bool lsi,
> >      return ret;
> >  }
> > =20
> > +static void spapr_irq_set_type_dual(sPAPRMachineState *spapr, int irq,=
 bool lsi)
> > +{
> > +    spapr_irq_xics.set_type(spapr, irq, lsi);
> > +    spapr_irq_xive.set_type(spapr, irq, lsi);
> > +}
> > +
> >  static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int=
 num)
> >  {
> >      spapr_irq_xics.free(spapr, irq, num);
> > @@ -582,6 +601,7 @@ sPAPRIrq spapr_irq_dual =3D {
> > =20
> >      .init        =3D spapr_irq_init_dual,
> >      .claim       =3D spapr_irq_claim_dual,
> > +    .set_type    =3D spapr_irq_set_type_dual,
> >      .free        =3D spapr_irq_free_dual,
> >      .qirq        =3D spapr_qirq_dual,
> >      .print_info  =3D spapr_irq_print_info_dual,
> > @@ -608,9 +628,25 @@ void spapr_irq_init(sPAPRMachineState *spapr, Erro=
r **errp)
> >                                        spapr->irq->nr_irqs);
> >  }
> > =20
> > -int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> > +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp)
> > +{
> > +    return spapr->irq->claim(spapr, irq, errp);
> > +}
> > +
> > +void spapr_irq_set_type(sPAPRMachineState *spapr, int irq, bool lsi)
> >  {
> > -    return spapr->irq->claim(spapr, irq, lsi, errp);
> > +    return spapr->irq->set_type(spapr, irq, lsi);
> > +}
> > +
> > +int spapr_irq_claim_msi(sPAPRMachineState *spapr, int irq, Error **err=
p)
> > +{
> > +    int ret =3D spapr_irq_claim(spapr, irq, errp);
> > +
> > +    if (!ret) {
> > +        spapr_irq_set_type(spapr, irq, false);
> > +    }
> > +
> > +    return ret;
> >  }
> > =20
> >  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
> > @@ -699,6 +735,7 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
> > =20
> >      .init        =3D spapr_irq_init_xics,
> >      .claim       =3D spapr_irq_claim_xics,
> > +    .set_type    =3D spapr_irq_set_type_xics,
> >      .free        =3D spapr_irq_free_xics,
> >      .qirq        =3D spapr_qirq_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index ccdaf2c9a606..ec9d4d28004c 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -391,7 +391,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >      }
> > =20
> >      for (i =3D 0; i < req_num; i++) {
> > -        spapr_irq_claim(spapr, irq + i, false, &err);
> > +        spapr_irq_claim_msi(spapr, irq + i, &err);
> >          if (err) {
> >              error_reportf_err(err, "Can't allocate MSIs for device %x:=
 ",
> >                                config_addr);
> > @@ -1738,11 +1738,12 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >              }
> >          }
> > =20
> > -        spapr_irq_claim(spapr, irq, true, &local_err);
> > +        spapr_irq_claim(spapr, irq, &local_err);
> >          if (local_err) {
> >              error_propagate_prepend(errp, local_err, "can't allocate L=
SIs: ");
> >              return;
> >          }
> > +        spapr_irq_set_type(spapr, irq, true);
> > =20
> >          sphb->lsi_table[i].irq =3D irq;
> >      }
> > diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> > index f80b70a39c46..9ae4351d4414 100644
> > --- a/hw/ppc/spapr_vio.c
> > +++ b/hw/ppc/spapr_vio.c
> > @@ -546,7 +546,7 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
> >          }
> >      }
> > =20
> > -    spapr_irq_claim(spapr, dev->irq, false, &local_err);
> > +    spapr_irq_claim_msi(spapr, dev->irq, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 14b02c3aca33..42b325eb51ba 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -36,7 +36,8 @@ typedef struct sPAPRIrq {
> >      uint8_t     ov5;
> > =20
> >      void (*init)(sPAPRMachineState *spapr, Error **errp);
> > -    int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **=
errp);
> > +    int (*claim)(sPAPRMachineState *spapr, int irq, Error **errp);
> > +    void (*set_type)(sPAPRMachineState *spapr, int irq, bool lsi);
> >      void (*free)(sPAPRMachineState *spapr, int irq, int num);
> >      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
> >      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
> > @@ -55,7 +56,9 @@ extern sPAPRIrq spapr_irq_xive;
> >  extern sPAPRIrq spapr_irq_dual;
> > =20
> >  void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
> > -int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> > +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp);
> > +void spapr_irq_set_type(sPAPRMachineState *spapr, int irq, bool lsi);
> > +int spapr_irq_claim_msi(sPAPRMachineState *spapr, int irq, Error **err=
p);
> >  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> >  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> >  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
> >  =20
>=20
