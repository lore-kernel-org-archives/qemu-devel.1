Received: from eggs.gnu.org ([208.118.235.92]:58971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gf7R5-0000GA-LE
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gf7R1-00079I-DF
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:09:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gf7Qz-00076B-V1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:09:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x03I4Kac023996
	for <qemu-devel@nongnu.org>; Thu, 3 Jan 2019 13:09:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pspsuhrbw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 13:09:29 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 3 Jan 2019 18:09:26 -0000
Date: Thu, 3 Jan 2019 19:09:19 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190103155438.68d6afe3.cohuck@redhat.com>
References: <20190103140246.50791-1-liq3ea@163.com>
	<20190103155438.68d6afe3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190103190919.05428d15@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390: avoid potential null
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
Cc: Li Qiang <liq3ea@163.com>, peter.maydell@linaro.org, walling@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Thu, 3 Jan 2019 15:54:38 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  3 Jan 2019 06:02:46 -0800
> Li Qiang <liq3ea@163.com> wrote:
> 
> > When getting the 'pbdev', the if...else has no default branch.
> > From Coverity, the 'pbdev' maybe null when the 'dev' is not
> > the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> > 
> > Spotted by Coverity: CID 1398593
> > 
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/s390x/s390-pci-bus.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 15759b6514..b3122268a3 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -956,6 +956,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> >          pbdev = S390_PCI_DEVICE(dev);
> >          pci_dev = pbdev->pdev;
> > +    } else {
> > +        error_setg(errp, "s390: device unplug for not supported device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +        return;
> 
> I think that is something that really Should Not Happen. However,
> looking at s390_pcihost_plug, we just do nothing if the plugged device
> does not match any of the expected three values. Maybe we should also
> set an error in that case there?
> 

Really Should Not Happen is in this case a programming error AFAIU.
Wouldn't something more assert like reflect that better?

> >      }
> >  
> >      switch (pbdev->state) {
> 
> 
