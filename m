Received: from eggs.gnu.org ([2001:4830:134:3::10]:41573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5NLe-0001CZ-J1
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5NLb-0004LT-Cr
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:15:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38450
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d5NLb-0004Kr-64
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:15:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v422DVGp032277
	for <qemu-devel@nongnu.org>; Mon, 1 May 2017 22:15:25 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6frwbhxc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 22:15:25 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 1 May 2017 22:15:24 -0400
Date: Tue, 2 May 2017 10:15:19 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-11-bjsdjshi@linux.vnet.ibm.com>
	<6a3e0621-9e16-ddd4-c1d9-2a7351ebb9e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3e0621-9e16-ddd4-c1d9-2a7351ebb9e6@redhat.com>
Message-Id: <20170502021519.GA27968@bjsdjshi@linux.vnet.ibm.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, cornelia.huck@de.ibm.com, agraf@suse.com

* Auger Eric <eric.auger@redhat.com> [2017-05-01 19:28:23 +0200]:

Hi Eric,

> > diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
> > index b58d8e9..4e2fa65 100644
> > --- a/hw/s390x/s390-ccw.h
> > +++ b/hw/s390x/s390-ccw.h
> > @@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
> >      CcwDevice parent_obj;
> >      CssDevId hostid;
> >      char *mdevid;
> > +    int (*handle_request) (ORB *, SCSW *, void *);
> shouldn't this callback be part of the class instead?
Ok. This sounds more proper.

> 
> >  } S390CCWDevice;
> >  
> >  typedef struct S390CCWDeviceClass {
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index cda3057..3ff78c5 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -47,6 +47,36 @@ struct VFIODeviceOps vfio_ccw_ops = {
> >      .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
> >  };
> >  
> > +static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> > +{
> > +    S390CCWDevice *cdev = data;
> > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > +    struct ccw_io_region *region = vcdev->io_region;
> > +    int ret;
> > +
> > +    QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
> > +    QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
> > +    QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
> > +
> > +    memset(region, 0, sizeof(*region));
> > +
> > +    memcpy(region->orb_area, orb, sizeof(ORB));
> > +    memcpy(region->scsw_area, scsw, sizeof(SCSW));
> > +
> > +again:
> > +    ret = pwrite(vcdev->vdev.fd, region,
> > +                 vcdev->io_region_size, vcdev->io_region_offset);
> > +    if (ret != vcdev->io_region_size) {
> > +        if (errno == EAGAIN) {
> > +            goto again;
> > +        }
> > +        error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
> > +        return -errno;
> > +    }
> > +
> > +    return region->ret_code;
> > +}
> > +
> >  static void vfio_ccw_reset(DeviceState *dev)
> >  {
> >      CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> > @@ -59,10 +89,52 @@ static void vfio_ccw_reset(DeviceState *dev)
> >  static void vfio_ccw_io_notifier_handler(void *opaque)
> >  {
> >      VFIOCCWDevice *vcdev = opaque;
> > +    struct ccw_io_region *region = vcdev->io_region;
> > +    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
> > +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
> > +    SubchDev *sch = ccw_dev->sch;
> > +    SCSW *s = &sch->curr_status.scsw;
> > +    IRB irb;
> >  
> >      if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> >          return;
> >      }
> > +
> > +    if (pread(vcdev->vdev.fd, region,
> > +              vcdev->io_region_size, vcdev->io_region_offset) == -1) {
> is it possible to read less bytes than requested?
Currently, impossible. The kernel side returns either the full region,
or an error.
But we surely could make it more friendly for a partial return. I will
add a check for that case, and generate a channel program check for it.

> 
> Thanks
> 
> Eric
> > +        switch (errno) {
> > +        case ENODEV:
> > +            /* Generate a deferred cc 3 condition. */
> > +            s->flags |= SCSW_FLAGS_MASK_CC;
> > +            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> > +            s->ctrl |= (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
> > +            goto read_err;
> > +        case EFAULT:
> > +            /* memory problem, generate channel data check */
> > +            s->ctrl &= ~SCSW_ACTL_START_PEND;
> > +            s->cstat = SCSW_CSTAT_DATA_CHECK;
> > +            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> > +            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> > +                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> > +            goto read_err;
> > +        default:
> > +            /* error, generate channel program check */
> > +            s->ctrl &= ~SCSW_ACTL_START_PEND;
> > +            s->cstat = SCSW_CSTAT_PROG_CHECK;
> > +            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> > +            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> > +                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> > +            goto read_err;
> > +        }
> > +    }
> > +
> > +    memcpy(&irb, region->irb_area, sizeof(IRB));
> > +
> > +    /* Update control block via irb. */
> > +    copy_scsw_to_guest(s, &irb.scsw);
> > +
> > +read_err:
> > +    css_inject_io_interrupt(sch);
> >  }
> >  
> >  static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
[...]

-- 
Dong Jia Shi
