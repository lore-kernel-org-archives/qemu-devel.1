Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F355CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54C620888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdzSn4a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54C620888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZVX-0003WK-UF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNw-0003Em-Qz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNu-0001kV-Gt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYEy4CSlUwYadDuzhQLAHzO3vI5ceB/8XHO+tzwcPP0=;
 b=EdzSn4a7c2TP4zY4QCDN22qJC6TudYKAjVxcVVxWpR2PkBBkwRBG6DvfBN/kbUlUckw8e4
 BwnOEFBXzBInrZzsamWEyS7u4KHnN/xxpKLbocNmGu9dSkpAjAE4U8XWL7dJLHXwwqb0hx
 vens4PvLh3/WpTd1IGHmjl4rOCkN/pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-3HKbV3FNPQeMIVkgd9OXIA-1; Wed, 17 Jun 2020 10:49:45 -0400
X-MC-Unique: 3HKbV3FNPQeMIVkgd9OXIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E241091337;
 Wed, 17 Jun 2020 14:49:44 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 967847CAAA;
 Wed, 17 Jun 2020 14:49:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 22/43] hw/block/nvme: factor out cmb setup
Date: Wed, 17 Jun 2020 16:48:48 +0200
Message-Id: <20200617144909.192176-23-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200609190333.59390-17-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a4022b0291..8aabb4c3c3 100644
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
2.25.4


