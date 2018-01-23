Received: from eggs.gnu.org ([2001:4830:134:3::10]:36889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eds07-0005cN-UK
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 01:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eds05-0007iO-6s
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 01:24:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35666
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eds05-0007hb-0L
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 01:24:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0N6Isrh096135
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 01:24:03 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fns7a4jj6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 01:24:03 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 01:24:02 -0500
Date: Tue, 23 Jan 2018 14:23:56 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
	<20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
	<a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
Message-Id: <20180123062356.GC32354@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com

* Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-16 16:57:13 +0100]:

> 
> 
> On 01/15/2018 09:59 AM, Dong Jia Shi wrote:
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-12 19:10:20 +0100]:
> > 
> >>
> >>
> >> On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
> >>> What are still missing, thus need to be offered in the next version are:
> >>> - I/O termination and FSM state handling if currently we have I/O on the status
> >>>   switched path.
> >>> - Vary on/off event is not sensible to a guest.
> >>
> >> I don't see a doc update. We do have documentation (in
> >> Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
> >> regions and their purpose/usage  is at least kind of explained. You are
> >> changing this interface without updating the doc.
> >>
> >> I would like to see documentation on this because I'm under the
> >> impression either the design is pretty convoluted or I did not
> >> get it at all.
> > Ah, I missed the documentation part. Thanks for pointing out. I will add
> > it in the next cycle.
> > 
> 
> I would have preferred having a doc update in this cycle. E.g. as
> an answer to the cover letter.
Ok. If you prefer this, let's try to clarify questions right here and
update documentations in the next review cycle (if there is any).

> 
> As previously pointed out I don't really understand your design.
> I wanted to avoid summarizing the design myself (that is my understanding
> of it), to then question the design.
Fair enough.

> 
> To give you a feeling of what I mean here some bullet points:
> * Channel paths are css level resources (simplified).
Yes, and it's the means for the machine to talk to the device.

> * When a channel path malfunctions a CRW is generated and a machine
> check channel report pending is generated. Same goes for
> channel paths popping up (on HW level). Should not these get
> propagated?
AFAIR, channel path related CRW is not that reliable. I mean it seems
that it's not mandatory to generate CRWs for channel path malfunctions.
AFAIU, it depneds on machine models. For example, we won't get
CRW_ERC_INIT for a "path has come" event on many models I believe. And
that's why nobody noticed the misuse of CRW_ERC_IPARM and CRW_ERC_INIT
in the CRW handling logic for channel path CRWs.
Ref:
2daace78a8c9 s390: chp: handle CRW_ERC_INIT for channel-path status change

So my understanding for this is: it really a design decision for us to
propagate all of the channel path CRWs, or we just use other ways (like
using PNO and PNOM as this series shows).

Of course, CRW propagation is good to have. But as a discussion result
of a former thread, that is something we can consider only after we have
a good channel path re-modelling. That is the problem. We can try to
trigger CRW event in some work of machine checks handling enhancement
later.

> * Kind of instead of the CRW you introduce a per device interrupt
> for channel path events on the qemu/kvm boundary. AFAIU for a chp
> event you do an STSCH for each (affected?) subchannel
Until here, yes and right.

> and generate an irq. Right? Why is this a good idea.
This is not right. This series does not generate an irq for the guest.
In QEMU, when it gets the notification of a channel path status change
event, it read the newest SCHIB from the schib region, and update the
SCHIB (patch related parts) for the virtual subchannel. The guest will
get the new SCHIB whenever it calls STSCH then.

I think this is a good idea, because:
1. This is complies the Linux implementation. Path status change could
   be noticed by Linux.
2. This provides enhancement with a small work. On the contrary, channel
   path re-modelling needs a lot of work.

> * SCHIB.PMCW provides path information relevant for a given device.
> This information is retrieved using store subchannel. Is your series
> sufficient for making store subchannel work properly (correct and
> reasonably up to date)?
Introducing a SCHIB region is the basis of further STSCH hanlding work.
This series depends on it, and only focuses on the update of the channel
path related parts of it. And for these parts, this work I think is
basically correct (more review comments are surely to be welcomed).

For the rest parts, this does not change anything than what have. As
replied to Conny in other mail of this thread: I think, if the other
fields are handled by QEMU well, then we don't need to trigger update
events for them. Currently I don't find things that need extra trigger.

> Regarding PMCW it's supposed to get updated when io functions are
> preformed by the css, AFAIR. Is that right?
I think so. And also for some other cases, for example, when we
configure on/off a channel path.

>  If yes what are the implications? Are the manipulations you do on
>  some PMCW fields architecturally correct?
If "architecturally correct" means what guest sees/senses is all obey to
the PoP, then I think so. We don't have to emulate the internal
behaviors (which could not be seen by OS) of CSS exactly when we
emulate, if the emulation does not impact on what Linux guest will see,
right?

I mean, the time point we update the PMCW does not has to be in the time
slot of io function performance. The guest would still have to get the
updated information through the calls of STSCH. We only need to provide
the updaetd result to the guest by handling STSCH well. And that's why
we say we do that lazily.

Nothing different (added value) will be seen by the guest, comparing
with the current lazy implementation I think.

> * The one thing I would very much appreciate as an user of vfio,
> and should in my understanding be the user story of this series
> (and the qemu counterpart of course) is the following. If my device
> (that is IO operation) failed because no path could be found on
> which the device is accessible, I would like to be able to identify
> that. Preferably the same way I would do for an LPAR guest. Is this
> series accomplishing that? 
With this the guest could lazily identify that. But since we have no
machine check propagation yet, for those cases which generate CRWs, it
might not be the same way for an LPAR guest I think.

> * Why not just do proper STSCH for vfio-ccw?
I only did the interested parts (path related). For the other parts, the
current handling is enough, no? Anyway, after we have the schib region,
we can do further STSCH handling any time later we want then.

> * Shouldn't we virtualize CHPIDs?
Nobody would say no for this. :) The problem is that this is something
big, and it's not a short-term goal in my current working project... I
really want to deliver a minimal function set in the near future
firstly. If the current working does not hurt, can we defer channel path
re-modelling and CHPIDs virtualization?

> What if we have a clash? Lets say my dasd is only accessible via chp
> 0.00 in the host. Currently we have a problem there, or (as the only
> path would end up being ignored)?
You mean the clash that sharing path 0.00 between a physical dasd and
the virtio ccw devices? The problem I saw is in the checking of the
chpid.is_virtual in css_do_rchp(). For a virtual chp, we should generate
INIT CRWs; while for a non-virtual one, we shouldn't. If the chp is
shared with virtual and non-virtual device, I don't know what to do
then...

I don't think we can fix this before we re-modelled the channel path.
But this is neither introduced nor aggravated by this series, right?

We'd have to document this either I think.

> Note: this is another unpleasant effect of not having MCSSE in the
> guest. The original design was to have a separate css for vfio, and
> then we would not have this kind of a problem.  (Virtualization of
> chps would still be good for migration.)
Nod. BTW, I don't say that I do not want channel path virtualization in
the long run. It's just I want a minimal function set more currently
from what I'm focusing perspective.

THANKS for these insightful questions!

-- 
Dong Jia Shi
