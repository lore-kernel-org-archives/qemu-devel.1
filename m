Received: from eggs.gnu.org ([2001:4830:134:3::10]:38447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dVTiH-0000W6-2t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 22:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dVTiC-0004sv-8z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 22:18:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dVTiB-0004n1-Tk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 22:18:40 -0400
Message-ID: <5966D866.3010700@huawei.com>
Date: Thu, 13 Jul 2017 10:18:14 +0800
From: wanghaibin <wanghaibin.wang@huawei.com>
MIME-Version: 1.0
References: <20170710070432.856-1-kraxel@redhat.com>
In-Reply-To: <20170710070432.856-1-kraxel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: skip update cursor in
 post_load if we don't have one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 2017/7/10 15:04, Gerd Hoffmann wrote:

> If the cursor resource id isn't set the guest didn't define a cursor.
> Skip the cursor update in post_load in that that case.
> 
> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


It's work!!

Tested-by: wanghaibin <wanghaibin.wang@huawei.com>

Thanks.

> ---
>  hw/display/virtio-gpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 58dc0b2737..eef11083d7 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1092,7 +1092,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>  
>          dpy_gfx_replace_surface(scanout->con, scanout->ds);
>          dpy_gfx_update(scanout->con, 0, 0, scanout->width, scanout->height);
> -        update_cursor(g, &scanout->cursor);
> +        if (scanout->cursor.resource_id) {
> +            update_cursor(g, &scanout->cursor);
> +        }
>          res->scanout_bitmask |= (1 << i);
>      }
>  
