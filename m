Received: from eggs.gnu.org ([2001:4830:134:3::10]:59634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eayUN-0007Ig-HN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eayUK-0007dq-FF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:43:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eayUK-0007cN-6K
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:43:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0F6g1HN128003
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 01:43:17 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fghu9at3n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 01:43:16 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 14 Jan 2018 23:43:15 -0700
Date: Mon, 15 Jan 2018 14:43:09 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<20180111030421.31418-2-bjsdjshi@linux.vnet.ibm.com>
	<20180111151659.2d997abf.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111151659.2d997abf.cohuck@redhat.com>
Message-Id: <20180115064309.GA12499@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vfio: ccw: introduce schib region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

* Cornelia Huck <cohuck@redhat.com> [2018-01-11 15:16:59 +0100]:

Hi Conny,

> On Thu, 11 Jan 2018 04:04:19 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > This introduces a new region for vfio-ccw to provide subchannel
> > information for user space.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_fsm.c     | 21 ++++++++++
> >  drivers/s390/cio/vfio_ccw_ops.c     | 79 +++++++++++++++++++++++++++----------
> >  drivers/s390/cio/vfio_ccw_private.h |  3 ++
> >  include/uapi/linux/vfio.h           |  1 +
> >  include/uapi/linux/vfio_ccw.h       |  6 +++
> >  5 files changed, 90 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > index c30420c517b1..be081ccabea3 100644
> > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> > @@ -172,6 +172,22 @@ static void fsm_irq(struct vfio_ccw_private *private,
> >  		complete(private->completion);
> >  }
> >  
> > +static void fsm_update_subch(struct vfio_ccw_private *private,
> > +			     enum vfio_ccw_event event)
> > +{
> > +	struct subchannel *sch;
> > +
> > +	sch = private->sch;
> > +	if (cio_update_schib(sch)) {
> 
> This implies device gone. Do we also want to trigger some event, or
> just wait until a machine check comes around and we're notified in the
> normal way? (Probably the latter.)
> 
We'd need to handle machine checks better anyway, and we can trigger
event there. I think we can choose the latter one.

> > +		private->schib_region.cc = 3;
> > +		return;
> > +	}
> > +
> > +	private->schib_region.cc = 0;
> > +	memcpy(private->schib_region.schib_area, &sch->schib,
> > +	       sizeof(sch->schib));
> 
> We might want to add documentation that schib_area contains the schib
> from the last successful invocation of stsch (if any). That makes sense
> as the schib remains unchanged for cc=3 after stsch anyway, but it
> can't hurt to spell it out.
> 
PoP doesn't say anything about the content of SCHIB when cc=3. So it's
fine to remain the last content I guess. I can add comments here and
document in vfio-ccw.txt. Ok?

> > +}
> > +
> >  /*
> >   * Device statemachine
> >   */
> > @@ -180,25 +196,30 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
> >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
> >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
> > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> >  	},
> >  	[VFIO_CCW_STATE_STANDBY] = {
> >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> >  	},
> >  	[VFIO_CCW_STATE_IDLE] = {
> >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
> >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> >  	},
> >  	[VFIO_CCW_STATE_BOXED] = {
> >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
> >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> >  	},
> >  	[VFIO_CCW_STATE_BUSY] = {
> >  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> >  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
> >  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> > +		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
> 
> Does it makes to trigger this through the state machine if we always do
> the same action and never change state?
Yes. Ah, are you implying that we can call update_subch directly without
state machine involved? If so, I agree. There seems no benifit to add
a new VFIO_CCW_EVENT_UPDATE_SUBCH event to the FSM.

> 
> >  	},
> >  };
> 
> Else, looks good.
> 
Thanks for the comments. :)

-- 
Dong Jia Shi
