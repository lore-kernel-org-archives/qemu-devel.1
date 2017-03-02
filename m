Received: from eggs.gnu.org ([2001:4830:134:3::10]:38317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjS3C-0003ZD-PI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjS37-00025z-TI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:49:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33129
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cjS37-00025R-NV
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:49:45 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22EmUjK057692
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 09:49:44 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xkx7549x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 09:49:44 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 2 Mar 2017 14:49:42 -0000
Date: Thu, 2 Mar 2017 15:49:35 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

On Thu,  2 Mar 2017 14:04:22 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> index 5556f0e..13dd14d 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -258,9 +258,16 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>          virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
>      }
> 
> -    /* Drain and switch bs back to the QEMU main loop */
> +    /* Drain and switch bs back to the QEMU main loop. After drain, the
> +     * device will not submit (nor comple) any requests until dataplane

s/comple/complete/

> +     * starts again.
> +     */
>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
> 
> +    /* Notify guest before the guest notifiers get cleaned up */
> +    qemu_bh_cancel(s->bh);
> +    notify_guest_bh(s);
> +

Hm... does virtio-scsi dataplane need a similar treatment? Or am I
missing something?

>      aio_context_release(s->ctx);
> 
>      for (i = 0; i < nvqs; i++) {
