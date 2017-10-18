Received: from eggs.gnu.org ([2001:4830:134:3::10]:37203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4l1Y-000885-7M
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4l1U-00056s-25
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e4l1T-00056B-P5
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:52:23 -0400
Date: Wed, 18 Oct 2017 11:52:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171018115219.2dafd05c.cohuck@redhat.com>
In-Reply-To: <0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
	<0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 18 Oct 2017 11:30:47 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.10.2017 16:04, Halil Pasic wrote:
> > Simplify the error handling of the SSCH and RSCH handler avoiding
> > arbitrary and cryptic error codes being used to tell how the instruction
> > is supposed to end.  Let the code detecting the condition tell how it's
> > to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> > in one go as the emulation of the two shares a lot of code.
> > 
> > For passthrough this change isn't pure refactoring, but changes the way
> > kernel reported EFAULT is handled. After clarifying the kernel interface
> > we decided that EFAULT shall be mapped to unit exception.  Same goes for
> > unexpected error codes and absence of required ORB flags.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/css.c              | 84 +++++++++++++--------------------------------
> >  hw/s390x/s390-ccw.c         | 11 +++---
> >  hw/vfio/ccw.c               | 28 +++++++++++----
> >  include/hw/s390x/css.h      | 23 +++++++++----
> >  include/hw/s390x/s390-ccw.h |  2 +-
> >  target/s390x/ioinst.c       | 53 ++++------------------------
> >  6 files changed, 75 insertions(+), 126 deletions(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index aa233d5f8a..ff5a05c34b 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -1181,12 +1181,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >  
> >  }
> >  
> > -static int sch_handle_start_func_passthrough(SubchDev *sch)
> > +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
> >  {
> >  
> >      PMCW *p = &sch->curr_status.pmcw;
> >      SCSW *s = &sch->curr_status.scsw;
> > -    int ret;
> >  
> >      ORB *orb = &sch->orb;
> >      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
> > @@ -1200,31 +1199,12 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
> >       */
> >      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
> >          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> > -        return -EINVAL;
> > +        warn_report("vfio-ccw requires PFCH and C64 flags set...");  
> 
> Not sure, but should this maybe rather be a
> "qemu_log_mask(LOG_GUEST_ERROR, ...)" instead?

Is that visible by default, though? I'd rather want the admin to be
able to find a hint in a log somewhere why the guest I/O is rejected.

> Anyway, as Cornelia already mentioned it: Please drop the trailing dots.
> 
> > +        sch_gen_unit_exception(sch);
> > +        css_inject_io_interrupt(sch);
> > +        return IOINST_CC_EXPECTED;
> >      }  
> [...]
> > @@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
> >      }
> >  }
> >  
> > -int css_do_rsch(SubchDev *sch)
> > +IOInstEnding css_do_rsch(SubchDev *sch)
> >  {
> >      SCSW *s = &sch->curr_status.scsw;
> >      PMCW *p = &sch->curr_status.pmcw;
> > -    int ret;
> >  
> >      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
> > -        ret = -ENODEV;
> > -        goto out;
> > +        return IOINST_CC_NOT_OPERATIONAL;
> >      }
> >  
> >      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
> > -        ret = -EINPROGRESS;
> > -        goto out;
> > +        return IOINST_CC_STATUS_PRESENT;
> >      }
> >  
> >      if (((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
> >          (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
> >          (!(s->ctrl & SCSW_ACTL_SUSP))) {
> > -        ret = -EINVAL;
> > -        goto out;
> > +        return IOINST_CC_BUSY;  
> 
> Why is EINVAL now mapped to IOINST_CC_BUSY? Shouldn't that be
> IOINST_CC_STATUS_PRESENT instead?

No, that is correct (see the PoP for when cc 2 is supposed to be set by
rsch).

> 
> >      }  
> [...]
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 76323c6bde..1cc2e5d873 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -47,9 +47,9 @@ struct VFIODeviceOps vfio_ccw_ops = {
> >      .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
> >  };
> >  
> > -static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> > +static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
> >  {
> > -    S390CCWDevice *cdev = data;
> > +    S390CCWDevice *cdev = sch->driver_data;
> >      VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> >      struct ccw_io_region *region = vcdev->io_region;
> >      int ret;
> > @@ -60,8 +60,8 @@ static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> >  
> >      memset(region, 0, sizeof(*region));
> >  
> > -    memcpy(region->orb_area, orb, sizeof(ORB));
> > -    memcpy(region->scsw_area, scsw, sizeof(SCSW));
> > +    memcpy(region->orb_area, &sch->orb, sizeof(ORB));
> > +    memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
> >  
> >  again:
> >      ret = pwrite(vcdev->vdev.fd, region,
> > @@ -71,10 +71,24 @@ again:
> >              goto again;
> >          }
> >          error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
> > -        return -errno;
> > +        ret = -errno;
> > +    } else {
> > +        ret = region->ret_code;
> > +    }
> > +    switch (-ret) {
> > +    case 0:
> > +        return IOINST_CC_EXPECTED;
> > +    case EBUSY:
> > +        return IOINST_CC_BUSY;
> > +    case ENODEV:
> > +    case EACCES:
> > +        return IOINST_CC_NOT_OPERATIONAL;
> > +    case EFAULT:
> > +    default:
> > +        sch_gen_unit_exception(sch);
> > +        css_inject_io_interrupt(sch);
> > +        return IOINST_CC_EXPECTED;  
> 
> Do we feel really confident that it is OK to do the setcc() in case of
> an exception here later? ... otherwise it might be necessery to
> introduce something like IOINST_EXCEPTION to the enum to signal the
> ioinst_handle_xxx() callers that they should not do the setcc() anymore...

I think Halil's comments in patch 2 already hint at possibly needing to
add IOINST_EXCEPTION later.
