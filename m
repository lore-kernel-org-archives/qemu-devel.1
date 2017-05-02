Received: from eggs.gnu.org ([2001:4830:134:3::10]:49584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5aHj-0002Yw-Bo
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5aHe-0004I6-FB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:04:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51079
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5aHe-0004H4-9R
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:04:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42FnJuj108421
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 12:04:13 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6tn99phy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:04:13 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 17:04:11 +0100
Date: Tue, 2 May 2017 18:04:07 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170502021519.GA27968@bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-11-bjsdjshi@linux.vnet.ibm.com>
	<6a3e0621-9e16-ddd4-c1d9-2a7351ebb9e6@redhat.com>
	<20170502021519.GA27968@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170502180407.33a8f468.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/13] s390x/css: introduce and realize
 ccw-request callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, agraf@suse.com

On Tue, 2 May 2017 10:15:19 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Auger Eric <eric.auger@redhat.com> [2017-05-01 19:28:23 +0200]:

> > >  static void vfio_ccw_io_notifier_handler(void *opaque)
> > >  {
> > >      VFIOCCWDevice *vcdev = opaque;
> > > +    struct ccw_io_region *region = vcdev->io_region;
> > > +    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
> > > +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
> > > +    SubchDev *sch = ccw_dev->sch;
> > > +    SCSW *s = &sch->curr_status.scsw;
> > > +    IRB irb;
> > >  
> > >      if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> > >          return;
> > >      }
> > > +
> > > +    if (pread(vcdev->vdev.fd, region,
> > > +              vcdev->io_region_size, vcdev->io_region_offset) == -1) {
> > is it possible to read less bytes than requested?
> Currently, impossible. The kernel side returns either the full region,
> or an error.
> But we surely could make it more friendly for a partial return. I will
> add a check for that case, and generate a channel program check for it.

I think a channel-control check would be more appropriate here.
