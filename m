Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E721C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C868120888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTkVvRdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C868120888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZae-0003G8-1b
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNq-00034T-C4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNl-0001ih-DA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0S3KnoPwmqMahXIoE1s8/g6EU45UbGowJAc/xq1GzA=;
 b=bTkVvRdTqJzwvm3Ldl6u57F6ItxfB09Rkoo3qrEq0AqyK/hd7nXH8efk/ojBPgS7ISx8xR
 cP+EKgfZNyCtrMtEqOfiiK1RWmgatxL18Mwz6u8VBwvRm3u3FgrFff2GTjq5b6cYf2miCs
 mSEnFYCJyxJa5n3i4/z8g4u3ImqgRKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-cMQC-2UuMxKT8gsQi3uQ0g-1; Wed, 17 Jun 2020 10:49:36 -0400
X-MC-Unique: cMQC-2UuMxKT8gsQi3uQ0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC253134D5;
 Wed, 17 Jun 2020 14:49:35 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D28977CAA0;
 Wed, 17 Jun 2020 14:49:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/43] hw/block/nvme: factor out device state setup
Date: Wed, 17 Jun 2020 16:48:43 +0200
Message-Id: <20200617144909.192176-18-kwolf@redhat.com>
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200609190333.59390-12-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ee669ee8dc..b721cab9b0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1399,6 +1399,17 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
     }
 }
 
+static void nvme_init_state(NvmeCtrl *n)
+{
+    n->num_namespaces = 1;
+    /* add one to max_ioqpairs to account for the admin queue pair */
+    n->reg_size = pow2ceil(NVME_REG_SIZE +
+                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
+    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
+    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
+    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -1415,6 +1426,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
+    nvme_init_state(n);
+
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
         error_setg(errp, "could not get backing file size");
@@ -1433,17 +1446,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
-    n->num_namespaces = 1;
-
-    /* add one to max_ioqpairs to account for the admin queue pair */
-    n->reg_size = pow2ceil(NVME_REG_SIZE +
-                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
-    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
-
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
-- 
2.25.4


