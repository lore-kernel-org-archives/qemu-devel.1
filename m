Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiAH-0004OC-Ql
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiAC-0001l4-TP
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:07:57 -0500
Date: Thu, 8 Nov 2018 12:07:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108120741.2e463fe2.cohuck@redhat.com>
In-Reply-To: <c2c3c667-e04e-9498-c4d7-05eaeedf0a26@linux.ibm.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-3-david@redhat.com>
	<20181105122148.2eae5288.cohuck@redhat.com>
	<3ba91b23-fbea-edce-3f2e-d3405cb3b4f7@redhat.com>
	<a836fc7f-ab55-a51e-26ed-4d0dfd721737@de.ibm.com>
	<a7da29b4-68ff-ae8b-5c0e-e025a7939102@redhat.com>
	<c2c3c667-e04e-9498-c4d7-05eaeedf0a26@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/zpci: use hotplug_dev instead
 of looking up the host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 7 Nov 2018 15:28:31 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 11/5/18 6:50 AM, David Hildenbrand wrote:
> > On 05.11.18 12:40, Christian Borntraeger wrote:  
> >>
> >>
> >> On 11/05/2018 12:37 PM, David Hildenbrand wrote:  
> >>> On 05.11.18 12:21, Cornelia Huck wrote:  
> >>>> On Mon,  5 Nov 2018 12:03:11 +0100
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>  
> >>>>> We directly have it in our hands.
> >>>>>
> >>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>>> ---
> >>>>>  hw/s390x/s390-pci-bus.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> >>>>> index 1eaae3aca6..68660eac74 100644
> >>>>> --- a/hw/s390x/s390-pci-bus.c
> >>>>> +++ b/hw/s390x/s390-pci-bus.c
> >>>>> @@ -814,9 +814,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
> >>>>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>>>>                                Error **errp)
> >>>>>  {
> >>>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
> >>>>>      PCIDevice *pdev = NULL;
> >>>>>      S390PCIBusDevice *pbdev = NULL;
> >>>>> -    S390pciState *s = s390_get_phb();
> >>>>>  
> >>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> >>>>>          BusState *bus;
> >>>>> @@ -924,11 +924,11 @@ static void s390_pcihost_timer_cb(void *opaque)
> >>>>>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>>>>                                  Error **errp)
> >>>>>  {
> >>>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
> >>>>>      PCIDevice *pci_dev = NULL;
> >>>>>      PCIBus *bus;
> >>>>>      int32_t devfn;
> >>>>>      S390PCIBusDevice *pbdev = NULL;
> >>>>> -    S390pciState *s = s390_get_phb();
> >>>>>  
> >>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> >>>>>          error_setg(errp, "PCI bridge hot unplug currently not supported");  
> >>>>
> >>>> Not sure whether that is an improvement (s390_get_phb() caches the
> >>>> value, and is called from multiple other places as well.)
> >>>>  
> >>>
> >>> Looking up a variable that is directly passed as an argument doesn't
> >>> look clean to me.  
> >>
> >> I think there was a reason for this caching, namely that qom resolution can
> >> be quite expensive. For the hotplug case this obviously does not matter but
> >> for all the other cases it might. So do we really want to have different 
> >> places use different methods?
> >>  
> > 
> > Caching resolution is fine (as that is expensive), caching a downcast is
> > as far as I remember not necessary. Especially, as you said, for hotplug
> > handlers.

Yes, the complete QOM cast was the expensive thing AFAIR.

> > 
> > Anyhow, if there are strong feelings to this change, I can drop this
> > patch. There are certainly more important things to do in zPCI hotplug code.
> > 
> >   
> 
> Truthfully, I'm not in favor of one over the other. As long as the device handlers
> are consistent, I think either is fine.

I don't feel *that* strong about this change here, either :) Your call.

> 
> However, it would be nice if at some point during plug we cache the PHB somewhere.
> That would be some sort of best-of-both-worlds approach.

Not sure if caching-from-a-downcast would be conceptionally clean. I'd
vote for either taking this patch or dropping it completely.
