Received: from eggs.gnu.org ([2001:4830:134:3::10]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIcWn-0006NA-4L
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIcWg-0004Xu-HK
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:10:17 -0400
Date: Tue, 15 May 2018 18:10:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180515181006.0cb1dfc2.cohuck@redhat.com>
In-Reply-To: <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
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

On Fri, 11 May 2018 11:33:35 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 09/05/2018 17:48, Cornelia Huck wrote:
> > Currently, vfio-ccw only relays start subchannel requests to the real
> > hardware, which is enough in many cases but falls short e.g. during
> > error recovery.
> >
> > Fortunately, it is easy to add support for halt and clear subchannel
> > requests to the existing infrastructure. User space can detect
> > support for halt/clear subchannel easily, as we always returned
> > -EOPNOTSUPP before and therefore we do not need any capability to
> > make this support discoverable.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
> >   drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++++++-----
> >   2 files changed, 92 insertions(+), 12 deletions(-)

> > @@ -65,6 +67,70 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   	return ret;
> >   }
> >   
> > +static int fsm_halt_helper(struct vfio_ccw_private *private)
> > +{
> > +	struct subchannel *sch;
> > +	int ccode;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	sch = private->sch;
> > +
> > +	spin_lock_irqsave(sch->lock, flags);
> > +	private->state = VFIO_CCW_STATE_BUSY;
> > +
> > +	/* Issue "Halt Subchannel" */
> > +	ccode = hsch(sch->schid);
> > +
> > +	switch (ccode) {
> > +	case 0:
> > +		/*
> > +		 * Initialize device status information
> > +		 */
> > +		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
> > +		ret = 0;
> > +		break;
> > +	case 1:		/* Status pending */  
> 
> shouldn't we make a difference between status pending
> and having halt in progress?
> 
> The guest can examine the SCSW, but couldn't it introduce
> a race condition?

Yes, good point. Especially as the guest might want to do different
things.

Regarding race conditions: The scsw can already be outdated after the
operation that stored it finished, which is true even on LPAR. That's
especially true for tsch which clears some status at the subchannel.
The guest must already be able to deal with this, the race window is
just larger.

> 
> 
> > +	case 2:		/* Busy */
> > +		ret = -EBUSY;
> > +		break;
> > +	default:	/* Device not operational */
> > +		ret = -ENODEV;
> > +	}
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;
> > +}
> > +
> > +static int fsm_clear_helper(struct vfio_ccw_private *private)
> > +{
> > +	struct subchannel *sch;
> > +	int ccode;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	sch = private->sch;
> > +
> > +	spin_lock_irqsave(sch->lock, flags);
> > +	private->state = VFIO_CCW_STATE_BUSY;
> > +
> > +	/* Issue "Clear Subchannel" */
> > +	ccode = csch(sch->schid);
> > +
> > +	switch (ccode) {
> > +	case 0:
> > +		/*
> > +		 * Initialize device status information
> > +		 */
> > +		sch->schib.scsw.cmd.actl |= SCSW_ACTL_CLEAR_PEND;
> > +		ret = 0;
> > +		break;
> > +	default:	/* Device not operational */
> > +		ret = -ENODEV;
> > +	}
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;
> > +}
> > +
> >   static void fsm_notoper(struct vfio_ccw_private *private,
> >   			enum vfio_ccw_event event)
> >   {
> > @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   
> >   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >   
> > -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> > +	/*
> > +	 * Start processing with the clear function, then halt, then start.
> > +	 * We may still be start pending when the caller wants to clean
> > +	 * up things via halt/clear.
> > +	 */  
> 
> hum. The scsw here does not reflect the hardware state but the
> command passed from the user interface.
> Can we and should we authorize multiple commands in one call?
> 
> If not, the comment is not appropriate and a switch on cmd.fctl
> would be a clearer.

There may be multiple functions specified, but we need to process them
in precedence order (and clear wins over the others, so to speak).
Would adding a sentence like "we always process just one function" help?

> 
> > +	if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> > +		/* issue clear and wait for interupt */
> > +		io_region->ret_code = fsm_clear_helper(private);
> > +		if (io_region->ret_code)
> > +			goto err_out;
> > +		return;
> > +	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> > +		/* issue halt and wait for interrupt */
> > +		io_region->ret_code = fsm_halt_helper(private);
> > +		if (io_region->ret_code)
> > +			goto err_out;
> > +		return;
> > +	} else if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >   		orb = (union orb *)io_region->orb_area;
> >   
> >   		/* Don't try to build a cp if transport mode is specified. */
> > @@ -152,16 +235,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   			goto err_out;
> >   		}
> >   		return;
> > -	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> > -		/* XXX: Handle halt. */
> > -		io_region->ret_code = -EOPNOTSUPP;
> > -		goto err_out;
> > -	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> > -		/* XXX: Handle clear. */
> > -		io_region->ret_code = -EOPNOTSUPP;
> > -		goto err_out;
> >   	}
> > -
> >   err_out:
> >   	private->state = VFIO_CCW_STATE_IDLE;
> >   }  
> 
> 
