Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eefSa-0004B0-Ax
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eefSV-0004Hc-7s
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:12:48 -0500
Date: Thu, 25 Jan 2018 12:12:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180125121237.0b247994.cohuck@redhat.com>
In-Reply-To: <20180123062356.GC32354@bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
	<20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
	<a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
	<20180123062356.GC32354@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com

On Tue, 23 Jan 2018 14:23:56 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-16 16:57:13 +0100]:

> > To give you a feeling of what I mean here some bullet points:
> > * Channel paths are css level resources (simplified).  
> Yes, and it's the means for the machine to talk to the device.
> 
> > * When a channel path malfunctions a CRW is generated and a machine
> > check channel report pending is generated. Same goes for
> > channel paths popping up (on HW level). Should not these get
> > propagated?  
> AFAIR, channel path related CRW is not that reliable. I mean it seems
> that it's not mandatory to generate CRWs for channel path malfunctions.
> AFAIU, it depneds on machine models. For example, we won't get
> CRW_ERC_INIT for a "path has come" event on many models I believe. And
> that's why nobody noticed the misuse of CRW_ERC_IPARM and CRW_ERC_INIT
> in the CRW handling logic for channel path CRWs.
> Ref:
> 2daace78a8c9 s390: chp: handle CRW_ERC_INIT for channel-path status change

Yes, CRWs for channel paths have (at least historically) been a bit of
a hit-and-miss.

[Also, I don't think that channel path CRWs are in any way mandatory
from how I read the PoP. Not sure if there's anything in non-public
documentation.]

> 
> So my understanding for this is: it really a design decision for us to
> propagate all of the channel path CRWs, or we just use other ways (like
> using PNO and PNOM as this series shows).
> 
> Of course, CRW propagation is good to have. But as a discussion result
> of a former thread, that is something we can consider only after we have
> a good channel path re-modelling. That is the problem. We can try to
> trigger CRW event in some work of machine checks handling enhancement
> later.

Nod. I think we *should* make at least an effort to give the guest
CRWs, but that depends upon proper channel path modeling.

> 
> > * Kind of instead of the CRW you introduce a per device interrupt
> > for channel path events on the qemu/kvm boundary. AFAIU for a chp
> > event you do an STSCH for each (affected?) subchannel  
> Until here, yes and right.
> 
> > and generate an irq. Right? Why is this a good idea.  
> This is not right. This series does not generate an irq for the guest.
> In QEMU, when it gets the notification of a channel path status change
> event, it read the newest SCHIB from the schib region, and update the
> SCHIB (patch related parts) for the virtual subchannel. The guest will
> get the new SCHIB whenever it calls STSCH then.
> 
> I think this is a good idea, because:
> 1. This is complies the Linux implementation. Path status change could
>    be noticed by Linux.
> 2. This provides enhancement with a small work. On the contrary, channel
>    path re-modelling needs a lot of work.

Yup. And keeping the control blocks that the guest can obtain
reasonably up to date is a good approach, even if it does not cover
everything.

> 
> > * SCHIB.PMCW provides path information relevant for a given device.
> > This information is retrieved using store subchannel. Is your series
> > sufficient for making store subchannel work properly (correct and
> > reasonably up to date)?  
> Introducing a SCHIB region is the basis of further STSCH hanlding work.
> This series depends on it, and only focuses on the update of the channel
> path related parts of it. And for these parts, this work I think is
> basically correct (more review comments are surely to be welcomed).
> 
> For the rest parts, this does not change anything than what have. As
> replied to Conny in other mail of this thread: I think, if the other
> fields are handled by QEMU well, then we don't need to trigger update
> events for them. Currently I don't find things that need extra trigger.

Yes. This is an improvement over the status quo, and it should be
sufficient for now. We can always improve this further later on.

> 
> > Regarding PMCW it's supposed to get updated when io functions are
> > preformed by the css, AFAIR. Is that right?  
> I think so. And also for some other cases, for example, when we
> configure on/off a channel path.

There are different rules for the different path masks. For example,
the POM will only update if a not-operational path is actually tried
for I/O. The PIM is changed more directly if certain configuration
operations are performed.

> 
> >  If yes what are the implications? Are the manipulations you do on
> >  some PMCW fields architecturally correct?  
> If "architecturally correct" means what guest sees/senses is all obey to
> the PoP, then I think so. We don't have to emulate the internal
> behaviors (which could not be seen by OS) of CSS exactly when we
> emulate, if the emulation does not impact on what Linux guest will see,
> right?
> 
> I mean, the time point we update the PMCW does not has to be in the time
> slot of io function performance. The guest would still have to get the
> updated information through the calls of STSCH. We only need to provide
> the updaetd result to the guest by handling STSCH well. And that's why
> we say we do that lazily.
> 
> Nothing different (added value) will be seen by the guest, comparing
> with the current lazy implementation I think.
> 
> > * The one thing I would very much appreciate as an user of vfio,
> > and should in my understanding be the user story of this series
> > (and the qemu counterpart of course) is the following. If my device
> > (that is IO operation) failed because no path could be found on
> > which the device is accessible, I would like to be able to identify
> > that. Preferably the same way I would do for an LPAR guest. Is this
> > series accomplishing that?   
> With this the guest could lazily identify that. But since we have no
> machine check propagation yet, for those cases which generate CRWs, it
> might not be the same way for an LPAR guest I think.

On real hardware, I'd expect a notification in the IRB. I haven't
checked (patch series has dropped out of my cache again, sorry), but if
the host got the right notifications, we should have updated the schib,
no?

Also keep in mind that you don't get immediate updates on z/VM, either
(especially as there's actual path virtualization involved); so the OS
already has to be able to deal with that.

> 
> > * Why not just do proper STSCH for vfio-ccw?  
> I only did the interested parts (path related). For the other parts, the
> current handling is enough, no? Anyway, after we have the schib region,
> we can do further STSCH handling any time later we want then.

FWIW, I don't think we'll get too much value for the effort if we
passthrough every channel I/O instruction.

> 
> > * Shouldn't we virtualize CHPIDs?  
> Nobody would say no for this. :) The problem is that this is something
> big, and it's not a short-term goal in my current working project... I
> really want to deliver a minimal function set in the near future
> firstly. If the current working does not hurt, can we defer channel path
> re-modelling and CHPIDs virtualization?
> 
> > What if we have a clash? Lets say my dasd is only accessible via chp
> > 0.00 in the host. Currently we have a problem there, or (as the only
> > path would end up being ignored)?  
> You mean the clash that sharing path 0.00 between a physical dasd and
> the virtio ccw devices? The problem I saw is in the checking of the
> chpid.is_virtual in css_do_rchp(). For a virtual chp, we should generate
> INIT CRWs; while for a non-virtual one, we shouldn't. If the chp is
> shared with virtual and non-virtual device, I don't know what to do
> then...
> 
> I don't think we can fix this before we re-modelled the channel path.
> But this is neither introduced nor aggravated by this series, right?

Agreed.

> 
> We'd have to document this either I think.

Agreed as well. I see a doc update in the future :)

> 
> > Note: this is another unpleasant effect of not having MCSSE in the
> > guest. The original design was to have a separate css for vfio, and
> > then we would not have this kind of a problem.  (Virtualization of
> > chps would still be good for migration.)  
> Nod. BTW, I don't say that I do not want channel path virtualization in
> the long run. It's just I want a minimal function set more currently
> from what I'm focusing perspective.

Yes. I think this relatively small update gives us quite a bit of
improvement.

> 
> THANKS for these insightful questions!
> 
