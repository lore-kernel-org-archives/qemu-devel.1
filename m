Received: from eggs.gnu.org ([2001:4830:134:3::10]:60056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1chP3k-0004VD-Qi
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1chP3j-0004dH-D2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:13:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1chP3j-0004cr-4P
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:13:55 -0500
Date: Fri, 24 Feb 2017 16:13:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170224161353.42f06060@t450s.home>
In-Reply-To: <20170217082939.33208-8-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-8-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 07/15] vfio: ccw: introduce
 ccw_io_region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Fri, 17 Feb 2017 09:29:31 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> To provide user-space a set of interfaces to:
> 1. pass in a ccw program to perform an I/O operation.
> 2. read back I/O results of the completed I/O operations.
> We introduce an MMIO region for the vfio-ccw device here.
> 
> This region is defined to content:
> 1. areas to store arguments that an ssch required.
> 2. areas to store the I/O results.
> 
> Using pwrite/pread to the device on this region, a user-space program
> could write/read data to/from the vfio-ccw device.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild   |  1 +
>  drivers/s390/cio/vfio_ccw_ops.c     | 47 +++++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>  include/uapi/linux/vfio_ccw.h       | 24 +++++++++++++++++++
>  4 files changed, 76 insertions(+)
>  create mode 100644 include/uapi/linux/vfio_ccw.h
> 
> diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
> index bf736e7..fdb9529 100644
> --- a/arch/s390/include/uapi/asm/Kbuild
> +++ b/arch/s390/include/uapi/asm/Kbuild
> @@ -52,3 +52,4 @@ header-y += unistd.h
>  header-y += virtio-ccw.h
>  header-y += vtoc.h
>  header-y += zcrypt.h
> +header-y += vfio_ccw.h
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index b8a2fed..6c06805 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -127,6 +127,51 @@ void vfio_ccw_mdev_release(struct mdev_device *mdev)
>  				 &private->nb);
>  }
>  
> +static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
> +				  char __user *buf,
> +				  size_t count,
> +				  loff_t *ppos)
> +{
> +	struct vfio_ccw_private *private;
> +	struct ccw_io_region *region;
> +
> +	if (*ppos + count > sizeof(*region))
> +		return -EINVAL;

Couldn't this wrap-around and still satisfy this test?

> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +	if (!private)
> +		return -ENODEV;
> +
> +	region = &private->io_region;
> +	if (copy_to_user(buf, (void *)region + *ppos, count))
> +		return -EFAULT;
> +
> +	return count;
> +}
> +
> +static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> +				   const char __user *buf,
> +				   size_t count,
> +				   loff_t *ppos)
> +{
> +	struct vfio_ccw_private *private;
> +	struct ccw_io_region *region;
> +
> +	if (*ppos + count > sizeof(*region))
> +		return -EINVAL;

Same here

> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +	if (!private)
> +		return -ENODEV;
> +
> +	region = &private->io_region;
> +	if (copy_from_user((void *)region + *ppos, buf, count))
> +		return -EFAULT;
> +	region->ret_code = 0;
> +
> +	return count;
> +}
> +
>  static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
>  	.owner			= THIS_MODULE,
>  	.supported_type_groups  = mdev_type_groups,
> @@ -134,6 +179,8 @@ static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
>  	.remove			= vfio_ccw_mdev_remove,
>  	.open			= vfio_ccw_mdev_open,
>  	.release		= vfio_ccw_mdev_release,
> +	.read			= vfio_ccw_mdev_read,
> +	.write			= vfio_ccw_mdev_write,
>  };
>  
>  int vfio_ccw_mdev_reg(struct subchannel *sch)
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 5afb3ba..359e96b 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -10,6 +10,8 @@
>  #ifndef _VFIO_CCW_PRIVATE_H_
>  #define _VFIO_CCW_PRIVATE_H_
>  
> +#include <linux/vfio_ccw.h>
> +
>  #include "css.h"
>  
>  /**
> @@ -19,6 +21,7 @@
>   * @avail: available for creating a mediated device
>   * @mdev: pointer to the mediated device
>   * @nb: notifier for vfio events
> + * @io_region: MMIO region to input/output I/O arguments/results
>   */
>  struct vfio_ccw_private {
>  	struct subchannel	*sch;
> @@ -26,6 +29,7 @@ struct vfio_ccw_private {
>  	atomic_t		avail;
>  	struct mdev_device	*mdev;
>  	struct notifier_block	nb;
> +	struct ccw_io_region	io_region;
>  } __aligned(8);
>  
>  extern int vfio_ccw_mdev_reg(struct subchannel *sch);
> diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
> new file mode 100644
> index 0000000..34a7f6f
> --- /dev/null
> +++ b/include/uapi/linux/vfio_ccw.h
> @@ -0,0 +1,24 @@
> +/*
> + * Interfaces for vfio-ccw
> + *
> + * Copyright IBM Corp. 2017
> + *
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _VFIO_CCW_H_
> +#define _VFIO_CCW_H_
> +
> +#include <linux/types.h>
> +
> +struct ccw_io_region {
> +#define ORB_AREA_SIZE 12
> +	__u8	orb_area[ORB_AREA_SIZE];
> +#define SCSW_AREA_SIZE 12
> +	__u8	scsw_area[SCSW_AREA_SIZE];
> +#define IRB_AREA_SIZE 96
> +	__u8	irb_area[IRB_AREA_SIZE];
> +	__u32	ret_code;
> +} __packed;
> +
> +#endif
