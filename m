Received: from eggs.gnu.org ([2001:4830:134:3::10]:36077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fe0jq-0008FI-1x
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fe0je-0008M3-VC
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:16:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fe0je-0008Kw-NI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:15:58 -0400
Date: Fri, 13 Jul 2018 19:15:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180713191451-mutt-send-email-mst@kernel.org>
References: <1531490645-10989-1-git-send-email-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531490645-10989-1-git-send-email-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru, Jia He <hejianet@gmail.com>

On Fri, Jul 13, 2018 at 05:04:05PM +0300, Yury Kotov wrote:
> virtio_queue_get_desc_addr returns 64-bit hwaddr while int is usually 32-bit.
> If returned hwaddr is not equal to 0 but least-significant 32 bits are
> equal to 0 then this code will not actually stop running queue.
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

So IIUC

Fixes: fb20fbb764aa1 ("vhost: avoid to start/stop virtqueue which is not ready")
And 
Cc: qemu-stable@nongnu.org

> ---
>  hw/virtio/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index b129cb9..7edeee7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1071,10 +1071,8 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>          .index = vhost_vq_index,
>      };
>      int r;
> -    int a;
>  
> -    a = virtio_queue_get_desc_addr(vdev, idx);
> -    if (a == 0) {
> +    if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return;
>      }
> -- 
> 2.7.4
