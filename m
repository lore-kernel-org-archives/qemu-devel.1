Received: from eggs.gnu.org ([2001:4830:134:3::10]:47362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYxPy-0000FC-I3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYxPw-0008Nd-Lr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fYxPw-0008MJ-GU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:42:44 -0400
Date: Fri, 29 Jun 2018 20:42:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629204213-mutt-send-email-mst@kernel.org>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-3-git-send-email-suzuki.poulose@arm.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/20] virtio: pci-legacy: Validate
 queue pfn
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

On Fri, Jun 29, 2018 at 12:15:22PM +0100, Suzuki K Poulose wrote:
> Legacy PCI over virtio uses a 32bit PFN for the queue. If the
> queue pfn is too large to fit in 32bits, which we could hit on
> arm64 systems with 52bit physical addresses (even with 64K page
> size), we simply miss out a proper link to the other side of
> the queue.
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
>  drivers/virtio/virtio_pci_legacy.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2780886..c0d6987a 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -122,6 +122,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	struct virtqueue *vq;
>  	u16 num;
>  	int err;
> +	u64 q_pfn;
>  
>  	/* Select the queue we're interested in */
>  	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> @@ -141,9 +142,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (!vq)
>  		return ERR_PTR(-ENOMEM);
>  
> +	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> +	if (q_pfn >> 32) {
> +		dev_err(&vp_dev->pci_dev->dev, "virtio-pci queue PFN too large\n");
> +		err = -E2BIG;

Same comment here. Let's make it clear it's host not guest problem.

> +		goto out_del_vq;
> +	}
> +
>  	/* activate the queue */
> -	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> -		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +	iowrite32(q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>  
>  	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
>  
> @@ -160,6 +167,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  
>  out_deactivate:
>  	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +out_del_vq:
>  	vring_del_virtqueue(vq);
>  	return ERR_PTR(err);
>  }
> -- 
> 2.7.4
