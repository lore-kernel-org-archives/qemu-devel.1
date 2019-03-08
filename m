Received: from eggs.gnu.org ([209.51.188.92]:36069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h2Np2-0003mQ-7D
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h2Np1-0008Du-65
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:18:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1h2Np0-0008DL-RD
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:18:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x28M9uNn039323
	for <qemu-devel@nongnu.org>; Fri, 8 Mar 2019 17:18:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r3wwj7rvq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 17:18:28 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 8 Mar 2019 22:18:27 -0000
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-3-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 8 Mar 2019 17:18:22 -0500
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2f3cd598-5d95-c1b5-24f8-4de2c454be59@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/6] vfio-ccw: rework ssch state handling
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



On 03/01/2019 04:38 AM, Cornelia Huck wrote:
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
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
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

Coincidentally, I did something AWESOME last night that the chunks 
listed above actually fix.  I have a large channel program, and when it 
runs my host crashes which isn't nice.  First, the callback:

[  547.821235] Call Trace:
[  547.821236] ([<0000000000000000>]           (null))
[  547.821244]  [<000003ff808d8b4a>] cp_prefetch+0x422/0x750 [vfio_ccw]
[  547.821247]  [<000003ff808d9a90>] fsm_io_request+0x1a0/0x2f0 [vfio_ccw]
[  547.821250]  [<000003ff808d90c4>] vfio_ccw_mdev_write+0xc4/0x1d8 
[vfio_ccw]
[  547.821255]  [<0000000000358d8c>] __vfs_write+0x34/0x1a8
[  547.821256]  [<00000000003590d0>] vfs_write+0xa0/0x1d8
[  547.821259]  [<0000000000359572>] ksys_pwrite64+0x8a/0xa8
[  547.821264]  [<0000000000866cf0>] system_call+0x270/0x290
[  547.821264] Last Breaking-Event-Address:
[  547.821267]  [<00000000003325b2>] __kmalloc+0x1c2/0x288

The channel program in question looks like this:

x01 cmd=0b flags=44 count=0006
x02 cmd=02 flags=64 count=07bf
x03 cmd=47 flags=44 count=0010
x04 cmd=49 flags=64 count=049b
x05 cmd=08 flags=00 count=0000 TIC to x04
x06 cmd=0b flags=64 count=0007
x07 cmd=23 flags=44 count=0001
x08 cmd=e4 flags=44 count=0018
x09 cmd=07 flags=44 count=0006
x0a cmd=e4 flags=44 count=0018
x0b cmd=47 flags=64 count=001b
x0c cmd=8e flags=64 count=013a
x0d cmd=9a flags=64 count=0009
x0e cmd=31 flags=4c count=0005
x0f cmd=08 flags=00 count=0000 TIC to x0e
x10 cmd=0d flags=64 count=061b
x11 cmd=07 flags=64 count=000b
x12 cmd=96 flags=64 count=0144
x13 cmd=a9 flags=64 count=0025
x14 cmd=08 flags=00 count=0000 TIC to x13
x15 cmd=05 flags=64 count=0387
x16 cmd=a4 flags=64 count=003e
x17 cmd=e4 flags=44 count=0018
x18 cmd=0b flags=64 count=000a
x19 cmd=96 flags=64 count=0497
x1a cmd=8e flags=64 count=02c3
x1b cmd=29 flags=64 count=01bf
x1c cmd=08 flags=00 count=0000 TIC to x1b
x1d cmd=1b flags=24 count=000a

Debugging it today, I found that we get an intermediate interrupt on CCW 
0x0e, and a final interrupt (well, unit check) on CCW 0x11.  But because 
of the intermediate interrupt, rewinding in cp_prefetch() at label 
out_err fails and we crash.  Whoops!

Recalling the above changes, I applied JUST the above pieces (not the 
remainder of this patch), and the above channel program works fine.  Now 
to figure out why I get a unit check.  :)

  - Eric
