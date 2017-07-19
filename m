Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXcvM-00030T-My
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXcvH-00036P-QK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:33:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56933
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dXcvH-00036D-K7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:33:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J0T94V131167
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:33:02 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bskq6gceg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:33:01 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 20:33:01 -0400
Date: Wed, 19 Jul 2017 08:32:55 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
	<20170718014926.44781-2-bjsdjshi@linux.vnet.ibm.com>
	<20170718103213.29a597b2@gondolin>
	<20170718084943.GC15985@bjsdjshi@linux.vnet.ibm.com>
	<20170718110749.5e7bcc65@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718110749.5e7bcc65@gondolin>
Message-Id: <20170719003255.GA11964@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/ccw: allocate irq info with the
 right size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, Jing Zhang <bjzhjing@linux.vnet.ibm.com>

* Cornelia Huck <cohuck@redhat.com> [2017-07-18 11:07:49 +0200]:

> On Tue, 18 Jul 2017 16:49:43 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Cornelia Huck <cohuck@redhat.com> [2017-07-18 10:32:13 +0200]:
> > 
> > > On Tue, 18 Jul 2017 03:49:25 +0200
> > > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > >   
> > > > From: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
> > > > 
> > > > When allocating memory for the vfio_irq_info parameter of the
> > > > VFIO_DEVICE_GET_IRQ_INFO ioctl, we used the wrong size. Let's
> > > > fix it by using the right size.
> > > > 
> > > > Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > Signed-off-by: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
> > > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > ---
> > > >  hw/vfio/ccw.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > > index 12d0262336..8d97b53e77 100644
> > > > --- a/hw/vfio/ccw.c
> > > > +++ b/hw/vfio/ccw.c
> > > > @@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> > > >          return;
> > > >      }
> > > >  
> > > > -    argsz = sizeof(*irq_set);
> > > > +    argsz = sizeof(*irq_info);
> > > >      irq_info = g_malloc0(argsz);
> > > >      irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> > > >      irq_info->argsz = argsz;  
> > > 
> > > irq_set is larger than irq_info, but yes, let's do this correctly.
> > > 
> > > Out of curiosity, how did you spot this?
> > >   
> > 
> > I'm trying to reuse the code here, while introducing some new MMIO
> > regions, which you will see them some days later. ;>
> > 
> 
> Looking forward to that :)
> 

If they are lucky enough to survive the internal review to meet you.
haha.
