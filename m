Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZGFO-0001vv-5Y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZGFJ-0000ox-EL
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eZGFJ-0000o9-85
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:16:45 -0500
Date: Wed, 10 Jan 2018 14:16:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180110141638.27d11941@redhat.com>
In-Reply-To: <1515516013-16604-2-git-send-email-jianjay.zhou@huawei.com>
References: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
	<1515516013-16604-2-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/4] vhost: fix memslot limit check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, mst@redhat.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com

On Wed, 10 Jan 2018 00:40:12 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

> Since used_memslots will be updated to the actual value after
> registering memory listener for the first time, move the
> memslots limit checking to the right place.
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/virtio/vhost.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e4290ce..69b3599 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1251,13 +1251,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>          goto fail;
>      }
>  
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> -        error_report("vhost backend memory slots limit is less"
> -                " than current number of present memory slots");
> -        r = -1;
> -        goto fail;
> -    }
> -
>      r = hdev->vhost_ops->vhost_set_owner(hdev);
>      if (r < 0) {
>          VHOST_OPS_DEBUG("vhost_set_owner failed");
> @@ -1339,6 +1332,18 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      hdev->memory_changed = false;
>      memory_listener_register(&hdev->memory_listener, &address_space_memory);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> +
> +    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +        error_report("vhost backend memory slots limit is less"
> +                " than current number of present memory slots");
> +        r = -1;
> +        if (busyloop_timeout) {
> +            goto fail_busyloop;
> +        } else {
> +            goto fail;
> +        }
> +    }
> +
>      return 0;
>  
>  fail_busyloop:
