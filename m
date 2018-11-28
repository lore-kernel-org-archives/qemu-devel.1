Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gS2ux-000610-Ip
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gS2p2-0004Sq-40
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:36:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gS2p1-0004NP-43
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:36:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wASGO8sO036074
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:36:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p1vrg6j7t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:36:13 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 28 Nov 2018 16:36:10 -0000
Date: Wed, 28 Nov 2018 17:36:04 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181122165432.4437-4-cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181128173604.24b301a3@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] vfio-ccw: add handling
 for asnyc channel instructions
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

On Thu, 22 Nov 2018 17:54:32 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
> 
> Interrupt status continues to be reported through the same channels
> as for ssch.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/Makefile           |   3 +-
>  drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>  drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>  drivers/s390/cio/vfio_ccw_private.h |   6 ++
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_ccw.h       |  12 +++
>  8 files changed, 313 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
> diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
> index f230516abb96..f6a8db04177c 100644
> --- a/drivers/s390/cio/Makefile
> +++ b/drivers/s390/cio/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
>  qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
>  obj-$(CONFIG_QDIO) += qdio.o
>  
> -vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o
> +vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o \
> +	vfio_ccw_async.o
>  obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> new file mode 100644
> index 000000000000..8c7f51d17d70
> --- /dev/null
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Async I/O region for vfio_ccw
> + *
> + * Copyright Red Hat, Inc. 2018
> + *
> + * Author(s): Cornelia Huck <cohuck@redhat.com>
> + */
> +
> +#include <linux/vfio.h>
> +#include <linux/mdev.h>
> +
> +#include "vfio_ccw_private.h"
> +
> +static size_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
> +					 char __user *buf, size_t count,
> +					 loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_cmd_region *region;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	region = private->region[i].data;
> +	if (copy_to_user(buf, (void *)region + pos, count))
> +		return -EFAULT;
> +
> +	return count;
> +
> +}
> +
> +static size_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
> +					  const char __user *buf, size_t count,
> +					  loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_cmd_region *region;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
> +		return -EACCES;
> +
> +	region = private->region[i].data;
> +	if (copy_from_user((void *)region + pos, buf, count))
> +		return -EFAULT;

I guess vfio_ccw_async_region_write() is supposed to be reentrant in a
sense that there may be more that one 'instances' of the function
executing at the same time, or am I wrong?

If it is reenarant, I wonder what protects private->region[i].data from
corruption or simply being changed 'while at it'?

Regards,
Halil

> +
> +	switch (region->command) {
> +	case VFIO_CCW_ASYNC_CMD_HSCH:
> +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_HALT_REQ);
> +		break;
> +	case VFIO_CCW_ASYNC_CMD_CSCH:
> +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLEAR_REQ);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return region->ret_code ? region->ret_code : count;
> +}
> +
