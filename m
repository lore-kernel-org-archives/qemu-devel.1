Received: from eggs.gnu.org ([209.51.188.92]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghtGx-0004wy-8s
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghtGw-00089i-Dh
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:38:39 -0500
Date: Fri, 11 Jan 2019 10:38:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190111103828.058ccc6c.cohuck@redhat.com>
In-Reply-To: <4988f58e-4bc5-c622-53b7-cfda758304e1@redhat.com>
References: <20190110210358.24035-1-david@redhat.com>
	<4988f58e-4bc5-c622-53b7-cfda758304e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Send correct event on
 hotplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 11 Jan 2019 08:16:41 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 10.01.19 22:03, David Hildenbrand wrote:
> > Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> > changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
> > ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
> > HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
> > state.
> > 
> > Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
> > state the device is in.
> > 
> > This fixes hotplugged devices having to be enabled explicitly in the
> > guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.
> > 
> > Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> > Report-by: Cornelia Huck <cohuck@redhat.com>  

Cool, works for me as well.

Tested-by: Cornelia Huck <cohuck@redhat.com>

Do we want to cc:stable? Probably not, as it's more annoying than
critical, and pci hotplug does not seem to be much used on s390x.

> 
> If this patch is the right thing to do, then
> 
> 1. s/Report-by/Reported-by/
> 2. Dropping the "." from the subject
> 
> (yes, it was late)

:) Can do while applying.

> 
> I wonder if we should do both events sequentially, but as I don't have
> access to the architecture I have to rely on that this works :)

Yep, let's wait for feedback from folks with architecture access.

> 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 15759b6514..7f911b216a 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -899,7 +899,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          }
> >  
> >          if (dev->hotplugged) {
> > -            s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDBY,
> > +            s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
> >                                           pbdev->fh, pbdev->fid);
> >          }
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> >   
> 
> 
