Received: from eggs.gnu.org ([2001:4830:134:3::10]:44094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnMhK-0005uU-Bj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnMhH-0006VO-A8
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:55:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49721
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cnMhH-0006UO-3b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:55:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2D9qtJE098050
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:55:21 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 294b216bp8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:55:21 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 13 Mar 2017 09:55:20 -0000
Date: Mon, 13 Mar 2017 10:55:15 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170313105515.75981fb9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH V2 1/3] virtio: guard against NULL pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 13 Mar 2017 14:29:41 +0800
Jason Wang <jasowang@redhat.com> wrote:

> To avoid access stale memory region cache after reset, this patch
> check the existence of virtqueue pfn for all exported virtqueue access
> helpers before trying to use them.
> 
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index efce4b3..76cc81b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -322,6 +322,10 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
>          return 0;
>      }
> 
> +    if (unlikely(!vq->vring.avail)) {
> +        return 0;

Shouldn't that rather return !0 (denoting a non-existing queue as
empty)?

> +    }
> +
>      return vring_avail_idx(vq) == vq->last_avail_idx;
>  }
> 
> @@ -333,6 +337,10 @@ int virtio_queue_empty(VirtQueue *vq)
>          return 0;
>      }
> 
> +    if (unlikely(!vq->vring.avail)) {
> +        return 0;

Likewise.

> +    }
> +
>      rcu_read_lock();
>      empty = vring_avail_idx(vq) == vq->last_avail_idx;
>      rcu_read_unlock();
> @@ -431,6 +439,10 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
>          return;
>      }
> 
> +    if (unlikely(!vq->vring.used)) {
> +        return;
> +    }
> +
>      idx = (idx + vq->used_idx) % vq->vring.num;
> 
>      uelem.id = elem->index;
> @@ -448,6 +460,10 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
>          return;
>      }
> 
> +    if (unlikely(!vq->vring.used)) {
> +        return;
> +    }
> +
>      /* Make sure buffer is written before we update index. */
>      smp_wmb();
>      trace_virtqueue_flush(vq, count);
> @@ -546,6 +562,11 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>      int64_t len = 0;
>      int rc;
> 
> +    if (unlikely(!vq->vring.desc)) {
> +        *in_bytes = *out_bytes = 0;

I think you need to check for in_bytes and out_bytes being !NULL first.

> +        return;
> +    }
> +
>      rcu_read_lock();
>      idx = vq->last_avail_idx;
>      total_bufs = in_total = out_total = 0;
