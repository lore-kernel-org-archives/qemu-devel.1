Received: from eggs.gnu.org ([2001:4830:134:3::10]:51556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1egMqO-00030w-FD
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1egMqK-000839-GK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:44:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1egMqK-00082Q-6D
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:44:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0U3i50x120192
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 22:44:18 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftfy7a297-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 22:44:18 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 20:44:17 -0700
Date: Tue, 30 Jan 2018 11:44:11 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
	<20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
	<a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
	<20180123062356.GC32354@bjsdjshi@linux.vnet.ibm.com>
	<879459e4-e6b1-2030-e3d4-0b991b532f51@linux.vnet.ibm.com>
	<87d11sggoo.fsf@bjsdjshi.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d11sggoo.fsf@bjsdjshi.ibm.com>
Message-Id: <20180130034411.GA5506@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2018-01-30 11:37:43 +0800]:

Damn.. Please just ignore the above mail. It's not the right draft.

> Halil Pasic <pasic@linux.vnet.ibm.com> writes:
> 
> Hi Halil,
> 
> As you may noticed, Conny replied to this thread on my mail. Some of her
> comments there could answer your questions. If that applies, I will just
> say "See Conny's mail" in the following, and you can reply to that mail,
> so we can consolidate further discussion.
> 
> >>> * When a channel path malfunctions a CRW is generated and a machine
> >>> check channel report pending is generated. Same goes for
> >>> channel paths popping up (on HW level). Should not these get
> >>> propagated?
> >> AFAIR, channel path related CRW is not that reliable. I mean it seems
> >> that it's not mandatory to generate CRWs for channel path malfunctions.
> >> AFAIU, it depneds on machine models. For example, we won't get
> >> CRW_ERC_INIT for a "path has come" event on many models I believe. And
> >> that's why nobody noticed the misuse of CRW_ERC_IPARM and CRW_ERC_INIT
> >> in the CRW handling logic for channel path CRWs.
> >> Ref:
> >> 2daace78a8c9 s390: chp: handle CRW_ERC_INIT for channel-path status change
> >> 
> >
> > Honestly, I forgot about this discussion. I've refreshed my memories by
> > now, but I could not find why is it supposed to be architecturally OK
> > to loose CRWs when for instance a chp goes away.
> >
> >> So my understanding for this is: it really a design decision for us to
> >> propagate all of the channel path CRWs, or we just use other ways (like
> >> using PNO and PNOM as this series shows).
> >
> > From what I read, CRWs did not seem optional.
> > I wonder what should I read in order to change my mind. I'm not
> > talking about the hardware in the wild -- but that could be buggy
> > hardware.
> >
> Ah, can you point out the chapter that says CRWs is mandatory?
> 
> AFAIU, PoP doesn't say, for example, chp gone will lead to a CRW, but it
> only says when we got a chp gone CRW it means a chp has been gone.
> 
> [See Conny's mail pls, and we can discuss there.]
> 
> >> 
> >> Of course, CRW propagation is good to have. But as a discussion result
> >> of a former thread, that is something we can consider only after we have
> >> a good channel path re-modelling. That is the problem. We can try to
> >> trigger CRW event in some work of machine checks handling enhancement
> >> later.
> >> 
> >>> * Kind of instead of the CRW you introduce a per device interrupt
> >>> for channel path events on the qemu/kvm boundary. AFAIU for a chp
> >>> event you do an STSCH for each (affected?) subchannel
> >> Until here, yes and right.
> >> 
> >>> and generate an irq. Right? Why is this a good idea.
> >> This is not right. This series does not generate an irq for the guest.
> >
> > You misunderstood this. The word 'irq' this sentence is a short version
> > of 'per device interrupt for channel path events on the qemu/kvm boundary'
> > form the previous sentence. It's not an irq injected into the guest but
> > a notification (which you call irq in '[RFC PATCH 2/3] vfio: ccw:
> > introduce channel path irq') for QEMU.
> >
> I see now. I misunderstood.
> 
> >> In QEMU, when it gets the notification of a channel path status change
> >> event, it read the newest SCHIB from the schib region, and update the
> >> SCHIB (patch related parts) for the virtual subchannel. The guest will
> >> get the new SCHIB whenever it calls STSCH then.
> >
> > We are in agreement. I just wanted to say, if let's say 42 vfio-ccw devices
> > are using the same chp and it goes away, you will generate 42 notifications.
> Yes, and this is the only way we can do for now, since there is no good
> chp model, we can't use CRWs to consolidate the notifications... Once we
> had the model and we can use CRW to indicate chp event, this could be
> easily removed and changed to that.
> 
> Once I had a version which leverages chp CRWs. But since we had
> agreement that CRW related code change will not be acceptable in the
> QEMU side before we have chp re-modelling doen, I changed to this PNO
> and PNOM implementation.
> 
> >
> >> 
> >> I think this is a good idea, because:
> >> 1. This is complies the Linux implementation. Path status change could
> >>    be noticed by Linux.
> >> 2. This provides enhancement with a small work. On the contrary, channel
> >>    path re-modelling needs a lot of work.
> >
> > I thing your answer is based on the misunderstanding explained above.
> I see now.
> 
> >
> > My idea was to be lazy in a different way. Instead of being lazy about
> > reading the subsection, I was wondering why not do an STSCH in the host
> > as a response to one being done in the guest.
> Hey, my way is only an upgrade version of your way, and is a bit more
> lazy than yours. ;)
> 
> >
> > That means: if there is no activity on the passed trough devices, nothing
> > needs to be done. (Except maybe the CRWs).
> >
> > The things aren't observable by the guest if it does not do STSCH anyway.
> Nod. This is the idea that this series is based on.
> 
> >
> >
> >> 
> >>> * SCHIB.PMCW provides path information relevant for a given device.
> >>> This information is retrieved using store subchannel. Is your series
> >>> sufficient for making store subchannel work properly (correct and
> >>> reasonably up to date)?
> >> Introducing a SCHIB region is the basis of further STSCH hanlding work.
> >> This series depends on it, and only focuses on the update of the channel
> >> path related parts of it. And for these parts, this work I think is
> >> basically correct (more review comments are surely to be welcomed).
> >> 
> >
> > Please elaborate on that basically. Or are those actually just correct
> > in your opinion?!
> >
> >> For the rest parts, this does not change anything than what have. As
> >> replied to Conny in other mail of this thread: I think, if the other
> >> fields are handled by QEMU well, then we don't need to trigger update
> >> events for them. Currently I don't find things that need extra trigger.
> >> 
> >
> > Fair.
> >
> >>> Regarding PMCW it's supposed to get updated when io functions are
> >>> preformed by the css, AFAIR. Is that right?
> >> I think so. And also for some other cases, for example, when we
> >> configure on/off a channel path.
> >> 
> >
> > Sorry, I ended up confusing opm with pom. That would have been illegal
> > (as Connie has pointed out recently) because it can only  change
> > only if the path is tried for IO.
> >
> >
> >>>  If yes what are the implications? Are the manipulations you do on
> >>>  some PMCW fields architecturally correct?
> >> If "architecturally correct" means what guest sees/senses is all obey to
> >> the PoP, then I think so. We don't have to emulate the internal
> >> behaviors (which could not be seen by OS) of CSS exactly when we
> >> emulate, if the emulation does not impact on what Linux guest will see,
> >> right?
> >> 
> >> I mean, the time point we update the PMCW does not has to be in the time
> >> slot of io function performance. The guest would still have to get the
> >> updated information through the calls of STSCH. We only need to provide
> >> the updaetd result to the guest by handling STSCH well. And that's why
> >> we say we do that lazily.
> >> 
> >> Nothing different (added value) will be seen by the guest, comparing
> >> with the current lazy implementation I think.> 
> >>> * The one thing I would very much appreciate as an user of vfio,
> >>> and should in my understanding be the user story of this series
> >>> (and the qemu counterpart of course) is the following. If my device
> >>> (that is IO operation) failed because no path could be found on
> >>> which the device is accessible, I would like to be able to identify
> >>> that. Preferably the same way I would do for an LPAR guest. Is this
> >>> series accomplishing that? 
> >> With this the guest could lazily identify that. But since we have no
> >> machine check propagation yet, for those cases which generate CRWs, it
> >> might not be the same way for an LPAR guest I think.
> >> 
> >
> > This was a yes/no question. I can't interpret your answer neither as
> > yes or as no. Maybe a little clarification: I'm talking about a
> > recent linux guest. 
> >
> >>> * Why not just do proper STSCH for vfio-ccw?
> >> I only did the interested parts (path related). For the other parts, the
> >> current handling is enough, no? Anyway, after we have the schib region,
> >> we can do further STSCH handling any time later we want then.
> >> 
> >
> > I mean, your approach works on the premise, that the host will notify
> > QEMU each time the content of the SCHIB (area) changes (modulo stuff) so
> > it can do an update in QEMU, and give the guest an up to date virtualized
> > SCHIB when it asks for it executing the STSCH instruction.
> >
> > I was asking myself. Why not instead while interpreting STSCH do a
> > STSCH on the host device (that is passed through), and virtualize the
> > result as necessary.
> >
> > It occurred to me if nothing simpler. 
> >
> >>> * Shouldn't we virtualize CHPIDs?
> >> Nobody would say no for this. :) The problem is that this is something
> >> big, and it's not a short-term goal in my current working project... I
> >> really want to deliver a minimal function set in the near future
> >> firstly. If the current working does not hurt, can we defer channel path
> >> re-modelling and CHPIDs virtualization?
> >
> > The problem is, I'm not sure it does not hurt. For instance because of
> > the question below. I would also prefer having a fair idea of what
> > we need for the envisioned (complete) solution before introducing
> > kernel interfaces (to avoid: pity in the end we need something
> > different, and resulting cluttered interface).
> >
> >> 
> >>> What if we have a clash? Lets say my dasd is only accessible via chp
> >>> 0.00 in the host. Currently we have a problem there, or (as the only
> >>> path would end up being ignored)?
> >> You mean the clash that sharing path 0.00 between a physical dasd and
> >> the virtio ccw devices? The problem I saw is in the checking of the
> >> chpid.is_virtual in css_do_rchp(). For a virtual chp, we should generate
> >> INIT CRWs; while for a non-virtual one, we shouldn't. If the chp is
> >> shared with virtual and non-virtual device, I don't know what to do
> >> then...
> >> 
> >> I don't think we can fix this before we re-modelled the channel path.
> >> But this is neither introduced nor aggravated by this series, right?
> >
> > I'm not sure about the later. What prevents the guest from believing
> > the (to use your terminology shared) chp 0.00 has become unavailable
> > if 0.00 becomes unavailable in the host?
> >
> > Would that adversely affect the virtual devices? It would at
> > least look strange.
> >
> >> 
> >> We'd have to document this either I think.
> >> 
> >>> Note: this is another unpleasant effect of not having MCSSE in the
> >>> guest. The original design was to have a separate css for vfio, and
> >>> then we would not have this kind of a problem.  (Virtualization of
> >>> chps would still be good for migration.)
> >> Nod. BTW, I don't say that I do not want channel path virtualization in
> >> the long run. It's just I want a minimal function set more currently
> >> from what I'm focusing perspective.
> >> 
> >> THANKS for these insightful questions!
> >> 
> 
> -- 
> Dong Jia Shi
> 
> 

-- 
Dong Jia Shi
