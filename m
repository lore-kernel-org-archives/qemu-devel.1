Received: from eggs.gnu.org ([209.51.188.92]:33512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gotMz-0004wG-Df
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gotMy-0002ua-Ge
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:09:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gotMx-0002rB-DI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:09:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UGxRoC004408
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:09:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qbfv4rsp7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:09:40 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 30 Jan 2019 17:09:38 -0000
Date: Wed, 30 Jan 2019 18:09:31 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190130132212.7376-7-cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-7-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190130180931.4fd4b6a9@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v3 6/6] vfio-ccw: add handling for async
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 30 Jan 2019 14:22:12 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> +static void fsm_async_retry(struct vfio_ccw_private *private,
> +			    enum vfio_ccw_event event)
> +{
> +	private->cmd_region->ret_code = -EAGAIN;
> +}
> +

This is essentially dead code at the moment, isn't it? I mean we hold the
io_mutex whenever we are in state VFIO_CCW_STATE_CP_PROCESSING, and we
call vfio_ccw_fsm_event() with the very same mutex held.

> @@ -213,26 +323,31 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	[VFIO_CCW_STATE_NOT_OPER] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>  	},
>  	[VFIO_CCW_STATE_STANDBY] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
>  	[VFIO_CCW_STATE_IDLE] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_request,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
>  	[VFIO_CCW_STATE_CP_PROCESSING] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_retry,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_retry,

Used here.

Regards,
Halil

>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
