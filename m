Received: from eggs.gnu.org ([2001:4830:134:3::10]:49900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLV2U-000581-N1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLV2Q-00028L-NF
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:46:54 -0400
Date: Wed, 23 May 2018 16:46:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180523164640.225908a9.cohuck@redhat.com>
In-Reply-To: <a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
	<20180523113708.50b21a77.cohuck@redhat.com>
	<a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, 23 May 2018 16:31:53 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/23/2018 11:37 AM, Cornelia Huck wrote:
> > On Wed, 23 May 2018 00:16:54 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> There is at least one guest (OS) such that although it does not rely on
> >> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
> >> P bit) not being set, it fails to tell this to the machine.
> >>
> >> Usually this ain't a big deal, as the original purpose of the P bit is to
> >> allow for performance optimizations. vfio-ccw however can not provide the
> >> guarantees required if the bit is not set.
> >>
> >> It is impossible to implement support for P bit not set (at impossible
> >> least without transitioning to lower level protocols) for vfio-ccw.  
> > 
> > "It is not possible to implement support for the P bit not set without
> > transitioning to lower level protocols for vfio-ccw."  
> > > ?  
> 
> Sounds much better. My sentence is ungrammatical.
> 
> >   
> >> So
> >> let's give the user the opportunity to force the P bit to set, if the  
> > 
> > s/to set/to be set/
> >   
> 
> Why do we need the 'be'?

Or "to force setting the P bit". It doesn't set itself :)

> 
> >> user knows this is safe.  For self modifying channel programs forcing the
> >> P bit is not safe. If P bit is forced for a self modifying channel  
> > 
> > s/P bit/the P bit/
> >   
> 
> Right.
> 
> >> program things are expected to break in strange ways.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> >> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>

> >> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >> index e67392c5f9..62de4c9710 100644
> >> --- a/hw/vfio/ccw.c
> >> +++ b/hw/vfio/ccw.c
> >> @@ -32,8 +32,20 @@ typedef struct VFIOCCWDevice {
> >>       uint64_t io_region_offset;
> >>       struct ccw_io_region *io_region;
> >>       EventNotifier io_notifier;
> >> +    bool force_orb_pfch;
> >> +    bool warned_force_orb_pfch;
> >>   } VFIOCCWDevice;
> >>   
> >> +#define WARN_ONCE(warned, fmt...) \
> >> +({\
> >> +if (!(warned)) {\
> >> +    warn_report((fmt));\
> >> +} \
> >> +warned = true;\
> >> +})  
> > 
> > I think introducing a macro for the single user is overkill here.
> > 
> > We might contemplate a generic "print this error once, controlled by
> > this flag" functionality, if there are more users.
> >  
> 
> I would prefer keeping the macro. If this generic functionality comes
> along it will be easier to spot the home-brewn counterpart. Also it's
> easier to read IMHO.

I'm really not too fond of that macro...

> BTW the macro could be an inline function like:
> 
>   static inline void warn_once(bool *warned, const char *fmt, ...)
> {
>      va_list ap;
> 
> 
>      if (!warned || *warned) {
>          return;
>      }
>      *warned= true;
>      va_start(ap, fmt);
>      vreport(REPORT_TYPE_WARNING, fmt, ap);
>      va_end(ap);
> }
> 
> if that's better.

I think an inline function is a better choice.

Also, if this is something that might be generally useful it should go
into util/error.c. Let's cc: Markus.

> 
> >> +
> >> +
> >> +
> >>   static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> >>   {
> >>       vdev->needs_reset = false;
> >> @@ -54,6 +66,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
> >>       struct ccw_io_region *region = vcdev->io_region;
> >>       int ret;
> >>   
> >> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> >> +        if (!(vcdev->force_orb_pfch)) {
> >> +            warn_report("vfio-ccw requires PFCH flag set");
> >> +            sch_gen_unit_exception(sch);
> >> +            css_inject_io_interrupt(sch);
> >> +            return IOINST_CC_EXPECTED;
> >> +        } else {
> >> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> >> +            WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced");  
> > 
> > This message should probably mention vfio-ccw as well as the subchannel
> > id?
> >   
> 
> I was thinking about this. I think all it would make sense to have a common
> prefix for all reports coming form vfio-ccw (QEMU). But then I was like, that
> is a separate patch.
> 
> Maybe something like:
> vfio-ccw (xx.xx.xxxx): specific message
> 
> OTOH we don't seem to do that elsewhere (git grep -e 'warn\|error_report\|error_setg' -- hw/s390x/).
> AFAIR the error_setg captures context (like, src, line, func) but does not
> necessarily report it. Another question is if this should be extended to
> hw/s390x/s390-ccw.c
> 
> What do you think?

I'm not sure that makes sense, especially as not everything might
explicitly refer to a certain subchannel.

Let's just add the subchannel id here? In this case, this is really a
useful piece of information (which device is showing this behaviour?)
