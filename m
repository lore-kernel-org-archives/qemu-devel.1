Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4F02073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn3KNSeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4F02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZWh-0006F3-HN
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNh-00030L-5l
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNe-0001gn-Ez
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmvqFrrNA6PmYVGzeQgPjmNtOe0odHrviI5a7ZFsoqQ=;
 b=hn3KNSeg/djEEbPYYiBU/qvs1A7dnoFMl947GFpS4oC1WoTZGmypDsDw6DSNOi+m4ctvur
 KdFJ1tuq/HHuUn7eF4raPCGrctkfY35ua50A8hdOf1xFCjR4gn//xlMxbUYxp1K90LXhuQ
 ptfeOFjem7vuurpT5DC1o7ms6sAoD0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-OJbhx6RsN0Gs-_Q-BsSb2g-1; Wed, 17 Jun 2020 10:49:31 -0400
X-MC-Unique: OJbhx6RsN0Gs-_Q-BsSb2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2BC683DB7A;
 Wed, 17 Jun 2020 14:49:30 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB6547CAA8;
 Wed, 17 Jun 2020 14:49:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/43] hw/block/nvme: fix pin-based interrupt behavior
Date: Wed, 17 Jun 2020 16:48:39 +0200
Message-Id: <20200617144909.192176-14-kwolf@redhat.com>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200609190333.59390-8-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.h |  2 +-
 hw/block/nvme.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9df244c93c..91f16c8125 100644
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
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d6fcf078a4..ee514625ee 100644
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
-- 
2.25.4


