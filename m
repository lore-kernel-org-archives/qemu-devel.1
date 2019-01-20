Received: from eggs.gnu.org ([209.51.188.92]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glEE7-00049X-Rx
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1glEE5-0003sm-Ty
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:37:31 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1glEE4-0003qR-PD
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:37:29 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.132])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 84E191A267C
	for <qemu-devel@nongnu.org>; Sun, 20 Jan 2019 15:37:25 +0100 (CET)
Date: Sun, 20 Jan 2019 15:37:05 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190120153705.67267d3f@bahia.lan>
In-Reply-To: <933449f5-e65a-caf1-4dad-81a62a0b95e4@kaod.org>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774530571.1208625.5318753891932747707.stgit@bahia.lan>
	<933449f5-e65a-caf1-4dad-81a62a0b95e4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/19] spapr: Identify LSIs of all
 possible PHBs at machine init
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

On Fri, 18 Jan 2019 13:38:02 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/17/19 6:15 PM, Greg Kurz wrote:
> > Every PHB needs to claim 4 LSIs to support legacy PCI devices. This is
> > currently done at PHB realize. When using in-kernel XICS (or upcoming
> > in-kernel XIVE), QEMU synchronizes the state of all irqs, including
> > these LSIs, later on at machine reset.
> >=20
> > In order to support PHB hotplug, we need a way to tell KVM about the
> > LSIs that doesn't require a machine reset. Since these irq numbers are
> > fixed values derived from the PHB index, let's identify them all at
> > machine init. Older machines that don't have fixed irq numbers cannot
> > support PHB hotplug and keep the existing behavior.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c              |    6 ++++++
> >  hw/ppc/spapr_pci.c          |   20 ++++++++++++++++++--
> >  include/hw/pci-host/spapr.h |    2 ++
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 26f8e55cc25e..9189b4d3a9d6 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2802,6 +2802,12 @@ static void spapr_machine_init(MachineState *mac=
hine)
> > =20
> >      phb =3D spapr_create_default_phb();
> > =20
> > +    if (!smc->legacy_irq_allocation) {
> > +        for (i =3D 0; i < SPAPR_MAX_PHBS; i++) {
> > +            spapr_phb_set_lsis(i, spapr);
> > +        }
> > +    }
> > + =20
>=20
> Can't we be more brutal and do the LSI setting in spapr_irq_init()=20
> for the whole [ SPAPR_IRQ_PCI_LSI ... SPAPR_IRQ_MSI -1 ] range ?=20
>=20

I like this. And we should even set the type of all IRQs for the machine
lifetime since it is an invariant. I'll give it a try for v4.

> C.=20
>=20
> >      for (i =3D 0; i < nb_nics; i++) {
> >          NICInfo *nd =3D &nd_table[i];
> > =20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index ec9d4d28004c..f5f13a4d4816 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1559,6 +1559,22 @@ static void spapr_pci_unplug_request(HotplugHand=
ler *plug_handler,
> >      }
> >  }
> > =20
> > +static uint32_t spapr_phb_index_to_lsi(int phb_index, int irq_index)
> > +{
> > +    return SPAPR_IRQ_PCI_LSI + phb_index * PCI_NUM_PINS + irq_index;
> > +}
> > +
> > +void spapr_phb_set_lsis(int index, sPAPRMachineState *spapr)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > +        uint32_t irq =3D spapr_phb_index_to_lsi(index, i);
> > +
> > +        spapr_irq_set_type(spapr, irq, true);
> > +    }
> > +}
> > +
> >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >  {
> >      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the=
 user
> > @@ -1726,7 +1742,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> > =20
> >      /* Initialize the LSI table */
> >      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > -        uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PIN=
S + i;
> > +        uint32_t irq =3D spapr_phb_index_to_lsi(sphb->index, i);
> >          Error *local_err =3D NULL;
> > =20
> >          if (smc->legacy_irq_allocation) {
> > @@ -1736,6 +1752,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >                                          "can't allocate LSIs: ");
> >                  return;
> >              }
> > +            spapr_irq_set_type(spapr, irq, true);
> >          }
> > =20
> >          spapr_irq_claim(spapr, irq, &local_err);
> > @@ -1743,7 +1760,6 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >              error_propagate_prepend(errp, local_err, "can't allocate L=
SIs: ");
> >              return;
> >          }
> > -        spapr_irq_set_type(spapr, irq, true);
> > =20
> >          sphb->lsi_table[i].irq =3D irq;
> >      }
> > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > index e0e683c32469..bb0ae7fdd41d 100644
> > --- a/include/hw/pci-host/spapr.h
> > +++ b/include/hw/pci-host/spapr.h
> > @@ -164,4 +164,6 @@ static inline void spapr_phb_vfio_reset(DeviceState=
 *qdev)
> > =20
> >  void spapr_phb_dma_reset(sPAPRPHBState *sphb);
> > =20
> > +void spapr_phb_set_lsis(int index, sPAPRMachineState *spapr);
> > +
> >  #endif /* PCI_HOST_SPAPR_H */
> >  =20
>=20
