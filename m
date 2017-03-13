Received: from eggs.gnu.org ([2001:4830:134:3::10]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnMrE-0001Yx-C1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnMr5-0003aI-JE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:05:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37287
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cnMr5-0003Zz-Cw
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:05:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2DA53k0129359
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:05:30 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 294b216rf5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:05:30 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 13 Mar 2017 10:05:28 -0000
Date: Mon, 13 Mar 2017 11:05:23 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1489386583-11564-2-git-send-email-jasowang@redhat.com>
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
	<1489386583-11564-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170313110523.549e4a99.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH V2 2/3] virtio: destroy region cache during
 reset
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

On Mon, 13 Mar 2017 14:29:42 +0800
Jason Wang <jasowang@redhat.com> wrote:

> We don't destroy region cache during reset which can make the maps
> of previous driver leaked to a buggy or malicious driver that don't
> set vring address before starting to use the device. Fix this by
> destroy the region cache during reset and validate it before trying to
> see them.
> 
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from v1:
> - switch to use rcu in virtio_virtqueue_region_cache()
> - use unlikely() when needed
> ---
>  hw/virtio/virtio.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 76cc81b..f086452 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -190,6 +190,10 @@ static inline uint16_t vring_avail_flags(VirtQueue *vq)
>  {
>      VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
>      hwaddr pa = offsetof(VRingAvail, flags);
> +    if (unlikely(!caches)) {
> +        virtio_error(vq->vdev, "Cannot map avail flags");
> +        return 0;

I'm still not 100% convinced of those checks; but they don't do any
harm.

> +    }
>      return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
>  }
> 

(...)

> +static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
> +{
> +    VRingMemoryRegionCaches *caches;
> +
> +    caches = atomic_read(&vq->vring.caches);
> +    atomic_set(&vq->vring.caches, NULL);

Needs atomic_rcu_set(), I think.

> +    if (caches) {
> +        call_rcu(caches, virtio_free_region_cache, rcu);
> +    }
> +}
> +
>  void virtio_reset(void *opaque)
>  {
>      VirtIODevice *vdev = opaque;
