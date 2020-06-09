Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4382C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BB0206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BB0206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijk1-0007Kw-Nk
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXf-0006OX-8t; Tue, 09 Jun 2020 15:04:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXd-0006ic-TF; Tue, 09 Jun 2020 15:04:10 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id BB598BFA96;
 Tue,  9 Jun 2020 19:03:47 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 14/22] hw/block/nvme: factor out namespace setup
Date: Tue,  9 Jun 2020 21:03:25 +0200
Message-Id: <20200609190333.59390-15-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609190333.59390-1-its@irrelevant.dk>
References: <20200609190333.59390-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 14:38:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky  <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200514044611.734782-16-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3f3db17231b3..c98af03f4449 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1417,6 +1417,27 @@ static void nvme_init_blk(NvmeCtrl *n, Error **errp)
                                   false, errp);
 }
 
+static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    int64_t bs_size;
+    NvmeIdNs *id_ns = &ns->id_ns;
+
+    bs_size = blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "could not get backing file size");
+        return;
+    }
+
+    n->ns_size = bs_size;
+
+    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
+
+    /* no thin provisioning */
+    id_ns->ncap = id_ns->nsze;
+    id_ns->nuse = id_ns->ncap;
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -1424,7 +1445,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     Error *local_err = NULL;
 
     int i;
-    int64_t bs_size;
     uint8_t *pci_conf;
 
     nvme_check_constraints(n, &local_err);
@@ -1435,12 +1455,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     nvme_init_state(n);
 
-    bs_size = blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
-    }
-
     nvme_init_blk(n, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1453,8 +1467,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
-    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
-
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
@@ -1563,17 +1575,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     for (i = 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns = &n->namespaces[i];
-        NvmeIdNs *id_ns = &ns->id_ns;
-        id_ns->nsfeat = 0;
-        id_ns->nlbaf = 0;
-        id_ns->flbas = 0;
-        id_ns->mc = 0;
-        id_ns->dpc = 0;
-        id_ns->dps = 0;
-        id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
-        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
-            cpu_to_le64(nvme_ns_nlbas(n, ns));
+        nvme_init_namespace(n, &n->namespaces[i], &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 }
 
-- 
2.27.0


