Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E77C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C23520888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR6UeM4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C23520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZUy-0001z6-8P
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNu-00038E-AQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNq-0001je-5R
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSLtLmcReavzS0Sph2ulwbtnl2qhAbzhnvNYRCXTCc8=;
 b=YR6UeM4FSl+d5Egk8hNH6YAuxrMVjgJgcrkKDdIGUS2ijdq8mZfpIIONIBycCaQPkgoF7j
 vIORZwp0/HNw6B6SDBONE85KbZkyrLrhi9DHTI6ILliiVSzsygCgDS/cCNfMG0Q5X8MPz3
 LvtAC4K6Hp9ewa0/3mjnn2A6tLidgd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-1198zFYzPXaRnsvHNQXgtw-1; Wed, 17 Jun 2020 10:49:43 -0400
X-MC-Unique: 1198zFYzPXaRnsvHNQXgtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D287134D2;
 Wed, 17 Jun 2020 14:49:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 138447CAAA;
 Wed, 17 Jun 2020 14:49:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/43] hw/block/nvme: factor out namespace setup
Date: Wed, 17 Jun 2020 16:48:46 +0200
Message-Id: <20200617144909.192176-21-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
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
Reviewed-by: Maxim Levitsky  <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200609190333.59390-15-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3f3db17231..c98af03f44 100644
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
2.25.4


