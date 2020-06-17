Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C93C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BBF206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/gDuapA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BBF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZdd-0007Wo-3j
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO1-0003MM-Ok
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNy-0001lm-RU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMaGkIV4H/VcvnLuJFfX383qw/BOg4LMNlsgAjuJ2uc=;
 b=Q/gDuapAB+NnbQmZYrKgSXO+EcdGuQoUUvFLk9WPPLKJ5MAbpuFgah7oSxVjgTxwDUWM8i
 Se+IkLfB9uX7snWheJlhz0xmUcRvFeiUJG0d5CEiyb2XjxBvvvTXpRYiv8ed3/dxmvGZf6
 HPGXkDDSAoRbTx5xg1pf0tECXrEH2TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-1gMgQpKYOtqvytETexVz5A-1; Wed, 17 Jun 2020 10:49:52 -0400
X-MC-Unique: 1gMgQpKYOtqvytETexVz5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E352480331A;
 Wed, 17 Jun 2020 14:49:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC0627CAA0;
 Wed, 17 Jun 2020 14:49:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/43] hw/block/nvme: add msix_qsize parameter
Date: Wed, 17 Jun 2020 16:48:53 +0200
Message-Id: <20200617144909.192176-28-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Decouple the requested maximum number of ioqpairs (param max_ioqpairs)
from the number of MSI-X interrupt vectors by introducing a new
msix_qsize parameter and initialize MSI-X with that. This allows
emulating a device that has fewer vectors than I/O queue pairs and also
allows more than 2048 queue pairs. To keep the device behaving as
previously, use a msix_qsize default of 65 (default max_ioqpairs + 1).

This decoupling was actually suggested by Maxim some time ago in a
slightly different context, so adding a Suggested-by.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20200609190333.59390-22-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.h |  1 +
 hw/block/nvme.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 61dd9b23b8..1d30c0bca2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -7,6 +7,7 @@ typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
+    uint16_t msix_qsize;
     uint32_t cmb_size_mb;
 } NvmeParams;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fe17aa5d70..acc6dbc900 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -54,6 +54,7 @@
 #include "trace.h"
 #include "nvme.h"
 
+#define NVME_MAX_IOQPAIRS 0xffff
 #define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
@@ -662,7 +663,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
-    if (unlikely(vector > n->params.max_ioqpairs)) {
+    if (unlikely(vector >= n->params.msix_qsize)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -1371,9 +1372,16 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
     }
 
     if (params->max_ioqpairs < 1 ||
-        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
+        params->max_ioqpairs > NVME_MAX_IOQPAIRS) {
         error_setg(errp, "max_ioqpairs must be between 1 and %d",
-                   PCI_MSIX_FLAGS_QSIZE);
+                   NVME_MAX_IOQPAIRS);
+        return;
+    }
+
+    if (params->msix_qsize < 1 ||
+        params->msix_qsize > PCI_MSIX_FLAGS_QSIZE + 1) {
+        error_setg(errp, "msix_qsize must be between 1 and %d",
+                   PCI_MSIX_FLAGS_QSIZE + 1);
         return;
     }
 
@@ -1527,7 +1535,7 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
                           n->reg_size);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, NULL);
 
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
@@ -1634,6 +1642,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
+    DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.25.4


