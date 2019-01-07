Received: from eggs.gnu.org ([209.51.188.92]:57752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggX6U-0002zJ-A8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggX6T-00016a-Ip
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:46:14 -0500
Date: Mon, 7 Jan 2019 16:45:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190107164559.02476c6e.cohuck@redhat.com>
In-Reply-To: <20190104160515.1b4a6dc1@oc2783563651>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<20190104160515.1b4a6dc1@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] s390: avoid potential null
 dereference in s390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Li Qiang <liq3ea@163.com>, peter.maydell@linaro.org, walling@linux.ibm.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Fri, 4 Jan 2019 16:05:15 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 4 Jan 2019 15:10:05 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Thu,  3 Jan 2019 07:16:12 -0800
> > Li Qiang <liq3ea@163.com> wrote:
> >   
> > > When getting the 'pbdev', the if...else has no default branch.
> > > From Coverity, the 'pbdev' maybe null when the 'dev' is not
> > > the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> > > This patch adds a default branch for device plug and unplug.
> > > 
> > > Spotted by Coverity: CID 1398593
> > > 
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > > Adds a default branch for device plug per Cornelia's review.
> > > 
> > >  hw/s390x/s390-pci-bus.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > > index 15759b6514..fe48a36ff6 100644
> > > --- a/hw/s390x/s390-pci-bus.c
> > > +++ b/hw/s390x/s390-pci-bus.c
> > > @@ -912,6 +912,9 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >          pbdev->fh = pbdev->idx;
> > >          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
> > >          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
> > > +    } else {
> > > +        error_setg(errp, "s390: device plug request for not supported device"
> > > +                   " type: %s", object_get_typename(OBJECT(dev)));  
> > 
> > Maybe make this "s390/pci: plugging device type <%s> is not supported"?
> >   
> 
> Under what circumstances could/does this happen? I mean how can this
> be triggered by the user?

Probably only if a new type that can be plugged has been added, but the
s390 pci code has not been updated. We could also assert, not sure what
would make it easier to figure out what went wrong.
