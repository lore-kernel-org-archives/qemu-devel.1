Received: from eggs.gnu.org ([209.51.188.92]:37691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkQXT-0004YI-5P
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkQXR-00018P-3q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:34:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gkQXQ-000189-S4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:34:09 -0500
Date: Fri, 18 Jan 2019 10:33:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190118103359.41a6e578.cohuck@redhat.com>
In-Reply-To: <0da57281-7039-b942-5efd-6e07c6a4c94a@redhat.com>
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-2-eric.auger@redhat.com>
	<faafbd89-9420-d0ae-5bed-409056ba86b6@ozlabs.ru>
	<739abfa7-5faa-0c0c-7e81-80136e702e08@redhat.com>
	<34fa59d1-225b-fbea-dca5-fdc9b789662a@ozlabs.ru>
	<0da57281-7039-b942-5efd-6e07c6a4c94a@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Fri, 18 Jan 2019 10:08:12 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alexey,
> 
> On 1/18/19 5:14 AM, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 17/01/2019 20:16, Auger Eric wrote:  
> >> Hi Alexey, Cornelia,
> >>
> >> On 1/17/19 4:46 AM, Alexey Kardashevskiy wrote:  
> >>>
> >>>
> >>> On 12/01/2019 03:58, Eric Auger wrote:  
> >>>> The code used to attach the eventfd handler for the ERR and
> >>>> REQ irq indices can be factorized into a helper. In subsequent
> >>>> patches we will extend this helper to support other irq indices.
> >>>>
> >>>> We test the notification is allowed outside of the helper:
> >>>> respectively check vdev->pci_aer and VFIO_FEATURE_ENABLE_REQ.
> >>>> Depending on the returned value we set vdev->pci_aer and
> >>>> vdev->req_enabled. An error handle is introduced for future usage
> >>>> although not strictly useful here.>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  hw/vfio/pci.c | 291 ++++++++++++++++++++++----------------------------
> >>>>  1 file changed, 127 insertions(+), 164 deletions(-)
> >>>>
> >>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>>> index c0cb1ec289..c589a4e666 100644
> >>>> --- a/hw/vfio/pci.c
> >>>> +++ b/hw/vfio/pci.c
> >>>> @@ -105,6 +105,95 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
> >>>>      vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> >>>>  }
> >>>>  
> >>>> +/*
> >>>> + * vfio_register_event_notifier - setup/tear down eventfd
> >>>> + * notification and handling for IRQ indices that span over
> >>>> + * a single IRQ
> >>>> + *
> >>>> + * @vdev: VFIO device handle
> >>>> + * @index: IRQ index the eventfd/handler is associated to
> >>>> + * @target_state: true means notifier needs to be set up
> >>>> + * @handler to attach if @target_state is true
> >>>> + * @errp error handle
> >>>> + */
> >>>> +static int vfio_register_event_notifier(VFIOPCIDevice *vdev,
> >>>> +                                        int index,
> >>>> +                                        bool target_state,
> >>>> +                                        void (*handler)(void *opaque),
> >>>> +                                        Error **errp)
> >>>> +{
> >>>> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> >>>> +                                      .index = index };
> >>>> +    struct vfio_irq_set *irq_set;
> >>>> +    EventNotifier *notifier;
> >>>> +    int argsz, ret = 0;
> >>>> +    int32_t *pfd, fd;
> >>>> +
> >>>> +    switch (index) {  
> >>>
> >>> I'd pass the notifier as a parameter as well so index/handler/notifier
> >>> would walk together.  
> >>
> >> I tend to agree with Cornelia. moving the notifier out of this helper
> >> would remove some factorization and this way, the caller does not have
> >> to care about it.  
> > 
> > 
> > Then why pass the handler? It also could go into this switch,
> > vfio_register_event_notifier()/vfio_set_event_handler() is never called
> > with more than one handler per index (or NULL but then target_state==false).  
> I don't have any strong opinion here. I will align with the majority's
> opinion.

If we are sure that the same index/notifier will always use the same
handler when setting (i.e., not a different handler if some feature is
available), we could also move getting it to the switch statement.
OTOH, passing in a handler is a common pattern. Don't really have a
strong opinion here.
