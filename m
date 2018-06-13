Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT4rt-0001sH-TW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT4rq-00009t-NQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:27:17 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT4rq-00007u-GD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:27:14 -0400
Received: by mail-wm0-f53.google.com with SMTP id v16-v6so4366997wmh.5
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:27:14 -0700 (PDT)
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-3-git-send-email-wexu@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9308fe7-5881-7ea6-de60-b3291abaac35@redhat.com>
Date: Wed, 13 Jun 2018 14:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-3-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/8] virtio: memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com, mst@redhat.com

On 05/06/2018 21:07, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
> 
> Mostly reuse memory cache with 1.0 except for the offset calculation.
> 
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>  hw/virtio/virtio.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e192a9a..f6c0689 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -150,11 +150,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
>      VRingMemoryRegionCaches *old = vq->vring.caches;
>      VRingMemoryRegionCaches *new;
>      hwaddr addr, size;
> -    int event_size;
>      int64_t len;
>  
> -    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> -
>      addr = vq->vring.desc;
>      if (!addr) {
>          return;
> @@ -168,7 +165,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
>          goto err_desc;
>      }
>  
> -    size = virtio_queue_get_used_size(vdev, n) + event_size;
> +    size = virtio_queue_get_used_size(vdev, n);
>      len = address_space_cache_init(&new->used, vdev->dma_as,
>                                     vq->vring.used, size, true);
>      if (len < size) {
> @@ -176,7 +173,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
>          goto err_used;
>      }
>  
> -    size = virtio_queue_get_avail_size(vdev, n) + event_size;
> +    size = virtio_queue_get_avail_size(vdev, n);
>      len = address_space_cache_init(&new->avail, vdev->dma_as,
>                                     vq->vring.avail, size, false);
>      if (len < size) {
> @@ -2320,14 +2317,28 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
>  
>  hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
>  {
> -    return offsetof(VRingAvail, ring) +
> -        sizeof(uint16_t) * vdev->vq[n].vring.num;
> +    int s;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        return sizeof(struct VRingPackedDescEvent);
> +    } else {
> +        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +        return offsetof(VRingAvail, ring) +
> +            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
> +    }
>  }
>  
>  hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
>  {
> -    return offsetof(VRingUsed, ring) +
> -        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
> +    int s;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        return sizeof(struct VRingPackedDescEvent);
> +    } else {
> +        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +        return offsetof(VRingUsed, ring) +
> +            sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
> +    }
>  }
>  
>  uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
