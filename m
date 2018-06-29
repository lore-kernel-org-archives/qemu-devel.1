Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO0-0008Fp-Us
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrNz-0002Cf-TS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:20 -0400
Received: from foss.arm.com ([217.140.101.70]:39246)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrNz-0002Bo-Mb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:19 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:22 +0100
Message-Id: <1530270944-11351-3-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Subject: [Qemu-devel] [PATCH v3 02/20] virtio: pci-legacy: Validate queue pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydel <peter.maydell@linaro.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Legacy PCI over virtio uses a 32bit PFN for the queue. If the
queue pfn is too large to fit in 32bits, which we could hit on
arm64 systems with 52bit physical addresses (even with 64K page
size), we simply miss out a proper link to the other side of
the queue.

Add a check to validate the PFN, rather than silently breaking
the devices.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydel <peter.maydell@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Change errno to -E2BIG
---
 drivers/virtio/virtio_pci_legacy.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2780886..c0d6987a 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -122,6 +122,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	struct virtqueue *vq;
 	u16 num;
 	int err;
+	u64 q_pfn;
 
 	/* Select the queue we're interested in */
 	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
@@ -141,9 +142,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
+	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
+	if (q_pfn >> 32) {
+		dev_err(&vp_dev->pci_dev->dev, "virtio-pci queue PFN too large\n");
+		err = -E2BIG;
+		goto out_del_vq;
+	}
+
 	/* activate the queue */
-	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
-		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
 
@@ -160,6 +167,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 out_deactivate:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+out_del_vq:
 	vring_del_virtqueue(vq);
 	return ERR_PTR(err);
 }
-- 
2.7.4
