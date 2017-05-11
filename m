Received: from eggs.gnu.org ([2001:4830:134:3::10]:40242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8rxl-00065j-AB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8rxi-0000U2-Un
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:33:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8rxi-0000TG-MR
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:33:14 -0400
Date: Thu, 11 May 2017 20:33:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170511202154-mutt-send-email-mst@kernel.org>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511123246.31308-4-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost: Update rings information for
 IOTLB earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Thu, May 11, 2017 at 02:32:43PM +0200, Maxime Coquelin wrote:
> Vhost-kernel backend need to receive IOTLB entries for rings
> information early, but vhost-user need the same information
> earlier, before VHOST_USER_SET_VRING_ADDR is sent.

Weird. What does VHOST_USER_SET_VRING_ADDR have to do with it?

According to
	Starting and stopping rings
in vhost user spec, vhost user does not access
anything until ring is started and enabled.


> This patch also trigger IOTLB miss for all rings informations
> for robustness, even if in practice these adresses are on the
> same page.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  hw/virtio/vhost.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 748e331..817f6d0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -799,7 +799,17 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>          .log_guest_addr = vq->used_phys,
>          .flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
>      };
> -    int r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> +    int r;
> +
> +    /* Update rings information for IOTLB to work correctly,
> +     * vhost-kernel & vhost-user backends require for this.*/

Any requirements must be in the spec. Pls add them there.
Pls fix comment style as you move code.


> +    if (vhost_dev_has_iommu(dev)) {
> +        vhost_device_iotlb_miss(dev, addr.desc_user_addr, true);
> +        vhost_device_iotlb_miss(dev, addr.used_user_addr, true);
> +        vhost_device_iotlb_miss(dev, addr.avail_user_addr, true);
> +    }
> +
> +    r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
>      if (r < 0) {
>          VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
>          return -errno;
> @@ -1551,13 +1561,6 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>  
>      if (vhost_dev_has_iommu(hdev)) {
>          hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> -
> -        /* Update used ring information for IOTLB to work correctly,
> -         * vhost-kernel code requires for this.*/
> -        for (i = 0; i < hdev->nvqs; ++i) {
> -            struct vhost_virtqueue *vq = hdev->vqs + i;
> -            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
> -        }
>      }
>      return 0;
>  fail_log:
> -- 
> 2.9.3
