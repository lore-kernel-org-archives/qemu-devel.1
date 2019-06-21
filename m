Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F0C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7FC208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZYkOXmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7FC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKqZ-0005lw-RV
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1heKoS-0003VU-Az
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1heKoQ-0006Ke-12
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1heKoP-0006Dw-On
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:45 -0400
Received: by mail-pg1-x544.google.com with SMTP id s27so3504021pgl.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RbHz2enfkwMHmJ+my47FZRWClOp++teCJSyLbAhJtF0=;
 b=mZYkOXmnXAhmlBeVKNjdB83awaCESTqzI5cPqR+E3JEiSl2QzBI2l7mH5KzubCDnos
 WUZkKojmGy/xSAi2k7C+oBsgVJMOEU82HuuQmQPgoPplaNvgYGJLw5bl356zo/8D/yAf
 QitIJiw7Be+doNnacy9+QnGA0yLwDUqVxRN3Yfy7KMlkJqtHWejOJIlHgdOqLuBGdT64
 3yNAfULzeXPrYULSCvd32iz6l4N/Iypefi5PAEvaveZ1S2hffpsXzdg/oXp36iSVsEnC
 IQ0xZJCEKDsmQyTHAGNbDMK/2DoN9dcEJZzYwEaj81zq048yK0H14BMvV39hUcftVSIb
 4/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RbHz2enfkwMHmJ+my47FZRWClOp++teCJSyLbAhJtF0=;
 b=hzoTo9Ocu3nmSDGmfNsWxOM/cZCsM+oZJL/dSV8ossHcTEa2/zdlz/IWCJOSAq0t1U
 q0VwItpiTnA8H0VXEXSOXYz4mxFkXHzHe4zHiK87kUUDSZrJ4lC2o7wEg3PpcskR0vtE
 PQ00M9DU34JkhASdSBcqGEmxB8jI1TsflNamJaGY1EHTBYKnbhEk5ZGt3CWccBnZDcVg
 fhVBS6gvyyQ+1ypB5gExkZA9YmTzWS91ppFag51jMZ+q9cKyEAiXRgsQIV4ClPRhKZia
 Op0vEG4Ytl4UYJwo1sp/zsSDeK4BhGeL2OyT+u0/+EQUGJVIprAdgZeQfy5Lgy3owIDF
 C+Og==
X-Gm-Message-State: APjAAAVFchpgVY5C3bzyihMyHAFFfyKX2X2wT3OuQsyTEEvMIjD2T2ZS
 gpTT7cJX8ZwAnjGyqwFiVcYF9S0P
X-Google-Smtp-Source: APXvYqwlXe2IbRsL4nYhUrdLWBKoCemadkbGf4Yrs4+lXXS91Oe9ysr2MQ/eGIr/VkyMVX155AUCKA==
X-Received: by 2002:a63:2224:: with SMTP id i36mr19197435pgi.70.1561128396072; 
 Fri, 21 Jun 2019 07:46:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2081:a5f2:5e1e:1cae:baa8:1943])
 by smtp.gmail.com with ESMTPSA id v5sm3338591pgq.66.2019.06.21.07.46.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 21 Jun 2019 07:46:35 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 20:15:41 +0530
Message-Id: <20190621144541.13770-2-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621144541.13770-1-skrtbhtngr@gmail.com>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [RFC 1/1] hw/pvrdma: Add live migration support
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define and register SaveVMHandlers pvrdma_save and
pvrdma_load for saving and loading the device state,
which currently includes only the dma, command slot
and response slot addresses.

Remap the DSR, command slot and response slot upon
loading the addresses in the pvrdma_load function.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index adcf79cd63..cd8573173c 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "hw/rdma/rdma.h"
+#include "migration/register.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
@@ -592,9 +593,62 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
     pvrdma_fini(pci_dev);
 }
 
+static void pvrdma_save(QEMUFile *f, void *opaque)
+{
+    PVRDMADev *dev = PVRDMA_DEV(opaque);
+
+    qemu_put_be64(f, dev->dsr_info.dma);
+    qemu_put_be64(f, dev->dsr_info.dsr->cmd_slot_dma);
+    qemu_put_be64(f, dev->dsr_info.dsr->resp_slot_dma);
+}
+
+static int pvrdma_load(QEMUFile *f, void *opaque, int version_id)
+{
+    PVRDMADev *dev = PVRDMA_DEV(opaque);
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+
+    // Remap DSR
+    dev->dsr_info.dma = qemu_get_be64(f);
+    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
+                                    sizeof(struct pvrdma_device_shared_region));
+    if (!dev->dsr_info.dsr) {
+        rdma_error_report("Failed to map to DSR");
+        return -1;
+    }
+    qemu_log("pvrdma_load: successfully remapped to DSR\n");
+
+    // Remap cmd slot
+    dev->dsr_info.dsr->cmd_slot_dma = qemu_get_be64(f);
+    dev->dsr_info.req = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->cmd_slot_dma,
+                                     sizeof(union pvrdma_cmd_req));
+    if (!dev->dsr_info.req) {
+        rdma_error_report("Failed to map to command slot address");
+        return -1;
+    }
+    qemu_log("pvrdma_load: successfully remapped to cmd slot\n");
+
+    // Remap rsp slot
+    dev->dsr_info.dsr->resp_slot_dma = qemu_get_be64(f);
+    dev->dsr_info.rsp = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->resp_slot_dma,
+                                     sizeof(union pvrdma_cmd_resp));
+    if (!dev->dsr_info.rsp) {
+        rdma_error_report("Failed to map to response slot address");
+        return -1;
+    }
+    qemu_log("pvrdma_load: successfully remapped to rsp slot\n");
+
+    return 0;
+}
+
+static SaveVMHandlers savevm_pvrdma = {
+    .save_state = pvrdma_save,
+    .load_state = pvrdma_load,
+};
+
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
     int rc = 0;
+    DeviceState *s = DEVICE(pdev);
     PVRDMADev *dev = PVRDMA_DEV(pdev);
     Object *memdev_root;
     bool ram_shared = false;
@@ -666,6 +720,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
+    register_savevm_live(s, "pvrdma", -1, 1, &savevm_pvrdma, dev);
+
 out:
     if (rc) {
         pvrdma_fini(pdev);
-- 
2.21.0


