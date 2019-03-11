Received: from eggs.gnu.org ([209.51.188.92]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3HXA-0004AE-Si
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3HX9-0005PB-S1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:47:48 -0400
Date: Mon, 11 Mar 2019 10:47:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311104740.6b271c6a.cohuck@redhat.com>
In-Reply-To: <2f3cd598-5d95-c1b5-24f8-4de2c454be59@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-3-cohuck@redhat.com>
	<2f3cd598-5d95-c1b5-24f8-4de2c454be59@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/6] vfio-ccw: rework ssch state handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 8 Mar 2019 17:18:22 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> > The flow for processing ssch requests can be improved by splitting
> > the BUSY state:
> > 
> > - CP_PROCESSING: We reject any user space requests while we are in
> >    the process of translating a channel program and submitting it to
> >    the hardware. Use -EAGAIN to signal user space that it should
> >    retry the request.
> > - CP_PENDING: We have successfully submitted a request with ssch and
> >    are now expecting an interrupt. As we can't handle more than one
> >    channel program being processed, reject any further requests with
> >    -EBUSY. A final interrupt will move us out of this state; this also
> >    fixes a latent bug where a non-final interrupt might have freed up
> >    a channel program that still was in progress.
> >    By making this a separate state, we make it possible to issue a
> >    halt or a clear while we're still waiting for the final interrupt
> >    for the ssch (in a follow-on patch).
> > 
> > It also makes a lot of sense not to preemptively filter out writes to
> > the io_region if we're in an incorrect state: the state machine will
> > handle this correctly.
> > 
> > Reviewed-by: Eric Farman <farman@linux.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_drv.c     |  8 ++++++--
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 19 ++++++++++++++-----
> >   drivers/s390/cio/vfio_ccw_ops.c     |  2 --
> >   drivers/s390/cio/vfio_ccw_private.h |  3 ++-
> >   4 files changed, 22 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> > index a10cec0e86eb..0b3b9de45c60 100644
> > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > @@ -72,20 +72,24 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
> >   {
> >   	struct vfio_ccw_private *private;
> >   	struct irb *irb;
> > +	bool is_final;
> >   
> >   	private = container_of(work, struct vfio_ccw_private, io_work);
> >   	irb = &private->irb;
> >   
> > +	is_final = !(scsw_actl(&irb->scsw) &
> > +		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> >   	if (scsw_is_solicited(&irb->scsw)) {
> >   		cp_update_scsw(&private->cp, &irb->scsw);
> > -		cp_free(&private->cp);
> > +		if (is_final)
> > +			cp_free(&private->cp);
> >   	}
> >   	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
> >   
> >   	if (private->io_trigger)
> >   		eventfd_signal(private->io_trigger, 1);
> >   
> > -	if (private->mdev)
> > +	if (private->mdev && is_final)
> >   		private->state = VFIO_CCW_STATE_IDLE;
> >   }
> >     
> 
> Coincidentally, I did something AWESOME last night that the chunks 
> listed above actually fix.  I have a large channel program, and when it 
> runs my host crashes which isn't nice.  

Ouch.

(...)

> Recalling the above changes, I applied JUST the above pieces (not the 
> remainder of this patch), and the above channel program works fine.

Thanks for pointing that out... I'll extract a patch with only the
changes above and post it with cc:stable. A channel program submitted
by the guest being able to crash the host is... not good.
