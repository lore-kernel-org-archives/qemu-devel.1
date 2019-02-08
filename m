Received: from eggs.gnu.org ([209.51.188.92]:36487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gsDfF-0007es-0m
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gsDfA-0006BH-Pg
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:26:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gsDf9-00069g-14
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:26:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18LNkuF097119
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 16:26:15 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhdy617xh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 16:26:15 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 8 Feb 2019 21:26:14 -0000
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-4-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 8 Feb 2019 16:26:06 -0500
MIME-Version: 1.0
In-Reply-To: <20190130132212.7376-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9ae9987a-f48d-9f35-9320-b9cfde6b2bad@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vfio-ccw: protect the I/O region
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
> Introduce a mutex to disallow concurrent reads or writes to the
> I/O region. This makes sure that the data the kernel or user
> space see is always consistent.
> 
> The same mutex will be used to protect the async region as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I keep wondering how the FSM could provide this, but I end up getting 
into chicken/egg rabbit holes.  So, until my brain becomes wiser...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>   drivers/s390/cio/vfio_ccw_drv.c     |  3 +++
>   drivers/s390/cio/vfio_ccw_ops.c     | 28 +++++++++++++++++++---------
>   drivers/s390/cio/vfio_ccw_private.h |  2 ++
>   3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 0b3b9de45c60..5ea0da1dd954 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -84,7 +84,9 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>   		if (is_final)
>   			cp_free(&private->cp);
>   	}
> +	mutex_lock(&private->io_mutex);
>   	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
> +	mutex_unlock(&private->io_mutex);
>   
>   	if (private->io_trigger)
>   		eventfd_signal(private->io_trigger, 1);
> @@ -129,6 +131,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>   
>   	private->sch = sch;
>   	dev_set_drvdata(&sch->dev, private);
> +	mutex_init(&private->io_mutex);
>   
>   	spin_lock_irq(sch->lock);
>   	private->state = VFIO_CCW_STATE_NOT_OPER;
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 3fdcc6dfe0bf..025c8a832bc8 100644
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
> @@ -188,23 +192,29 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>   {
>   	struct vfio_ccw_private *private;
>   	struct ccw_io_region *region;
> +	int ret;
>   
>   	if (*ppos + count > sizeof(*region))
>   		return -EINVAL;
>   
>   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +	if (!mutex_trylock(&private->io_mutex))
> +		return -EAGAIN;
>   
>   	region = private->io_region;
> -	if (copy_from_user((void *)region + *ppos, buf, count))
> -		return -EFAULT;
> +	if (copy_from_user((void *)region + *ppos, buf, count)) {
> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
>   
>   	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
> -	if (region->ret_code != 0) {
> +	if (region->ret_code != 0)
>   		private->state = VFIO_CCW_STATE_IDLE;
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
> index 50c52efb4fcb..32173cbd838d 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -28,6 +28,7 @@
>    * @mdev: pointer to the mediated device
>    * @nb: notifier for vfio events
>    * @io_region: MMIO region to input/output I/O arguments/results
> + * @io_mutex: protect against concurrent update of I/O regions
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
