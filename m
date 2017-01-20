Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUcQ4-0001x7-TT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUcQ1-0000dm-TR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:52:09 -0500
Date: Fri, 20 Jan 2017 18:51:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170120185017-mutt-send-email-mst@kernel.org>
References: <1484880649-12600-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484880649-12600-1-git-send-email-zhaoshenglong@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Fix no interrupt when not creating
 msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org, shannon.zhao@linaro.org

On Fri, Jan 20, 2017 at 10:50:49AM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> For ARM virt machine, if we use virt-2.7 which will not create ITS node,
> the virtio-net can not recieve interrupts so it can't get ip address
> through dhcp.
> This fixes commit 83d768b(virtio: set ISR on dataplane notifications).
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  hw/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index aa4f38f..709b718 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2082,6 +2082,7 @@ static void virtio_queue_guest_notifier_read(EventNotifier *n)
>  {
>      VirtQueue *vq = container_of(n, VirtQueue, guest_notifier);
>      if (event_notifier_test_and_clear(n)) {
> +        virtio_set_isr(vq->vdev, 0x1);
>          virtio_notify_vector(vq->vdev, vq->vector);
>      }
>  }

Then you should bring back virtio_irq, to avoid duplicating
code from virtio_notify.



> -- 
> 2.0.4
> 
