Received: from eggs.gnu.org ([2001:4830:134:3::10]:52747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eZwkY-0006Fq-U5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eZwkU-0001CL-7c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:39:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eZwkT-0001BJ-WC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:39:46 -0500
References: <20180112101356.27044-1-zhengxiang9@huawei.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <0d69f912-4370-f227-7b59-cfc9caa39f9b@redhat.com>
Date: Fri, 12 Jan 2018 11:39:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180112101356.27044-1-zhengxiang9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix corrupting GPA 0 when using
 uninitialized queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zheng Xiang <zhengxiang9@huawei.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, pbonzini@redhat.com, zhaoshenglong@huawei.com, christoffer.dall@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>



On 01/12/2018 11:13 AM, Zheng Xiang wrote:
> When guest driver only setup part of queues declared in QEMU, it
> would corrupt guest's physical address 0 when using uninitialized
> queues in vhost_virtqueue_start.
> 
> In AARCH64 virtual machines, the address of system memory starts at
> 0x40000000 and the address of rom starts at 0. So, when using qemu
> with vhost-scsi, it will fail with below error:
> qemu-kvm: Error start vhost dev
> qemu-kvm: unable to start vhost-scsi: Cannot allocate memory
> 
> This patch fix this issue by skipping calling vhost_virtqueue_start
> for uninitialized queues.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
> ---
>   hw/virtio/vhost.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e4290ce..ac79ffd 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1532,6 +1532,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>           goto fail_mem;
>       }
>       for (i = 0; i < hdev->nvqs; ++i) {
> +        if (virtio_queue_get_desc_addr(vdev, hdev->vq_index + i) == 0)
> +            continue;
>           r = vhost_virtqueue_start(hdev,
>                                     vdev,
>                                     hdev->vqs + i,
> 

Thanks, it fixes the silent corruption that happens with vhost-user net
backend and Windows guests, when the number of queues pairs declared in
Qemu is higher than the number of vcpus.

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime
