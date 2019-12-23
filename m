Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB15C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9F206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9F206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJ29-0004NK-EB
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1ijJ1F-0003jV-Oo
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1ijJ1D-00047w-Rl
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:24:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:25328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1ijJ1D-0003Ul-Hw
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:24:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 00:24:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,346,1571727600"; d="scan'208";a="219436161"
Received: from he.bj.intel.com ([10.238.157.85])
 by orsmga003.jf.intel.com with ESMTP; 23 Dec 2019 00:24:37 -0800
From: Yang Zhong <yang.zhong@intel.com>
To: pbonzini@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com
Subject: [PATCH] virtio: add the queue number check
Date: Mon, 23 Dec 2019 16:28:13 +0800
Message-Id: <20191223082813.28930-1-yang.zhong@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: yang.zhong@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the guest kernel driver, like virtio_blk.c and virtio_scsi.c,
there are some definitions like below:

num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs)

If the queue number is bigger than vcpu number, the VM will be
stuck in the guest driver because the qemu and guest driver have
different queue number. So, this check can avoid this issues.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/block/vhost-user-blk.c | 11 +++++++++++
 hw/block/virtio-blk.c     | 11 ++++++++++-
 hw/scsi/virtio-scsi.c     | 12 ++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 63da9bb619..250e72abe4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -23,6 +23,8 @@
 #include "qom/object.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/virtio/virtio.h"
@@ -391,6 +393,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     Error *err = NULL;
+    unsigned cpus;
     int i, ret;
 
     if (!s->chardev.chr) {
@@ -403,6 +406,14 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
+                               "cpus", 0);
+    if (s->num_queues > cpus ) {
+        error_setg(errp, "vhost-user-blk: the queue number should be equal "
+                "or less than vcpu number");
+        return;
+    }
+
     if (!s->queue_size) {
         error_setg(errp, "vhost-user-blk: queue size must be non-zero");
         return;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index d62e6377c2..b2f4d01148 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -18,6 +18,8 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/blockdev.h"
@@ -1119,7 +1121,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
     Error *err = NULL;
-    unsigned i;
+    unsigned i,cpus;
 
     if (!conf->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -1133,6 +1135,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "num-queues property must be larger than 0");
         return;
     }
+    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
+                               "cpus", 0);
+    if (conf->num_queues > cpus ) {
+        error_setg(errp, "virtio-blk: the queue number should be equal "
+                "or less than vcpu number");
+        return;
+    }
     if (!is_power_of_2(conf->queue_size) ||
         conf->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index e8b2b64d09..8e3e44f6b9 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -21,6 +21,8 @@
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "sysemu/block-backend.h"
 #include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
@@ -880,6 +882,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(dev);
+    unsigned cpus;
     int i;
 
     virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
@@ -893,6 +896,15 @@ void virtio_scsi_common_realize(DeviceState *dev,
         virtio_cleanup(vdev);
         return;
     }
+
+    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
+                               "cpus", 0);
+    if (s->conf.num_queues > cpus ) {
+        error_setg(errp, "virtio-scsi: the queue number should be equal "
+                "or less than vcpu number");
+        return;
+    }
+
     s->cmd_vqs = g_new0(VirtQueue *, s->conf.num_queues);
     s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
     s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
-- 
2.17.1


