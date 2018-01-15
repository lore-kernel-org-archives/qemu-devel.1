Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb1w8-0008Ce-47
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb1w4-0004y5-3m
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:24:16 -0500
Date: Mon, 15 Jan 2018 11:24:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180115112406.2c70baba.cohuck@redhat.com>
In-Reply-To: <20180115064309.GA12499@bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<20180111030421.31418-2-bjsdjshi@linux.vnet.ibm.com>
	<20180111151659.2d997abf.cohuck@redhat.com>
	<20180115064309.GA12499@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vfio: ccw: introduce schib region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Mon, 15 Jan 2018 14:43:09 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-01-11 15:16:59 +0100]:
> 
> Hi Conny,
> 
> > On Thu, 11 Jan 2018 04:04:19 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> > > This introduces a new region for vfio-ccw to provide subchannel
> > > information for user space.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  drivers/s390/cio/vfio_ccw_fsm.c     | 21 ++++++++++
> > >  drivers/s390/cio/vfio_ccw_ops.c     | 79 +++++++++++++++++++++++++++----------
> > >  drivers/s390/cio/vfio_ccw_private.h |  3 ++
> > >  include/uapi/linux/vfio.h           |  1 +
> > >  include/uapi/linux/vfio_ccw.h       |  6 +++
> > >  5 files changed, 90 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > > index c30420c517b1..be081ccabea3 100644
> > > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > > +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> > > @@ -172,6 +172,22 @@ static void fsm_irq(struct vfio_ccw_private *private,
> > >  		complete(private->completion);
> > >  }
> > >  
> > > +static void fsm_update_subch(struct vfio_ccw_private *private,
> > > +			     enum vfio_ccw_event event)
> > > +{
> > > +	struct subchannel *sch;
> > > +
> > > +	sch = private->sch;
> > > +	if (cio_update_schib(sch)) {  
> > 
> > This implies device gone. Do we also want to trigger some event, or
> > just wait until a machine check comes around and we're notified in the
> > normal way? (Probably the latter.)
> >   
> We'd need to handle machine checks better anyway, and we can trigger
> event there. I think we can choose the latter one.

Agreed. We can tackle the whole machine check complex later, especially
as it also has implications for interacting with user space.

> 
> > > +		private->schib_region.cc = 3;
> > > +		return;
> > > +	}
> > > +
> > > +	private->schib_region.cc = 0;
> > > +	memcpy(private->schib_region.schib_area, &sch->schib,
> > > +	       sizeof(sch->schib));  
> > 
> > We might want to add documentation that schib_area contains the schib
> > from the last successful invocation of stsch (if any). That makes sense
> > as the schib remains unchanged for cc=3 after stsch anyway, but it
> > can't hurt to spell it out.
> >   
> PoP doesn't say anything about the content of SCHIB when cc=3. So it's
> fine to remain the last content I guess. I can add comments here and
> document in vfio-ccw.txt. Ok?

The PoP says "Condition code 3 is set, and no other action is taken" -
I'd interpret this as "no content is changed, but you probably should
not look at that storage area". I'd hope that the caller does not look
at the contents for cc 3, but it's a good idea to document this.

> 
> > > +}
> > > +
> > >  /*
> > >   * Device statemachine
> > >   */
> > > @@ -180,25 +196,30 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
> > >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
> > >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> > >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
> > > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> > >  	},
> > >  	[VFIO_CCW_STATE_STANDBY] = {
> > >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> > >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> > >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> > >  	},
> > >  	[VFIO_CCW_STATE_IDLE] = {
> > >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> > >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
> > >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> > >  	},
> > >  	[VFIO_CCW_STATE_BOXED] = {
> > >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> > >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
> > >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> > >  	},
> > >  	[VFIO_CCW_STATE_BUSY] = {
> > >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> > >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
> > >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,  
> > 
> > Does it makes to trigger this through the state machine if we always do
> > the same action and never change state?  
> Yes. Ah, are you implying that we can call update_subch directly without
> state machine involved? If so, I agree. There seems no benifit to add
> a new VFIO_CCW_EVENT_UPDATE_SUBCH event to the FSM.

Yes, that's what I meant. Whatever makes the code easy to understand.
