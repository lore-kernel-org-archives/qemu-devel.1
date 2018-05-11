Received: from eggs.gnu.org ([2001:4830:134:3::10]:60236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4Qu-00023W-R2
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4Qr-00074I-KS
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:33:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fH4Qr-00073f-Bn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:33:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4B9T1T7065627
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:33:44 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hw4xp14aw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:33:43 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 11 May 2018 10:33:41 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 11 May 2018 11:33:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180509154822.23510-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 09/05/2018 17:48, Cornelia Huck wrote:
> Currently, vfio-ccw only relays start subchannel requests to the real
> hardware, which is enough in many cases but falls short e.g. during
> error recovery.
>
> Fortunately, it is easy to add support for halt and clear subchannel
> requests to the existing infrastructure. User space can detect
> support for halt/clear subchannel easily, as we always returned
> -EOPNOTSUPP before and therefore we do not need any capability to
> make this support discoverable.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
>   drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++=
++++-----
>   2 files changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_cc=
w_drv.c
> index ea6a2d0b2894..6212d577117f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -76,8 +76,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct =
*work)
>   	irb =3D &private->irb;
>  =20
>   	if (scsw_is_solicited(&irb->scsw)) {
> -		cp_update_scsw(&private->cp, &irb->scsw);
> -		cp_free(&private->cp);
> +		/*
> +		 * For the start function, we need to update based on the
> +		 * channel program. Nothing needs to be done for halt/clear.
> +		 */
> +		if (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC) {
> +			cp_update_scsw(&private->cp, &irb->scsw);
> +			cp_free(&private->cp);
> +		}
>   	}
>   	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
>  =20
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_cc=
w_fsm.c
> index 3c800642134e..94cae2984c35 100644
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
> @@ -65,6 +67,70 @@ static int fsm_io_helper(struct vfio_ccw_private *pr=
ivate)
>   	return ret;
>   }
>  =20
> +static int fsm_halt_helper(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	int ccode;
> +	unsigned long flags;
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

shouldn't we make a difference between status pending
and having halt in progress?

The guest can examine the SCSW, but couldn't it introduce
a race condition?


> +	case 2:		/* Busy */
> +		ret =3D -EBUSY;
> +		break;
> +	default:	/* Device not operational */
> +		ret =3D -ENODEV;
> +	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
> +static int fsm_clear_helper(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	int ccode;
> +	unsigned long flags;
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
> +		sch->schib.scsw.cmd.actl |=3D SCSW_ACTL_CLEAR_PEND;
> +		ret =3D 0;
> +		break;
> +	default:	/* Device not operational */
> +		ret =3D -ENODEV;
> +	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
>   static void fsm_notoper(struct vfio_ccw_private *private,
>   			enum vfio_ccw_event event)
>   {
> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private=
 *private,
>  =20
>   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>  =20
> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> +	/*
> +	 * Start processing with the clear function, then halt, then start.
> +	 * We may still be start pending when the caller wants to clean
> +	 * up things via halt/clear.
> +	 */

hum. The scsw here does not reflect the hardware state but the
command passed from the user interface.
Can we and should we authorize multiple commands in one call?

If not, the comment is not appropriate and a switch on cmd.fctl
would be a clearer.

> +	if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> +		/* issue clear and wait for interupt */
> +		io_region->ret_code =3D fsm_clear_helper(private);
> +		if (io_region->ret_code)
> +			goto err_out;
> +		return;
> +	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> +		/* issue halt and wait for interrupt */
> +		io_region->ret_code =3D fsm_halt_helper(private);
> +		if (io_region->ret_code)
> +			goto err_out;
> +		return;
> +	} else if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>   		orb =3D (union orb *)io_region->orb_area;
>  =20
>   		/* Don't try to build a cp if transport mode is specified. */
> @@ -152,16 +235,7 @@ static void fsm_io_request(struct vfio_ccw_private=
 *private,
>   			goto err_out;
>   		}
>   		return;
> -	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> -		/* XXX: Handle halt. */
> -		io_region->ret_code =3D -EOPNOTSUPP;
> -		goto err_out;
> -	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> -		/* XXX: Handle clear. */
> -		io_region->ret_code =3D -EOPNOTSUPP;
> -		goto err_out;
>   	}
> -
>   err_out:
>   	private->state =3D VFIO_CCW_STATE_IDLE;
>   }


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
