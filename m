Received: from eggs.gnu.org ([209.51.188.92]:59612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqzaG-0005Gp-RZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqzYy-0007kb-Qs
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:10:53 -0500
Date: Tue, 5 Feb 2019 13:10:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205131047.32f7c7a1.cohuck@redhat.com>
In-Reply-To: <55d9fc3d-12ec-9ad7-cdaa-72c5dbb65aca@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-3-cohuck@redhat.com>
	<55d9fc3d-12ec-9ad7-cdaa-72c5dbb65aca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vfio-ccw: rework ssch state handling
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

On Mon, 4 Feb 2019 16:29:40 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/30/2019 08:22 AM, Cornelia Huck wrote:
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
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_drv.c     |  8 ++++++--
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 19 ++++++++++++++-----
> >   drivers/s390/cio/vfio_ccw_ops.c     |  2 --
> >   drivers/s390/cio/vfio_ccw_private.h |  3 ++-
> >   4 files changed, 22 insertions(+), 10 deletions(-)

> > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > index e7c9877c9f1e..b4a141fbd1a8 100644
> > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> > @@ -28,7 +28,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   	sch = private->sch;
> >   
> >   	spin_lock_irqsave(sch->lock, flags);
> > -	private->state = VFIO_CCW_STATE_BUSY;
> >   
> >   	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
> >   	if (!orb) {
> > @@ -46,6 +45,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   		 */
> >   		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
> >   		ret = 0;
> > +		private->state = VFIO_CCW_STATE_CP_PENDING;  
> 
> [1]
> 
> >   		break;
> >   	case 1:		/* Status pending */
> >   	case 2:		/* Busy */
> > @@ -107,6 +107,12 @@ static void fsm_io_busy(struct vfio_ccw_private *private,
> >   	private->io_region->ret_code = -EBUSY;
> >   }
> >   
> > +static void fsm_io_retry(struct vfio_ccw_private *private,
> > +			 enum vfio_ccw_event event)
> > +{
> > +	private->io_region->ret_code = -EAGAIN;
> > +}
> > +
> >   static void fsm_disabled_irq(struct vfio_ccw_private *private,
> >   			     enum vfio_ccw_event event)
> >   {
> > @@ -135,8 +141,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   	struct mdev_device *mdev = private->mdev;
> >   	char *errstr = "request";
> >   
> > -	private->state = VFIO_CCW_STATE_BUSY;
> > -
> > +	private->state = VFIO_CCW_STATE_CP_PROCESSING;  
> 
> [1]
> 
> >   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >   
> >   	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> > @@ -181,7 +186,6 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   	}
> >   
> >   err_out:
> > -	private->state = VFIO_CCW_STATE_IDLE;  
> 
> [1] Revisiting these locations as from an earlier discussion [2]... 
> These go IDLE->CP_PROCESSING->CP_PENDING if we get a cc=0 on the SSCH, 
> but we stop in CP_PROCESSING if the SSCH gets a nonzero cc.  Shouldn't 
> we cleanup and go back to IDLE in this scenario, rather than forcing 
> userspace to escalate to CSCH/HSCH after some number of retries (via FSM)?
> 
> [2] https://patchwork.kernel.org/patch/10773611/#22447997

It does do that (in vfio_ccw_mdev_write), it was not needed here. Or do
you think doing it here would be more obvious?

> 
> Besides that, I think this looks good to me.

Thanks!
