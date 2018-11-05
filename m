Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJeCV-0003e0-Q9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJeCS-0002un-KO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:41:51 -0500
Date: Mon, 5 Nov 2018 13:41:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181105134118.01fef179.cohuck@redhat.com>
In-Reply-To: <b114a7d0-1e56-2294-484c-f4143cfd989e@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-5-david@redhat.com>
	<b114a7d0-1e56-2294-484c-f4143cfd989e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/4] s390x/zpci: properly fail if the
 zPCI device cannot be created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Michael S
	. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>

On Mon, 5 Nov 2018 13:04:04 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2018-11-05 12:03, David Hildenbrand wrote:
> > Right now, errors during realize()/pre_plug/plug of the zPCI device
> > would result in QEMU crashing instead of failing nicely when creating
> > a zPCI device for a PCI device.

Yeah, failing instead of crashing is better :)

Is there any way we can trigger this problem for testing?

> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 1849f9d334..4939490c7c 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -778,17 +778,31 @@ static void s390_pci_msix_free(S390PCIBusDevice *pbdev)
> >  }
> >  
> >  static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
> > -                                             const char *target)
> > +                                             const char *target, Error **errp)
> >  {
> > -    DeviceState *dev = NULL;
> > +    Error *local_err = NULL;
> > +    DeviceState *dev;
> >  
> >      dev = qdev_try_create(BUS(s->bus), TYPE_S390_PCI_DEVICE);
> >      if (!dev) {
> > +        error_setg(errp, "zPCI device could not be created");
> >          return NULL;
> >      }
> >  
> > -    qdev_prop_set_string(dev, "target", target);
> > -    qdev_init_nofail(dev);
> > +    object_property_set_str(OBJECT(dev), "target", target, &local_err);
> > +    if (local_err) {
> > +        object_unparent(OBJECT(dev));
> > +        error_propagate_prepend(errp, local_err,
> > +                                "zPCI device could not be created: ");
> > +        return NULL;
> > +    }
> > +    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
> > +    if (local_err) {
> > +        object_unparent(OBJECT(dev));
> > +        error_propagate_prepend(errp, local_err,
> > +                                "zPCI device could not be created: ");
> > +        return NULL;
> > +    }
> >  
> >      return S390_PCI_DEVICE(dev);
> >  }
> > @@ -873,9 +887,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  
> >          pbdev = s390_pci_find_dev_by_target(s, dev->id);
> >          if (!pbdev) {
> > -            pbdev = s390_pci_device_new(s, dev->id);
> > +            pbdev = s390_pci_device_new(s, dev->id, errp);
> >              if (!pbdev) {
> > -                error_setg(errp, "create zpci device failed");
> >                  return;
> >              }
> >          }
> >   
> 
> Looks right to me, I think this is even suitable for v3.1.

I can consider this for 3.1. Is this patch standalone?

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
