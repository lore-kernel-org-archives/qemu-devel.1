Received: from eggs.gnu.org ([209.51.188.92]:55952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1glg3k-0001j0-27
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1glg3h-0001Lj-QT
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:20:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1glg3c-0001K0-Bg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:20:35 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LKGdYn140528
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 15:20:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q5my9g4bu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 15:20:27 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 21 Jan 2019 20:20:25 -0000
Date: Mon, 21 Jan 2019 21:20:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190121110354.2247-3-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190121212018.4e377e59@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 21 Jan 2019 12:03:51 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

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

[..]

>  static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  {
>  	struct vfio_ccw_private *private;
>  	struct ccw_io_region *region;
> +	int ret;
>  
>  	if (*ppos + count > sizeof(*region))
>  		return -EINVAL;
>  
>  	private = dev_get_drvdata(mdev_parent_dev(mdev));
> -	if (private->state != VFIO_CCW_STATE_IDLE)
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
>  		return -EACCES;
> +	if (!mutex_trylock(&private->io_mutex))
> +		return -EAGAIN;
>  
>  	region = private->io_region;
> -	if (copy_from_user((void *)region + *ppos, buf, count))
> -		return -EFAULT;
> +	if (copy_from_user((void *)region + *ppos, buf, count)) {

This might race with vfio_ccw_sch_io_todo() on
private->io_region->irb_area, or?

> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
>  
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
> -	if (region->ret_code != 0) {
> -		private->state = VFIO_CCW_STATE_IDLE;
> -		return region->ret_code;
> -	}
> +	ret = (region->ret_code != 0) ? region->ret_code : count;
>  
> -	return count;
> +out_unlock:
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
>  }
>  
[..]
