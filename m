Received: from eggs.gnu.org ([2001:4830:134:3::10]:47189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYxPN-0005RE-Im
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYxPK-0006UN-Db
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fYxPK-0006TX-6T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:06 -0400
Date: Fri, 29 Jun 2018 20:42:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629200816-mutt-send-email-mst@kernel.org>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/20] virtio: mmio-v1: Validate queue
 PFN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Peter Maydel <peter.maydell@linaro.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

On Fri, Jun 29, 2018 at 12:15:21PM +0100, Suzuki K Poulose wrote:
> virtio-mmio with virtio-v1 uses a 32bit PFN for the queue.
> If the queue pfn is too large to fit in 32bits, which
> we could hit on arm64 systems with 52bit physical addresses
> (even with 64K page size), we simply miss out a proper link
> to the other side of the queue.
> 
> Add a check to validate the PFN, rather than silently breaking
> the devices.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Peter Maydel <peter.maydell@linaro.org>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Change errno to -E2BIG
> ---
>  drivers/virtio/virtio_mmio.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 67763d3..82cedc8 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -397,9 +397,21 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	/* Activate the queue */
>  	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
>  	if (vm_dev->version == 1) {
> +		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
> +
> +		/*
> +		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
> +		 * that doesn't fit in 32bit, fail the setup rather than
> +		 * pretending to be successful.
> +		 */
> +		if (q_pfn >> 32) {
> +			dev_err(&vdev->dev, "virtio-mmio: queue address too large\n");

How about:
	"hypervisor bug: legacy virtio-mmio must not be used with more than 0x%llx Gigabytes of memory",
	0x1ULL << (32 - 30) << PAGE_SHIFT

> +			err = -E2BIG;
> +			goto error_bad_pfn;
> +		}
> +
>  		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> -		writel(virtqueue_get_desc_addr(vq) >> PAGE_SHIFT,
> -				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
>  	} else {
>  		u64 addr;
>  
> @@ -430,6 +442,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	return vq;
>  
> +error_bad_pfn:
> +	vring_del_virtqueue(vq);
>  error_new_virtqueue:
>  	if (vm_dev->version == 1) {
>  		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> -- 
> 2.7.4
