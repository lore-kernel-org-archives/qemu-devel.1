Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVD0z-0000Nn-1b
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVD0s-0003ad-A0
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:05:44 -0500
Date: Fri, 7 Dec 2018 11:05:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181207110529.3b293124.cohuck@redhat.com>
In-Reply-To: <20181206194714.31e9f43a@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<20181206194714.31e9f43a@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 6 Dec 2018 19:47:14 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 5 Dec 2018 13:54:02 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 4 Dec 2018 16:02:36 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Tue, 4 Dec 2018 14:11:30 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >   
> > > > On Tue, 4 Dec 2018 13:38:10 +0100
> > > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >     
> > > > > On Thu, 22 Nov 2018 17:54:29 +0100
> > > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > > >     
> > > > > > [This is the Linux kernel part, git tree is available at
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git
> > > > > > vfio-ccw-caps
> > > > > > 
> > > > > > The companion QEMU patches are available at
> > > > > > https://github.com/cohuck/qemu vfio-ccw-caps]
> > > > > > 
> > > > > > Currently, vfio-ccw only relays START SUBCHANNEL requests to
> > > > > > the real device. This tends to work well for the most common
> > > > > > 'good path' scenarios; however, as we emulate {HALT,CLEAR}
> > > > > > SUBCHANNEL in QEMU, things like clearing pending requests at
> > > > > > the device is currently not supported. This may be a problem
> > > > > > for e.g. error recovery.      
> > > > > 
> > > > > I'm wondering: what about MODIFY SUBCHANNEL? Do we plan to add
> > > > > MSCH as well or is it supposed to remain 'userspace emulated'?
> > > > > AFAIR MSCH may have an effect on error recovery as well.    
> > > > 
> > > > I think that would require a deeper change, as we have the
> > > > requirement to enable the subchannel before handing it to
> > > > userspace. IOW, the guest does not cause the subchannel to be
> > > > enabled/disabled, but the host does.   
> > > 
> > > My point is, when the subchannel is disabled, 'firmware' is
> > > responsible for suppressing interrupts and error conditions, and
> > > also for doing the appropriate recovery procedure, so to say under
> > > the hood.  
> > 
> > I don't think there's actually much of a 'recovery' possible at a
> > subchannel level (other than 'have you tried turning it off and on
> > again?'); the interesting stuff is all at the device-specific level.
> >   
> 
> To clarify my concern let me quote from the PoP
> (SA22-7832-10 page 14-9):
> 
> """
> If a device presents unsolicited status while the
> associated subchannel is disabled, that status is
> discarded by the channel subsystem without
> generating an I/O-interruption condition. How-
> ever, if the status presented contains unit check,
> the channel subsystem issues the clear signal for
> the associated subchannel and does not gener-
> ate an I/O-interruption condition. This should be
> taken into account when the program uses MOD-
> IFY SUBCHANNEL to enable a subchannel. For
> example, the medium on the associated device
> that was present when the subchannel became
> disabled may have been replaced, and, there-
> fore, the program should verify the integrity of
> that medium.
> """

Hm, so is your concern that we might have a status (unit check) if we
have an enabled subchannel that might not be present if the subchannel
had been disabled all the time? Is that a problem in practice?

> > > 
> > > I think Jason has discovered some problems related to this while
> > > doing his DASD IPL with vfio-ccw work, but I don't quite remember
> > > any more.  
> > 
> > cc:ing Jason, in case he remembers :)

Like in that case. Couldn't a unit check status also arrive just when
the subchannel has been enabled, and the code therefore has to deal
with it anyway?

> >   
> > > IMHO it may be possible to emulate enable/disable, but it seems way
> > > more error prone and complicated, than letting the guest
> > > enable/disable the host subchannel.
> > > 
> > > I have no idea what was the reason for going with the initial design.
> > > I would appreciate any hints or explanations, but I'm well aware
> > > that it was a long time ago.  
> > 
> > I don't really remember either, and any non-public mails from that time
> > are inaccessible to me :(
> > 
> > It *might* be an artifact of the original design (which operated at the
> > ccw_device rather than the subchannel level), though.
> >   
> 
> Interesting.
> 
> > > > Parameters (like for channel measurements) are a different game.
> > > > It is something we should look into, but it will need a different
> > > > region.    
> > > 
> > > Yes emulation only channel measurements seem even less likely than
> > > proper enable/disable. And 'that would need a different' region
> > > helps me understanding the scope of async_cmd_region. Maybe we
> > > should reconsider the comment '+ * @cmd_region: MMIO region for
> > > asynchronous I/O commands other than START'.  
> > 
> > What do you think is wrong with that comment?
> >   
> 
> Well msch is also an async I/O command other than START. If msch does not
> belong here but needs it's own region, then this description seems too
> generic.

Why do you consider msch to be async? ssch, hsch, csch all have the
potential to cause the execution of an asynchronous (start/halt/clear)
function, while msch just (possibly) modifies the subchannel and is
done.

> 
> > > > > BTW I would like to have the concurrency discussion sorted out
> > > > > before I proceed with my review, because reviewing the stuff
> > > > > without a fair idea of what exactly are we trying to achieve
> > > > > would yield poor results.    
> > > > 
> > > > I'm not sure what is unclear about what we're trying to achieve
> > > > (enable the guest to issue halt/clear on real hardware)?    
> > > 
> > > Yeah, that is perfectly clear, but it ain't the complete story. E.g.
> > > are subsequent commands blocking until the preceding command finishes
> > > is part of the interface. And what is good implementation depends on
> > > the answer. What I mean, I first need to understand how things are
> > > supposed to work (together) so I can double check that against the
> > > implementation. Otherwise all I can do is nitpicking.
> > > 
> > > To get more tangible: we are in the middle of processing an SSCH
> > > request (e.g. doing the translation) when a HSCH comes in. What
> > > should happen? Should we start processing HSCH after he instruction
> > > part of SSCH is done -- which currently includes translation? Or
> > > should we -EBUSY? Or do we abort START related activities and do the
> > > HALT stuff?  
> > 
> > I think most of the sorting-out-the-operations stuff should be done by
> > the hardware itself, and we should not really try to enforce anything
> > special in our vfio code.
> >   
> 
> Sounds very reasonable to me. Does this mean you are against Pierre's
> '[PATCH v3 6/6] vfio: ccw: serialize the write system calls' as it does
> not let HW sort out stuff, but enforces sequencing?

I have not yet had time to look at that, sorry.

> 
> 
> > For your example, it might be best if a hsch is always accepted and
> > send on towards the hardware.  
> 
> Nod.
> 
> > Probably best to reflect back -EAGAIN if
> > we're currently processing another instruction from another vcpu, so
> > that the user space caller can retry.  
> 
> Hm, not sure how this works together with your previous sentence.

The software layering. We have the kernel layer
(drivers/s390/cio/vfio_ccw_*) that interacts with the hardware more or
less directly, and the QEMU layer, which does some writes on regions.
In the end, the goal is to act on behalf of the guest issuing a
ssch/hsch/csch, which is from the guest's view a single instruction. We
should not have the individual "instructions" compete with each other
so that they run essentially in parallel (kernel layer), but we should
also not try to impose an artificial ordering as to when instructions
executed by different vcpus are executed (QEMU layer). Therefore, don't
try to run an instruction in the kernel when another one is in progress
for the same subchannel (exclusivity in the kernel), but retry in QEMU
if needed (no ordering between vcpus imposed).

In short, don't create strange concurrency issues in the "instruction"
handling, but make it possible to execute instructions in a
non-predictable order if the guest does not care about enforcing
ordering on its side.

> 
> > Same for ssch, if another ssch is
> > already being processed. We *could* reflect cc 2 if the fctl bit is
> > already set, but that won't do for csch, so it is probably best to have
> > the hardware figure that out in any case.
> >   
> 
> We just need to be careful about avoiding races if we let hw sort out
> things. If an ssch is issued with the start function pending the correct
> response is cc 2. 

But sending it on to the hardware will give us that cc 2, no?

> 
> > If I read the code correctly, we currently reflect -EBUSY and not
> > -EAGAIN if we get a ssch request while already processing another one.
> > QEMU hands that back to the guest as a cc 2, which is not 100% correct.
> > In practice, we don't see this with Linux guests due to locking.
> >   
> 
> Nod, does not happen because of BQL. We currently do the user-space
> counterpart of vfio_ccw_mdev_write() in BQL context or (i.e. we hold
> BQL until translation is done and our host ssch() comes back)?

The Linux kernel uses the subchannel lock to enforce exclusivity for
subchannel instructions, so we won't see Linux guests issue
instructions on different vcpus in parallel, that's what I meant.

> 
> I think -EBUSY is the correct response for ssch while start pending set.
> I think we set start pending in QEMU before we issue 'start command/io
> request' to the kernel. I don't think -EAGAIN is a good idea. AFAIU we
> would expect user-space to loop on -EAGAIN e.g. at least until the
> processing of a 'start command' is done and the (fist) ssch by the host
> is issued. And then what?  Translate the second channel program issue
> the second ssch in the host and probably get a non-zero cc? Or return
> -EBUSY? Or keep returning -EAGAIN?

My idea was:
- return -EAGAIN if we're already processing a channel instruction
- continue returning -EBUSY etc. if the instruction gets the respective
  return code from the hardware

So, the second ssch would first get a -EAGAIN and then a -EBUSY if the
first ssch is done, but the subchannel is still doing the start
function. Just as you would expect when you do a ssch while your last
request has not finished yet.

> 
> > > > But yes, we need to sort out that concurrency thing; I'm currently
> > > > unsure if the core should do some things as well or if it's more of
> > > > a vendor-driver thing.
> > > >     
> > > 
> > > By core you mean vfio-mdev core? If yes, I think it is a
> > > vendor-driver thing: limiting concurrency for all vfio-mdev  does
> > > not make sense IMHO.  
> > 
> > Also generic vfio. But I'm still unclear which guarantees we have. I
> > suspect none; I'm wondering whether other vfio devices might have
> > issues as well.
> >   
> 
> My intuition says this is something left to the devices.

Probably, yes.
