Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC3EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5911120707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuOIu/hK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5911120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZfm-0002tR-I5
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO3-0003Ok-Lq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO0-0001mM-TR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLvr08dl856z5pwql72CFgRjGAy1S559L7/FJIEOUUk=;
 b=PuOIu/hKQyn41niWauKIjQDz+XvvR6QXaF503UaHEIPgmTi45UUcN7ry+bNPV+rEvgCHCe
 5DAVGGlqiADG2OLa7DEQmXNKEGIi4z7IkFSIBmOcCDzI2LeyKmUcGQNGLq/uM9Sk1TCKUO
 c/TCe9X8E+HxFN3ej11DBSlWh+x7QmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-iqx5X3ykM6G-Z8FxDMC1Qw-1; Wed, 17 Jun 2020 10:49:53 -0400
X-MC-Unique: iqx5X3ykM6G-Z8FxDMC1Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302CF18A266A;
 Wed, 17 Jun 2020 14:49:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3944A7CAA0;
 Wed, 17 Jun 2020 14:49:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 28/43] hw/block/nvme: verify msix_init_exclusive_bar() return
 value
Date: Wed, 17 Jun 2020 16:48:54 +0200
Message-Id: <20200617144909.192176-29-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Pass an Error to msix_init_exclusive_bar() and check it.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20200609190333.59390-23-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index acc6dbc900..2a2e43f681 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1522,7 +1522,7 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
                      PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
 }
 
-static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     uint8_t *pci_conf = pci_dev->config;
 
@@ -1535,7 +1535,9 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
                           n->reg_size);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, NULL);
+    if (msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp)) {
+        return;
+    }
 
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
@@ -1603,7 +1605,12 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
-    nvme_init_pci(n, pci_dev);
+    nvme_init_pci(n, pci_dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     nvme_init_ctrl(n, pci_dev);
 
     for (i = 0; i < n->num_namespaces; i++) {
-- 
2.25.4


