Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0898C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59492071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59492071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyX6J-00042n-0S
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyX5T-0003ST-Ef
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:00:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:6705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyX5Q-0006Nl-Ld
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:00:23 -0400
IronPort-SDR: yi/vCICxfg1/+wAzar/BbzJ4EH2Z+xxqWA2PMm1ucwWG4hCFAtb/O/IJpucef1E1PlWH/ZqRmu
 xR7r59fJ4Vdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="215102994"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="215102994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 02:00:10 -0700
IronPort-SDR: 5LOe/PSFBk1/CfLxhBIMwEnojD/Lx40ZwX8jLkcTgo4zlyzmMJXP4Bln77aHZqL0tqHqOpbqzx
 0s4uOz1Ar94A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="462770332"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.135])
 by orsmga005.jf.intel.com with ESMTP; 23 Jul 2020 02:00:08 -0700
From: Zeng Guang <guang.zeng@intel.com>
To: jslaby@suse.cz, david@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc/edu: support pci device state migration
Date: Thu, 23 Jul 2020 16:43:55 +0800
Message-Id: <20200723084355.18370-1-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=guang.zeng@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 05:00:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Zeng Guang <guang.zeng@intel.com>, wei.w.wang@intel.com, chao.gao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently edu device doesn't support live migration. Part of PCI
configuration information would be lost after migration.

PCI device state in source VM:
     Bus  0, device   3, function 0:
     Class 0255: PCI device 1234:11e8
     PCI subsystem 1af4:1100
     IRQ 11, pin A
     BAR0: 32 bit memory at 0xfea00000 [0xfeafffff].
     id ""

PCI device state in destination VM:
     Bus  0, device   3, function 0:
     Class 0255: PCI device 1234:11e8
     PCI subsystem 1af4:1100
     IRQ 0, pin A
     BAR0: 32 bit memory at 0xffffffffffffffff [0x000ffffe].
     id ""

Add VMState for edu device to support migration.

Signed-off-by: Gao Chao <chao.gao@intel.com>
Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/misc/edu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index ec617e63f3..5f3fecac41 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qemu/module.h"
@@ -70,7 +71,7 @@ typedef struct {
         dma_addr_t cmd;
     } dma;
     QEMUTimer dma_timer;
-    char dma_buf[DMA_SIZE];
+    uint8_t dma_buf[DMA_SIZE];
     uint64_t dma_mask;
 } EduState;
 
@@ -405,6 +406,28 @@ static void edu_instance_init(Object *obj)
                                    &edu->dma_mask, OBJ_PROP_FLAG_READWRITE);
 }
 
+static const VMStateDescription vmstate_edu = {
+    .name = "edu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, EduState),
+        VMSTATE_BOOL(stopping, EduState),
+        VMSTATE_UINT32(addr4, EduState),
+        VMSTATE_UINT32(fact, EduState),
+        VMSTATE_UINT32(status, EduState),
+        VMSTATE_UINT32(irq_status, EduState),
+        VMSTATE_UINT64(dma.src, EduState),
+        VMSTATE_UINT64(dma.dst, EduState),
+        VMSTATE_UINT64(dma.cnt, EduState),
+        VMSTATE_UINT64(dma.cmd, EduState),
+        VMSTATE_TIMER(dma_timer, EduState),
+        VMSTATE_BUFFER(dma_buf, EduState),
+        VMSTATE_UINT64(dma_mask, EduState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void edu_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -415,6 +438,7 @@ static void edu_class_init(ObjectClass *class, void *data)
     k->vendor_id = PCI_VENDOR_ID_QEMU;
     k->device_id = 0x11e8;
     k->revision = 0x10;
+    dc->vmsd = &vmstate_edu;
     k->class_id = PCI_CLASS_OTHERS;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
-- 
2.17.1


