Received: from eggs.gnu.org ([2001:4830:134:3::10]:39589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFldN-0005hi-H4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFldJ-0002kk-Hz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dFldJ-0002jE-Bu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:12:41 -0400
Date: Tue, 30 May 2017 21:12:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170530210905-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170526142858.19931-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170526142858.19931-4-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] vhost: extend ring information
 update for IOTLB to all rings
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

On Fri, May 26, 2017 at 04:28:55PM +0200, Maxime Coquelin wrote:
> Vhost-kernel backend need

needs

> to receive IOTLB entry for used ring
> information early, which is done by triggering a miss event on
> its address.
> 
> This patch extends this behaviour to all rings information, to be
> compatible with vhost-user backend design.

Why does vhost-user need it though?

> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> v2:
>  - Revert back to existing behaviour, i.e. only send IOTLB updates
> at ring enablement time, not at ring address setting time (mst).
>  - Extend IOTLB misses to all ring addresses, not only used ring.
> 
>  hw/virtio/vhost.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6eddb09..7867034 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1552,11 +1552,15 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>      if (vhost_dev_has_iommu(hdev)) {
>          hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
>  
> -        /* Update used ring information for IOTLB to work correctly,
> -         * vhost-kernel code requires for this.*/
> +        /*
> +         * Update rings information for IOTLB to work correctly,
> +         * vhost-kernel and vhost-user codes require for this.

Better just say "Update ring info for vhost iotlb."

The rest isn't really informative.



> +         */
>          for (i = 0; i < hdev->nvqs; ++i) {
>              struct vhost_virtqueue *vq = hdev->vqs + i;
>              vhost_device_iotlb_miss(hdev, vq->used_phys, true);
> +            vhost_device_iotlb_miss(hdev, vq->desc_phys, true);
> +            vhost_device_iotlb_miss(hdev, vq->avail_phys, true);

So I don't remember why does vhost in kernel want miss on used
at start time.

Jason, could you comment on this please?



>          }
>      }
>      return 0;
> -- 
> 2.9.4
