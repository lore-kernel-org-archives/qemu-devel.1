Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD52C76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8DC20823
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8c6EWEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8DC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoz5k-0005Yt-35
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 19:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5N-00043K-Gv
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5M-00031m-E1
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hoz5M-000316-87
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so15985495pgl.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o3w6rrLptWsFl8HE0mEgf9b9opUynwdbAv9zKRjY76s=;
 b=l8c6EWEbsxt6dLj6FQIoUHfh7OciM+CGiXzER7SMhKZNukCVHy8wnwSgG7Sr/ABXQT
 xeeQkwuuADOdqi1ipkqsiOhRPteg0y7Hp95+cflu7ZSGCUAgFBLsiILyLTK/Jh+yWMXa
 ixQN6aasiTsVnWMToWsPi7lP5kgYwgtLMZvzM1c7Hg3X/9JwsZfr8lCh2i1hgvmv2qsy
 SUtxb+ZiISEuVVfFmG0q9E9/aS6fl90TpnZiNMIpTMGdPi4n9r+ZwBImJnZK+I5pai4c
 M5TKTAc20MYBw+vwXT9uzxaUQDw8NUx7YAyJNPPnQx4d6P+3956GWDbPXtqXi7Qi4X7F
 m3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o3w6rrLptWsFl8HE0mEgf9b9opUynwdbAv9zKRjY76s=;
 b=TohzYsq08ks7q7Itj5A9+txcM7y3CEGDKEBs2Kyw2weM17wuTbJSbDOqwxKgf+xpZZ
 epxNJ+ngscc5zmqITtFWxmpPdOKKGIA/WeQc0+aRuTDKiTu1V+QwjcdPnUta8alKo3Ek
 4jNzo5DYamGcbdqL9viKf6S+tCZ15bYBiEL6s5F5YyGvNnCh46LSENoSnWgrpDoJbI5k
 tXs3rJ9fCEeHW6si057OjMnKoJILGv0xjEzHkkhtgBnXhADlvOvSR4+F/GCAf3x6vztq
 n5nsU8feNfOGeXuIUwcTOyLexVAookZ9/wrlyW/wN9ptMkQNySvrpJcOjr32K6OIEoo5
 6NpQ==
X-Gm-Message-State: APjAAAUe/GI9Enp3PXXnj+QtWU3q88RQG5RoP95LPHHEZzfY+cZleW1M
 XSkPwG0YhOHS2ubJuOWG3SmWhUzs
X-Google-Smtp-Source: APXvYqyrOprRWLKEpWfEXg3nT/puwVIHP2ARZx3OjAsv279ytkEXdWzb7pB8I5s2/yuS0ulB7QeBag==
X-Received: by 2002:a17:90a:a008:: with SMTP id
 q8mr67993851pjp.114.1563666494919; 
 Sat, 20 Jul 2019 16:48:14 -0700 (PDT)
Received: from beta.cse.iitb.ac.in ([2405:204:20e:f16f:2a5b:d596:9ab:8e05])
 by smtp.gmail.com with ESMTPSA id b6sm31229151pgq.26.2019.07.20.16.48.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 16:48:14 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 05:18:03 +0530
Message-Id: <20190720234803.18938-3-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720234803.18938-1-skrtbhtngr@gmail.com>
References: <20190720234803.18938-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [RFC v3 2/2] hw/pvrdma: add live migration support
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

vmstate_pvrdma describes the PCI and MSIX states as well as the dma
address for dsr and the gid table of device.
vmstate_pvrdma_gids describes each gid in the gid table.

pvrdma_post_save() does the job of unregistering gid entries from the
backend device in the source host.

pvrdma_post_load() maps to dsr using the loaded dma address, registers
each loaded gid into the backend device, and finally calls load_dsr()
to perform other mappings and ring init operations.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6c90db96f9..6f8b56dea3 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "hw/rdma/rdma.h"
+#include "migration/register.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
@@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
     pvrdma_fini(pci_dev);
 }
 
+static int pvrdma_post_save(void *opaque)
+{
+    int i, rc;
+    PVRDMADev *dev = opaque;
+
+    for (i = 0; i < MAX_GIDS; i++) {
+
+        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
+            continue;
+        }
+        rc = rdma_backend_del_gid(&dev->backend_dev,
+                                   dev->backend_eth_device_name,
+                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
+        if (rc) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+static int pvrdma_post_load(void *opaque, int version_id)
+{
+    int i, rc;
+    PVRDMADev *dev = opaque;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    DSRInfo *dsr_info = &dev->dsr_info;
+
+    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
+                                sizeof(struct pvrdma_device_shared_region));
+    if (!dsr_info->dsr) {
+        rdma_error_report("Failed to map to DSR");
+        return -ENOMEM;
+    }
+
+    for (i = 0; i < MAX_GIDS; i++) {
+
+        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
+            continue;
+        }
+
+        rc = rdma_backend_add_gid(&dev->backend_dev,
+                                  dev->backend_eth_device_name,
+                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
+        if (rc) {
+            return -EINVAL;
+        }
+    }
+
+    return load_dsr(dev);
+}
+
+static const VMStateDescription vmstate_pvrdma_gids = {
+    .name = "pvrdma-gids",
+    .fields = (VMStateField[]) {
+            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_pvrdma = {
+    .name = PVRDMA_HW_NAME,
+    .post_save = pvrdma_post_save,
+    .post_load = pvrdma_post_load,
+    .fields = (VMStateField[]) {
+            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
+            VMSTATE_MSIX(parent_obj, PVRDMADev),
+            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
+            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
+                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
+                                 RdmaRmGid),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
     int rc = 0;
@@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "RDMA Device";
     dc->props = pvrdma_dev_properties;
+    dc->vmsd = &vmstate_pvrdma;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 
     ir->print_statistics = pvrdma_print_statistics;
-- 
2.21.0


