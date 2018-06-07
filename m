Received: from eggs.gnu.org ([2001:4830:134:3::10]:33672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQrd4-00053P-KE
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQrd1-0000h2-HZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:54:50 -0400
Date: Thu, 7 Jun 2018 11:54:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180607115442.6a779ed9.cohuck@redhat.com>
In-Reply-To: <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 6 Jun 2018 16:15:31 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 06/06/2018 14:21, Cornelia Huck wrote:
> > On Tue, 5 Jun 2018 17:23:02 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 05/06/2018 15:14, Cornelia Huck wrote:  
> >>> On Tue, 22 May 2018 17:10:44 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>     
> >>>> On 22/05/2018 14:52, Cornelia Huck wrote:  
> >>>>> On Wed, 16 May 2018 15:32:48 +0200
> >>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>>>        
> >>>>>> On 15/05/2018 18:10, Cornelia Huck wrote:  
> >>>>>>> On Fri, 11 May 2018 11:33:35 +0200
> >>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>>>>>           
> >>>>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:  
> ...snip...
> > Not sure if I parse this correctly... but the architecture says that
> > the subchannel has the {start,halt,clear} function set as a result of
> > {start,halt,clear} subchannel, doesn't it?  
> The fc field of the SCSW indicates the functions pending or in progress
> resulting of the execution of the instructions START, CLEAR or HALT which
> have been accepted by the subchannel.
> Up to 2 functions being pending or in progress.
> The fc field is only updated when the condition code is set to 0 during 
> the execution
> of the instruction.
> 
> 1) The guest do a SSCH instruction
> 2) we intercept and QEMU issue the write with SSCH bit set
> 3) In the driver we are called in write and issue the SSCH instruction
> 4) the subchannel (the real one) set the start bit in fc field
> 
> later
> 1) The guest do a CSCH instruction
> 2) we intercept and QEMU issue the write with CSCH bit set
> 3) In the driver we are called in write and issue the CSCH instruction
> 4) the subchannel (the real one) set the clear bit in fc and clear the 
> start bit
> 
> 
> The subchannel accept to handle functions (start, halt, clear) 
> asynchronously
> otherwise it could not accept a CLEAR instruction to stop a previous START
> instruction.
> But the instructions are issued one after the other to the sub-channel.
> 
> I think we can only agree on this and that we had at some point a 
> misunderstanding.

Yes. I think much of the confusion comes from the fact that QEMU is
performing the 'async' function while it is still processing the
instruction -- IOW, it is already done with the I/O when it sets cc 0.


> >>>> - if yes, why should clear have precedence ?  
> >>> Because it does on the hardware?  
> >> What you say is right if we would have a register inside the subchannel
> >> where we write the commands.
> >> But this is not what we handle we handle separate instructions coming
> >> from an instruction stream.
> >>
> >> We do never receive two instructions at the same time, but each after
> >> the other.
> >> If the sub-channel is busy on IO a clear or a cancel must be able to
> >> stop the IO.
> >> I agree upon this.
> >> But we do not have any other command in the same call.
> >>
> >> If we would construct the interface differently, for example using an
> >> mmap() system
> >> call and let the user ORing the command bitfield before using an ioctl
> >> to inform
> >> us from the change, or if we poll on the command bitfield we should
> >> implement
> >> it like you say.
> >> But this is not what we do, and this is not what the architecture does.
> >> does it?  
> > The thing is that the guest does not interact with this interface at
> > all, it is just the backend implementation. The instructions set the
> > bits in the scsw fctl field, and we get the scsw from QEMU. By the
> > architecture, both start and halt may be set in the fctl at the same
> > time. [That this currently does not happen because QEMU is not really
> > handling things asynchronously is an implementation detail.]  
> 
> I do not understand the point of sending a halt and a start to the same
> sub-channel at the same time?
> 
> If QEMU, once asynchronous, can do this, it could just
> halt the start before asking this to the backend. Don't it?
> 
> Another point is that the start must have been accepted by the
> sub-channel for the start bit in the fc field of the SCSW to be set.

Hm, I think we need to be more precise as to what scsw we're talking
about. Bad ascii art time:

--------------
|   scsw(g)  |  ssch
--------------   |
                 |                                       guest
--------------------------------------------------------------
                 |                                        qemu
--------------   v
|   scsw(q)  | emulate
--------------   |
                 |
--------------   v
|   scsw(r)  | pwrite()
--------------   |
                 |
--------------------------------------------------------------
                 |                                        vfio
                 v
                ssch
                 |
--------------------------------------------------------------
                 |                                    hardware
--------------   v
|   scsw(h)  | actually do something
--------------

The guest issues a ssch (which gets intercepted; it won't get control
back until ssch finishes with a cc set.) scsw(g) won't change, unless
the guest does a stsch for the subchannel on another vcpu, in which
case it will get whatever information qemu holds in scsw(q) at that
point in time.

When qemu starts to emulate the guest's ssch, it will set the start
function bit in the fctl field of scsw(q). It then copies scsw(q) to
scsw(r) in the vfio region.

The vfio code will then proceed to call ssch on the real subchannel.
This is the first time we get really asynchronous, as the ssch will
return with cc set and the start function will be performed at some
point in time. If we would do a stsch on the real subchannel, we would
see that scsw(h) now has the start function bit set.

Currently, we won't return back up the chain until we get an interrupt
from the hardware, at which time we update the scsw(r) from the irb.
This will propagate into the scsw(q). At the time we finish handling
the guest's ssch and return control to it, we're all done and if the
guest does a stsch to update its scsw(g), it will get the current
scsw(q) which will already contain the scsw from the interrupt's irb
(indicating that the start function is already finished).

Now let's imagine we have a future implementation that handles actually
performing the start on the hardware asynchronously, i.e. it returns
control to the guest without the interrupt having been posted (let's
say that it is a longer-running I/O request). If the guest now did a
stsch to update scsw(g), it would get the current state of scsw(q),
which would be "start function set, but not done yet".

If the guest now does a hsch, it would trap in the same way as the ssch
before. When qemu gets control, it adds the halt bit in scsw(q) (which
is in accordance with the architecture). My proposal is to do the same
copying to scsw(r) again, which would mean we get a request with both
the halt and the start bit set. The vfio code now needs to do a hsch
(instead of a ssch). The real channel subsystem should figure this out,
as we can't reliably check whether the start function has concluded
already (there's always a race window).

For csch, things are a bit different (which the code posted here did
not take into account). The qemu emulation of csch needs to clear any
start/halt bits in scsw(q) when setting the clear bit there, and
therefore scsw(r) will only have the clear bit set in that case. We
still should do an unconditional csch for the same reasons as above;
the hardware will do the same things (clearing start/halt, setting
clear) in the scsw(h).

Congratulations, you've reached the end :) I hope that was helpful and
not too confusing.
