Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA47C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAE3214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAE3214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1T9-00076P-U1
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QJ-0005Y7-NF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QI-0002uz-DU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:43440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1QI-0002os-5z; Tue, 05 Nov 2019 11:11:14 -0500
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1Q9-0000Xh-PU; Tue, 05 Nov 2019 19:11:05 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Date: Tue,  5 Nov 2019 19:11:02 +0300
Message-Id: <20191105161105.19016-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch protects from creating illegal virtio device configuration
via direct virtqueue size property setting.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/virtio/virtio-blk-pci.c  |  9 +++++++++
 hw/virtio/virtio-scsi-pci.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 60c9185c39..6177ff1df8 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -48,6 +48,15 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    bool modern = virtio_pci_modern(vpci_dev);
+    uint32_t queue_size = dev->vdev.conf.queue_size;
+
+    if (!modern && queue_size > 128) {
+        error_setg(errp,
+                   "too big queue size (%u, max: 128) "
+                   "for non-modern virtio device", queue_size);
+        return;
+    }
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 2830849729..6e6790fda5 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -17,6 +17,7 @@
 
 #include "hw/virtio/virtio-scsi.h"
 #include "virtio-pci.h"
+#include "qapi/error.h"
 
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 
@@ -47,6 +48,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
     DeviceState *proxy = DEVICE(vpci_dev);
     char *bus_name;
+    bool modern = virtio_pci_modern(vpci_dev);
+    uint32_t virtqueue_size = vs->conf.virtqueue_size;
+
+    if (!modern && virtqueue_size > 128) {
+        error_setg(errp,
+                   "too big virtqueue size (%u, max: 128) "
+                   "for non-modern virtio device", virtqueue_size);
+        return;
+    }
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = vs->conf.num_queues + 3;
-- 
2.17.0


