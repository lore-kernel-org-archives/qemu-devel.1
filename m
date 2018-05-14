Received: from eggs.gnu.org ([2001:4830:134:3::10]:35417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIDn5-0006su-H4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIDmz-00051G-5j
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:45:27 -0400
Date: Mon, 14 May 2018 15:45:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180514154515.056b605f.cohuck@redhat.com>
In-Reply-To: <ea3c977e-de5c-ed68-fc8d-448efca1d463@linux.ibm.com>
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-2-pasic@linux.ibm.com>
	<20180514141808.78efe5c0.cohuck@redhat.com>
	<ea3c977e-de5c-ed68-fc8d-448efca1d463@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>

On Mon, 14 May 2018 14:40:13 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/14/2018 02:18 PM, Cornelia Huck wrote:
> > On Thu, 10 May 2018 02:07:11 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> There is at least one control program (guest) that although it does not  
> > 
> > I'd drop 'control program' here as well, as it probably confuses more
> > than helps.
> >   
> 
> Will do (everywhere).
> 
> >> rely on the guarantees provided by ORB 1 word 9 bit (aka unlimited
> >> prefetch, aka P bit) not being set, fails to tell this to the machine.
> >>
> >> Usually this ain't a big deal, as the story is usually about performance
> >> optimizations only. But vfio-ccw can not provide the guarantees required
> >> if the bit is not set.  
> > 
> > Isn't that also about channel program rewriting? Or am I mixing things
> > up?
> >   
> 
> I don't understand the question. Can you rephrase it (maybe with more
> details)?

If the caller doesn't allow prefetching, it may manipulate parts of the
channel program that have not yet been fetched. For example, setting a
suspend flag and manipulating ccws that come after that. (I think the
ctc and lcs drivers do something like that, or at least did in the
past.)

> 
> >>
> >> Since it is impossible to implement support for P bit not set (at
> >> impossible least without transitioning to lower level protocols) in
> >> vfio-ccw let's provide a manual override.  
> > 
> > Hm... so the basic idea seems to be "we don't support !PFCH, but we
> > know that the guest will not rely on the guarantees, so we provide the
> > host admin with a way to override the setting"?
> >   
> 
> That is the idea, although I'm not sure what 'the setting' is.

Lack of coffee :) I meant 'handling'.

> 
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> >> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> ---
> >>   hw/s390x/css.c |  3 +--
> >>   hw/vfio/ccw.c  | 13 +++++++++++++
> >>   2 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index 301bf1772f..32f1b2820d 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -1196,8 +1196,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
> >>        * Only support prefetch enable mode.
> >>        * Only support 64bit addressing idal.
> >>        */
> >> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
> >> -        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> >> +    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> >>           warn_report("vfio-ccw requires PFCH and C64 flags set");  
> > 
> > Adapt this warning?
> >   
> >>           sch_gen_unit_exception(sch);
> >>           css_inject_io_interrupt(sch);
> >> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >> index e67392c5f9..32cf606a71 100644
> >> --- a/hw/vfio/ccw.c
> >> +++ b/hw/vfio/ccw.c
> >> @@ -32,6 +32,8 @@ typedef struct VFIOCCWDevice {
> >>       uint64_t io_region_offset;
> >>       struct ccw_io_region *io_region;
> >>       EventNotifier io_notifier;
> >> +    /* force unlimited prefetch */
> >> +    bool f_upfch;  
> > 
> > force_unlimited_prefetch? You only use it that often :)
> >   
> 
> I would have expected complaints for the property name in the
> first place. I think we should first find a good name for the
> property and then consider the rest.

What about 'force_pfch' (at least matches the name of the bit in the
code)?

> 
> >>   } VFIOCCWDevice;
> >>   
> >>   static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> >> @@ -52,8 +54,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
> >>       S390CCWDevice *cdev = sch->driver_data;
> >>       VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> >>       struct ccw_io_region *region = vcdev->io_region;
> >> +    bool upfch = sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH;  
> > 
> > Frankly, I'd drop that variable...
> >   
> >>       int ret;
> >>   
> >> +    if (!upfch && !vcdev->f_upfch) {
> >> +        warn_report("vfio-ccw requires PFCH flag set");
> >> +        sch_gen_unit_exception(sch);
> >> +        css_inject_io_interrupt(sch);
> >> +        return IOINST_CC_EXPECTED;
> >> +    } else if (!upfch) {
> >> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> >> +    }  
> > 
> > and do
> > 
> > if (!(sch->orb.ctrl0 & ORB_CTR0_MASK_PFCH)) {
> >    if (!vcdev->f_upfch) {
> >      ...error...
> >    } else {
> >      ...set bit...
> >    }
> > }
> > 
> > Avoids discussions around variable naming, as well :)
> >   
> 
> Seems like more indentation and more lies of code to me, but
> no strong feelings. It may be easier to read.

Yes, I think this makes it easier to see which branch is taken.

> 
> >> +
> >>       QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
> >>       QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
> >>       QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
> >> @@ -429,6 +441,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> >>   
> >>   static Property vfio_ccw_properties[] = {
> >>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
> >> +    DEFINE_PROP_BOOL("f-upfch", VFIOCCWDevice, f_upfch, false),  
> > 
> > Any particular reason you want to control this on a device-by-device
> > level?
> >   
> 
> It seemed natural for me. What are our options here? I don't like
> machine property, as it is not a machine thing.

On the one hand, we want to accommodate certain guests; on the other
hand, the guest is free to address different devices in different ways
(although I would expect the difference to be more by different device
types).

In the end, it seems that a per-device property is the easiest approach
after all. (The admin can probably set this globally, if desired.)

Another thought: Should there be a warning logged somewhere if we
actually force pfch (i.e., not just set the property)?
