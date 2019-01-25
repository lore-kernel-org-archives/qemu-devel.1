Received: from eggs.gnu.org ([209.51.188.92]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmrDh-0003ZY-L9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmrBU-0000TX-NA
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:25:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gmrBU-0000H8-CS
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:25:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0P2Nrcd109613
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 21:25:17 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7pfuyn43-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 21:25:17 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 25 Jan 2019 02:25:16 -0000
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 24 Jan 2019 21:25:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190121110354.2247-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
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



On 01/21/2019 06:03 AM, Cornelia Huck wrote:
> Rework handling of multiple I/O requests to return -EAGAIN if
> we are already processing an I/O request. Introduce a mutex
> to disallow concurrent writes to the I/O region.
> 
> The expectation is that userspace simply retries the operation
> if it gets -EAGAIN.
> 
> We currently don't allow multiple ssch requests at the same
> time, as we don't have support for keeping channel programs
> around for more than one request.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c     |  1 +
>   drivers/s390/cio/vfio_ccw_fsm.c     |  8 +++-----
>   drivers/s390/cio/vfio_ccw_ops.c     | 31 +++++++++++++++++++----------
>   drivers/s390/cio/vfio_ccw_private.h |  2 ++
>   4 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index a10cec0e86eb..2ef189fe45ed 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -125,6 +125,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>   
>   	private->sch = sch;
>   	dev_set_drvdata(&sch->dev, private);
> +	mutex_init(&private->io_mutex);
>   
>   	spin_lock_irq(sch->lock);
>   	private->state = VFIO_CCW_STATE_NOT_OPER;
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index cab17865aafe..f6ed934cc565 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -28,7 +28,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   	sch = private->sch;
>   
>   	spin_lock_irqsave(sch->lock, flags);
> -	private->state = VFIO_CCW_STATE_BUSY;

[1]

>   
>   	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
>   
> @@ -42,6 +41,8 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   		 */
>   		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
>   		ret = 0;
> +		/* Don't allow another ssch for now */
> +		private->state = VFIO_CCW_STATE_BUSY;

[1]

>   		break;
>   	case 1:		/* Status pending */
>   	case 2:		/* Busy */
> @@ -99,7 +100,7 @@ static void fsm_io_error(struct vfio_ccw_private *private,
>   static void fsm_io_busy(struct vfio_ccw_private *private,
>   			enum vfio_ccw_event event)
>   {
> -	private->io_region->ret_code = -EBUSY;
> +	private->io_region->ret_code = -EAGAIN;
>   }
>   
>   static void fsm_disabled_irq(struct vfio_ccw_private *private,
> @@ -130,8 +131,6 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   	struct mdev_device *mdev = private->mdev;
>   	char *errstr = "request";
>   
> -	private->state = VFIO_CCW_STATE_BUSY;
> -

[1]

>   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>   
>   	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> @@ -176,7 +175,6 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   	}
>   
>   err_out:
> -	private->state = VFIO_CCW_STATE_IDLE;

[1] I think these changes are cool.  We end up going into (and staying 
in) state=BUSY if we get cc=0 on the SSCH, rather than in/out as we 
bumble along.

But why can't these be separated out from this patch?  It does change 
the behavior of the state machine, and seem distinct from the addition 
of the mutex you otherwise add here?  At the very least, this behavior 
change should be documented in the commit since it's otherwise lost in 
the mutex/EAGAIN stuff.

>   	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
>   			       io_region->ret_code, errstr);
>   }
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index f673e106c041..3fa9fc570400 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -169,16 +169,20 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
>   {
>   	struct vfio_ccw_private *private;
>   	struct ccw_io_region *region;
> +	int ret;
>   
>   	if (*ppos + count > sizeof(*region))
>   		return -EINVAL;
>   
>   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +	mutex_lock(&private->io_mutex);
>   	region = private->io_region;
>   	if (copy_to_user(buf, (void *)region + *ppos, count))
> -		return -EFAULT;
> -
> -	return count;
> +		ret = -EFAULT;
> +	else
> +		ret = count;
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
>   }
>   
>   static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>   {
>   	struct vfio_ccw_private *private;
>   	struct ccw_io_region *region;
> +	int ret;
>   
>   	if (*ppos + count > sizeof(*region))
>   		return -EINVAL;
>   
>   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> -	if (private->state != VFIO_CCW_STATE_IDLE)
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
>   		return -EACCES;
> +	if (!mutex_trylock(&private->io_mutex))
> +		return -EAGAIN;

Ah, I see Halil's difficulty here.

It is true there is a race condition today, and that this doesn't 
address it.  That's fine, add it to the todo list.  But even with that, 
I don't see what the mutex is enforcing?  Two simultaneous SSCHs will be 
serialized (one will get kicked out with a failed trylock() call), while 
still leaving the window open between cc=0 on the SSCH and the 
subsequent interrupt.  In the latter case, a second SSCH will come 
through here, do the copy_from_user below, and then jump to fsm_io_busy 
to return EAGAIN.  Do we really want to stomp on io_region in that case? 
  Why can't we simply return EAGAIN if state==BUSY?

>   
>   	region = private->io_region;
> -	if (copy_from_user((void *)region + *ppos, buf, count))
> -		return -EFAULT;
> +	if (copy_from_user((void *)region + *ppos, buf, count)) {
> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
>   
>   	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ)
> -	if (region->ret_code != 0) {
> -		private->state = VFIO_CCW_STATE_IDLE;

[1] (above)

> -		return region->ret_code;
> -	}
> +	ret = (region->ret_code != 0) ? region->ret_code : count;
>   
> -	return count;
> +out_unlock:
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
>   }
>   
>   static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 08e9a7dc9176..e88237697f83 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -28,6 +28,7 @@
>    * @mdev: pointer to the mediated device
>    * @nb: notifier for vfio events
>    * @io_region: MMIO region to input/output I/O arguments/results
> + * @io_mutex: protect against concurrent update of I/O structures
>    * @cp: channel program for the current I/O operation
>    * @irb: irb info received from interrupt
>    * @scsw: scsw info
> @@ -42,6 +43,7 @@ struct vfio_ccw_private {
>   	struct mdev_device	*mdev;
>   	struct notifier_block	nb;
>   	struct ccw_io_region	*io_region;
> +	struct mutex		io_mutex;
>   
>   	struct channel_program	cp;
>   	struct irb		irb;
> 
