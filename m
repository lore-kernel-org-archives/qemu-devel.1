Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77161C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494EF20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494EF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B48-0000sm-DE
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150t-000799-0M
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhabin@linux.alibaba.com>) id 1j150r-0004La-Pj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:54 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhabin@linux.alibaba.com>)
 id 1j150r-0004Ja-Fp
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:05:53 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=zhabin@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Tpb9F9i_1581325531; 
Received: from localhost(mailfrom:zhabin@linux.alibaba.com
 fp:SMTPD_---0Tpb9F9i_1581325531) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Feb 2020 17:05:32 +0800
From: Zha Bin <zhabin@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] virtio-mmio: refactor common functionality
Date: Mon, 10 Feb 2020 17:05:18 +0800
Message-Id: <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
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

Common functionality is refactored into virtio_mmio_common.h
in order to MSI support in later patch set.

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 drivers/virtio/virtio_mmio.c        | 21 +--------------------
 drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 create mode 100644 drivers/virtio/virtio_mmio_common.h

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1733ab97..41e1c93 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -61,13 +61,12 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
+#include "virtio_mmio_common.h"
 
 
 
@@ -77,24 +76,6 @@
 
 
 
-#define to_virtio_mmio_device(_plat_dev) \
-	container_of(_plat_dev, struct virtio_mmio_device, vdev)
-
-struct virtio_mmio_device {
-	struct virtio_device vdev;
-	struct platform_device *pdev;
-
-	void __iomem *base;
-	unsigned long version;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-
-	unsigned short notify_base;
-	unsigned short notify_multiplier;
-};
-
 struct virtio_mmio_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
new file mode 100644
index 0000000..90cb304
--- /dev/null
+++ b/drivers/virtio/virtio_mmio_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
+#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
+/*
+ * Virtio MMIO driver - common functionality for all device versions
+ *
+ * This module allows virtio devices to be used over a memory-mapped device.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/virtio.h>
+
+#define to_virtio_mmio_device(_plat_dev) \
+	container_of(_plat_dev, struct virtio_mmio_device, vdev)
+
+struct virtio_mmio_device {
+	struct virtio_device vdev;
+	struct platform_device *pdev;
+
+	void __iomem *base;
+	unsigned long version;
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+
+	unsigned short notify_base;
+	unsigned short notify_multiplier;
+};
+
+#endif
-- 
1.8.3.1


