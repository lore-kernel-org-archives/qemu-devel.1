Received: from eggs.gnu.org ([2001:4830:134:3::10]:51450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQxrb-0007tz-UV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQxrZ-0001or-8V
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:34:15 -0400
Date: Thu, 7 Jun 2018 18:34:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180607183407.1ea5ab89.cohuck@redhat.com>
In-Reply-To: <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for
 halt/clear subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>

On Thu, 7 Jun 2018 18:17:57 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 06/07/2018 11:54 AM, Cornelia Huck wrote:
> > Hm, I think we need to be more precise as to what scsw we're talking
> > about. Bad ascii art time:
> > 
> > --------------
> > |   scsw(g)  |  ssch
> > --------------   |
> >                   |                                       guest
> > --------------------------------------------------------------
> >                   |                                        qemu
> > --------------   v
> > |   scsw(q)  | emulate
> > --------------   |
> >                   |
> > --------------   v
> > |   scsw(r)  | pwrite()
> > --------------   |
> >                   |
> > --------------------------------------------------------------
> >                   |                                        vfio
> >                   v
> >                  ssch
> >                   |
> > --------------------------------------------------------------
> >                   |                                    hardware
> > --------------   v
> > |   scsw(h)  | actually do something
> > --------------
> > 
> > The guest issues a ssch (which gets intercepted; it won't get control
> > back until ssch finishes with a cc set.) scsw(g) won't change, unless
> > the guest does a stsch for the subchannel on another vcpu, in which
> > case it will get whatever information qemu holds in scsw(q) at that
> > point in time.  
> 
> (1) I think BQL make other cpu or not other kind of the same. We will
> effectively start processing the stsch in QEMU after we are done
> with the ssch in QEMU.

Yeah, but my main point was that the change is in scsw(q) only.

> 
> > 
> > When qemu starts to emulate the guest's ssch, it will set the start
> > function bit in the fctl field of scsw(q). It then copies scsw(q) to
> > scsw(r) in the vfio region.
> >   
> 
> (2) This is architecturally wrong AFAIK. The fctl bit is supposed to be set on
> cc 0. But because of (1) this might not be a observable by the guest --
> we can fix it up.

The bit is set some time during the processing of the instruction - we
need finite time to do the processing, but it should not be observable
by the guest. We should not set the bit if we won't set cc 0.

> 
> (3)IMHO scsw(r) is not a real scsw as defined by the architecture but
> a strange communication structure (not) defined vfio-ccw.

IIRC it was intended as a real scsw; we just did not want to define the
whole structure as both Linux and QEMU have scsw definitions that map
to the same hardware structure but look different.

> 
> > The vfio code will then proceed to call ssch on the real subchannel.
> > This is the first time we get really asynchronous, as the ssch will
> > return with cc set and the start function will be performed at some
> > point in time. If we would do a stsch on the real subchannel, we would
> > see that scsw(h) now has the start function bit set.
> >   
> 
> (4) I guess only if cc 0.

Yes, obviously.

> 
> > Currently, we won't return back up the chain until we get an interrupt
> > from the hardware, at which time we update the scsw(r) from the irb.
> > This will propagate into the scsw(q). At the time we finish handling
> > the guest's ssch and return control to it, we're all done and if the
> > guest does a stsch to update its scsw(g), it will get the current
> > scsw(q) which will already contain the scsw from the interrupt's irb
> > (indicating that the start function is already finished).
> > 
> > Now let's imagine we have a future implementation that handles actually
> > performing the start on the hardware asynchronously, i.e. it returns
> > control to the guest without the interrupt having been posted (let's
> > say that it is a longer-running I/O request). If the guest now did a
> > stsch to update scsw(g), it would get the current state of scsw(q),
> > which would be "start function set, but not done yet".  
> 
> (5) AFAIK this is how the current implementation works. We don't wait
> for the I/O interrupt on the host to present a cc to the guest for it's
> ssch.

But the vfio code does wait, no? We just signal the interrupt via
eventfd as well.

> 
> > 
> > If the guest now does a hsch, it would trap in the same way as the ssch
> > before. When qemu gets control, it adds the halt bit in scsw(q) (which
> > is in accordance with the architecture).  
> 
> (7) Again it's when is fctl set according to the architecture...

Same comment as above. If we do a hsch for a subchannel with the start
function set, we'll set cc 0.

> 
> > My proposal is to do the same
> > copying to scsw(r) again, which would mean we get a request with both
> > the halt and the start bit set.  
> 
> (8) IMHO when receiving the 'request' we are and should be in instruction
> context -- opposed to basic io function context. So we should not set fctl
> before we know what will our guest cc be. But since scsw(r) is not a real
> scsw it is just strange.

I think what we are doing is really 'performing the start function' -
it's just not asynchronous in the current implementation. So we already
know that ssch will return with cc 0.

> 
> > The vfio code now needs to do a hsch
> > (instead of a ssch). The real channel subsystem should figure this out,
> > as we can't reliably check whether the start function has concluded
> > already (there's always a race window).
> >   
> 
> (9) Yes we can't tell for sure if the start function is still being performed
> by the stuff below.

We'll need to figure out a way to outsource most of those decisions to
the real hardware. If we're not sure whether we can set cc 0, we should
probably just set cc 2 and be done with it. (Serialization with regard
to interrupts needed, of course.)

> 
> Regards,
> Halil

Thanks for reading!

> 
> > For csch, things are a bit different (which the code posted here did
> > not take into account). The qemu emulation of csch needs to clear any
> > start/halt bits in scsw(q) when setting the clear bit there, and
> > therefore scsw(r) will only have the clear bit set in that case. We
> > still should do an unconditional csch for the same reasons as above;
> > the hardware will do the same things (clearing start/halt, setting
> > clear) in the scsw(h).
> > 
> > Congratulations, you've reached the end:)  I hope that was helpful and
> > not too confusing.
> >   
> 
