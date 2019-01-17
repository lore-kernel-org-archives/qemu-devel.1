Received: from eggs.gnu.org ([209.51.188.92]:35568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gk3XW-00011x-4J
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gk3XQ-0000qi-P3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gk3XP-0000lJ-Hb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:00:36 -0500
Date: Thu, 17 Jan 2019 09:59:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190117095956.29cbd8ab.cohuck@redhat.com>
In-Reply-To: <faafbd89-9420-d0ae-5bed-409056ba86b6@ozlabs.ru>
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-2-eric.auger@redhat.com>
	<faafbd89-9420-d0ae-5bed-409056ba86b6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-pci: Introduce
 vfio_register_event_notifier helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Thu, 17 Jan 2019 14:46:42 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 12/01/2019 03:58, Eric Auger wrote:
> > The code used to attach the eventfd handler for the ERR and
> > REQ irq indices can be factorized into a helper. In subsequent
> > patches we will extend this helper to support other irq indices.
> > 
> > We test the notification is allowed outside of the helper:
> > respectively check vdev->pci_aer and VFIO_FEATURE_ENABLE_REQ.
> > Depending on the returned value we set vdev->pci_aer and
> > vdev->req_enabled. An error handle is introduced for future usage
> > although not strictly useful here.>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  hw/vfio/pci.c | 291 ++++++++++++++++++++++----------------------------
> >  1 file changed, 127 insertions(+), 164 deletions(-)
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index c0cb1ec289..c589a4e666 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -105,6 +105,95 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
> >      vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> >  }
> >  
> > +/*
> > + * vfio_register_event_notifier - setup/tear down eventfd
> > + * notification and handling for IRQ indices that span over
> > + * a single IRQ
> > + *
> > + * @vdev: VFIO device handle
> > + * @index: IRQ index the eventfd/handler is associated to
> > + * @target_state: true means notifier needs to be set up
> > + * @handler to attach if @target_state is true
> > + * @errp error handle
> > + */
> > +static int vfio_register_event_notifier(VFIOPCIDevice *vdev,
> > +                                        int index,
> > +                                        bool target_state,
> > +                                        void (*handler)(void *opaque),
> > +                                        Error **errp)
> > +{
> > +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> > +                                      .index = index };
> > +    struct vfio_irq_set *irq_set;
> > +    EventNotifier *notifier;
> > +    int argsz, ret = 0;
> > +    int32_t *pfd, fd;
> > +
> > +    switch (index) {  
> 
> I'd pass the notifier as a parameter as well so index/handler/notifier
> would walk together.

I first had the same thought, but I actually like that everything is
together in this switch statement.

Alternatively, pack it together in an indexed array? But that gets a
bit awkward with the intx stuff.

> 
> 
> > +    case VFIO_PCI_REQ_IRQ_INDEX:
> > +        notifier = &vdev->req_notifier;
> > +        break;
> > +    case VFIO_PCI_ERR_IRQ_INDEX:
> > +        notifier = &vdev->err_notifier;
> > +        break;
> > +    default:
> > +        return -EINVAL;
> > +    }
