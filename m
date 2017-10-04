Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzgMI-0001rZ-Ba
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzgMF-0000ec-9f
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzgMF-0000eL-3Y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:52:51 -0400
Date: Wed, 4 Oct 2017 11:52:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004115246.79d9ae8e.cohuck@redhat.com>
In-Reply-To: <23a6f10f-086c-874e-8aeb-b0cdc1916127@redhat.com>
References: <20171004090032.27365-1-cohuck@redhat.com>
	<23a6f10f-086c-874e-8aeb-b0cdc1916127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: sort some devices into categories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net

On Wed, 4 Oct 2017 11:20:00 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 04.10.2017 11:00, Cornelia Huck wrote:
> > Add missing categorizations for some s390x devices:
> > - zpci device -> misc
> > - 3270 -> display
> > - vfio-ccw -> misc
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/3270-ccw.c     | 1 +
> >  hw/s390x/s390-pci-bus.c | 1 +
> >  hw/vfio/ccw.c           | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> > diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
> > index eaca28e224..081e3ef6f4 100644
> > --- a/hw/s390x/3270-ccw.c
> > +++ b/hw/s390x/3270-ccw.c
> > @@ -160,6 +160,7 @@ static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
> >      dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
> >      dc->realize = emulated_ccw_3270_realize;
> >      dc->hotpluggable = false;
> > +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);  
> 
> While you're at it, add a proper dc->desc ?
> 
> >  }
> >  
> >  static const TypeInfo emulated_ccw_3270_info = {
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 3b9965fde0..96116b7d1e 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -1032,6 +1032,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >  
> >      dc->desc = "zpci device";  
> 
> While you're at it, add better desc?

Hey, it's not wrong :) (and I can't really think of a good one...)

> 
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >      dc->reset = s390_pci_device_reset;
> >      dc->bus_type = TYPE_S390_PCI_BUS;
> >      dc->realize = s390_pci_device_realize;
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index a8baadf57a..76323c6bde 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -413,6 +413,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
> >      dc->props = vfio_ccw_properties;
> >      dc->vmsd = &vfio_ccw_vmstate;
> >      dc->desc = "VFIO-based subchannel assignment";
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >      dc->realize = vfio_ccw_realize;
> >      dc->unrealize = vfio_ccw_unrealize;
> >      dc->reset = vfio_ccw_reset;
> >   
> 
> Anyway, it's also fine without better descs, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
