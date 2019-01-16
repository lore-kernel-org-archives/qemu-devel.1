Received: from eggs.gnu.org ([209.51.188.92]:51253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjhPq-0001RV-0z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjhPn-0001wY-SU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:23:16 -0500
Date: Wed, 16 Jan 2019 10:22:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116102239.4700fee0.cohuck@redhat.com>
In-Reply-To: <05fdc8f0-b7d2-ff3d-0c0b-699864f0f7e9@linux.ibm.com>
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-2-david@redhat.com>
	<05fdc8f0-b7d2-ff3d-0c0b-699864f0f7e9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] s390x/pci: Use hotplug_dev instead
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
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 15 Jan 2019 15:57:38 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/14/19 5:31 AM, David Hildenbrand wrote:
> > We directly have it in our hands.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >   hw/s390x/s390-pci-bus.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 7f911b216a..86dda831f9 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -826,9 +826,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
> >   static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >                                 Error **errp)
> >   {
> > +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
> >       PCIDevice *pdev = NULL;
> >       S390PCIBusDevice *pbdev = NULL;
> > -    S390pciState *s = s390_get_phb();
> >   
> >       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> >           BusState *bus;
> > @@ -935,11 +935,11 @@ static void s390_pcihost_timer_cb(void *opaque)
> >   static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >                                   Error **errp)
> >   {
> > +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
> >       PCIDevice *pci_dev = NULL;
> >       PCIBus *bus;
> >       int32_t devfn;
> >       S390PCIBusDevice *pbdev = NULL;
> > -    S390pciState *s = s390_get_phb();
> >   
> >       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> >           error_setg(errp, "PCI bridge hot unplug currently not supported");
> >   
> 
> Looks like the macro will do the same thing as the function does? I 
> wonder if it makes sense to one day replace all function calls with the 
> macro.

The idea behind the function was to do some caching. Opinions on that
differ :)

> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 

If you like this patch, I don't really object to merging it :)
