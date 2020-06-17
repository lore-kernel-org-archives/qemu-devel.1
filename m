Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCB420888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4zNNw1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCB420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZkn-0003RD-Pl
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNz-0003K5-8i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNw-0001l3-7s
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyK2MsouuN6zHcH+tYkXVojAXdDXYRw821r2LOw8TmE=;
 b=d4zNNw1FkIrP/LVzeKGEjBYspkl9Y7X8ugzRO8wKy4tV53NDrDcngGugOgOrjm0srJU5uV
 YTAQQsMb7nfnfqhNEU6m211m6OLOiugW3PgXe5I9Dwtrogl+scAC2dJdQi7VM0h/PiR/bp
 aThPJeSEv/DzwDY/afrlkaXQNDSvA/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-LISF0vxCPma-Q18bvFTpww-1; Wed, 17 Jun 2020 10:49:46 -0400
X-MC-Unique: LISF0vxCPma-Q18bvFTpww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D342A8730AC;
 Wed, 17 Jun 2020 14:49:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2D77CAA0;
 Wed, 17 Jun 2020 14:49:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/43] hw/block/nvme: factor out pmr setup
Date: Wed, 17 Jun 2020 16:48:49 +0200
Message-Id: <20200617144909.192176-24-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200609190333.59390-18-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 95 ++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8aabb4c3c3..b954e7b7b2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -57,6 +57,7 @@
 #define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
+#define NVME_PMR_BIR 2
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1461,6 +1462,55 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
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
@@ -1539,50 +1589,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
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
2.25.4


