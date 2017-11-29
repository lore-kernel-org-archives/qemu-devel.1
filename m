Received: from eggs.gnu.org ([2001:4830:134:3::10]:59006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK35O-0001ro-C9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK35L-0004Do-Bu
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:52215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eK35L-0003cm-0z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:35 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 29 Nov 2017 21:55:22 +0800
Message-Id: <1511963726-34070-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v18 06/10] virtio_ring: add a new API,
 virtqueue_add_one_desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Current virtqueue_add API implementation is based on the scatterlist
struct, which uses kaddr. This is inadequate to all the use case of
vring. For example:
- Some usages don't use IOMMU, in this case the user can directly pass
  in a physical address in hand, instead of going through the sg
  implementation (e.g. the VIRTIO_BALLOON_F_SG feature)
- Sometimes, a guest physical page may not have a kaddr (e.g. high
  memory) but need to use vring (e.g. the VIRTIO_BALLOON_F_FREE_PAGE_VQ
  feature)

The new API virtqueue_add_one_desc enables the caller to assign a vring
desc with a physical address and len. Also, factor out the common code
with virtqueue_add in vring_set_avail.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 94 +++++++++++++++++++++++++++++++++++---------
 include/linux/virtio.h       |  6 +++
 2 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index eb30f3e..0b87123 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -257,6 +257,79 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 	return desc;
 }
 
+static void vring_set_avail(struct virtqueue *_vq,
+			    unsigned int i)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int avail;
+
+	avail = vq->avail_idx_shadow & (vq->vring.num - 1);
+	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, i);
+
+	/*
+	 * Descriptors and available array need to be set before we expose the
+	 * new available array entries.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->avail_idx_shadow++;
+	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+					       vq->avail_idx_shadow);
+	vq->num_added++;
+
+	pr_debug("Added buffer head %i to %p\n", i, vq);
+
+	/*
+	 * This is very unlikely, but theoretically possible.  Kick
+	 * just in case.
+	 */
+	if (unlikely(vq->num_added == (1 << 16) - 1))
+		virtqueue_kick(_vq);
+}
+
+int virtqueue_add_one_desc(struct virtqueue *_vq,
+			   uint64_t addr,
+			   uint32_t len,
+			   bool in_desc,
+			   void *data)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc *desc;
+	unsigned int i;
+
+	START_USE(vq);
+	BUG_ON(data == NULL);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return -EIO;
+	}
+
+	if (_vq->num_free < 1) {
+		END_USE(vq);
+		return -ENOSPC;
+	}
+
+	i = vq->free_head;
+	desc = &vq->vring.desc[i];
+	desc->addr = cpu_to_virtio64(_vq->vdev, addr);
+	desc->len = cpu_to_virtio32(_vq->vdev, len);
+	if (in_desc)
+		desc->flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_WRITE);
+	else
+		desc->flags = 0;
+	vq->desc_state[i].data = data;
+	vq->desc_state[i].indir_desc = NULL;
+	vq->free_head = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
+	_vq->num_free--;
+
+	vring_set_avail(_vq, i);
+
+	END_USE(vq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_one_desc);
+
 static inline int virtqueue_add(struct virtqueue *_vq,
 				struct scatterlist *sgs[],
 				unsigned int total_sg,
@@ -269,7 +342,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
+	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
 	int head;
 	bool indirect;
 
@@ -395,26 +468,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	else
 		vq->desc_state[head].indir_desc = ctx;
 
-	/* Put entry in available array (but don't update avail->idx until they
-	 * do sync). */
-	avail = vq->avail_idx_shadow & (vq->vring.num - 1);
-	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
-
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
-	vq->avail_idx_shadow++;
-	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
-	vq->num_added++;
-
-	pr_debug("Added buffer head %i to %p\n", head, vq);
+	vring_set_avail(_vq, head);
 	END_USE(vq);
 
-	/* This is very unlikely, but theoretically possible.  Kick
-	 * just in case. */
-	if (unlikely(vq->num_added == (1 << 16) - 1))
-		virtqueue_kick(_vq);
-
 	return 0;
 
 unmap_release:
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 988c735..1d89996 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -35,6 +35,12 @@ struct virtqueue {
 	void *priv;
 };
 
+int virtqueue_add_one_desc(struct virtqueue *_vq,
+			   uint64_t addr,
+			   uint32_t len,
+			   bool in_desc,
+			   void *data);
+
 int virtqueue_add_outbuf(struct virtqueue *vq,
 			 struct scatterlist sg[], unsigned int num,
 			 void *data,
-- 
2.7.4
