Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986FC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA5320715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA5320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B7E-0006BZ-QM
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150z-0007Ae-1o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150x-0004Pb-NF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:06:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhabin@linux.alibaba.com>)
 id 1j150x-0004O3-BL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:59 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04396; MF=zhabin@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0TpayjRN_1581325532; 
Received: from localhost(mailfrom:zhabin@linux.alibaba.com
 fp:SMTPD_---0TpayjRN_1581325532) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Feb 2020 17:05:32 +0800
From: Zha Bin <zhabin@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Date: Mon, 10 Feb 2020 17:05:19 +0800
Message-Id: <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
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

Create a generic irq domain for all architectures which
supports virtio-mmio. The device offering VIRTIO_F_MMIO_MSI
feature bit can use this irq domain.

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/base/platform-msi.c      |  4 +-
 drivers/virtio/Kconfig           |  9 ++++
 drivers/virtio/virtio_mmio_msi.h | 93 ++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h              |  1 +
 4 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virtio/virtio_mmio_msi.h

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8da314b..45752f1 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -31,12 +31,11 @@ struct platform_msi_priv_data {
 /* The devid allocator */
 static DEFINE_IDA(platform_msi_devid_ida);
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 /*
  * Convert an msi_desc to a globaly unique identifier (per-device
  * devid + msi_desc position in the msi_list).
  */
-static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
+irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
 	u32 devid;
 
@@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
 }
 
+#ifdef GENERIC_MSI_DOMAIN_OPS
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 078615c..551a9f7 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,6 +84,15 @@ config VIRTIO_MMIO
 
  	 If unsure, say N.
 
+config VIRTIO_MMIO_MSI
+	bool "Memory-mapped virtio device MSI"
+	depends on VIRTIO_MMIO && GENERIC_MSI_IRQ_DOMAIN && GENERIC_MSI_IRQ
+	help
+	 This allows device drivers to support msi interrupt handling for
+	 virtio-mmio devices. It can improve performance greatly.
+
+	 If unsure, say N.
+
 config VIRTIO_MMIO_CMDLINE_DEVICES
 	bool "Memory mapped virtio devices parameter parsing"
 	depends on VIRTIO_MMIO
diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmio_msi.h
new file mode 100644
index 0000000..27cb2af
--- /dev/null
+++ b/drivers/virtio/virtio_mmio_msi.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
+#define _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
+
+#ifdef CONFIG_VIRTIO_MMIO_MSI
+
+#include <linux/msi.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/platform_device.h>
+
+static irq_hw_number_t mmio_msi_hwirq;
+static struct irq_domain *mmio_msi_domain;
+
+struct irq_domain *__weak arch_msi_root_irq_domain(void)
+{
+	return NULL;
+}
+
+void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+}
+
+static void mmio_msi_mask_irq(struct irq_data *data)
+{
+}
+
+static void mmio_msi_unmask_irq(struct irq_data *data)
+{
+}
+
+static struct irq_chip mmio_msi_controller = {
+	.name			= "VIRTIO-MMIO-MSI",
+	.irq_mask		= mmio_msi_mask_irq,
+	.irq_unmask		= mmio_msi_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= irq_msi_compose_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int mmio_msi_prepare(struct irq_domain *domain, struct device *dev,
+				int nvec, msi_alloc_info_t *arg)
+{
+	memset(arg, 0, sizeof(*arg));
+	return 0;
+}
+
+static void mmio_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	mmio_msi_hwirq = platform_msi_calc_hwirq(desc);
+}
+
+static irq_hw_number_t mmio_msi_get_hwirq(struct msi_domain_info *info,
+					      msi_alloc_info_t *arg)
+{
+	return mmio_msi_hwirq;
+}
+
+static struct msi_domain_ops mmio_msi_domain_ops = {
+	.msi_prepare	= mmio_msi_prepare,
+	.set_desc	= mmio_msi_set_desc,
+	.get_hwirq	= mmio_msi_get_hwirq,
+};
+
+static struct msi_domain_info mmio_msi_domain_info = {
+	.flags          = MSI_FLAG_USE_DEF_DOM_OPS |
+			  MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_ACTIVATE_EARLY,
+	.ops            = &mmio_msi_domain_ops,
+	.chip           = &mmio_msi_controller,
+	.handler        = handle_edge_irq,
+	.handler_name   = "edge",
+};
+
+static inline void mmio_msi_create_irq_domain(void)
+{
+	struct fwnode_handle *fn;
+	struct irq_domain *parent = arch_msi_root_irq_domain();
+
+	fn = irq_domain_alloc_named_fwnode("VIRTIO-MMIO-MSI");
+	if (fn && parent) {
+		mmio_msi_domain =
+			platform_msi_create_irq_domain(fn,
+				&mmio_msi_domain_info, parent);
+		irq_domain_free_fwnode(fn);
+	}
+}
+#else
+static inline void mmio_msi_create_irq_domain(void) {}
+#endif
+
+#endif
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ad679e..ee5f566 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-- 
1.8.3.1


