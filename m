Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D6C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451AE20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451AE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B5g-0003gb-DX
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150s-00078z-Sa
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150o-0004Ih-6D
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:51 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhabin@linux.alibaba.com>)
 id 1j150n-0004Ep-Su
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:50 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07417; MF=zhabin@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Tpb7N0C_1581325531; 
Received: from localhost(mailfrom:zhabin@linux.alibaba.com
 fp:SMTPD_---0Tpb7N0C_1581325531) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Feb 2020 17:05:31 +0800
From: Zha Bin <zhabin@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Date: Mon, 10 Feb 2020 17:05:17 +0800
Message-Id: <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
X-Mailman-Approved-At: Mon, 10 Feb 2020 10:31:31 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: virtio-dev@lists.oasis-open.org, zhabin@linux.alibaba.com, slp@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jing2.liu@linux.intel.com,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jiang <gerry@linux.alibaba.com>

The standard virtio-mmio devices use notification register to signal
backend. This will cause vmexits and slow down the performance when we
passthrough the virtio-mmio devices to guest virtual machines.
We proposed to update virtio over MMIO spec to add the per-queue
notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
configure notify location for each queue.

[1] https://lkml.org/lkml/2020/1/21/31

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/virtio/virtio_mmio.c       | 37 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_config.h |  8 +++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725..1733ab97 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -90,6 +90,9 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+
+	unsigned short notify_base;
+	unsigned short notify_multiplier;
 };
 
 struct virtio_mmio_vq_info {
@@ -98,6 +101,9 @@ struct virtio_mmio_vq_info {
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
+
+	/* Notify Address*/
+	unsigned int notify_addr;
 };
 
 
@@ -119,13 +125,23 @@ static u64 vm_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+static void vm_transport_features(struct virtio_device *vdev, u64 features)
+{
+	if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
+		__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
+}
+
 static int vm_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_mmio a chance to accept features. */
+	vm_transport_features(vdev, features);
+
 	/* Make sure there is are no mixed devices */
 	if (vm_dev->version == 2 &&
 			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
@@ -272,10 +288,13 @@ static void vm_reset(struct virtio_device *vdev)
 static bool vm_notify(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
+	struct virtio_mmio_vq_info *info = vq->priv;
 
-	/* We write the queue's selector into the notification register to
+	/* We write the queue's selector into the Notify Address to
 	 * signal the other end */
-	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	if (info)
+		writel(vq->index, vm_dev->base + info->notify_addr);
+
 	return true;
 }
 
@@ -434,6 +453,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	vq->priv = info;
 	info->vq = vq;
 
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION))
+		info->notify_addr = vm_dev->notify_base +
+				vm_dev->notify_multiplier * vq->index;
+	else
+		info->notify_addr = VIRTIO_MMIO_QUEUE_NOTIFY;
+
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_add(&info->node, &vm_dev->virtqueues);
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
@@ -471,6 +496,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return irq;
 	}
 
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
+		unsigned int notify = readl(vm_dev->base +
+				VIRTIO_MMIO_QUEUE_NOTIFY);
+
+		vm_dev->notify_base = notify & 0xffff;
+		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;
+	}
+
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
 	if (err)
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index ff8e7dc..5d93c01 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		38
+#define VIRTIO_TRANSPORT_F_END		40
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -88,4 +88,10 @@
  * Does the device support Single Root I/O Virtualization?
  */
 #define VIRTIO_F_SR_IOV			37
+
+/*
+ * This feature indicates the enhanced notification support on MMIO transport
+ * layer.
+ */
+#define VIRTIO_F_MMIO_NOTIFICATION	39
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
1.8.3.1


