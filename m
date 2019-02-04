Received: from eggs.gnu.org ([209.51.188.92]:50711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gqloM-0006ET-Id
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gqloL-0001MQ-3l
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:29:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54612
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gqloK-0001Iq-Qa
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:29:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14LSwO9076301
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 16:29:46 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qev70jqf4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 16:29:45 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 4 Feb 2019 21:29:45 -0000
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-3-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 4 Feb 2019 16:29:40 -0500
MIME-Version: 1.0
In-Reply-To: <20190130132212.7376-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <55d9fc3d-12ec-9ad7-cdaa-72c5dbb65aca@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vfio-ccw: rework ssch state handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 01/30/2019 08:22 AM, Cornelia Huck wrote:
> The flow for processing ssch requests can be improved by splitting
> the BUSY state:
> 
> - CP_PROCESSING: We reject any user space requests while we are in
>    the process of translating a channel program and submitting it to
>    the hardware. Use -EAGAIN to signal user space that it should
>    retry the request.
> - CP_PENDING: We have successfully submitted a request with ssch and
>    are now expecting an interrupt. As we can't handle more than one
>    channel program being processed, reject any further requests with
>    -EBUSY. A final interrupt will move us out of this state; this also
>    fixes a latent bug where a non-final interrupt might have freed up
>    a channel program that still was in progress.
>    By making this a separate state, we make it possible to issue a
>    halt or a clear while we're still waiting for the final interrupt
>    for the ssch (in a follow-on patch).
> 
> It also makes a lot of sense not to preemptively filter out writes to
> the io_region if we're in an incorrect state: the state machine will
> handle this correctly.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c     |  8 ++++++--
>   drivers/s390/cio/vfio_ccw_fsm.c     | 19 ++++++++++++++-----
>   drivers/s390/cio/vfio_ccw_ops.c     |  2 --
>   drivers/s390/cio/vfio_ccw_private.h |  3 ++-
>   4 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index a10cec0e86eb..0b3b9de45c60 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -72,20 +72,24 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>   {
>   	struct vfio_ccw_private *private;
>   	struct irb *irb;
> +	bool is_final;
>   
>   	private = container_of(work, struct vfio_ccw_private, io_work);
>   	irb = &private->irb;
>   
> +	is_final = !(scsw_actl(&irb->scsw) &
> +		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
>   	if (scsw_is_solicited(&irb->scsw)) {
>   		cp_update_scsw(&private->cp, &irb->scsw);
> -		cp_free(&private->cp);
> +		if (is_final)
> +			cp_free(&private->cp);
>   	}
>   	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>   
>   	if (private->io_trigger)
>   		eventfd_signal(private->io_trigger, 1);
>   
> -	if (private->mdev)
> +	if (private->mdev && is_final)
>   		private->state = VFIO_CCW_STATE_IDLE;
>   }
>   
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index e7c9877c9f1e..b4a141fbd1a8 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -28,7 +28,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   	sch = private->sch;
>   
>   	spin_lock_irqsave(sch->lock, flags);
> -	private->state = VFIO_CCW_STATE_BUSY;
>   
>   	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
>   	if (!orb) {
> @@ -46,6 +45,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   		 */
>   		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
>   		ret = 0;
> +		private->state = VFIO_CCW_STATE_CP_PENDING;

[1]

>   		break;
>   	case 1:		/* Status pending */
>   	case 2:		/* Busy */
> @@ -107,6 +107,12 @@ static void fsm_io_busy(struct vfio_ccw_private *private,
>   	private->io_region->ret_code = -EBUSY;
>   }
>   
> +static void fsm_io_retry(struct vfio_ccw_private *private,
> +			 enum vfio_ccw_event event)
> +{
> +	private->io_region->ret_code = -EAGAIN;
> +}
> +
>   static void fsm_disabled_irq(struct vfio_ccw_private *private,
>   			     enum vfio_ccw_event event)
>   {
> @@ -135,8 +141,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   	struct mdev_device *mdev = private->mdev;
>   	char *errstr = "request";
>   
> -	private->state = VFIO_CCW_STATE_BUSY;
> -
> +	private->state = VFIO_CCW_STATE_CP_PROCESSING;

[1]

>   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>   
>   	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> @@ -181,7 +186,6 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   	}
>   
>   err_out:
> -	private->state = VFIO_CCW_STATE_IDLE;

[1] Revisiting these locations as from an earlier discussion [2]... 
These go IDLE->CP_PROCESSING->CP_PENDING if we get a cc=0 on the SSCH, 
but we stop in CP_PROCESSING if the SSCH gets a nonzero cc.  Shouldn't 
we cleanup and go back to IDLE in this scenario, rather than forcing 
userspace to escalate to CSCH/HSCH after some number of retries (via FSM)?

[2] https://patchwork.kernel.org/patch/10773611/#22447997

Besides that, I think this looks good to me.

  - Eric

>   	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
>   			       io_region->ret_code, errstr);
>   }
> @@ -221,7 +225,12 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>   		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>   	},
> -	[VFIO_CCW_STATE_BUSY] = {
> +	[VFIO_CCW_STATE_CP_PROCESSING] = {
> +		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> +		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_retry,
> +		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> +	},
> +	[VFIO_CCW_STATE_CP_PENDING] = {
>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>   		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index f673e106c041..3fdcc6dfe0bf 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -193,8 +193,6 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>   		return -EINVAL;
>   
>   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> -	if (private->state != VFIO_CCW_STATE_IDLE)
> -		return -EACCES;
>   
>   	region = private->io_region;
>   	if (copy_from_user((void *)region + *ppos, buf, count))
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 08e9a7dc9176..50c52efb4fcb 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -63,7 +63,8 @@ enum vfio_ccw_state {
>   	VFIO_CCW_STATE_NOT_OPER,
>   	VFIO_CCW_STATE_STANDBY,
>   	VFIO_CCW_STATE_IDLE,
> -	VFIO_CCW_STATE_BUSY,
> +	VFIO_CCW_STATE_CP_PROCESSING,
> +	VFIO_CCW_STATE_CP_PENDING,
>   	/* last element! */
>   	NR_VFIO_CCW_STATES
>   };
> 
