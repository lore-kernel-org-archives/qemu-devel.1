Received: from eggs.gnu.org ([208.118.235.92]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gfR2U-0000LN-W1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gfR2Q-0004S5-0r
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:05:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gfR2L-0004Gc-Iz
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:05:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x04Ex1xt064742
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 10:05:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pt6yerr57-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 10:05:23 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 4 Jan 2019 15:05:21 -0000
Date: Fri, 4 Jan 2019 16:05:15 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190104151005.42b6f111.cohuck@redhat.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190104160515.1b4a6dc1@oc2783563651>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, peter.maydell@linaro.org, walling@linux.ibm.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Fri, 4 Jan 2019 15:10:05 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  3 Jan 2019 07:16:12 -0800
> Li Qiang <liq3ea@163.com> wrote:
> 
> > When getting the 'pbdev', the if...else has no default branch.
> > From Coverity, the 'pbdev' maybe null when the 'dev' is not
> > the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> > This patch adds a default branch for device plug and unplug.
> > 
> > Spotted by Coverity: CID 1398593
> > 
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> > Adds a default branch for device plug per Cornelia's review.
> > 
> >  hw/s390x/s390-pci-bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 15759b6514..fe48a36ff6 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -912,6 +912,9 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          pbdev->fh = pbdev->idx;
> >          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
> >          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
> > +    } else {
> > +        error_setg(errp, "s390: device plug request for not supported device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> 
> Maybe make this "s390/pci: plugging device type <%s> is not supported"?
> 

Under what circumstances could/does this happen? I mean how can this
be triggered by the user?

Regards,
Halil

> >      }
> >  }
> >  
> > @@ -956,6 +959,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> >          pbdev = S390_PCI_DEVICE(dev);
> >          pci_dev = pbdev->pdev;
> > +    } else {
> > +        error_setg(errp, "s390: device unplug request for not supported device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> 
> Halil has a point when he suggests an assert here. If we fence the
> device type in the plug function, I can't think of a way we would end
> up here.
> 
> > +        return;
> >      }
> >  
> >      switch (pbdev->state) {
> 
> 
