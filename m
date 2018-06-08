Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fRGNb-00054k-Ds
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fRGNX-0006rb-Jp
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:20:30 -0400
Date: Fri, 8 Jun 2018 14:20:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180608142022.7dd6a658.cohuck@redhat.com>
In-Reply-To: <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
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
	<86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
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

On Thu, 7 Jun 2018 18:37:16 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 07/06/2018 11:54, Cornelia Huck wrote:

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
> >
> > When qemu starts to emulate the guest's ssch, it will set the start
> > function bit in the fctl field of scsw(q). It then copies scsw(q) to
> > scsw(r) in the vfio region.
> >
> > The vfio code will then proceed to call ssch on the real subchannel.
> > This is the first time we get really asynchronous, as the ssch will
> > return with cc set and the start function will be performed at some
> > point in time. If we would do a stsch on the real subchannel, we would
> > see that scsw(h) now has the start function bit set.
> >
> > Currently, we won't return back up the chain until we get an interrupt
> > from the hardware, at which time we update the scsw(r) from the irb.  
> 
> I do not find where the thread waits for interrupt inside the
> write->fsm_io_request->fsm_io_helper->ssch chain.
> 
> I must have miss it ten times. Can you point it to me?

I'm not surprised you did not find it, because it isn't there :)

I've let myself be confused by the /* Start channel program and wait
for I/O interrupt. */ comment -- it is wrong and should be removed (but
we did have that waiting initially). So we already have the async
situation :)

> 
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
> >
> > If the guest now does a hsch, it would trap in the same way as the ssch
> > before. When qemu gets control, it adds the halt bit in scsw(q) (which
> > is in accordance with the architecture).  
> 
> This I agree.
> The scsw(q) is part of the QEMU device.
> 
> >   My proposal is to do the same
> > copying to scsw(r) again, which would mean we get a request with both
> > the halt and the start bit set. The vfio code now needs to do a hsch
> > (instead of a ssch). The real channel subsystem should figure this out,
> > as we can't reliably check whether the start function has concluded
> > already (there's always a race window).  
> 
> This I do not agree scsw(r) is part of the driver.
> The interface here is not a device interface anymore but a driver 
> interface.
> SCSW is a status, it is at its place in QEMU device interface with the 
> guest
> but here pwrite() sends a command.

Hm, I rather consider that "we write a status, and the backend figures
out what to do based on that status".

> 
> 
> Since we do not do a STSCH on each command, scsw(q), should be
> updated by QEMU depending on syscall return value.
> This is not done currently, only the success path is right
> because it is set before the call.
> 
> If I read right and the IRQ is asynchronous, the scsw(q) is not right,
> because not updated, after the interrupt is received from the guest.

Yes, we're probably missing some updates.
