Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E15C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 04:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8326206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 04:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8326206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ5v2-00022o-QX
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 00:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jZ5lu-0001fj-4X; Thu, 14 May 2020 00:47:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:43880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jZ5lr-0003le-Vy; Thu, 14 May 2020 00:47:01 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 52562BFE52;
 Thu, 14 May 2020 04:46:37 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 18/20] hw/block/nvme: factor out pmr setup
Date: Thu, 14 May 2020 06:46:09 +0200
Message-Id: <20200514044611.734782-19-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514044611.734782-1-its@irrelevant.dk>
References: <20200514044611.734782-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 00:46:30
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 95 ++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d71a5f142d51..7254b66ae199 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -58,6 +58,7 @@
 #define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
+#define NVME_PMR_BIR 2
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1463,6 +1464,55 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
                      PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
 }
 
+static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    /* Controller Capabilities register */
+    NVME_CAP_SET_PMRS(n->bar.cap, 1);
+
+    /* PMR Capabities register */
+    n->bar.pmrcap = 0;
+    NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
+    NVME_PMRCAP_SET_WDS(n->bar.pmrcap, 0);
+    NVME_PMRCAP_SET_BIR(n->bar.pmrcap, NVME_PMR_BIR);
+    NVME_PMRCAP_SET_PMRTU(n->bar.pmrcap, 0);
+    /* Turn on bit 1 support */
+    NVME_PMRCAP_SET_PMRWBM(n->bar.pmrcap, 0x02);
+    NVME_PMRCAP_SET_PMRTO(n->bar.pmrcap, 0);
+    NVME_PMRCAP_SET_CMSS(n->bar.pmrcap, 0);
+
+    /* PMR Control register */
+    n->bar.pmrctl = 0;
+    NVME_PMRCTL_SET_EN(n->bar.pmrctl, 0);
+
+    /* PMR Status register */
+    n->bar.pmrsts = 0;
+    NVME_PMRSTS_SET_ERR(n->bar.pmrsts, 0);
+    NVME_PMRSTS_SET_NRDY(n->bar.pmrsts, 0);
+    NVME_PMRSTS_SET_HSTS(n->bar.pmrsts, 0);
+    NVME_PMRSTS_SET_CBAI(n->bar.pmrsts, 0);
+
+    /* PMR Elasticity Buffer Size register */
+    n->bar.pmrebs = 0;
+    NVME_PMREBS_SET_PMRSZU(n->bar.pmrebs, 0);
+    NVME_PMREBS_SET_RBB(n->bar.pmrebs, 0);
+    NVME_PMREBS_SET_PMRWBZ(n->bar.pmrebs, 0);
+
+    /* PMR Sustained Write Throughput register */
+    n->bar.pmrswtp = 0;
+    NVME_PMRSWTP_SET_PMRSWTU(n->bar.pmrswtp, 0);
+    NVME_PMRSWTP_SET_PMRSWTV(n->bar.pmrswtp, 0);
+
+    /* PMR Memory Space Control register */
+    n->bar.pmrmsc = 0;
+    NVME_PMRMSC_SET_CMSE(n->bar.pmrmsc, 0);
+    NVME_PMRMSC_SET_CBA(n->bar.pmrmsc, 0);
+
+    pci_register_bar(pci_dev, NVME_PMRCAP_BIR(n->bar.pmrcap),
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
+}
+
 static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
 {
     uint8_t *pci_conf = pci_dev->config;
@@ -1541,50 +1591,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     } else if (n->pmrdev) {
-        /* Controller Capabilities register */
-        NVME_CAP_SET_PMRS(n->bar.cap, 1);
-
-        /* PMR Capabities register */
-        n->bar.pmrcap = 0;
-        NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
-        NVME_PMRCAP_SET_WDS(n->bar.pmrcap, 0);
-        NVME_PMRCAP_SET_BIR(n->bar.pmrcap, 2);
-        NVME_PMRCAP_SET_PMRTU(n->bar.pmrcap, 0);
-        /* Turn on bit 1 support */
-        NVME_PMRCAP_SET_PMRWBM(n->bar.pmrcap, 0x02);
-        NVME_PMRCAP_SET_PMRTO(n->bar.pmrcap, 0);
-        NVME_PMRCAP_SET_CMSS(n->bar.pmrcap, 0);
-
-        /* PMR Control register */
-        n->bar.pmrctl = 0;
-        NVME_PMRCTL_SET_EN(n->bar.pmrctl, 0);
-
-        /* PMR Status register */
-        n->bar.pmrsts = 0;
-        NVME_PMRSTS_SET_ERR(n->bar.pmrsts, 0);
-        NVME_PMRSTS_SET_NRDY(n->bar.pmrsts, 0);
-        NVME_PMRSTS_SET_HSTS(n->bar.pmrsts, 0);
-        NVME_PMRSTS_SET_CBAI(n->bar.pmrsts, 0);
-
-        /* PMR Elasticity Buffer Size register */
-        n->bar.pmrebs = 0;
-        NVME_PMREBS_SET_PMRSZU(n->bar.pmrebs, 0);
-        NVME_PMREBS_SET_RBB(n->bar.pmrebs, 0);
-        NVME_PMREBS_SET_PMRWBZ(n->bar.pmrebs, 0);
-
-        /* PMR Sustained Write Throughput register */
-        n->bar.pmrswtp = 0;
-        NVME_PMRSWTP_SET_PMRSWTU(n->bar.pmrswtp, 0);
-        NVME_PMRSWTP_SET_PMRSWTV(n->bar.pmrswtp, 0);
-
-        /* PMR Memory Space Control register */
-        n->bar.pmrmsc = 0;
-        NVME_PMRMSC_SET_CMSE(n->bar.pmrmsc, 0);
-        NVME_PMRMSC_SET_CBA(n->bar.pmrmsc, 0);
-
-        pci_register_bar(pci_dev, NVME_PMRCAP_BIR(n->bar.pmrcap),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
+        nvme_init_pmr(n, pci_dev);
     }
 
     for (i = 0; i < n->num_namespaces; i++) {
-- 
2.26.2


