Received: from eggs.gnu.org ([2001:4830:134:3::10]:52173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOoa-0003D8-8J
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOoY-0000vf-Q7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cqOoY-0000vL-Hj
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:26 -0400
Date: Tue, 21 Mar 2017 12:47:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170321124724.3277f097@t450s.home>
In-Reply-To: <20170317031743.40128-12-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-12-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/16] vfio: ccw: realize
 VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Fri, 17 Mar 2017 04:17:38 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Realize VFIO_DEVICE_GET_IRQ_INFO ioctl to retrieve
> VFIO_CCW_IO_IRQ information.
> 
> Realize VFIO_DEVICE_SET_IRQS ioctl to set an eventfd fd for
> VFIO_CCW_IO_IRQ. Once a write operation to the ccw_io_region
> was performed, trigger a signal on this fd.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c     | 123 +++++++++++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_private.h |   4 ++
>  include/uapi/linux/vfio.h           |  10 ++-
>  3 files changed, 134 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 125818c..1294c53 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -202,6 +202,9 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  	if (region->ret_code != 0)
>  		return region->ret_code;
>  
> +	if (private->io_trigger)
> +		eventfd_signal(private->io_trigger, 1);
> +
>  	return count;
>  }
>  
> @@ -209,7 +212,7 @@ static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
>  {
>  	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
>  	info->num_regions = VFIO_CCW_NUM_REGIONS;
> -	info->num_irqs = 0;
> +	info->num_irqs = VFIO_CCW_NUM_IRQS;
>  
>  	return 0;
>  }
> @@ -230,6 +233,83 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
>  	}
>  }
>  
> +int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
> +{
> +	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
> +		return -EINVAL;
> +
> +	info->count = 1;
> +	info->flags = VFIO_IRQ_INFO_EVENTFD;
> +
> +	return 0;
> +}
> +
> +static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
> +				  uint32_t flags,
> +				  void __user *data)
> +{
> +	struct vfio_ccw_private *private;
> +	struct eventfd_ctx **ctx;
> +
> +	if (!(flags & VFIO_IRQ_SET_ACTION_TRIGGER))
> +		return -EINVAL;
> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +	if (!private)
> +		return -ENODEV;
> +
> +	ctx = &private->io_trigger;
> +
> +	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
> +	case VFIO_IRQ_SET_DATA_NONE:
> +	{
> +		if (*ctx)
> +			eventfd_signal(*ctx, 1);
> +		return 0;
> +	}
> +	case VFIO_IRQ_SET_DATA_BOOL:
> +	{
> +		uint8_t trigger;
> +
> +		if (get_user(trigger, (uint8_t __user *)data))
> +			return -EFAULT;
> +
> +		if (trigger && *ctx)
> +			eventfd_signal(*ctx, 1);
> +		return 0;
> +	}
> +	case VFIO_IRQ_SET_DATA_EVENTFD:
> +	{
> +		int32_t fd;
> +
> +		if (get_user(fd, (int32_t __user *)data))
> +			return -EFAULT;
> +
> +		if (fd == -1) {
> +			if (*ctx)
> +				eventfd_ctx_put(*ctx);
> +			*ctx = NULL;
> +		} else if (fd >= 0) {
> +			struct eventfd_ctx *efdctx;
> +
> +			efdctx = eventfd_ctx_fdget(fd);
> +			if (IS_ERR(efdctx))
> +				return PTR_ERR(efdctx);
> +
> +			if (*ctx)
> +				eventfd_ctx_put(*ctx);
> +
> +			*ctx = efdctx;
> +		} else
> +			return -EINVAL;
> +
> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>  				   unsigned int cmd,
>  				   unsigned long arg)
> @@ -277,6 +357,47 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>  
>  		return copy_to_user((void __user *)arg, &info, minsz);
>  	}
> +	case VFIO_DEVICE_GET_IRQ_INFO:
> +	{
> +		struct vfio_irq_info info;
> +
> +		minsz = offsetofend(struct vfio_irq_info, count);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz || info.index >= VFIO_CCW_NUM_IRQS)
> +			return -EINVAL;
> +
> +		ret = vfio_ccw_mdev_get_irq_info(&info);
> +		if (ret)
> +			return ret;
> +
> +		if (info.count == -1)
> +			return -EINVAL;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +	}
> +	case VFIO_DEVICE_SET_IRQS:
> +	{
> +		struct vfio_irq_set hdr;
> +		size_t data_size;
> +		void __user *data;
> +
> +		minsz = offsetofend(struct vfio_irq_set, count);
> +
> +		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		ret = vfio_set_irqs_validate_and_prepare(&hdr, 1,
> +							 VFIO_CCW_NUM_IRQS,
> +							 &data_size);
> +		if (ret)
> +			return ret;
> +
> +		data = (void __user *)(arg + minsz);
> +		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
> +	}
>  	case VFIO_DEVICE_RESET:
>  		return vfio_ccw_mdev_reset(mdev);
>  	default:
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 79e5337..dddab52 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -11,6 +11,7 @@
>  #define _VFIO_CCW_PRIVATE_H_
>  
>  #include <linux/completion.h>
> +#include <linux/eventfd.h>
>  #include <linux/vfio_ccw.h>
>  
>  #include "css.h"
> @@ -29,6 +30,7 @@
>   * @cp: channel program for the current I/O operation
>   * @irb: irb info received from interrupt
>   * @scsw: scsw info
> + * @io_trigger: eventfd ctx for signaling userspace I/O results
>   */
>  struct vfio_ccw_private {
>  	struct subchannel	*sch;
> @@ -43,6 +45,8 @@ struct vfio_ccw_private {
>  	struct channel_program	cp;
>  	struct irb		irb;
>  	union scsw		scsw;
> +
> +	struct eventfd_ctx	*io_trigger;
>  } __aligned(8);
>  
>  extern int vfio_ccw_mdev_reg(struct subchannel *sch);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 3fd70ff..ae46105 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -449,8 +449,9 @@ enum {
>  };
>  
>  /*
> - * The vfio-ccw bus driver makes use of the following fixed region.
> - * Unimplemented regions return a size of zero.
> + * The vfio-ccw bus driver makes use of the following fixed region and
> + * IRQ index mapping. Unimplemented regions return a size of zero.
> + * Unimplemented IRQ types return a count of zero.
>   */
>  
>  enum {
> @@ -458,6 +459,11 @@ enum {
>  	VFIO_CCW_NUM_REGIONS
>  };
>  
> +enum {
> +	VFIO_CCW_IO_IRQ_INDEX,
> +	VFIO_CCW_NUM_IRQS
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)


Acked-by: Alex Williamson <alex.williamson@redhat.com>
