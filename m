Received: from eggs.gnu.org ([209.51.188.92]:52713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gph6E-0001RH-Ah
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gph6C-0006ss-Ue
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gph6C-0006mD-E9
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:48 -0500
Date: Fri, 1 Feb 2019 17:15:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190201170832-mutt-send-email-mst@kernel.org>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
	<1547663480-547-2-git-send-email-wexu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663480-547-2-git-send-email-wexu@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] virtio: introduce packed ring
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com
Cc: tiwei.bie@intel.com, qemu-devel@nongnu.org, jasowang@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

On Wed, Jan 16, 2019 at 01:31:06PM -0500, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
> 
> >From 1.1 spec.
> 
> Signed-off-by: Wei Xu <wexu@redhat.com>

So pls don't open-code this in qemu. These headers should come
from Linux using scripts/update-linux-headers.sh.


> ---
>  include/standard-headers/linux/virtio_config.h | 15 +++++++++
>  include/standard-headers/linux/virtio_ring.h   | 43 ++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
> index 0b19436..9f450fd 100644
> --- a/include/standard-headers/linux/virtio_config.h
> +++ b/include/standard-headers/linux/virtio_config.h
> @@ -75,6 +75,21 @@
>   */
>  #define VIRTIO_F_IOMMU_PLATFORM		33
>  
> +/* This feature indicates support for the packed virtqueue layout. */
> +#define VIRTIO_F_RING_PACKED		34
> +
> +/* Enable events */
> +#define RING_EVENT_FLAGS_ENABLE 0x0
> +/* Disable events */
> +#define RING_EVENT_FLAGS_DISABLE 0x1
> +/*
> + *  * Enable events for a specific descriptor
> + *   * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> + *    * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
> + *     */

Above is formatted very strangely. Prefix RING_ is also probably
not a good one. Linux uses VRING.

> +#define RING_EVENT_FLAGS_DESC 0x2
> +/* The value 0x3 is reserved */
> +
>  /*
>   * Does the device support Single Root I/O Virtualization?
>   */
> diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
> index d26e72b..1719c6f 100644
> --- a/include/standard-headers/linux/virtio_ring.h
> +++ b/include/standard-headers/linux/virtio_ring.h
> @@ -42,6 +42,10 @@
>  /* This means the buffer contains a list of buffer descriptors. */
>  #define VRING_DESC_F_INDIRECT	4
>  
> +/* Mark a descriptor as available or used. */
> +#define VRING_DESC_F_AVAIL	(1ul << 7)
> +#define VRING_DESC_F_USED	(1ul << 15)
> +
>  /* The Host uses this in used->flags to advise the Guest: don't kick me when
>   * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
>   * will still kick if it's out of buffers. */
> @@ -51,6 +55,17 @@
>   * optimization.  */
>  #define VRING_AVAIL_F_NO_INTERRUPT	1
>  
> +/* Enable events. */
> +#define VRING_EVENT_F_ENABLE	0x0
> +/* Disable events. */
> +#define VRING_EVENT_F_DISABLE	0x1
> +/*
> + * Enable events for a specific descriptor
> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> + */
> +#define VRING_EVENT_F_DESC	0x2
> +
>  /* We support indirect buffer descriptors */
>  #define VIRTIO_RING_F_INDIRECT_DESC	28
>  
> @@ -169,4 +184,32 @@ static inline int vring_need_event(uint16_t event_idx, uint16_t new_idx, uint16_
>  	return (uint16_t)(new_idx - event_idx - 1) < (uint16_t)(new_idx - old);
>  }
>  
> +struct vring_packed_desc_event {
> +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> +	__virtio16 off_wrap;
> +	/* Descriptor Ring Change Event Flags. */
> +	__virtio16 flags;
> +};
> +
> +struct vring_packed_desc {
> +	/* Buffer Address. */
> +	__virtio64 addr;
> +	/* Buffer Length. */
> +	__virtio32 len;
> +	/* Buffer ID. */
> +	__virtio16 id;
> +	/* The flags depending on descriptor type. */
> +	__virtio16 flags;
> +};

This seems strange. I don't think this needs __virtio variants -
they are unconditionally LE.

> +
> +struct vring_packed {
> +	unsigned int num;
> +
> +	struct vring_packed_desc *desc;
> +
> +	struct vring_packed_desc_event *driver;
> +
> +	struct vring_packed_desc_event *device;
> +};
> +

I don't know why we have this in the UAPI. I think it's a good idea
to drop it, in Linux as well.

>  #endif /* _LINUX_VIRTIO_RING_H */
> -- 
> 1.8.3.1
