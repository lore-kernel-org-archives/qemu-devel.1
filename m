Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDAA206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDAA206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijmu-0002iK-Gn
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXh-0006RF-5V; Tue, 09 Jun 2020 15:04:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXf-0006it-Pb; Tue, 09 Jun 2020 15:04:12 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B4899BF846;
 Tue,  9 Jun 2020 19:03:48 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 16/22] hw/block/nvme: factor out cmb setup
Date: Tue,  9 Jun 2020 21:03:27 +0200
Message-Id: <20200609190333.59390-17-its@irrelevant.dk>
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200514044611.734782-18-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a4022b029166..8aabb4c3c39f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -56,6 +56,7 @@
 
 #define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
+#define NVME_CMB_BIR 2
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1438,6 +1439,28 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     id_ns->nuse = id_ns->ncap;
 }
 
+static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
+    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
+    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+
+    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+}
+
 static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
 {
     uint8_t *pci_conf = pci_dev->config;
@@ -1514,25 +1537,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     n->bar.intmc = n->bar.intms = 0;
 
     if (n->params.cmb_size_mb) {
-
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
-
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
-
-        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
-
+        nvme_init_cmb(n, pci_dev);
     } else if (n->pmrdev) {
         /* Controller Capabilities register */
         NVME_CAP_SET_PMRS(n->bar.cap, 1);
-- 
2.27.0


