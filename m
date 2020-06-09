Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E7CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333E32067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333E32067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jije5-00071p-BR
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXL-00064m-Ch; Tue, 09 Jun 2020 15:03:51 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXG-0006hT-Hx; Tue, 09 Jun 2020 15:03:51 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 55E4DBF920;
 Tue,  9 Jun 2020 19:03:44 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 07/22] hw/block/nvme: fix pin-based interrupt behavior
Date: Tue,  9 Jun 2020 21:03:18 +0200
Message-Id: <20200609190333.59390-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609190333.59390-1-its@irrelevant.dk>
References: <20200609190333.59390-1-its@irrelevant.dk>
MIME-Version: 1.0
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

First, since the device only supports MSI-X or pin-based interrupt, if
MSI-X is not enabled, it should not accept interrupt vectors different
from 0 when creating completion queues.

Secondly, the irq_status NvmeCtrl member is meant to be compared to the
INTMS register, so it should only be 32 bits wide. And it is really only
useful when used with multi-message MSI.

Third, since we do not force a 1-to-1 correspondence between cqid and
interrupt vector, the irq_status register should not have bits set
according to cqid, but according to the associated interrupt vector.

Fix these issues, but keep irq_status available so we can easily support
multi-message MSI down the line.

Fixes: 5e9aa92eb1a5 ("hw/block: Fix pin-based interrupt behaviour of NVMe")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20200514044611.734782-8-its@irrelevant.dk>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 12 ++++++++----
 hw/block/nvme.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d6fcf078a4c9..ee514625ee85 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -137,8 +137,8 @@ static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
             trace_pci_nvme_irq_pin();
-            assert(cq->cqid < 64);
-            n->irq_status |= 1 << cq->cqid;
+            assert(cq->vector < 32);
+            n->irq_status |= 1 << cq->vector;
             nvme_irq_check(n);
         }
     } else {
@@ -152,8 +152,8 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
         if (msix_enabled(&(n->parent_obj))) {
             return;
         } else {
-            assert(cq->cqid < 64);
-            n->irq_status &= ~(1 << cq->cqid);
+            assert(cq->vector < 32);
+            n->irq_status &= ~(1 << cq->vector);
             nvme_irq_check(n);
         }
     }
@@ -652,6 +652,10 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_pci_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    if (unlikely(!msix_enabled(&n->parent_obj) && vector)) {
+        trace_pci_nvme_err_invalid_create_cq_vector(vector);
+        return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
+    }
     if (unlikely(vector > n->params.num_queues)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9df244c93c02..91f16c812582 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -84,7 +84,7 @@ typedef struct NvmeCtrl {
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
-    uint64_t    irq_status;
+    uint32_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
 
-- 
2.27.0


