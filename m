Received: from eggs.gnu.org ([208.118.235.92]:50605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQBLx-0007qY-GN
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQBBt-0007Gb-Le
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:08:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43688
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQBBr-0007Ew-Tz
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:08:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANCxsbc070401
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:08:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nxerh90uw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:08:10 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 13:08:08 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 14:08:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <91b54c7e-a7b1-b721-89be-12a5706a0e21@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 22/11/2018 17:54, Cornelia Huck wrote:
> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
>=20
> Interrupt status continues to be reported through the same channels
> as for ssch.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/Makefile           |   3 +-
>   drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>   drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>   drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++=
-
>   drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>   drivers/s390/cio/vfio_ccw_private.h |   6 ++
>   include/uapi/linux/vfio.h           |   4 +
>   include/uapi/linux/vfio_ccw.h       |  12 +++
>   8 files changed, 313 insertions(+), 19 deletions(-)
>   create mode 100644 drivers/s390/cio/vfio_ccw_async.c
>=20
> diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
> index f230516abb96..f6a8db04177c 100644
> --- a/drivers/s390/cio/Makefile
> +++ b/drivers/s390/cio/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_CCWGROUP) +=3D ccwgroup.o
>   qdio-objs :=3D qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
>   obj-$(CONFIG_QDIO) +=3D qdio.o
>  =20
> -vfio_ccw-objs +=3D vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_cc=
w_fsm.o
> +vfio_ccw-objs +=3D vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_cc=
w_fsm.o \
> +	vfio_ccw_async.o
>   obj-$(CONFIG_VFIO_CCW) +=3D vfio_ccw.o
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_=
ccw_async.c
> new file mode 100644
> index 000000000000..8c7f51d17d70
> --- /dev/null
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0

...snip...


>   static void __exit vfio_ccw_sch_exit(void)
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_cc=
w_fsm.c
> index f94aa01f9c36..0caf77e8f377 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -3,8 +3,10 @@
>    * Finite state machine for vfio-ccw device handling
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2018
>    *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    */
>  =20
>   #include <linux/vfio.h>
> @@ -68,6 +70,81 @@ static int fsm_io_helper(struct vfio_ccw_private *pr=
ivate)
>   	return ret;
>   }
>  =20
> +static int fsm_do_halt(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	unsigned long flags;
> +	int ccode;
> +	int ret;
> +
> +	sch =3D private->sch;
> +
> +	spin_lock_irqsave(sch->lock, flags);
> +	private->state =3D VFIO_CCW_STATE_BUSY;
> +
> +	/* Issue "Halt Subchannel" */
> +	ccode =3D hsch(sch->schid);
> +
> +	switch (ccode) {
> +	case 0:
> +		/*
> +		 * Initialize device status information
> +		 */
> +		sch->schib.scsw.cmd.actl |=3D SCSW_ACTL_HALT_PEND;
> +		ret =3D 0;
> +		break;
> +	case 1:		/* Status pending */
> +	case 2:		/* Busy */
> +		ret =3D -EBUSY;
> +		break;
> +	case 3:		/* Device not operational */
> +	{
> +		ret =3D -ENODEV;
> +		break;
> +	}
> +	default:
> +		ret =3D ccode;
> +	}

Shouldn't you set the state back here?

> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
> +static int fsm_do_clear(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	unsigned long flags;
> +	int ccode;
> +	int ret;
> +
> +	sch =3D private->sch;
> +
> +	spin_lock_irqsave(sch->lock, flags);
> +	private->state =3D VFIO_CCW_STATE_BUSY;
> +
> +	/* Issue "Clear Subchannel" */
> +	ccode =3D csch(sch->schid);
> +
> +	switch (ccode) {
> +	case 0:
> +		/*
> +		 * Initialize device status information
> +		 */
> +		sch->schib.scsw.cmd.actl =3D SCSW_ACTL_CLEAR_PEND;
> +		/* TODO: check what else we might need to clear */
> +		ret =3D 0;
> +		break;
> +	case 3:		/* Device not operational */
> +	{
> +		ret =3D -ENODEV;
> +		break;
> +	}
> +	default:
> +		ret =3D ccode;
> +	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
>   static void fsm_notoper(struct vfio_ccw_private *private,
>   			enum vfio_ccw_event event)
>   {
> @@ -102,6 +179,20 @@ static void fsm_io_busy(struct vfio_ccw_private *p=
rivate,
>   	private->io_region->ret_code =3D -EBUSY;
>   }
>  =20
> +static void fsm_async_error(struct vfio_ccw_private *private,
> +			    enum vfio_ccw_event event)
> +{
> +	pr_err("vfio-ccw: FSM: halt/clear request from state:%d\n",
> +	       private->state);
> +	private->cmd_region->ret_code =3D -EIO;
> +}
> +
> +static void fsm_async_busy(struct vfio_ccw_private *private,
> +			   enum vfio_ccw_event event)
> +{
> +	private->cmd_region->ret_code =3D -EBUSY;
> +}
> +
>   static void fsm_disabled_irq(struct vfio_ccw_private *private,
>   			     enum vfio_ccw_event event)
>   {
> @@ -166,11 +257,11 @@ static void fsm_io_request(struct vfio_ccw_privat=
e *private,
>   		}
>   		return;
>   	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> -		/* XXX: Handle halt. */
> +		/* halt is handled via the async cmd region */
>   		io_region->ret_code =3D -EOPNOTSUPP;
>   		goto err_out;
>   	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> -		/* XXX: Handle clear. */
> +		/* clear is handled via the async cmd region */
>   		io_region->ret_code =3D -EOPNOTSUPP;
>   		goto err_out;

What about filtering inside the vfio_ccw_mdev_write_io_region() before=20
the call to the FSM?


>   	}
> @@ -181,6 +272,59 @@ static void fsm_io_request(struct vfio_ccw_private=
 *private,
>   			       io_region->ret_code, errstr);
>   }
>  =20
> +/*
> + * Deal with a halt request from userspace.
> + */
> +static void fsm_halt_request(struct vfio_ccw_private *private,
> +			     enum vfio_ccw_event event)
> +{
> +	struct ccw_cmd_region *cmd_region =3D private->cmd_region;
> +	int state =3D private->state;
> +
> +	private->state =3D VFIO_CCW_STATE_BOXED;
> +
> +	if (cmd_region->command !=3D VFIO_CCW_ASYNC_CMD_HSCH) {
> +		/* should not happen? */

I think we should make sure it does not happen before we get here.
Like serializing HALT and CLEAR before the FSM.

> +		cmd_region->ret_code =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	cmd_region->ret_code =3D fsm_do_halt(private);

fsm_do_halt() set the state to BUSY.
Do we need a state change here and in fsm_do_halt ?

Why not only the BUSY state?

> +	if (cmd_region->ret_code)
> +		goto err_out;
> +
> +	return;
> +
> +err_out:
> +	private->state =3D state;
> +}
> +

...snip...

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
