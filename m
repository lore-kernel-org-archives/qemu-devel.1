Received: from eggs.gnu.org ([2001:4830:134:3::10]:41698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQCrs-0008Pm-0o
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQCrn-0005Kw-T0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:23:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQCrn-0005Kc-Oo
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:23:19 -0400
Date: Tue, 5 Jun 2018 17:23:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605172222-mutt-send-email-mst@kernel.org>
References: <1528206970-4815-1-git-send-email-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528206970-4815-1-git-send-email-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-blk: start vhost when guest
 kicks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: stefanha@redhat.com, changpeng.liu@intel.com, qemu-devel@nongnu.org, chaiwen@baidu.com, nixun@baidu.com

On Tue, Jun 05, 2018 at 09:56:10PM +0800, Yongji Xie wrote:
> Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
> kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This would cause
> that those old guests fail to boot with vhost-user-blk device.
> 
> To fix it, start vhost when guest kicks instead of waiting for .set_status().
> 
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> Signed-off-by: Chai Wen <chaiwen@baidu.com>
> Signed-off-by: Ni Xun <nixun@baidu.com>

Can we at least limit this to when virtio 1.0 has not
been negotiated?

> ---
>  hw/block/vhost-user-blk.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index d755223..8fd0e6f 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -217,7 +217,27 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>  
>  static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    int i;
>  
> +    if (s->dev.started) {
> +        return;
> +    }
> +
> +    /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
> +     * vhost here instead of waiting for .set_status().
> +     */
> +    vhost_user_blk_start(vdev);
> +
> +    /* Kick right away to begin processing requests already in vring */
> +    for (i = 0; i < s->dev.nvqs; i++) {
> +        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
> +
> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
> +            continue;
> +        }
> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
> +    }
>  }
>  
>  static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> -- 
> 1.7.9.5
