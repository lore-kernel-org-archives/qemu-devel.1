Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635BC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A2220715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B3i-000832-U6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j151U-0007JX-VJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j151O-0004jW-HF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:06:32 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhabin@linux.alibaba.com>)
 id 1j151O-0004hT-1y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:06:26 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07488; MF=zhabin@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0TpZzdpy_1581325533; 
Received: from localhost(mailfrom:zhabin@linux.alibaba.com
 fp:SMTPD_---0TpZzdpy_1581325533) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Feb 2020 17:05:33 +0800
From: Zha Bin <zhabin@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] virtio-mmio: add MSI interrupt feature support
Date: Mon, 10 Feb 2020 17:05:20 +0800
Message-Id: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
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

Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
virtio over mmio devices as a lightweight machine model for modern
cloud. The standard virtio over MMIO transport layer only supports one
legacy interrupt, which is much heavier than virtio over PCI transport
layer using MSI. Legacy interrupt has long work path and causes specific
VMExits in following cases, which would considerably slow down the
performance:

1) read interrupt status register
2) update interrupt status register
3) write IOAPIC EOI register

We proposed to add MSI support for virtio over MMIO via new feature
bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.

With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
uses msi_sharing[1] to indicate the event and vector mapping.
Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
Bit 1 is 1: device uses sharing mode and dynamic mapping.

[1] https://lkml.org/lkml/2020/1/21/31

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/virtio/virtio_mmio.c        | 299 ++++++++++++++++++++++++++++++++++--
 drivers/virtio/virtio_mmio_common.h |   8 +
 drivers/virtio/virtio_mmio_msi.h    |  82 ++++++++++
 include/uapi/linux/virtio_config.h  |   7 +-
 include/uapi/linux/virtio_mmio.h    |  31 ++++
 5 files changed, 411 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 41e1c93..b24ce21 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -67,8 +67,7 @@
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 #include "virtio_mmio_common.h"
-
-
+#include "virtio_mmio_msi.h"
 
 /* The alignment to use between consumer and producer parts of vring.
  * Currently hardcoded to the page size. */
@@ -85,9 +84,13 @@ struct virtio_mmio_vq_info {
 
 	/* Notify Address*/
 	unsigned int notify_addr;
-};
 
+	/* MSI vector (or none) */
+	unsigned int msi_vector;
+};
 
+static void vm_free_msi_irqs(struct virtio_device *vdev);
+static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs);
 
 /* Configuration interface */
 
@@ -110,6 +113,9 @@ static void vm_transport_features(struct virtio_device *vdev, u64 features)
 {
 	if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
 		__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
+
+	if (features & BIT_ULL(VIRTIO_F_MMIO_MSI))
+		__virtio_set_bit(vdev, VIRTIO_F_MMIO_MSI);
 }
 
 static int vm_finalize_features(struct virtio_device *vdev)
@@ -307,7 +313,33 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	return ret;
 }
 
+static irqreturn_t vm_vring_interrupt(int irq, void *opaque)
+{
+	struct virtio_mmio_device *vm_dev = opaque;
+	struct virtio_mmio_vq_info *info;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vm_dev->lock, flags);
+	list_for_each_entry(info, &vm_dev->virtqueues, node) {
+		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
+			ret = IRQ_HANDLED;
+	}
+	spin_unlock_irqrestore(&vm_dev->lock, flags);
+
+	return ret;
+}
+
+
+/* Handle a configuration change */
+static irqreturn_t vm_config_changed(int irq, void *opaque)
+{
+	struct virtio_mmio_device *vm_dev = opaque;
+
+	virtio_config_changed(&vm_dev->vdev);
 
+	return IRQ_HANDLED;
+}
 
 static void vm_del_vq(struct virtqueue *vq)
 {
@@ -316,6 +348,15 @@ static void vm_del_vq(struct virtqueue *vq)
 	unsigned long flags;
 	unsigned int index = vq->index;
 
+	if (vm_dev->msi_enabled && !vm_dev->msi_share) {
+		if (info->msi_vector != VIRTIO_MMIO_MSI_NO_VECTOR) {
+			int irq = mmio_msi_irq_vector(&vq->vdev->dev,
+					info->msi_vector);
+
+			free_irq(irq, vq);
+		}
+	}
+
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
@@ -334,20 +375,56 @@ static void vm_del_vq(struct virtqueue *vq)
 	kfree(info);
 }
 
-static void vm_del_vqs(struct virtio_device *vdev)
+static void vm_free_irqs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+
+	if (vm_dev->msi_enabled)
+		vm_free_msi_irqs(vdev);
+	else
+		free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+}
+
+static void vm_del_vqs(struct virtio_device *vdev)
+{
 	struct virtqueue *vq, *n;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vm_del_vq(vq);
 
-	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+	vm_free_irqs(vdev);
+}
+
+static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_dev,
+					int enable)
+{
+	u32 state;
+
+	state = readl(vm_dev->base + VIRTIO_MMIO_MSI_STATE);
+	if (enable && (state & VIRTIO_MMIO_MSI_ENABLED_MASK))
+		return;
+
+	writel(VIRTIO_MMIO_MSI_CMD_ENABLE,
+		vm_dev->base + VIRTIO_MMIO_MSI_COMMAND);
+}
+
+static void mmio_msi_config_vector(struct virtio_mmio_device *vm_dev, u32 vec)
+{
+	writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
+	writel(VIRTIO_MMIO_MSI_CMD_MAP_CONFIG, vm_dev->base +
+			VIRTIO_MMIO_MSI_COMMAND);
+}
+
+static void mmio_msi_queue_vector(struct virtio_mmio_device *vm_dev, u32 vec)
+{
+	writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
+	writel(VIRTIO_MMIO_MSI_CMD_MAP_QUEUE, vm_dev->base +
+			VIRTIO_MMIO_MSI_COMMAND);
 }
 
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
-				  const char *name, bool ctx)
+				  const char *name, bool ctx, u32 msi_vector)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtio_mmio_vq_info *info;
@@ -440,6 +517,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	else
 		info->notify_addr = VIRTIO_MMIO_QUEUE_NOTIFY;
 
+	info->msi_vector = msi_vector;
+	/* Set queue event and vector mapping for MSI share mode. */
+	if (vm_dev->msi_share && msi_vector != VIRTIO_MMIO_MSI_NO_VECTOR)
+		mmio_msi_queue_vector(vm_dev, msi_vector);
+
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_add(&info->node, &vm_dev->virtqueues);
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
@@ -461,12 +543,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	return ERR_PTR(err);
 }
 
-static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char * const names[],
-		       const bool *ctx,
-		       struct irq_affinity *desc)
+static int vm_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char * const names[],
+			const bool *ctx)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	int irq = platform_get_irq(vm_dev->pdev, 0);
@@ -487,8 +568,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
-	if (err)
-		return err;
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
@@ -497,14 +576,202 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		}
 
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false);
+				     ctx ? ctx[i] : false,
+				     VIRTIO_MMIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
 			return PTR_ERR(vqs[i]);
 		}
 	}
 
+	return err;
+}
+
+static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[], vq_callback_t *callbacks[],
+			const char * const names[], bool per_vq_vectors,
+			const bool *ctx, struct irq_affinity *desc)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int i, err, allocated_vectors, nvectors;
+	u32 msi_vec;
+	u32 max_vec_num = readl(vm_dev->base + VIRTIO_MMIO_MSI_VEC_NUM);
+
+	/* For MSI non-sharing, the max vector number MUST greater than nvqs.
+	 * Otherwise, go back to legacy interrupt.
+	 */
+	if (per_vq_vectors && max_vec_num < (nvqs + 1))
+		return -EINVAL;
+
+	if (per_vq_vectors) {
+		nvectors = 1;
+		for (i = 0; i < nvqs; ++i)
+			if (callbacks[i])
+				++nvectors;
+	} else {
+		nvectors = 2;
+	}
+
+	vm_dev->msi_share = !per_vq_vectors;
+
+	/* Allocate nvqs irqs for queues and one irq for configuration */
+	err = vm_request_msi_vectors(vdev, nvectors);
+	if (err != 0)
+		return err;
+
+	allocated_vectors = vm_dev->msi_used_vectors;
+	for (i = 0; i < nvqs; i++) {
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+		if (!callbacks[i])
+			msi_vec = VIRTIO_MMIO_MSI_NO_VECTOR;
+		else if (per_vq_vectors)
+			msi_vec = allocated_vectors++;
+		else
+			msi_vec = 1;
+		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
+				ctx ? ctx[i] : false, msi_vec);
+		if (IS_ERR(vqs[i])) {
+			err = PTR_ERR(vqs[i]);
+			goto error_find;
+		}
+
+		if (!per_vq_vectors ||
+				msi_vec == VIRTIO_MMIO_MSI_NO_VECTOR)
+			continue;
+
+		/* allocate per-vq irq if available and necessary */
+		snprintf(vm_dev->vm_vq_names[msi_vec],
+			sizeof(*vm_dev->vm_vq_names),
+			"%s-%s",
+			dev_name(&vm_dev->vdev.dev), names[i]);
+		err = request_irq(mmio_msi_irq_vector(&vqs[i]->vdev->dev,
+					msi_vec),
+				vring_interrupt, 0,
+				vm_dev->vm_vq_names[msi_vec], vqs[i]);
+
+		if (err)
+			goto error_find;
+	}
+
 	return 0;
+
+error_find:
+	vm_del_vqs(vdev);
+	return err;
+}
+
+static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+		       struct virtqueue *vqs[],
+		       vq_callback_t *callbacks[],
+		       const char * const names[],
+		       const bool *ctx,
+		       struct irq_affinity *desc)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int err;
+
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
+		unsigned int notify = readl(vm_dev->base +
+				VIRTIO_MMIO_QUEUE_NOTIFY);
+
+		vm_dev->notify_base = notify & 0xffff;
+		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;
+	}
+
+	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_MSI)) {
+		bool dyn_mapping = !!(readl(vm_dev->base +
+					VIRTIO_MMIO_MSI_STATE) &
+				VIRTIO_MMIO_MSI_SHARING_MASK);
+		if (!dyn_mapping)
+			err = vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
+				names, true, ctx, desc);
+		else
+			err = vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
+				names, false, ctx, desc);
+		if (!err)
+			return 0;
+	}
+
+	return vm_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
+}
+
+static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	unsigned int v;
+	int irq, err;
+
+	if (vm_dev->msi_enabled)
+		return -EINVAL;
+
+	vm_dev->vm_vq_names = kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_names),
+					GFP_KERNEL);
+	if (!vm_dev->vm_vq_names)
+		return -ENOMEM;
+
+	mmio_get_msi_domain(vdev);
+	err = mmio_msi_domain_alloc_irqs(&vdev->dev, nirqs);
+	if (err) {
+		kfree(vm_dev->vm_vq_names);
+		vm_dev->vm_vq_names = NULL;
+		return err;
+	}
+
+	mmio_msi_set_enable(vm_dev, 1);
+	vm_dev->msi_enabled = true;
+
+	v = vm_dev->msi_used_vectors;
+	/* The first MSI vector is used for configuration change event. */
+	snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
+			"%s-config", dev_name(&vdev->dev));
+	irq = mmio_msi_irq_vector(&vdev->dev, v);
+	err = request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[v],
+			vm_dev);
+	if (err)
+		goto error_request_irq;
+
+	/* Set the configuration event mapping. */
+	if (vm_dev->msi_share)
+		mmio_msi_config_vector(vm_dev, v);
+
+	++vm_dev->msi_used_vectors;
+
+	if (vm_dev->msi_share) {
+		v = vm_dev->msi_used_vectors;
+		snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
+			 "%s-virtqueues", dev_name(&vm_dev->vdev.dev));
+		err = request_irq(mmio_msi_irq_vector(&vdev->dev, v),
+				  vm_vring_interrupt, 0, vm_dev->vm_vq_names[v],
+				  vm_dev);
+		if (err)
+			goto error_request_irq;
+		++vm_dev->msi_used_vectors;
+	}
+
+	return 0;
+
+error_request_irq:
+	vm_free_msi_irqs(vdev);
+
+	return err;
+}
+
+static void vm_free_msi_irqs(struct virtio_device *vdev)
+{
+	int i;
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+
+	mmio_msi_set_enable(vm_dev, 0);
+	for (i = 0; i < vm_dev->msi_used_vectors; i++)
+		free_irq(mmio_msi_irq_vector(&vdev->dev, i), vm_dev);
+	mmio_msi_domain_free_irqs(&vdev->dev);
+	kfree(vm_dev->vm_vq_names);
+	vm_dev->vm_vq_names = NULL;
+	vm_dev->msi_enabled = false;
+	vm_dev->msi_used_vectors = 0;
 }
 
 static const char *vm_bus_name(struct virtio_device *vdev)
@@ -609,6 +876,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vm_dev);
 
+	mmio_msi_create_irq_domain();
+
 	rc = register_virtio_device(&vm_dev->vdev);
 	if (rc)
 		put_device(&vm_dev->vdev.dev);
diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
index 90cb304..ccf6320 100644
--- a/drivers/virtio/virtio_mmio_common.h
+++ b/drivers/virtio/virtio_mmio_common.h
@@ -26,6 +26,14 @@ struct virtio_mmio_device {
 
 	unsigned short notify_base;
 	unsigned short notify_multiplier;
+
+	/* Name strings for interrupts. This size should be enough. */
+	char (*vm_vq_names)[256];
+
+	/* used vectors */
+	unsigned int msi_used_vectors;
+	bool msi_share;
+	bool msi_enabled;
 };
 
 #endif
diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmio_msi.h
index 27cb2af..10038cb 100644
--- a/drivers/virtio/virtio_mmio_msi.h
+++ b/drivers/virtio/virtio_mmio_msi.h
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/platform_device.h>
+#include "virtio_mmio_common.h"
 
 static irq_hw_number_t mmio_msi_hwirq;
 static struct irq_domain *mmio_msi_domain;
@@ -21,12 +22,41 @@ void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 }
 
+static void __iomem *vm_dev_base(struct msi_desc *desc)
+{
+	if (desc) {
+		struct device *dev = desc->dev;
+		struct virtio_device *vdev = dev_to_virtio(dev);
+		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+
+		return vm_dev->base;
+	}
+
+	return NULL;
+}
+
+static void mmio_msi_set_mask_bit(struct irq_data *data, u32 flag)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	void __iomem *base = vm_dev_base(desc);
+	unsigned int offset = data->irq - desc->irq;
+
+	if (base) {
+		u32 op = flag ? VIRTIO_MMIO_MSI_CMD_MASK :
+			VIRTIO_MMIO_MSI_CMD_UNMASK;
+		writel(offset, base + VIRTIO_MMIO_MSI_VEC_SEL);
+		writel(op, base + VIRTIO_MMIO_MSI_COMMAND);
+	}
+}
+
 static void mmio_msi_mask_irq(struct irq_data *data)
 {
+	mmio_msi_set_mask_bit(data, 1);
 }
 
 static void mmio_msi_unmask_irq(struct irq_data *data)
 {
+	mmio_msi_set_mask_bit(data, 0);
 }
 
 static struct irq_chip mmio_msi_controller = {
@@ -86,8 +116,60 @@ static inline void mmio_msi_create_irq_domain(void)
 		irq_domain_free_fwnode(fn);
 	}
 }
+
+static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	void __iomem *base = vm_dev_base(desc);
+
+	if (base) {
+		writel(desc->platform.msi_index, base +
+				VIRTIO_MMIO_MSI_VEC_SEL);
+		writel(msg->address_lo, base + VIRTIO_MMIO_MSI_ADDRESS_LOW);
+		writel(msg->address_hi, base + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
+		writel(msg->data, base + VIRTIO_MMIO_MSI_DATA);
+		writel(VIRTIO_MMIO_MSI_CMD_CONFIGURE,
+			base + VIRTIO_MMIO_MSI_COMMAND);
+	}
+}
+
+static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
+				unsigned int nvec)
+{
+	return platform_msi_domain_alloc_irqs(dev, nvec,
+			mmio_write_msi_msg);
+}
+
+static inline void mmio_msi_domain_free_irqs(struct device *dev)
+{
+	return platform_msi_domain_free_irqs(dev);
+}
+
+static inline void mmio_get_msi_domain(struct virtio_device *vdev)
+{
+	if (!vdev->dev.msi_domain)
+		vdev->dev.msi_domain = mmio_msi_domain;
+}
+
+static inline int mmio_msi_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct msi_desc *entry = first_msi_entry(dev);
+
+	return entry->irq + nr;
+}
+
 #else
 static inline void mmio_msi_create_irq_domain(void) {}
+static inline int mmio_msi_irq_vector(struct device *dev, unsigned int nr)
+{
+	return -EINVAL;
+}
+static inline void mmio_get_msi_domain(struct virtio_device *vdev) {}
+static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
+				unsigned int nvec)
+{
+	return -EINVAL;
+}
+static inline void mmio_msi_domain_free_irqs(struct device *dev) {}
 #endif
 
 #endif
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 5d93c01..5eb3900 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		40
+#define VIRTIO_TRANSPORT_F_END		41
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -94,4 +94,9 @@
  * layer.
  */
 #define VIRTIO_F_MMIO_NOTIFICATION	39
+
+/*
+ * This feature indicates the MSI support on MMIO layer.
+ */
+#define VIRTIO_F_MMIO_MSI		40
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
index c4b0968..777cb0e 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -122,6 +122,21 @@
 #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
 #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
 
+/* MSI max vector number that device supports - Read Only */
+#define VIRTIO_MMIO_MSI_VEC_NUM		0x0c0
+/* MSI state register  - Read Only */
+#define VIRTIO_MMIO_MSI_STATE		0x0c4
+/* MSI command register - Write Only */
+#define VIRTIO_MMIO_MSI_COMMAND		0x0c8
+/* MSI vector selector  - Write Only */
+#define VIRTIO_MMIO_MSI_VEC_SEL		0x0d0
+/* MSI low 32 bit address, 64 bits in two halves */
+#define VIRTIO_MMIO_MSI_ADDRESS_LOW	0x0d4
+/* MSI high 32 bit address, 64 bits in two halves */
+#define VIRTIO_MMIO_MSI_ADDRESS_HIGH	0x0d8
+/* MSI 32 bit data */
+#define VIRTIO_MMIO_MSI_DATA		0x0dc
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
 
@@ -130,6 +145,22 @@
 #define VIRTIO_MMIO_CONFIG		0x100
 
 
+/* MSI commands */
+#define VIRTIO_MMIO_MSI_CMD_ENABLE	0x1
+#define VIRTIO_MMIO_MSI_CMD_DISABLE	0x2
+#define VIRTIO_MMIO_MSI_CMD_CONFIGURE	0x3
+#define VIRTIO_MMIO_MSI_CMD_MASK	0x4
+#define VIRTIO_MMIO_MSI_CMD_UNMASK	0x5
+#define VIRTIO_MMIO_MSI_CMD_MAP_CONFIG	0x6
+#define VIRTIO_MMIO_MSI_CMD_MAP_QUEUE	0x7
+
+/* MSI NO_VECTOR */
+#define VIRTIO_MMIO_MSI_NO_VECTOR	0xffffffff
+
+/* MSI state enabled state mask */
+#define VIRTIO_MMIO_MSI_ENABLED_MASK	(1 << 31)
+/* MSI state MSI sharing mask */
+#define VIRTIO_MMIO_MSI_SHARING_MASK	(1 << 30)
 
 /*
  * Interrupt flags (re: interrupt status & acknowledge registers)
-- 
1.8.3.1


